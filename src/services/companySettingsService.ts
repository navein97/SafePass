import { supabase } from '../lib/supabase';

export interface CompanyInfo {
    name: string;
    logo_url: string | null;
}

export const CompanySettingsService = {
    /**
     * Get company info (publicly accessible)
     */
    async getCompanyInfo(): Promise<CompanyInfo> {
        try {
            const { data, error } = await supabase
                .from('app_settings')
                .select('value')
                .eq('key', 'company_info')
                .single();

            if (error) {
                // Return default if not found (or table doesn't exist yet)
                console.warn('Error fetching company info:', error.message);
                return { name: 'SafePass', logo_url: null };
            }

            return data?.value || { name: 'SafePass', logo_url: null };
        } catch (error) {
            console.error('CompanySettingsService error:', error);
            return { name: 'SafePass', logo_url: null };
        }
    },

    /**
     * Update company info (Level 1 Managers only)
     */
    async updateCompanyInfo(info: CompanyInfo): Promise<{ success: boolean; error?: any }> {
        try {
            const { error } = await supabase
                .from('app_settings')
                .upsert({
                    key: 'company_info',
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
    }
};
