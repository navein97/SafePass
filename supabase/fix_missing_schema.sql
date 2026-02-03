-- ============================================
-- FIX MISSING SCHEMA ELEMENTS - UPDATED
-- Adds missing columns and functions
-- Run this in Supabase SQL Editor
-- ============================================

-- 1. Add missing columns to profiles table
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS address TEXT,
ADD COLUMN IF NOT EXISTS designation TEXT,
ADD COLUMN IF NOT EXISTS company_name TEXT;

-- 2. Drop the generated 'read' column if it exists (from previous migration)
-- and ensure notifications work correctly with 'is_read'
DO $$
BEGIN
    -- Drop the generated column if it exists
    IF EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_schema = 'public' 
        AND table_name = 'notifications' 
        AND column_name = 'read'
    ) THEN
        ALTER TABLE public.notifications DROP COLUMN read;
    END IF;
END $$;

-- Note: Frontend code now uses 'is_read' which already exists, so no changes needed

-- 3. Create policy to allow inserting notifications
DROP POLICY IF EXISTS "Users can insert own notifications" ON public.notifications;
CREATE POLICY "Users can insert own notifications" 
    ON public.notifications FOR INSERT
    WITH CHECK (auth.uid() = user_id);

-- Allow managers to send notifications to their team
DROP POLICY IF EXISTS "Managers can insert notifications" ON public.notifications;
CREATE POLICY "Managers can insert notifications" 
    ON public.notifications FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM public.profiles 
            WHERE id = auth.uid() AND role IN ('manager', 'admin')
        )
    );

-- 4. Create the missing change_user_password function
CREATE OR REPLACE FUNCTION public.change_user_password(
    target_user_id UUID,
    new_password TEXT
)
RETURNS json AS $$
DECLARE
    requesting_user_role TEXT;
    target_user_role TEXT;
    requesting_user_level INTEGER;
    target_user_dept TEXT;
    requesting_user_dept TEXT;
    result json;
BEGIN
    -- Get requesting user details
    SELECT role, manager_level, department 
    INTO requesting_user_role, requesting_user_level, requesting_user_dept
    FROM public.profiles 
    WHERE id = auth.uid();
    
    -- Get target user details
    SELECT role, department 
    INTO target_user_role, target_user_dept
    FROM public.profiles 
    WHERE id = target_user_id;
    
    -- Check permissions
    -- Managers can only change passwords for users in their hierarchy
    IF requesting_user_role = 'manager' THEN
        -- Level 2 managers can only change passwords for staff in their department
        IF requesting_user_level = 2 THEN
            IF target_user_role NOT IN ('staff', 'driver') THEN
                RAISE EXCEPTION 'Permission denied: Level 2 managers can only change passwords for staff';
            END IF;
            IF target_user_dept IS NOT NULL AND target_user_dept != requesting_user_dept THEN
                RAISE EXCEPTION 'Permission denied: Can only change passwords for staff in your department';
            END IF;
        END IF;
        -- Level 1 managers can change passwords for any staff or level 2 managers
    ELSIF requesting_user_role = 'admin' THEN
        -- Admins can change any password
        NULL;
    ELSE
        -- Only managers and admins can change other users' passwords
        RAISE EXCEPTION 'Permission denied: Only managers can change user passwords';
    END IF;
    
    -- Update the password in auth.users using the admin API
    -- Note: Supabase handles password hashing automatically
    UPDATE auth.users
    SET encrypted_password = crypt(new_password, gen_salt('bf')),
        updated_at = NOW()
    WHERE id = target_user_id;
    
    -- Check if update was successful
    IF NOT FOUND THEN
        result := json_build_object('success', false, 'message', 'User not found');
    ELSE
        result := json_build_object('success', true, 'message', 'Password updated successfully');
    END IF;
    
    RETURN result;
EXCEPTION
    WHEN OTHERS THEN
        result := json_build_object('success', false, 'message', SQLERRM);
        RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission to authenticated users
GRANT EXECUTE ON FUNCTION public.change_user_password(UUID, TEXT) TO authenticated;

-- Add comment for clarity
COMMENT ON FUNCTION public.change_user_password IS 'Allows managers to change passwords for users in their hierarchy';

-- ============================================
-- VERIFICATION QUERIES (Optional - for testing)
-- ============================================
-- Run these to verify the changes:
-- SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'profiles' AND column_name IN ('address', 'designation', 'company_name');
-- SELECT column_name, data_type FROM information_schema.columns WHERE table_name = 'notifications' AND column_name IN ('is_read', 'read');
-- SELECT routine_name FROM information_schema.routines WHERE routine_name = 'change_user_password';

-- ============================================
-- MIGRATION COMPLETE
-- ============================================
