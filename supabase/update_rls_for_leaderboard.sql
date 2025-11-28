-- =================================================================
-- UPDATE RLS POLICIES FOR PUBLIC LEADERBOARD
-- Run this in Supabase SQL Editor to allow everyone to see the leaderboard
-- =================================================================

-- 1. Allow all authenticated users to view ALL profiles (to see names)
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
CREATE POLICY "Users can view all profiles" 
  ON public.profiles FOR SELECT 
  USING (auth.role() = 'authenticated');

-- 2. Allow all authenticated users to view ALL compliance logs (to see scores)
DROP POLICY IF EXISTS "Users can view own compliance logs" ON public.compliance_logs;
CREATE POLICY "Users can view all compliance logs" 
  ON public.compliance_logs FOR SELECT 
  USING (auth.role() = 'authenticated');

-- 3. Allow all authenticated users to view ALL quiz attempts (optional, for transparency)
DROP POLICY IF EXISTS "Users can view own quiz attempts" ON public.quiz_attempts;
CREATE POLICY "Users can view all quiz attempts" 
  ON public.quiz_attempts FOR SELECT 
  USING (auth.role() = 'authenticated');
