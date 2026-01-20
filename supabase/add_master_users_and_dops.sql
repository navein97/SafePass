-- Migration to add Master User levels and DOPS metrics
-- Run this in Supabase SQL Editor

-- 1. Add new columns to profiles table
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS manager_level INTEGER CHECK (manager_level IN (1, 2)),
ADD COLUMN IF NOT EXISTS department TEXT,
ADD COLUMN IF NOT EXISTS division TEXT,
ADD COLUMN IF NOT EXISTS area TEXT,
ADD COLUMN IF NOT EXISTS operational_effectiveness DECIMAL DEFAULT 0,
ADD COLUMN IF NOT EXISTS operational_discipline DECIMAL DEFAULT 0,
ADD COLUMN IF NOT EXISTS professional_conduct DECIMAL DEFAULT 0;

-- 2. Update existing manager policies or create new ones if needed
-- (The existing policies check for 'manager' role, which covers both levels, 
-- but we might want to ensure Level 1 can edit Level 2 in the future.
-- For now, the existing "Managers can view all profiles" acts as a base.)

-- 3. Add comment for clarity
COMMENT ON COLUMN public.profiles.manager_level IS 'Level 1: Principal/Owner, Level 2: Departmental';
