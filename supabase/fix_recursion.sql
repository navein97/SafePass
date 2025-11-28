-- =================================================================
-- FIX INFINITE RECURSION ERROR
-- Run this in Supabase SQL Editor
-- =================================================================

-- 1. Drop the problematic "Manager" policy that causes the loop
DROP POLICY IF EXISTS "Managers can view all profiles" ON public.profiles;

-- 2. Drop other existing read policies to avoid conflicts
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can view all profiles" ON public.profiles;

-- 3. Create a single, SAFE policy for reading profiles
-- This uses auth.role() which checks the token, NOT the table, preventing loops.
CREATE POLICY "Enable read access for all authenticated users"
ON public.profiles FOR SELECT
USING (auth.role() = 'authenticated');
