-- =============================================
-- FIX REGISTRATION FLOW
-- =============================================



-- 2. Create a SECURITY DEFINER function to register a workspace
--    This bypasses RLS entirely, so anon users can call it safely.
CREATE OR REPLACE FUNCTION public.register_workspace(
    p_company_name TEXT
)
RETURNS UUID AS $$
DECLARE
    v_company_id UUID;
BEGIN
    -- Create the company
    INSERT INTO public.companies (name, quota_drivers, quota_managers, subscription_tier)
    VALUES (p_company_name, 3, 1, 'trial')
    RETURNING id INTO v_company_id;

    RETURN v_company_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Create a function to link a user to their company after signup
CREATE OR REPLACE FUNCTION public.link_user_to_company(
    p_user_id UUID,
    p_company_id UUID
)
RETURNS VOID AS $$
BEGIN
    UPDATE public.profiles
    SET company_id = p_company_id
    WHERE id = p_user_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
