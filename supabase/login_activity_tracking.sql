-- ============================================================
-- LOGIN ACTIVITY TRACKING
-- Run this in Supabase SQL Editor to enable login tracking.
-- Tracks all successful logins (password & session restore).
-- ============================================================

-- 1. Create the login_logs table
CREATE TABLE IF NOT EXISTS public.login_logs (
  id              UUID        PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id         UUID        REFERENCES auth.users(id) ON DELETE SET NULL,
  full_name       TEXT,
  employee_id     TEXT,
  role            TEXT,          -- 'driver', 'manager'
  manager_level   INTEGER,       -- 1 = master user, 2 = sub-manager, NULL = driver
  company_id      UUID,
  company_name    TEXT,
  login_type      TEXT NOT NULL DEFAULT 'password',  -- 'password' | 'session_restore'
  logged_in_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- 2. Indexes for common query patterns
CREATE INDEX IF NOT EXISTS idx_login_logs_logged_in_at  ON public.login_logs(logged_in_at DESC);
CREATE INDEX IF NOT EXISTS idx_login_logs_role          ON public.login_logs(role);
CREATE INDEX IF NOT EXISTS idx_login_logs_company_id    ON public.login_logs(company_id);
CREATE INDEX IF NOT EXISTS idx_login_logs_user_id       ON public.login_logs(user_id);

-- 3. Enable RLS
ALTER TABLE public.login_logs ENABLE ROW LEVEL SECURITY;

-- 4. Allow any authenticated user to INSERT their own login record
DROP POLICY IF EXISTS "Users can insert own login log" ON public.login_logs;
CREATE POLICY "Users can insert own login log"
  ON public.login_logs
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- 5. Restrict SELECT to service role only (Super Admin reads via service key / RPC)
--    Regular users cannot read the login log table directly.
DROP POLICY IF EXISTS "No direct reads" ON public.login_logs;
CREATE POLICY "No direct reads"
  ON public.login_logs
  FOR SELECT
  USING (false);

-- ============================================================
-- SETUP COMPLETE
-- The app will insert a row on every successful login.
-- Super Admin reads via superAdminService using a privileged RPC
-- or the Supabase service role key in a future Edge Function.
-- For now, Super Admin reads are done by temporarily granting
-- SELECT to the authenticated role for super admin users only.
-- ============================================================

-- 6. (Recommended) Grant super admin read access via RPC
-- This function returns login logs, callable by any authenticated user.
-- Security is enforced by the passcode gate in the app.
CREATE OR REPLACE FUNCTION public.get_login_logs(
  p_limit     INTEGER DEFAULT 100,
  p_role      TEXT    DEFAULT NULL,
  p_company_id UUID   DEFAULT NULL
)
RETURNS SETOF public.login_logs
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT *
  FROM public.login_logs
  WHERE
    (p_role IS NULL OR role = p_role)
    AND (p_company_id IS NULL OR company_id = p_company_id)
  ORDER BY logged_in_at DESC
  LIMIT p_limit;
$$;

-- 7. Quick stats helper
CREATE OR REPLACE FUNCTION public.get_login_stats()
RETURNS JSON
LANGUAGE sql
SECURITY DEFINER
SET search_path = public
AS $$
  SELECT json_build_object(
    'total_today',
      (SELECT COUNT(*) FROM public.login_logs
       WHERE logged_in_at >= CURRENT_DATE),
    'unique_users_today',
      (SELECT COUNT(DISTINCT user_id) FROM public.login_logs
       WHERE logged_in_at >= CURRENT_DATE),
    'driver_logins_today',
      (SELECT COUNT(*) FROM public.login_logs
       WHERE logged_in_at >= CURRENT_DATE AND role = 'driver'),
    'manager_logins_today',
      (SELECT COUNT(*) FROM public.login_logs
       WHERE logged_in_at >= CURRENT_DATE AND role = 'manager' AND (manager_level IS NULL OR manager_level != 1)),
    'master_logins_today',
      (SELECT COUNT(*) FROM public.login_logs
       WHERE logged_in_at >= CURRENT_DATE AND role = 'manager' AND manager_level = 1),
    'total_all_time',
      (SELECT COUNT(*) FROM public.login_logs)
  );
$$;
