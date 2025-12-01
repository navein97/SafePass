import { supabase } from '../lib/supabase';
import { Region } from '../types/models';
import { Platform } from 'react-native';

export interface SignUpData {
    email: string;
    password: string;
    fullName: string;
    employeeId: string;
    region: Region;
}

export interface SignInData {
    email: string;
    password: string;
}

export const AuthService = {
    /**
     * Register a new driver
     */
    async signUp(data: SignUpData) {
        try {
            // Use web URL for web platform, deep link for mobile
            const redirectUrl = Platform.OS === 'web'
                ? 'https://safepass-kappa.vercel.app/auth/callback'
                : 'safepass://auth/callback';

            const { data: authData, error: authError } = await supabase.auth.signUp({
                email: data.email,
                password: data.password,
                options: {
                    emailRedirectTo: redirectUrl,
                    data: {
                        full_name: data.fullName,
                        employee_id: data.employeeId,
                        region: data.region,
                    },
                },
            });

            if (authError) throw authError;

            // Debug logging
            console.log('✅ Signup successful!');
            console.log('📧 Email sent to:', data.email);
            console.log('🔗 Redirect URL:', redirectUrl);
            console.log('👤 User ID:', authData.user?.id);
            console.log('✉️ Email confirmation required:', !authData.user?.email_confirmed_at);

            return { user: authData.user, error: null };
        } catch (error: any) {
            console.error('Sign up error:', error);
            return { user: null, error: error.message };
        }
    },

    /**
     * Resend confirmation email
     */
    async resendConfirmationEmail(email: string) {
        try {
            const redirectUrl = Platform.OS === 'web'
                ? 'https://safepass-kappa.vercel.app/auth/callback'
                : 'safepass://auth/callback';

            const { error } = await supabase.auth.resend({
                type: 'signup',
                email: email,
                options: {
                    emailRedirectTo: redirectUrl,
                },
            });

            if (error) throw error;

            console.log('✅ Confirmation email resent to:', email);
            return { error: null };
        } catch (error: any) {
            console.error('Resend email error:', error);
            return { error: error.message };
        }
    },

    /**
     * Sign in existing user
     */
    async signIn(data: SignInData) {
        try {
            const { data: authData, error: authError } = await supabase.auth.signInWithPassword({
                email: data.email,
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
     * Get current session
     */
    async getSession() {
        try {
            const { data: { session }, error } = await supabase.auth.getSession();
            if (error) throw error;
            return { session, error: null };
        } catch (error: any) {
            console.error('Get session error:', error);
            return { session: null, error: error.message };
        }
    },

    /**
     * Get current user profile
     */
    async getUserProfile() {
        try {
            const { data: { user } } = await supabase.auth.getUser();

            if (!user) {
                return { profile: null, error: 'No user logged in' };
            }

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
     * Listen to auth state changes
     */
    onAuthStateChange(callback: (event: string, session: any) => void) {
        return supabase.auth.onAuthStateChange(callback);
    },
};
