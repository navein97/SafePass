-- User Management Updates
-- 1. Update profiles table columns
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS phone_number TEXT;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS age INTEGER;
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS vehicle_type TEXT;

-- 2. Update Region Check Constraint
ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_region_check;
ALTER TABLE public.profiles ADD CONSTRAINT profiles_region_check CHECK (region IN ('MY', 'PT', 'TH', 'SG'));

-- 3. Update handle_new_user function to include new fields
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
    phone_number
  )
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'employee_id', split_part(NEW.email, '@', 1)),
    COALESCE(NEW.raw_user_meta_data->>'region', 'MY'),
    COALESCE(NEW.raw_user_meta_data->>'role', 'driver'),
    (NEW.raw_user_meta_data->>'age')::int,
    NEW.raw_user_meta_data->>'vehicle_type',
    NEW.raw_user_meta_data->>'phone_number'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. RPC for Manager to delete user
CREATE OR REPLACE FUNCTION public.delete_user(target_user_id UUID)
RETURNS void AS $$
DECLARE
    requesting_user_role TEXT;
BEGIN
    -- Check if the requester is a manager
    SELECT role INTO requesting_user_role FROM public.profiles WHERE id = auth.uid();
    
    IF requesting_user_role != 'manager' AND requesting_user_role != 'admin' THEN
        RAISE EXCEPTION 'Only managers can delete users';
    END IF;

    -- Delete from auth.users (cascades to profiles)
    DELETE FROM auth.users WHERE id = target_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Data Migration: Copy email prefix to employee_id for existing users
UPDATE public.profiles 
SET employee_id = split_part(email, '@', 1)
WHERE employee_id IS NULL OR employee_id = 'PENDING' OR employee_id = '';
