import { supabase } from '../lib/supabase';
import { NotificationService } from './notificationService';

export interface MasterCompany {
  id: string;
  name: string;
  code?: string;
  created_at: string;
  is_beta_tester?: boolean;
  master_user?: {
    id: string;
    full_name?: string;
    email?: string;
    phone_number?: string;
    role?: string;
    created_at?: string;
  };
  total_drivers?: number;
  total_quizzes?: number;
  average_score?: number;
}

export const SuperAdminService = {
  /**
   * Fetches all registered companies and their corresponding master users (Level 1 Managers).
   */
  async getAllMasterCompanies(): Promise<MasterCompany[]> {
    try {
      // 1. Fetch companies
      const { data: companies, error: compErr } = await supabase
        .from('companies')
        .select('*')
        .order('created_at', { ascending: false });

      if (compErr) throw compErr;
      if (!companies || companies.length === 0) return [];

      // 2. Fetch profiles to link master users & counts
      const companyIds = companies.map(c => c.id);

      const { data: profiles, error: profErr } = await supabase
        .from('profiles')
        .select('*')
        .in('company_id', companyIds);

      if (profErr) console.warn('[SuperAdminService] Error fetching profiles:', profErr);

      const profileUserIds = (profiles || []).map(p => p.id);

      const { data: quizResults, error: quizErr } = await supabase
        .from('quiz_attempts')
        .select('user_id, score')
        .in('user_id', profileUserIds.length > 0 ? profileUserIds : ['00000000-0000-0000-0000-000000000000']);

      if (quizErr) console.warn('[SuperAdminService] Error fetching quiz attempts:', quizErr);

      return companies.map(comp => {
        const compProfiles = (profiles || []).filter(p => p.company_id === comp.id);
        const masterUser = compProfiles.find(p => p.role === 'manager' && (p.manager_level === 1 || !p.manager_level)) || compProfiles[0];
        
        const compProfileIds = compProfiles.map(p => p.id);
        const compQuizzes = (quizResults || []).filter(q => compProfileIds.includes(q.user_id));

        const avgScore = compQuizzes.length > 0
          ? Math.round(compQuizzes.reduce((sum, q) => sum + (q.score || 0), 0) / compQuizzes.length)
          : 0;

        return {
          id: comp.id,
          name: comp.name || 'Unnamed Company',
          code: comp.code || comp.company_code || '',
          created_at: comp.created_at,
          is_beta_tester: comp.is_beta_tester || false,
          master_user: masterUser ? {
            id: masterUser.id,
            full_name: masterUser.full_name || masterUser.name || 'Master User',
            email: masterUser.email || '',
            phone_number: masterUser.phone_number || masterUser.phone || '',
            role: masterUser.role,
            created_at: masterUser.created_at
          } : undefined,
          total_drivers: compProfiles.filter(p => p.role === 'driver').length,
          total_quizzes: compQuizzes.length,
          average_score: avgScore
        };
      });
    } catch (err) {
      console.error('[SuperAdminService] Error fetching master companies:', err);
      return [];
    }
  },

  /**
   * Toggles the Beta Tester status for a master user's company.
   */
  async toggleBetaStatus(companyId: string, currentStatus: boolean): Promise<boolean> {
    try {
      const { error } = await supabase
        .from('companies')
        .update({ is_beta_tester: !currentStatus })
        .eq('id', companyId);

      if (error) throw error;
      return true;
    } catch (err) {
      console.error('[SuperAdminService] Error toggling beta status:', err);
      return false;
    }
  },

  /**
   * Sends targeted messages / notifications to specific master users or beta testers.
   */
  async sendTargetedNotification({
    targetType, // 'all_masters' | 'beta_masters' | 'specific_company'
    companyId,
    title,
    message,
  }: {
    targetType: 'all_masters' | 'beta_masters' | 'specific_company';
    companyId?: string;
    title: string;
    message: string;
  }): Promise<{ success: boolean; count: number; error?: string }> {
    try {
      const allCompanies = await this.getAllMasterCompanies();
      let targetCompanies: MasterCompany[] = [];

      if (targetType === 'all_masters') {
        targetCompanies = allCompanies;
      } else if (targetType === 'beta_masters') {
        targetCompanies = allCompanies.filter(c => c.is_beta_tester);
      } else if (targetType === 'specific_company' && companyId) {
        targetCompanies = allCompanies.filter(c => c.id === companyId);
      }

      const masterUserIds = targetCompanies
        .map(c => c.master_user?.id)
        .filter((id): id is string => Boolean(id));

      if (masterUserIds.length === 0) {
        return { success: false, count: 0, error: 'No master users found for the selected filter.' };
      }

      let count = 0;
      for (const userId of masterUserIds) {
        await NotificationService.sendNotification({
          userId,
          title,
          body: message,
          data: { type: 'admin_broadcast', sent_at: new Date().toISOString() }
        });
        count++;
      }

      return { success: true, count };
    } catch (err: any) {
      console.error('[SuperAdminService] Error sending targeted notification:', err);
      return { success: false, count: 0, error: err.message || 'Failed to send targeted notification' };
    }
  },

  /**
   * Telemetry / Incognito inspect view data for a specific master user company.
   */
  async inspectCompanyTelemetry(companyId: string) {
    try {
      const { data: drivers } = await supabase
        .from('profiles')
        .select('*')
        .eq('company_id', companyId);

      const driverIds = (drivers || []).map(d => d.id);

      const { data: quizLogs } = await supabase
        .from('quiz_attempts')
        .select('*')
        .in('user_id', driverIds.length > 0 ? driverIds : ['00000000-0000-0000-0000-000000000000'])
        .order('created_at', { ascending: false })
        .limit(20);

      const { data: notifications } = await supabase
        .from('notifications')
        .select('*')
        .in('user_id', (drivers || []).map(d => d.id))
        .order('created_at', { ascending: false })
        .limit(20);

      return {
        drivers: drivers || [],
        recentQuizzes: quizLogs || [],
        recentNotifications: notifications || [],
      };
    } catch (err) {
      console.error('[SuperAdminService] Error inspecting company:', err);
      return { drivers: [], recentQuizzes: [], recentNotifications: [] };
    }
  },

  /**
   * Read the global daily quiz limit from app_settings.
   * Defaults to 5 if not configured.
   */
  async getGlobalDailyLimit(): Promise<number> {
    try {
      const { data, error } = await supabase
        .from('app_settings')
        .select('value')
        .eq('key', 'global_daily_quiz_limit')
        .maybeSingle();

      if (error) {
        console.warn('[SuperAdminService] Error reading global daily limit:', error.message);
        return 5;
      }

      const parsed = parseInt(String(data?.value ?? '5'), 10);
      return isNaN(parsed) || parsed < 1 ? 5 : parsed;
    } catch (err) {
      console.error('[SuperAdminService] getGlobalDailyLimit error:', err);
      return 5;
    }
  },

  /**
   * Save the global daily quiz limit to app_settings.
   */
  async setGlobalDailyLimit(limit: number): Promise<boolean> {
    try {
      const { error } = await supabase
        .from('app_settings')
        .upsert(
          { key: 'global_daily_quiz_limit', value: limit, updated_at: new Date().toISOString() },
          { onConflict: 'key' }
        );

      if (error) throw error;
      return true;
    } catch (err) {
      console.error('[SuperAdminService] setGlobalDailyLimit error:', err);
      return false;
    }
  },
};
