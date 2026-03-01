-- =====================================================
-- CNG Driver 360 - Supabase Backend Setup
-- =====================================================
-- Run these SQL commands in your Supabase SQL Editor

-- 1. Add Master Profile columns to profiles table
-- =====================================================
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS designation TEXT,
ADD COLUMN IF NOT EXISTS company_name TEXT,
ADD COLUMN IF NOT EXISTS address TEXT,
ADD COLUMN IF NOT EXISTS status TEXT DEFAULT 'active'; -- Added for soft delete

-- ... existing code ...

-- 3. Create function to delete user (soft delete)
-- =====================================================
DROP FUNCTION IF EXISTS delete_user(UUID);
CREATE OR REPLACE FUNCTION delete_user(target_user_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Check if the caller is a manager
    IF NOT EXISTS (
        SELECT 1 FROM public.profiles 
        WHERE id = auth.uid() AND role = 'manager'
    ) THEN
        RAISE EXCEPTION 'Only managers can delete users';
    END IF;

    -- Perform soft delete by updating status
    UPDATE public.profiles 
    SET status = 'inactive', 
        updated_at = NOW() 
    WHERE id = target_user_id;
    
    -- We do NOT delete from auth.users to keep the account for history
    -- Instead, we could optionally lock the user out if needed, 
    -- but for now, the UI will filter them out.
END;
$$;


-- 4. Create function to change user password (admin only)
-- =====================================================
DROP FUNCTION IF EXISTS change_user_password(UUID, TEXT);
CREATE OR REPLACE FUNCTION change_user_password(
    target_user_id UUID,
    new_password TEXT
)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    target_email TEXT;
BEGIN
    -- Check if the caller is a manager
    IF NOT EXISTS (
        SELECT 1 FROM profiles 
        WHERE id = auth.uid() AND role = 'manager'
    ) THEN
        RAISE EXCEPTION 'Only managers can change passwords';
    END IF;

    -- Get the user's email
    SELECT email INTO target_email
    FROM auth.users
    WHERE id = target_user_id;

    IF target_email IS NULL THEN
        RAISE EXCEPTION 'User not found';
    END IF;

    -- Update the password
    UPDATE auth.users
    SET 
        encrypted_password = crypt(new_password, gen_salt('bf')),
        updated_at = NOW()
    WHERE id = target_user_id;
END;
$$;


-- 5. Grant execute permissions
-- =====================================================
GRANT EXECUTE ON FUNCTION delete_user(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION change_user_password(UUID, TEXT) TO authenticated;


-- 6. Verify the setup
-- =====================================================
-- Check if columns exist
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'profiles' 
AND column_name IN ('designation', 'company_name', 'address', 'phone_number');

-- Check if notifications table exists
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'notifications';

-- Check if functions exist
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_name IN ('delete_user', 'change_user_password');
