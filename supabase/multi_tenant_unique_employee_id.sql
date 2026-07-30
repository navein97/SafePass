-- ==========================================================
-- MULTI-TENANT UNIQUE EMPLOYEE ID FIX
-- ==========================================================
-- Run this script in the Supabase SQL Editor.
-- This allows different companies to use the same Driver ID (e.g. 'MY001')
-- but prevents the same company from creating duplicate 'MY001's.

DO $$
BEGIN
    -- 1. Drop the global unique constraint on employee_id (if it exists)
    IF EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'profiles_employee_id_key' 
        AND conrelid = 'public.profiles'::regclass
    ) THEN
        ALTER TABLE public.profiles DROP CONSTRAINT profiles_employee_id_key;
    END IF;

    -- 2. Add the new composite unique constraint (company_id + employee_id)
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'profiles_company_employee_id_key' 
        AND conrelid = 'public.profiles'::regclass
    ) THEN
        ALTER TABLE public.profiles ADD CONSTRAINT profiles_company_employee_id_key UNIQUE (company_id, employee_id);
    END IF;
END $$;
