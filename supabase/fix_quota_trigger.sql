-- Fix quota trigger to exclude inactive users
-- Run this in your Supabase SQL Editor

CREATE OR REPLACE FUNCTION check_company_quotas()
RETURNS TRIGGER AS $$
DECLARE
    v_company_id UUID;
    v_quota_limit INTEGER;
    v_current_count INTEGER;
BEGIN
    -- Determine company_id
    v_company_id := NEW.company_id;
    
    -- If no company_id, skip quota check (for super-admins or unlinked users)
    IF v_company_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Check Quota based on Role
    IF NEW.role = 'driver' THEN
        SELECT quota_drivers INTO v_quota_limit FROM public.companies WHERE id = v_company_id;
        SELECT COUNT(*) INTO v_current_count FROM public.profiles 
        WHERE company_id = v_company_id AND role = 'driver' AND id != NEW.id AND (status IS NULL OR status != 'inactive');
        
        IF v_current_count >= v_quota_limit THEN
            RAISE EXCEPTION 'Driver quota exceeded for this company. Limit: %', v_quota_limit;
        END IF;

    ELSIF NEW.role = 'manager' THEN
        SELECT quota_managers INTO v_quota_limit FROM public.companies WHERE id = v_company_id;
        SELECT COUNT(*) INTO v_current_count FROM public.profiles 
        WHERE company_id = v_company_id AND role = 'manager' AND id != NEW.id AND (status IS NULL OR status != 'inactive');
        
        IF v_current_count >= v_quota_limit THEN
            RAISE EXCEPTION 'Manager quota exceeded for this company. Limit: %', v_quota_limit;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
