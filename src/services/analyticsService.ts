import { supabase } from '../lib/supabase';

export interface AppEvent {
  id?: string;
  event_name: string;
  user_id?: string;
  company_id?: string;
  metadata?: Record<string, any>;
  created_at?: string;
}

export const AnalyticsService = {
  /**
   * Silently tracks an event to Supabase app_events table.
   * Fails gracefully if table or network is unavailable.
   */
  async trackEvent(eventName: string, metadata: Record<string, any> = {}): Promise<void> {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      let companyId = metadata.company_id || null;

      if (user && !companyId) {
        // Try fetching company_id from user metadata or profile
        companyId = user.user_metadata?.company_id || null;
      }

      await supabase.from('app_events').insert({
        event_name: eventName,
        user_id: user?.id || null,
        company_id: companyId,
        metadata,
        created_at: new Date().toISOString(),
      });
    } catch (err) {
      // Fail silently to avoid breaking core app experience
      console.debug('[AnalyticsService] Silently failed to track event:', eventName, err);
    }
  },

  /**
   * Fetches recent event log history for Super Admin dashboard.
   */
  async getRecentEvents(limit: number = 50): Promise<AppEvent[]> {
    try {
      const { data, error } = await supabase
        .from('app_events')
        .select('*')
        .order('created_at', { ascending: false })
        .limit(limit);

      if (error) throw error;
      return data || [];
    } catch (err) {
      console.warn('[AnalyticsService] Unable to fetch events:', err);
      return [];
    }
  },

  /**
   * Fetches high-level usage metrics for Super Admin.
   */
  async getUsageMetrics() {
    try {
      const { count: totalEvents } = await supabase
        .from('app_events')
        .select('*', { count: 'exact', head: true });

      const { count: totalCompanies } = await supabase
        .from('companies')
        .select('*', { count: 'exact', head: true });

      const { count: totalProfiles } = await supabase
        .from('profiles')
        .select('*', { count: 'exact', head: true });

      const { count: totalQuizzes } = await supabase
        .from('quiz_results')
        .select('*', { count: 'exact', head: true });

      return {
        totalEvents: totalEvents || 0,
        totalCompanies: totalCompanies || 0,
        totalUsers: totalProfiles || 0,
        totalQuizzes: totalQuizzes || 0,
      };
    } catch (err) {
      console.warn('[AnalyticsService] Error fetching metrics:', err);
      return {
        totalEvents: 0,
        totalCompanies: 0,
        totalUsers: 0,
        totalQuizzes: 0,
      };
    }
  }
};
