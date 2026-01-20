-- Add trigger to automatically create profiles for new users with metadata
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
    department, 
    area
  )
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'employee_id', 'PENDING'),
    COALESCE(NEW.raw_user_meta_data->>'region', 'MY'),
    COALESCE(NEW.raw_user_meta_data->>'role', 'driver'),
    (NEW.raw_user_meta_data->>'manager_level')::int,
    NEW.raw_user_meta_data->>'department',
    NEW.raw_user_meta_data->>'area'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
