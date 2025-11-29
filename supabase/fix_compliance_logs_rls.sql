-- Fix RLS policy for compliance_logs to allow upsert operations
-- This allows users to both INSERT and UPDATE their own compliance logs

-- Drop existing policies
DROP POLICY IF EXISTS "Users can create own compliance logs" ON public.compliance_logs;
DROP POLICY IF EXISTS "Users can view own compliance logs" ON public.compliance_logs;
DROP POLICY IF EXISTS "Managers can view all compliance logs" ON public.compliance_logs;
DROP POLICY IF EXISTS "Users can view all compliance logs" ON public.compliance_logs;

-- Allow users to INSERT their own compliance logs
CREATE POLICY "Users can insert own compliance logs"
  ON public.compliance_logs FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Allow users to UPDATE their own compliance logs (needed for upsert)
CREATE POLICY "Users can update own compliance logs"
  ON public.compliance_logs FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- Allow all authenticated users to view all compliance logs (for leaderboard)
CREATE POLICY "Users can view all compliance logs"
  ON public.compliance_logs FOR SELECT
  USING (auth.role() = 'authenticated');
