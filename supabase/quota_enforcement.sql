-- ================================================================
-- QUOTA ENFORCEMENT: Deactivate random drivers on trial expiry
-- ================================================================
-- Run this in Supabase SQL Editor
-- ================================================================

-- 1. Upgrade downgrade_expired_trials() to randomly deactivate
--    over-quota drivers when a trial expires
-- ================================================================
CREATE OR REPLACE FUNCTION public.downgrade_expired_trials()
RETURNS VOID AS $$
DECLARE
    v_company RECORD;
BEGIN
    -- Loop through every company whose trial has expired
    FOR v_company IN
        SELECT id
        FROM public.companies
        WHERE trial_end_date IS NOT NULL
          AND trial_end_date < NOW()
    LOOP
        -- Step 1: Downgrade the company tier and quota
        UPDATE public.companies
        SET
            subscription_tier = 'trial',
            quota_drivers     = 3,
            quota_managers    = 1,
            updated_at        = NOW()
        WHERE id = v_company.id;

        -- Step 2: Randomly keep 3 drivers ACTIVE, deactivate the rest
        UPDATE public.profiles
        SET status = 'inactive'
        WHERE
            company_id = v_company.id
            AND role = 'driver'
            AND id NOT IN (
                -- Randomly pick 3 drivers to remain active
                SELECT id
                FROM public.profiles
                WHERE company_id = v_company.id
                  AND role = 'driver'
                  AND COALESCE(status, 'active') != 'inactive'
                ORDER BY random()
                LIMIT 3
            );

    END LOOP;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ================================================================
-- 2. Upgrade handle_stripe_success() to REACTIVATE all drivers
--    when a company subscribes/upgrades
-- ================================================================
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
    IF p_package_id = 'trial' THEN
        v_drivers := 3;
        v_managers := 1;
    ELSIF p_package_id IN ('standard', 'enterprise', 'test') THEN
        v_drivers := p_driver_count;
        v_managers := GREATEST(1, CEIL(p_driver_count / 25.0));
    ELSE
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
        quota_drivers     = v_drivers,
        quota_managers    = v_managers,
        trial_end_date    = NULL,
        updated_at        = NOW()
    WHERE id = p_company_id;

    -- Reactivate ALL previously deactivated drivers when they resubscribe
    UPDATE public.profiles
    SET status = 'active'
    WHERE
        company_id = p_company_id
        AND role = 'driver'
        AND status = 'inactive';

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
