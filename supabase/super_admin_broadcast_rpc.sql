-- This RPC function bypasses Row Level Security (RLS) using "SECURITY DEFINER"
-- It allows the Super Admin to get a list of user IDs across all companies for broadcasting.

CREATE OR REPLACE FUNCTION get_broadcast_target_ids(
  p_target_type text,
  p_company_id uuid DEFAULT NULL,
  p_recipient_scope text DEFAULT 'masters_only'
) RETURNS TABLE(user_id uuid)
SECURITY DEFINER
AS $$
BEGIN
  IF p_target_type = 'all_masters' THEN
    RETURN QUERY 
      SELECT id FROM public.profiles 
      WHERE role = 'master' OR (role = 'manager' AND (manager_level = 1 OR manager_level IS NULL));
      
  ELSIF p_target_type = 'beta_masters' THEN
    RETURN QUERY 
      SELECT p.id FROM public.profiles p
      JOIN public.companies c ON p.company_id = c.id
      WHERE (p.role = 'master' OR (p.role = 'manager' AND (p.manager_level = 1 OR p.manager_level IS NULL)))
      AND c.is_beta_tester = true;
      
  ELSIF p_target_type = 'specific_company' THEN
    IF p_recipient_scope = 'masters_only' THEN
      RETURN QUERY 
        SELECT id FROM public.profiles 
        WHERE company_id = p_company_id 
        AND (role = 'master' OR role = 'manager');
    ELSE
      RETURN QUERY 
        SELECT id FROM public.profiles 
        WHERE company_id = p_company_id;
    END IF;
  END IF;
END;
$$ LANGUAGE plpgsql;
