-- ================================================================
-- UNIVERSAL LOGIN: Email Resolver
-- ================================================================
-- Run this in Supabase SQL Editor
-- ================================================================

-- This function takes a user's login input (either an Email or Employee ID)
-- and returns their true, registered email address from the database.
CREATE OR REPLACE FUNCTION public.get_email_for_login(p_input TEXT)
RETURNS TEXT AS $$
DECLARE
    v_true_email TEXT;
BEGIN
    -- 1. Clean the input (trim whitespace, lowercase)
    p_input := lower(trim(p_input));

    -- 2. If it looks like an email already, check if it exists in profiles
    IF p_input LIKE '%@%' THEN
        SELECT email INTO v_true_email
        FROM public.profiles
        WHERE lower(email) = p_input;
        
        -- If we found it, return it. If not, return the input anyway 
        -- so Supabase Auth can handle the "Invalid Credentials" error natively.
        IF FOUND THEN
            RETURN v_true_email;
        ELSE
            RETURN p_input;
        END IF;
    END IF;

    -- 3. If it does NOT have an '@', it must be an Employee ID.
    -- Look up their true email using their Employee ID.
    SELECT email INTO v_true_email
    FROM public.profiles
    WHERE lower(employee_id) = p_input;

    -- 4. If we found a match, return their real email!
    IF FOUND THEN
        RETURN v_true_email;
    END IF;

    -- 5. Fallback: If they typed an ID that doesn't exist at all,
    -- return the old dummy email format so Supabase Auth can naturally reject it.
    RETURN p_input || '@driver360.internal';
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant access so anyone (even unauthenticated users on the login screen) can resolve their email
GRANT EXECUTE ON FUNCTION public.get_email_for_login(TEXT) TO anon, authenticated;
