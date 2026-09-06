-- Fix: Change Standard Plan Free Trial Quota to 50 drivers and 4 managers
-- Run this in your Supabase SQL Editor

-- 1. Update existing company records currently on standard trial to 50 drivers and 4 managers
UPDATE public.companies
SET 
    quota_drivers = 50,
    quota_managers = 4,
    updated_at = NOW()
WHERE 
    subscription_tier = 'standard'
    AND trial_end_date IS NOT NULL;

-- 2. Update register_workspace for new signups (50 drivers, 4 managers)
CREATE OR REPLACE FUNCTION public.register_workspace(
    p_company_name TEXT,
    p_company_code TEXT DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_company_id UUID;
    v_clean_code TEXT;
BEGIN
    v_clean_code := upper(trim(p_company_code));

    IF v_clean_code IS NOT NULL AND v_clean_code != '' THEN
        IF EXISTS (SELECT 1 FROM public.companies WHERE upper(code) = v_clean_code) THEN
            RAISE EXCEPTION 'Company code "%" is already taken.', v_clean_code;
        END IF;
    END IF;

    -- Create company with 1-month free Standard plan: 50 drivers, 4 managers
    INSERT INTO public.companies (
        name,
        code,
        quota_drivers, 
        quota_managers, 
        subscription_tier,
        trial_end_date,
        has_used_free_trial
    )
    VALUES (
        p_company_name,
        v_clean_code,
        50, 
        4, 
        'standard',
        NOW() + INTERVAL '1 month',
        true
    )
    RETURNING id INTO v_company_id;

    RETURN v_company_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Update activate_free_trial for existing companies activating free trial (50 drivers, 4 managers)
CREATE OR REPLACE FUNCTION public.activate_free_trial(
    p_company_id UUID
)
RETURNS VOID AS $$
BEGIN
    UPDATE public.companies
    SET 
        subscription_tier = 'standard',
        quota_drivers = 50,
        quota_managers = 4,
        trial_end_date = NOW() + INTERVAL '1 month',
        has_used_free_trial = true,
        updated_at = NOW()
    WHERE 
        id = p_company_id 
        AND has_used_free_trial = false;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
