-- ============================================
-- SIMPLIFIED FIX: Just remove the bad policy
-- ============================================

-- Drop ONLY the problematic policy I created in companies.sql
DROP POLICY IF EXISTS "Managers can view all profiles in company" ON public.profiles;

-- That's it! The old policies will continue to work.
-- The recursion was caused by this specific policy that checked profiles.company_id
