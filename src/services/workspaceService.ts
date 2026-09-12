
import { supabase } from '../lib/supabase';
import { AuthService, SignUpData } from './authService';
import { OtpService } from './otpService';

export interface RegisterWorkspaceData extends SignUpData {
    companyName: string;
    companyCode?: string;
    captchaToken?: string;
}

export const WorkspaceService = {
    /**
     * Step 1: Register the Master User (no company yet)
     * Company name is stored in user metadata for later.
     * Company is created upon setupWorkspaceIfNeeded after login.
     * Triggers SMS OTP send immediately to user's phone number.
     */
    async registerWorkspace(data: RegisterWorkspaceData) {
        try {
            // Check if company code is already taken before signing up user
            if (data.companyCode) {
                const cleanCode = data.companyCode.trim().toUpperCase();
                const { data: existingComp } = await supabase
                    .from('companies')
                    .select('id')
                    .eq('code', cleanCode)
                    .maybeSingle();

                if (existingComp) {
                    return {
                        success: false,
                        error: `Company code "${cleanCode}" is already taken. Please choose another code.`,
                    };
                }
            }

            // Just sign up the user with company_name in metadata
            const signUpResult = await AuthService.signUp({
                ...data,
                role: 'manager',
                manager_level: 1,
                isPublic: true,
                company_name: data.companyName, // Stored in metadata for later
                company_code: data.companyCode ? data.companyCode.trim().toUpperCase() : undefined,
                captchaToken: data.captchaToken,
            });

            if (signUpResult.error) {
                return { success: false, error: signUpResult.error };
            }

            const userId = signUpResult.user?.id;
            const phone = data.phone_number;

            // Automatically send the first SMS OTP via Supabase Auth
            if (phone) {
                try {
                    await OtpService.sendSmsOtp(phone);
                } catch (otpErr) {
                    console.warn('[WorkspaceService] Initial OTP send error:', otpErr);
                }
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

            const { profile } = await AuthService.getUserProfile();
            if (!profile) {

                return;
            }

            // If user already has a company, nothing to do
            if (profile.company_id) {

                return;
            }

            // If user is a manager level 1 without a company, they need one
            if (profile.role === 'manager' && profile.manager_level === 1) {
                // Get company_name from auth metadata
                const { data: { user } } = await supabase.auth.getUser();
                const companyName = user?.user_metadata?.company_name;
                const companyCode = user?.user_metadata?.company_code;

                if (!companyName) {

                    return;
                }

                // Create company via RPC (bypasses RLS)
                const { data: companyId, error: companyError } = await supabase
                    .rpc('register_workspace', {
                        p_company_name: companyName,
                        p_company_code: companyCode || null
                    });

                if (companyError) {
                    console.error('[WorkspaceService] Company creation error:', companyError);
                    // If company code was already taken (e.g. re-registration), link to that existing company
                    if (companyCode && companyError.message?.includes('already taken')) {
                        const { data: existingComp } = await supabase
                            .from('companies')
                            .select('id')
                            .eq('code', companyCode.trim().toUpperCase())
                            .maybeSingle();

                        if (existingComp?.id) {
                            console.log('[WorkspaceService] Linking to existing company:', existingComp.id);
                            await supabase.rpc('link_user_to_company', {
                                p_user_id: profile.id,
                                p_company_id: existingComp.id
                            });
                            return;
                        }
                    }
                    return;
                }

                // Link user to company via RPC (bypasses RLS)
                const { error: linkError } = await supabase.rpc('link_user_to_company', {
                    p_user_id: profile.id,
                    p_company_id: companyId
                });

                if (linkError) {
                    console.error('[WorkspaceService] Link error:', linkError);
                    return;
                }
            }
        } catch (error: any) {
            console.error('Setup workspace error:', error);
        }
    }
};
