-- Run this script in the Supabase SQL Editor to create the deactivate_user RPC
-- This safely bypasses RLS so managers can deactivate drivers.

CREATE OR REPLACE FUNCTION public.deactivate_user(target_user_id UUID)
RETURNS void AS $$
DECLARE
  v_caller_role TEXT;
  v_caller_company UUID;
  v_target_company UUID;
  v_target_level INTEGER;
BEGIN
  -- Get caller info
  SELECT role, company_id INTO v_caller_role, v_caller_company 
  FROM public.profiles WHERE id = auth.uid();
  
  -- Check if caller is manager or admin
  IF v_caller_role NOT IN ('manager', 'admin') THEN
    RAISE EXCEPTION 'Unauthorized';
  END IF;

  -- Get target info
  SELECT company_id, manager_level INTO v_target_company, v_target_level
  FROM public.profiles WHERE id = target_user_id;

  -- Must be in the same company
  IF v_caller_company != v_target_company THEN
    RAISE EXCEPTION 'Target user not found in your company';
  END IF;

  -- Cannot deactivate Master User (level 1)
  IF v_target_level = 1 THEN
    RAISE EXCEPTION 'Cannot deactivate Master User';
  END IF;

  -- Perform deactivation
  UPDATE public.profiles
  SET status = 'inactive',
      deactivated_by = auth.uid(),
      deactivated_at = NOW()
  WHERE id = target_user_id;
  
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
