-- Ensure unique constraints on profiles table to prevent duplication
-- Run this in Supabase SQL Editor

-- 1. Ensure employee_id is unique
-- This is the critical check to prevent duplicate users
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'profiles_employee_id_key' 
        AND conrelid = 'public.profiles'::regclass
    ) THEN
        ALTER TABLE public.profiles ADD CONSTRAINT profiles_employee_id_key UNIQUE (employee_id);
    END IF;
END $$;

-- 2. Email constraint removed as the column does not exist in profiles.
-- The auth.users table (Supabase internal) already handles email uniqueness.
