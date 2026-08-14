import { supabase } from '../lib/supabase';

const DEFAULT_PASSCODE = '280397';

export const PasscodeService = {
  /**
   * Fetches the portal passcode from Supabase app_settings table.
   * Falls back to '280397' if table/key is not set or network fails.
   */
  async getPasscode(): Promise<string> {
    try {
      const { data, error } = await supabase
        .from('app_settings')
        .select('value')
        .eq('key', 'portal_passcode')
        .single();

      if (error || !data || !data.value) {
        // Auto-insert default passcode if row is missing
        await supabase.from('app_settings').upsert({
          key: 'portal_passcode',
          value: DEFAULT_PASSCODE,
          updated_at: new Date().toISOString(),
        });
        return DEFAULT_PASSCODE;
      }

      return data.value.trim();
    } catch (err) {
      console.warn('[PasscodeService] Error fetching passcode, using default:', err);
      return DEFAULT_PASSCODE;
    }
  },

  /**
   * Verifies an input passcode against the stored or default passcode.
   */
  async verifyPasscode(inputPasscode: string): Promise<boolean> {
    const validPasscode = await this.getPasscode();
    return inputPasscode.trim() === validPasscode;
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
