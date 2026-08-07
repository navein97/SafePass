-- Fix: get_company_stats now excludes inactive/deactivated users
-- Run this in the Supabase SQL Editor

CREATE OR REPLACE FUNCTION get_company_stats(p_company_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_driver_count INTEGER;
    v_manager_count INTEGER;
    v_driver_quota INTEGER;
    v_manager_quota INTEGER;
BEGIN
    -- Get Counts (exclude deactivated/inactive users)
    SELECT COUNT(*) INTO v_driver_count FROM public.profiles 
    WHERE company_id = p_company_id AND role = 'driver'
    AND (status IS NULL OR status != 'inactive');
    
    SELECT COUNT(*) INTO v_manager_count FROM public.profiles 
    WHERE company_id = p_company_id AND role = 'manager'
    AND (status IS NULL OR status != 'inactive');

    -- Get Quotas
    SELECT quota_drivers, quota_managers INTO v_driver_quota, v_manager_quota 
    FROM public.companies WHERE id = p_company_id;

    RETURN jsonb_build_object(
        'drivers', v_driver_count,
        'managers', v_manager_count,
        'quota_drivers', COALESCE(v_driver_quota, 0),
        'quota_managers', COALESCE(v_manager_quota, 0)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
