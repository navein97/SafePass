-- Setup Test Data for Master Users
-- Run this in Supabase SQL Editor

-- 1. Get User IDs (You don't need to run this part, just for reference on how we target them)
-- We will use the email to find the user in auth.users, then update public.profiles

-- Setup chandrajeimohan@gmail.com as Level 1 (Principal/Highest)
UPDATE public.profiles
SET 
  role = 'manager',
  manager_level = 1,
  department = 'Headquarters',
  operational_effectiveness = 0.85,
  operational_discipline = 0.70,
  professional_conduct = 0.95
WHERE email = 'chandrajeimohan@gmail.com';

-- Setup naveinthiran97@gmail.com as Level 2 (Department Manager)
UPDATE public.profiles
SET 
  role = 'manager',
  manager_level = 2,
  department = 'Operations',
  operational_effectiveness = 0.75,
  operational_discipline = 0.60,
  professional_conduct = 0.80
WHERE email = 'naveinthiran97@gmail.com';

-- Setup naveinrex97@gmail.com as Driver (Standard User)
UPDATE public.profiles
SET 
  role = 'driver',
  manager_level = NULL,
  department = 'Operations',
  vehicle_type = 'Truck',
  age = 28
WHERE email = 'naveinrex97@gmail.com';

-- Verify the updates
SELECT email, role, manager_level, department FROM public.profiles WHERE email IN (
    'chandrajeimohan@gmail.com',
    'naveinthiran97@gmail.com',
    'naveinrex97@gmail.com'
);
