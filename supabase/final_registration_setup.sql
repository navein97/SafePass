-- FINAL REGISTRATION & ONBOARDING SETUP
-- Run this in Supabase SQL Editor to ensure all columns and policies are ready.

-- 1. Ensure Profiles table has all necessary columns
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS manager_level INTEGER;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS company_id UUID REFERENCES public.companies(id);
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS phone_number TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS age INTEGER;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS vehicle_type TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS designation TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS address TEXT;

-- 2. Enable Anonymous Company Creation (For Self-Serve Registration)
-- This allows new users to register their company before they have an account
CREATE POLICY "Allow anonymous company creation" 
ON public.companies FOR INSERT 
TO anon 
WITH CHECK (true);

-- 3. Update handle_new_user function to map ALL metadata correctly
-- This is critical so that company_id and role are set during registration
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
    manager_level, 
    company_id,
    age,
    vehicle_type,
    phone_number,
    designation,
    address
  )
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'employee_id', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'region', 'MY'),
    COALESCE(NEW.raw_user_meta_data->>'role', 'driver'),
    (NEW.raw_user_meta_data->>'manager_level')::int,
    (NEW.raw_user_meta_data->>'company_id')::uuid,
    (NEW.raw_user_meta_data->>'age')::int,
    NEW.raw_user_meta_data->>'vehicle_type',
    NEW.raw_user_meta_data->>'phone_number',
    NEW.raw_user_meta_data->>'designation',
    NEW.raw_user_meta_data->>'address'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Ensure public.companies can be viewed by its employees
-- (Already mostly in companies.sql but let's be safe)
DROP POLICY IF EXISTS "Users can view own company" ON public.companies;
CREATE POLICY "Users can view own company" 
ON public.companies FOR SELECT 
TO authenticated
USING (
  id IN (
    SELECT company_id FROM public.profiles WHERE id = auth.uid()
  )
);
