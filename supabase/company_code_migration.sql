-- ==========================================================
-- OPTION B: COMPANY CODE MIGRATION SCRIPT
-- ==========================================================
-- Run this script in your Supabase SQL Editor.

-- 1. Add `code` column to `companies` table if not exists
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'companies' 
        AND column_name = 'code'
    ) THEN
        ALTER TABLE public.companies ADD COLUMN code TEXT UNIQUE;
    END IF;
END $$;

-- Create an index for fast company code lookups
CREATE INDEX IF NOT EXISTS idx_companies_code ON public.companies(lower(code));

-- 2. Update register_workspace RPC to store company code
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

    -- Check if code is provided and unique
    IF v_clean_code IS NOT NULL AND v_clean_code != '' THEN
        IF EXISTS (SELECT 1 FROM public.companies WHERE upper(code) = v_clean_code) THEN
            RAISE EXCEPTION 'Company code "%" is already taken.', v_clean_code;
        END IF;
    END IF;

    -- Create the company with quota and tier
    INSERT INTO public.companies (name, code, quota_drivers, quota_managers, subscription_tier)
    VALUES (p_company_name, v_clean_code, 5, 2, 'trial')
    RETURNING id INTO v_company_id;

    RETURN v_company_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Update get_email_for_login RPC to handle Company Code + Driver ID
-- Inputs can be:
--   - Email directly: e.g. "manager@company.com"
--   - Full formatted string: e.g. "PRO-001" or "PRO 001"
--   - Separate inputs: handled in frontend by combining into "PRO-001"
CREATE OR REPLACE FUNCTION public.get_email_for_login(p_input TEXT)
RETURNS TEXT AS $$
DECLARE
    v_true_email TEXT;
    v_clean_input TEXT;
BEGIN
    v_clean_input := lower(trim(p_input));

    -- 1. If it looks like an email, match against profiles.email
    IF v_clean_input LIKE '%@%' THEN
        SELECT email INTO v_true_email
        FROM public.profiles
        WHERE lower(email) = v_clean_input;
        
        IF FOUND THEN
            RETURN v_true_email;
        ELSE
            RETURN v_clean_input;
        END IF;
    END IF;

    -- 2. Match against employee_id directly (which stores "PRO-001")
    SELECT email INTO v_true_email
    FROM public.profiles
    WHERE lower(employee_id) = v_clean_input
       OR lower(employee_id) = replace(v_clean_input, ' ', '-');

    IF FOUND THEN
        RETURN v_true_email;
    END IF;

    -- 3. Fallback dummy email for auth rejection
    RETURN v_clean_input || '@driver360.internal';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

GRANT EXECUTE ON FUNCTION public.get_email_for_login(TEXT) TO anon, authenticated;
