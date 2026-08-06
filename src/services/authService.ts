import { supabase } from '../lib/supabase';
import { Region } from '../types/models';
import { Platform } from 'react-native';

export interface SignUpData {
    email?: string;
    password: string;
    fullName: string;
    employeeId: string;
    region: Region | string;
    age?: number;
    vehicle_type?: string;
    phone_number?: string;
    companyId?: string;
    isPublic?: boolean; // NEW: Flag to force public signup
    [key: string]: any;
}

export interface SignInData {
    employeeId: string; // Employee ID or email
    password: string;
    companyCode?: string;
}

export const AuthService = {
    /**
     * Register a new driver
     */
    async signUp(data: SignUpData) {
        try {
            // Generate dummy email if none provided
            const normalizedId = data.employeeId.trim().toLowerCase();
            const email = data.email?.trim().toLowerCase() || `${normalizedId}@driver360.internal`;

            // IF LOGGED IN (e.g. Master User creating a driver):
            // Use the secure RPC instead of public signUp. This prevents "500 Internal Server Errors"
            // that happen when hitting Supabase's public rate limits or trying to sign up while already signed in.
            // UNLESS it's explicitly a public register (isPublic: true)
            const { data: sessionData } = await supabase.auth.getSession();

            if (!data.isPublic && sessionData.session) {
                // Always normalize employee ID to lowercase+trimmed to ensure login will always match
                const normalizedEmployeeId = data.employeeId.trim().toLowerCase();
                const normalizedEmail = data.email?.trim().toLowerCase() || `${normalizedEmployeeId}@driver360.internal`;
                
                const result = await supabase.rpc('create_company_user', {
                    p_email: normalizedEmail,
                    p_password: data.password,
                    p_full_name: data.fullName.trim(),
                    p_employee_id: data.employeeId.trim(),
                    p_region: data.region,
                    p_role: data.role || 'driver',
                    p_manager_level: data.manager_level || null,
                    p_company_id: data.companyId || null,
                    p_age: data.age || null,
                    p_vehicle_type: data.vehicle_type || null,
                    p_phone_number: data.phone_number?.trim() || null
                });

                const obj = (result.data as any) || {};

                if (obj.success === false) {
                    throw new Error(obj.error || 'Failed to create user via RPC');
                }

                return { user: { id: obj.user_id }, error: null };
            }

            // IF NOT LOGGED IN (e.g. completely new Master user registering a workspace)
            const redirectUrl = Platform.OS === 'web'
                ? 'https://driver360-kappa.vercel.app/auth/callback'
                : 'driver360://auth/callback';

            const { data: authData, error: authError } = await supabase.auth.signUp({
                email: email,
                password: data.password,
                options: {
                    emailRedirectTo: redirectUrl,
                    data: {
                        full_name: data.fullName.trim(),
                        employee_id: data.employeeId.trim(),
                        region: data.region,
                        age: data.age,
                        vehicle_type: data.vehicle_type,
                        phone_number: data.phone_number?.trim(),
                        role: data.role || 'driver',
                        manager_level: data.manager_level,
                        company_id: data.companyId,
                        company_name: (data as any).company_name,
                        company_code: (data as any).company_code,
                    },
                },
            });

            if (authError) throw authError;
            return { user: authData.user, error: null };

        } catch (error: any) {
            console.error('Sign up error:', error);
            return { user: null, error: error.message };
        }
    },

    /**
     * Sign in existing user (supports Email or Employee ID)
     */
    async signIn(data: SignInData) {
        try {
            const rawInput = data.employeeId.trim();
            const companyCode = data.companyCode?.trim().toUpperCase();
            
            let lookupInput = rawInput.toLowerCase();
            if (!rawInput.includes('@') && companyCode) {
                const prefix = `${companyCode.toLowerCase()}-`;
                // Only add the company code prefix if the employee ID doesn't already start with it
                if (!rawInput.toLowerCase().startsWith(prefix)) {
                    lookupInput = `${prefix}${rawInput.toLowerCase()}`;
                }
            }
            
            // Look up the true email using the new Universal Login RPC
            const { data: trueEmail, error: lookupError } = await supabase.rpc('get_email_for_login', {
                p_input: lookupInput
            });

            // If the RPC fails (e.g. network error), fallback to the old logic to prevent complete lockout
            let email = trueEmail;
            if (lookupError || !email) {
                console.warn('Email lookup RPC failed, falling back to dummy format:', lookupError);
                email = rawInput.includes('@')
                    ? rawInput.toLowerCase()
                    : `${lookupInput}@driver360.internal`;
            }

            const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
                email: email,
                password: data.password,
            });

            if (authError) throw authError;

            // NEW: After successful auth, check if the account is ACTIVE in the profiles table
            const { data: profileData, error: profileError } = await supabase
                .from('profiles')
                .select('status')
                .eq('id', authData.user.id)
                .single();

            if (profileError) {
                // If profile doesn't exist or error, stay cautious
                console.error('Login profile check error:', profileError);
            } else if (profileData && profileData.status === 'inactive') {
                // BLOCK LOGIN: If status is 'inactive', sign out immediately
                await supabase.auth.signOut();
                throw new Error('Account inactive. Please contact your administrator.');
            }

            return { session: authData.session, user: authData.user, error: null };
        } catch (error: any) {
            console.error('Sign in error:', error);
            return { session: null, user: null, error: error.message };
        }
    },

    /**
     * Delete a user account (Manager only)
     */
    async deleteUser(userId: string) {
        try {
            const { error } = await supabase.rpc('delete_user', {
                target_user_id: userId
            });

            if (error) throw error;
            return { success: true, error: null };
        } catch (error: any) {
            console.error('Delete user error:', error);
            return { success: false, error: error.message };
        }
    },

    /**
     * Update a user account (Manager only)
     */
    async updateCompanyUser(data: {
        userId: string;
        fullName: string;
        employeeId: string;
        region: string;
        age?: number;
        vehicle_type?: string;
        phone_number?: string;
    }) {
        try {
            const normalizedEmployeeId = data.employeeId.trim().toLowerCase();
            const email = `${normalizedEmployeeId}@driver360.internal`;
            
            const { data: result, error } = await supabase.rpc('update_company_user', {
                target_user_id: data.userId,
                p_email: email,
                p_full_name: data.fullName.trim(),
                p_employee_id: data.employeeId.trim(),
                p_region: data.region,
                p_age: data.age || null,
                p_vehicle_type: data.vehicle_type || null,
                p_phone_number: data.phone_number?.trim() || null
            });

            if (error) throw error;
            if (result && result.success === false) throw new Error(result.error || 'Failed to update user');
            
            return { success: true, error: null };
        } catch (error: any) {
            console.error('Update company user error:', error);
            return { success: false, error: error.message };
        }
    },

    /**
     * Sign out current user
     */
    async signOut() {
        try {
            const { error } = await supabase.auth.signOut();
            if (error) throw error;
            return { error: null };
        } catch (error: any) {
            console.error('Sign out error:', error);
            return { error: error.message };
        }
    },

    /**
     * Get current user profile
     */
    async getUserProfile() {
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) return { profile: null, error: 'No user logged in' };

            const { data: profile, error } = await supabase
                .from('profiles')
                .select('*')
                .eq('id', user.id)
                .single();

            if (error) throw error;
            return { profile, error: null };
        } catch (error: any) {
            console.error('Get profile error:', error);
            return { profile: null, error: error.message };
        }
    },

    /**
     * Update user profile
     */
    async updateProfile(userId: string, updates: any) {
        try {
            const { data, error } = await supabase
                .from('profiles')
                .update(updates)
                .eq('id', userId)
                .select()
                .single();

            if (error) throw error;
            return { data, error: null };
        } catch (error: any) {
            console.error('Update profile error:', error);
            return { data: null, error: error.message };
        }
    },

    /**
     * Update user password (for Forgot Password flow)
     */
    async updatePassword(newPassword: string) {
        try {
            const { error } = await supabase.auth.updateUser({
                password: newPassword
            });
            if (error) throw error;
            return { error: null };
        } catch (error: any) {
            console.error('Update password error:', error);
            return { error: error.message };
        }
    },

    onAuthStateChange(callback: (event: string, session: any) => void) {
        return supabase.auth.onAuthStateChange(callback);
    },

    /**
     * Get all users (Manager only) - filtered by company
     */
    async getAllUsers() {
        try {
            // Get the current user's company_id
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) throw new Error('Not authenticated');

            const { data: currentProfile } = await supabase
                .from('profiles')
                .select('company_id')
                .eq('id', user.id)
                .single();

            let query = supabase
                .from('profiles')
                .select('*')
                .neq('status', 'inactive') // Only show active users (exclude inactive)
                .order('created_at', { ascending: false });

            // Filter by company if user has one
            if (currentProfile?.company_id) {
                query = query.eq('company_id', currentProfile.company_id);
            }

            const { data: users, error } = await query;

            if (error) throw error;
            return { users, error: null };
        } catch (error: any) {
            console.error('Get all users error:', error);
            return { users: null, error: error.message };
        }
    },

    /**
     * Reset user password (Manager only)
     * Note: This requires a backend function 'reset_user_password'
     */
    async adminResetPassword(userId: string) {
        try {
            // Attempt to call RPC function
            const { error } = await supabase.rpc('reset_user_password', {
                target_user_id: userId,
                new_password: '123456' // Default password
            });

            if (error) {
                // If RPC fails (e.g. not found), throw error to be handled by UI
                // In a real app we might need a different strategy if RPC isn't available
                throw error;
            }
            return { success: true, error: null };
        } catch (error: any) {
            console.error('Reset password error:', error);
            return { success: false, error: error.message };
        }
    },

    /**
     * Change user password (Manager only)
     */
    async changeUserPassword(userId: string, newPassword: string) {
        try {
            const { error } = await supabase.rpc('change_user_password', {
                target_user_id: userId,
                new_password: newPassword
            });

            if (error) throw error;
            return { success: true, error: null };
        } catch (error: any) {
            console.error('Change password error:', error);
            return { success: false, error: error.message };
        }
    },

    /**
     * Send password reset email (for Forgot Password flow)
     */
    async resetPassword(email: string) {
        try {
            const origin = (Platform.OS === 'web' && typeof window !== 'undefined')
                ? window.location.origin
                : 'https://safepass-kappa.vercel.app';

            const redirectUrl = `${origin}/auth/callback`;

            const { error } = await supabase.auth.resetPasswordForEmail(email, {
                redirectTo: redirectUrl,
            });

            if (error) throw error;
            return { error: null };
        } catch (error: any) {
            console.error('Reset password error:', error);
            return { error: error.message };
        }
    },
};
