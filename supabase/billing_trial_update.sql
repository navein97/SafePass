-- ==========================================================
-- 1-MONTH FREE STANDARD PLAN UPDATE
-- ==========================================================

-- 1. Add trial_end_date and has_used_free_trial to companies table
ALTER TABLE public.companies ADD COLUMN IF NOT EXISTS trial_end_date TIMESTAMP WITH TIME ZONE;
ALTER TABLE public.companies ADD COLUMN IF NOT EXISTS has_used_free_trial BOOLEAN DEFAULT false;

-- 2. Update register_workspace to grant 1-month free standard plan
CREATE OR REPLACE FUNCTION public.register_workspace(
    p_company_name TEXT
)
RETURNS UUID AS $$
DECLARE
    v_company_id UUID;
BEGIN
    -- Create the company with 1 month free Standard plan
    -- Quota: 100 drivers, 4 managers (100 / 25)
    INSERT INTO public.companies (
        name, 
        quota_drivers, 
        quota_managers, 
        subscription_tier,
        trial_end_date,
        has_used_free_trial
    )
    VALUES (
        p_company_name, 
        100, 
        4, 
        'standard',
        NOW() + INTERVAL '1 month',
        true
    )
    RETURNING id INTO v_company_id;

    RETURN v_company_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Update handle_stripe_success to handle dynamic quotas and clear trial
CREATE OR REPLACE FUNCTION public.handle_stripe_success(
    p_company_id UUID,
    p_package_id TEXT,
    p_driver_count INTEGER DEFAULT 0
)
RETURNS VOID AS $$
DECLARE
    v_drivers INTEGER;
    v_managers INTEGER;
BEGIN
    -- Determine quotas based on package_id and dynamic driver count
    IF p_package_id = 'trial' THEN
        v_drivers := 3;
        v_managers := 1;
    ELSIF p_package_id IN ('standard', 'enterprise', 'test') THEN
        -- Dynamic allocation based on driver count
        -- Standard: RM 120/driver. Free manager ratio: 25 drivers = 1 manager
        v_drivers := p_driver_count;
        v_managers := GREATEST(1, CEIL(p_driver_count / 25.0));
    ELSE
        -- Fallback for legacy packages if any
        CASE p_package_id
            WHEN 'starter' THEN
                v_drivers := 5;
                v_managers := 1;
            WHEN 'growth' THEN
                v_drivers := 25;
                v_managers := 3;
            ELSE
                RAISE EXCEPTION 'Unknown package ID: %', p_package_id;
        END CASE;
    END IF;

    -- Update the company record
    UPDATE public.companies
    SET 
        subscription_tier = p_package_id,
        quota_drivers = v_drivers,
        quota_managers = v_managers,
        trial_end_date = NULL, -- Clear trial upon subscription
        updated_at = NOW()
    WHERE id = p_company_id;

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 4. Enable pg_cron and schedule daily downgrade for expired trials
-- Note: pg_cron extension must be enabled in Supabase Dashboard (Database -> Extensions)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Create the downgrade function
CREATE OR REPLACE FUNCTION public.downgrade_expired_trials()
RETURNS VOID AS $$
BEGIN
    UPDATE public.companies
    SET 
        subscription_tier = 'trial',
        quota_drivers = 3,
        quota_managers = 1,
        updated_at = NOW()
    WHERE 
        trial_end_date IS NOT NULL 
        AND trial_end_date < NOW();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Schedule it to run daily at midnight
SELECT cron.schedule(
    'downgrade-expired-trials',
    '0 0 * * *', -- Every day at 00:00
    $$ SELECT public.downgrade_expired_trials(); $$
);

-- 5. Function to manually activate free trial for existing companies that haven't used it
CREATE OR REPLACE FUNCTION public.activate_free_trial(
    p_company_id UUID
)
RETURNS VOID AS $$
BEGIN
    UPDATE public.companies
    SET 
        subscription_tier = 'standard',
        quota_drivers = 100,
        quota_managers = 4,
        trial_end_date = NOW() + INTERVAL '1 month',
        has_used_free_trial = true,
        updated_at = NOW()
    WHERE 
        id = p_company_id 
        AND has_used_free_trial = false;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ==========================================================
