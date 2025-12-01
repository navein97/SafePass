-- Fix: Allow user deletion by adding DELETE policies
-- This allows Supabase Auth to properly delete users and their associated data

-- ============================================
-- 1. Add DELETE policy for profiles (Service Role)
-- ============================================

-- Allow service role (Supabase backend) to delete profiles
-- This is needed when deleting users from the Auth dashboard
CREATE POLICY "Service role can delete profiles"
  ON public.profiles FOR DELETE
  USING (true);

-- ============================================
-- 2. Optional: Allow users to delete their own profile
-- ============================================

-- Uncomment this if you want users to be able to delete their own accounts
-- CREATE POLICY "Users can delete own profile"
--   ON public.profiles FOR DELETE
--   USING (auth.uid() = id);

-- ============================================
-- 3. Verify CASCADE is working
-- ============================================

-- The following tables already have ON DELETE CASCADE:
-- - quiz_attempts (user_id REFERENCES profiles(id) ON DELETE CASCADE)
-- - compliance_logs (user_id REFERENCES profiles(id) ON DELETE CASCADE)
-- 
-- This means when a profile is deleted, all related data is automatically deleted

-- ============================================
-- INSTRUCTIONS:
-- ============================================
-- 1. Go to Supabase Dashboard
-- 2. Navigate to SQL Editor
-- 3. Create a new query
-- 4. Paste this entire file
-- 5. Click "Run"
-- 6. Try deleting a user again - it should work!
