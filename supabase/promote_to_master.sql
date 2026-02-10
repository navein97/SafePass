-- ==========================================
-- Promote User to Master (Level 1 Manager)
-- ==========================================

-- This SQL updates the user with employee_id 'MY001' to have the 'manager' role
-- and sets their manager_level to 1 (Master/HR).

-- 1. Update the role and manager_level
UPDATE public.profiles
SET 
  role = 'manager',
  manager_level = 1
WHERE employee_id = 'MY001';

-- 2. Verify the change
SELECT id, full_name, employee_id, role, manager_level 
FROM public.profiles 
WHERE employee_id = 'MY001';
