-- =============================================
-- FIX: Master User role not being set on registration
-- The handle_new_user trigger was not reading 'role' and 'manager_level'
-- from auth metadata, so all new users defaulted to 'driver'.
-- Run this in Supabase SQL Editor.
-- =============================================

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
    CASE 
      WHEN NEW.raw_user_meta_data->>'manager_level' IS NOT NULL 
           AND NEW.raw_user_meta_data->>'manager_level' ~ '^\d+$'
      THEN (NEW.raw_user_meta_data->>'manager_level')::int
      ELSE NULL
    END,
    CASE 
      WHEN NEW.raw_user_meta_data->>'company_id' IS NOT NULL 
           AND NEW.raw_user_meta_data->>'company_id' != ''
           AND NEW.raw_user_meta_data->>'company_id' != 'undefined'
      THEN (NEW.raw_user_meta_data->>'company_id')::uuid
      ELSE NULL
    END,
    CASE 
      WHEN NEW.raw_user_meta_data->>'age' IS NOT NULL 
           AND NEW.raw_user_meta_data->>'age' ~ '^\d+$'
      THEN (NEW.raw_user_meta_data->>'age')::int
      ELSE NULL
    END,
    NEW.raw_user_meta_data->>'vehicle_type',
    NEW.raw_user_meta_data->>'phone_number',
    NEW.raw_user_meta_data->>'designation',
    NEW.raw_user_meta_data->>'address'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
