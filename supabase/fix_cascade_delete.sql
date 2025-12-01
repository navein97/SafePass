-- Fix: Add ON DELETE CASCADE to profiles table
-- This ensures that when a User is deleted from Auth, their Profile is also automatically deleted.

-- 1. Drop the existing foreign key constraint
-- Note: We use IF EXISTS just in case the name is different, but 'profiles_id_fkey' is the default.
ALTER TABLE public.profiles
DROP CONSTRAINT IF EXISTS profiles_id_fkey;

-- 2. Re-add the foreign key with ON DELETE CASCADE
ALTER TABLE public.profiles
ADD CONSTRAINT profiles_id_fkey
FOREIGN KEY (id)
REFERENCES auth.users(id)
ON DELETE CASCADE;

-- 3. Verify RLS Policy (Just to be safe, ensuring the Service Role can delete)
DROP POLICY IF EXISTS "Service role can delete profiles" ON public.profiles;

CREATE POLICY "Service role can delete profiles"
  ON public.profiles FOR DELETE
  USING (true);

-- INSTRUCTIONS:
-- 1. Copy this entire code.
-- 2. Go to Supabase Dashboard -> SQL Editor.
-- 3. Paste and Run.
-- 4. Try deleting the user again.
