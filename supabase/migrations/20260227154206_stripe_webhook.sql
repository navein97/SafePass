-- Function to handle successful Stripe payments and update company quotas
-- This should be called by a Supabase Edge Function or Webhook listener

CREATE OR REPLACE FUNCTION public.handle_stripe_success(
    p_company_id UUID,
    p_package_id TEXT
)
RETURNS VOID AS $$
DECLARE
    v_drivers INTEGER;
    v_managers INTEGER;
BEGIN
    -- Determine quotas based on package_id
    CASE p_package_id
        WHEN 'starter' THEN
            v_drivers := 5;
            v_managers := 1;
        WHEN 'growth' THEN
            v_drivers := 25;
            v_managers := 3;
        WHEN 'enterprise' THEN
            v_drivers := 100;
            v_managers := 10;
        ELSE
            RAISE EXCEPTION 'Unknown package ID: %', p_package_id;
    END CASE;

    -- Update the company record
    UPDATE public.companies
    SET 
        subscription_tier = p_package_id,
        quota_drivers = v_drivers,
        quota_managers = v_managers,
        updated_at = NOW()
    WHERE id = p_company_id;

    -- Log the success (optional, if you have a logs table)
    -- INSERT INTO payment_logs (company_id, package_id, status) VALUES (p_company_id, p_package_id, 'completed');

END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
