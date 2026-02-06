-- ============================================
-- DIAGNOSTIC QUERIES FOR USER CREATION ISSUE
-- Run these in Supabase SQL Editor to identify the problem
-- ============================================

-- 1. Check if all required columns exist in profiles table
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' 
  AND table_name = 'profiles'
ORDER BY ordinal_position;

-- Expected columns should include:
-- id, email, full_name, employee_id, region, role, age, vehicle_type, phone_number, designation

-- 2. Check the current handle_new_user function
SELECT prosrc 
FROM pg_proc 
WHERE proname = 'handle_new_user';

-- 3. Check if there are any triggers on auth.users
SELECT trigger_name, event_manipulation, action_statement
FROM information_schema.triggers
WHERE event_object_table = 'users'
  AND event_object_schema = 'auth';

-- ============================================
-- INSTRUCTIONS:
-- 1. Run query #1 first and share the results
-- 2. This will show us which columns are missing
-- ============================================
