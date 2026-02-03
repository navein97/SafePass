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
    [key: string]: any;
}

export interface SignInData {
    employeeId: string; // Employee ID or email
    password: string;
}

export const AuthService = {
    /**
     * Register a new driver
     */
    async signUp(data: SignUpData) {
        try {
            // Generate dummy email if none provided - ensure it's lowercase and trimmed to prevent duplicates
            const normalizedId = data.employeeId.trim().toLowerCase();
            const email = data.email?.trim().toLowerCase() || `${normalizedId}@safepass.internal`;

            const redirectUrl = Platform.OS === 'web'
                ? 'https://safepass-kappa.vercel.app/auth/callback'
                : 'safepass://auth/callback';

            const { data: authData, error: authError } = await supabase.auth.signUp({
                email: email,
                password: data.password,
                options: {
                    emailRedirectTo: redirectUrl,
                    data: {
                        full_name: data.fullName.trim(),
                        employee_id: data.employeeId.trim(), // Keep original case for display if needed, or normalize?. Usually IDs are case insensitive but let's just trim.
                        region: data.region,
                        age: data.age,
                        vehicle_type: data.vehicle_type,
                        phone_number: data.phone_number?.trim(),
                        role: data.role || 'driver'
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
            // Convert Employee ID to internal email format directly
            // This removes the need for the 'email' column in the profiles table
            const email = data.employeeId.includes('@')
                ? data.employeeId
                : `${data.employeeId.toLowerCase().trim()}@safepass.internal`;

            const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
                email: email,
                password: data.password,
            });

            if (authError) throw authError;
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

    onAuthStateChange(callback: (event: string, session: any) => void) {
        return supabase.auth.onAuthStateChange(callback);
    },

    /**
     * Get all users (Manager only)
     */
    async getAllUsers() {
        try {
            const { data: users, error } = await supabase
                .from('profiles')
                .select('*')
                .order('created_at', { ascending: false });

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
};
