
import { supabase } from '../lib/supabase';
import { AuthService, SignUpData } from './authService';

export interface RegisterWorkspaceData extends SignUpData {
    companyName: string;
}

export const WorkspaceService = {
    /**
     * Step 1: Register the Master User (no company yet)
     * Company name is stored in user metadata for later.
     * Company is only created AFTER email verification + first login.
     */
    async registerWorkspace(data: RegisterWorkspaceData) {
        try {
            // Just sign up the user with company_name in metadata
            const signUpResult = await AuthService.signUp({
                ...data,
                role: 'manager',
                manager_level: 1,
                isPublic: true,
                company_name: data.companyName, // Stored in metadata for later
            });

            if (signUpResult.error) {
                return { success: false, error: signUpResult.error };
            }

            return { success: true, user: signUpResult.user };
        } catch (error: any) {
            console.error('Workspace registration error:', error);
            return { success: false, error: error.message };
        }
    },

    /**
     * Step 2: Called after first login (email verified)
     * Checks if the user needs a company created and sets it up.
     */
    async setupWorkspaceIfNeeded() {
        try {
            console.log('[WorkspaceService] setupWorkspaceIfNeeded called');
            const { profile } = await AuthService.getUserProfile();
            if (!profile) {
                console.log('[WorkspaceService] No profile found, aborting');
                return;
            }

            console.log('[WorkspaceService] Profile:', {
                role: profile.role,
                manager_level: profile.manager_level,
                company_id: profile.company_id,
            });

            // If user already has a company, nothing to do
            if (profile.company_id) {
                console.log('[WorkspaceService] Already has company, skipping');
                return;
            }

            // If user is a manager level 1 without a company, they need one
            if (profile.role === 'manager' && profile.manager_level === 1) {
                // Get company_name from auth metadata
                const { data: { user } } = await supabase.auth.getUser();
                const companyName = user?.user_metadata?.company_name;

                console.log('[WorkspaceService] user_metadata:', user?.user_metadata);
                console.log('[WorkspaceService] companyName:', companyName);

                if (!companyName) {
                    console.log('[WorkspaceService] No company_name in metadata, aborting');
                    return;
                }

                // Create company via RPC (bypasses RLS)
                console.log('[WorkspaceService] Creating company via RPC...');
                const { data: companyId, error: companyError } = await supabase
                    .rpc('register_workspace', {
                        p_company_name: companyName
                    });

                if (companyError) {
                    console.error('[WorkspaceService] Company creation error:', companyError);
                    return;
                }

                console.log('[WorkspaceService] Company created, ID:', companyId);

                // Link user to company via RPC (bypasses RLS)
                const { error: linkError } = await supabase.rpc('link_user_to_company', {
                    p_user_id: profile.id,
                    p_company_id: companyId
                });

                if (linkError) {
                    console.error('[WorkspaceService] Link error:', linkError);
                    return;
                }

                console.log('✅ Workspace created and linked:', companyId);
            }
        } catch (error: any) {
            console.error('Setup workspace error:', error);
        }
    }
};
