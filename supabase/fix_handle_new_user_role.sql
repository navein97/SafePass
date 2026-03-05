-- ============================================
-- FIX: Add missing EMAIL column and update trigger
-- The profiles table is missing the 'email' column
-- Run this in Supabase SQL Editor
-- ============================================

-- Step 1: Add the missing email column
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS email TEXT UNIQUE;

-- Step 2: Update existing records to have email (if any exist without it)
-- This populates email based on employee_id for existing users
UPDATE public.profiles 
SET email = LOWER(employee_id) || '@driver360.internal'
WHERE email IS NULL;

-- Step 3: Make email NOT NULL after populating existing records
ALTER TABLE public.profiles 
ALTER COLUMN email SET NOT NULL;

-- Step 4: Recreate the handle_new_user function (same as before)
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (
    id, 
    email, 
    full_name, 
    employee_id, 
    region, 
    role,
    age,
    vehicle_type,
    phone_number,
    designation
  )
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'employee_id', 'PENDING'),
    COALESCE(NEW.raw_user_meta_data->>'region', 'MY'),
    COALESCE(NEW.raw_user_meta_data->>'role', 'driver'),
    (NEW.raw_user_meta_data->>'age')::INTEGER,
    NEW.raw_user_meta_data->>'vehicle_type',
    NEW.raw_user_meta_data->>'phone_number',
    NEW.raw_user_meta_data->>'designation'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================
-- VERIFICATION
-- ============================================
-- Run this to verify email column was added:
SELECT column_name, data_type, is_nullable 
FROM information_schema.columns 
WHERE table_name = 'profiles' AND column_name = 'email';

-- Expected output:
-- email | text | NO

-- ============================================
-- After running this, try creating a user again!
-- ============================================
