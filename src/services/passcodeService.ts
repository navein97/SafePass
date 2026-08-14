import { supabase } from '../lib/supabase';

export const PasscodeService = {
  /**
   * Fetches the portal passcode from Supabase app_settings table for authenticated super admins.
   */
  async getPasscode(): Promise<string | null> {
    try {
      const { data, error } = await supabase
        .from('app_settings')
        .select('value')
        .eq('key', 'portal_passcode')
        .single();

      if (error || !data || !data.value) {
        return null;
      }

      return data.value.trim();
    } catch (err) {
      console.warn('[PasscodeService] Error fetching passcode:', err);
      return null;
    }
  },

  /**
   * Verifies an input passcode against the stored passcode.
   */
  async verifyPasscode(inputPasscode: string): Promise<boolean> {
    try {
      const validPasscode = await this.getPasscode();
      if (!validPasscode) {
        // Fallback: check if the user is authenticated as super_admin
        const { data: { user } } = await supabase.auth.getUser();
        if (!user) return false;

        const { data: profile } = await supabase
          .from('profiles')
          .select('role')
          .eq('id', user.id)
          .single();

        return profile?.role === 'super_admin';
      }
      return inputPasscode.trim() === validPasscode;
    } catch {
      return false;
    }
  },

  /**
   * Updates the portal passcode in Supabase app_settings table.
   */
  async updatePasscode(newPasscode: string): Promise<{ success: boolean; error?: string }> {
    try {
      const { error } = await supabase
        .from('app_settings')
        .upsert({
          key: 'portal_passcode',
          value: newPasscode.trim(),
          updated_at: new Date().toISOString(),
        });

      if (error) throw error;
      return { success: true };
    } catch (err: any) {
      console.error('[PasscodeService] Error updating passcode:', err);
      return { success: false, error: err.message || 'Failed to update passcode' };
    }
  }
};
