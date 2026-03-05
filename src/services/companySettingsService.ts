import { supabase } from '../lib/supabase';

export interface CompanyInfo {
    name: string;
    logo_url?: string | null;
}

export interface CompanyStats {
    drivers: number;
    managers: number;
    quota_drivers: number;
    quota_managers: number;
}

export const CompanySettingsService = {
    /**
     * Get company info, scoped to a specific company
     * If no companyId is provided, fetches the current user's company info
     */
    async getCompanyInfo(companyId?: string | null): Promise<CompanyInfo> {
        try {
            // If no companyId given, try to get it from the current user
            let resolvedCompanyId = companyId;
            if (!resolvedCompanyId) {
                resolvedCompanyId = await this.getCurrentUserCompanyId();
            }

            // Use a company-scoped key if we have a company ID
            const key = resolvedCompanyId ? `company_info_${resolvedCompanyId}` : 'company_info';

            const { data, error } = await supabase
                .from('app_settings')
                .select('value')
                .eq('key', key)
                .maybeSingle();

            if (error) {
                console.warn('Error fetching company info:', error.message);
                return { name: 'Driver 360', logo_url: null };
            }

            return data?.value || { name: 'Driver 360', logo_url: null };
        } catch (error) {
            console.error('CompanySettingsService error:', error);
            return { name: 'Driver 360', logo_url: null };
        }
    },

    /**
     * Update company info, scoped to a specific company
     */
    async updateCompanyInfo(info: CompanyInfo, companyId?: string | null): Promise<{ success: boolean; error?: any }> {
        try {
            // Resolve companyId if not provided
            let resolvedCompanyId = companyId;
            if (!resolvedCompanyId) {
                resolvedCompanyId = await this.getCurrentUserCompanyId();
            }

            const key = resolvedCompanyId ? `company_info_${resolvedCompanyId}` : 'company_info';

            const { error } = await supabase
                .from('app_settings')
                .upsert({
                    key: key,
                    value: info,
                    updated_at: new Date().toISOString()
                });

            if (error) throw error;
            return { success: true };
        } catch (error) {
            console.error('Error updating company info:', error);
            return { success: false, error };
        }
    },

    /**
     * Upload company logo to storage
     */
    async uploadCompanyLogo(uri: string): Promise<{ url: string | null; error?: any }> {
        try {
            // 1. Convert URI to Blob
            const response = await fetch(uri);
            const blob = await response.blob();

            // 2. Determine file extension
            const fileExt = uri.split('.').pop()?.toLowerCase() || 'jpg';
            const fileName = `logo_${Date.now()}.${fileExt}`;
            const filePath = `logos/${fileName}`;

            // 3. Upload to Supabase Storage
            // Note: 'company-assets' bucket must exist and be public
            const { data, error: uploadError } = await supabase.storage
                .from('company-assets')
                .upload(filePath, blob, {
                    contentType: `image/${fileExt === 'png' ? 'png' : 'jpeg'}`,
                    upsert: true
                });

            if (uploadError) throw uploadError;

            // 4. Get Public URL
            const { data: { publicUrl } } = supabase.storage
                .from('company-assets')
                .getPublicUrl(filePath);

            return { url: publicUrl, error: null };
        } catch (error) {
            console.error('Error uploading logo:', error);
            return { url: null, error };
        }
    },

    /**
     * Get current user's company ID
     */
    async getCurrentUserCompanyId(): Promise<string | null> {
        try {
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) return null;

            const { data: profile } = await supabase
                .from('profiles')
                .select('company_id')
                .eq('id', user.id)
                .single();

            return profile?.company_id || null;
        } catch (error) {
            console.error('Error getting company ID:', error);
            return null;
        }
    },

    /**
     * Get company quota statistics
     */
    async getCompanyStats(companyId: string): Promise<CompanyStats | null> {
        try {
            const { data, error } = await supabase.rpc('get_company_stats', {
                p_company_id: companyId
            });

            if (error) throw error;
            return data as CompanyStats;
        } catch (error) {
            console.error('Error getting company stats:', error);
            return null;
        }
    }
};
