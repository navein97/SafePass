-- ==========================================
-- MULTI-TENANT ROW LEVEL SECURITY (RLS) FIXES
-- ==========================================
-- Run this script in the Supabase SQL Editor.
-- It ensures that users can only view and interact with data
-- that belongs to their own company/workspace.

-- 1. Helper function to get current user's company_id
CREATE OR REPLACE FUNCTION public.get_my_company_id()
RETURNS UUID AS $$
  SELECT company_id FROM public.profiles WHERE id = auth.uid();
$$ LANGUAGE sql SECURITY DEFINER STABLE;

-- 2. Secure profiles table
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view profiles in their company" ON public.profiles;
CREATE POLICY "Users can view profiles in their company"
ON public.profiles FOR SELECT
TO authenticated
USING (
  -- Users can always see their own profile OR
  id = auth.uid() OR
  -- Users can see anyone else's profile IF they belong to the same company
  company_id = public.get_my_company_id()
);

DROP POLICY IF EXISTS "Users can update their own profile" ON public.profiles;
CREATE POLICY "Users can update their own profile"
ON public.profiles FOR UPDATE
TO authenticated
USING (id = auth.uid());

-- 3. Secure user_batch_progress table
ALTER TABLE public.user_batch_progress ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view batch progress for their company" ON public.user_batch_progress;
CREATE POLICY "Users can view batch progress for their company"
ON public.user_batch_progress FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  user_id IN (SELECT id FROM public.profiles WHERE company_id = public.get_my_company_id())
);

DROP POLICY IF EXISTS "Users can insert their own batch progress" ON public.user_batch_progress;
CREATE POLICY "Users can insert their own batch progress"
ON public.user_batch_progress FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

-- 4. Secure quiz_attempts table
ALTER TABLE public.quiz_attempts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view quiz attempts for their company" ON public.quiz_attempts;
CREATE POLICY "Users can view quiz attempts for their company"
ON public.quiz_attempts FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  user_id IN (SELECT id FROM public.profiles WHERE company_id = public.get_my_company_id())
);

DROP POLICY IF EXISTS "Users can insert their own quiz attempts" ON public.quiz_attempts;
CREATE POLICY "Users can insert their own quiz attempts"
ON public.quiz_attempts FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

-- 5. Secure compliance_logs table
ALTER TABLE public.compliance_logs ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view compliance logs for their company" ON public.compliance_logs;
CREATE POLICY "Users can view compliance logs for their company"
ON public.compliance_logs FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  user_id IN (SELECT id FROM public.profiles WHERE company_id = public.get_my_company_id())
);

DROP POLICY IF EXISTS "Users can insert their own compliance logs" ON public.compliance_logs;
CREATE POLICY "Users can insert their own compliance logs"
ON public.compliance_logs FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

DROP POLICY IF EXISTS "Users can update their own compliance logs" ON public.compliance_logs;
CREATE POLICY "Users can update their own compliance logs"
ON public.compliance_logs FOR UPDATE
TO authenticated
USING (user_id = auth.uid());

-- 6. Secure posts table (Social Screen)
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view posts from their company" ON public.posts;
CREATE POLICY "Users can view posts from their company"
ON public.posts FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  user_id IN (SELECT id FROM public.profiles WHERE company_id = public.get_my_company_id())
);

DROP POLICY IF EXISTS "Users can create their own posts" ON public.posts;
CREATE POLICY "Users can create their own posts"
ON public.posts FOR INSERT
TO authenticated
WITH CHECK (user_id = auth.uid());

-- 7. Secure post_likes table
ALTER TABLE public.post_likes ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can view likes from their company" ON public.post_likes;
CREATE POLICY "Users can view likes from their company"
ON public.post_likes FOR SELECT
TO authenticated
USING (
  user_id = auth.uid() OR
  user_id IN (SELECT id FROM public.profiles WHERE company_id = public.get_my_company_id())
);

DROP POLICY IF EXISTS "Users can manage their own likes" ON public.post_likes;
CREATE POLICY "Users can manage their own likes"
ON public.post_likes FOR ALL
TO authenticated
USING (user_id = auth.uid())
WITH CHECK (user_id = auth.uid());
