-- =====================================================
-- CNG Driver 360 - Supabase Backend Setup
-- =====================================================
-- Run these SQL commands in your Supabase SQL Editor

-- 1. Add Master Profile columns to profiles table
-- =====================================================
ALTER TABLE profiles 
ADD COLUMN IF NOT EXISTS designation TEXT,
ADD COLUMN IF NOT EXISTS company_name TEXT,
ADD COLUMN IF NOT EXISTS address TEXT;

-- Note: phone_number should already exist, but if not:
-- ALTER TABLE profiles ADD COLUMN IF NOT EXISTS phone_number TEXT;


-- 2. Create notifications table
-- =====================================================
CREATE TABLE IF NOT EXISTS notifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    data JSONB,
    read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Add index for faster queries
CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON notifications(created_at DESC);

-- Enable RLS (Row Level Security)
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- Policy: Users can only see their own notifications
CREATE POLICY "Users can view own notifications" ON notifications
    FOR SELECT USING (auth.uid() = user_id);

-- Policy: Managers can insert notifications for any user
CREATE POLICY "Managers can create notifications" ON notifications
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM profiles 
            WHERE id = auth.uid() AND role = 'manager'
        )
    );


-- 3. Create function to delete user (admin only)
-- =====================================================
CREATE OR REPLACE FUNCTION delete_user(target_user_id UUID)
RETURNS VOID
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    -- Check if the caller is a manager
    IF NOT EXISTS (
        SELECT 1 FROM profiles 
        WHERE id = auth.uid() AND role = 'manager'
    ) THEN
        RAISE EXCEPTION 'Only managers can delete users';
    END IF;

    -- Delete from profiles table (cascade will handle related data)
    DELETE FROM profiles WHERE id = target_user_id;
    
    -- Delete from auth.users table
    DELETE FROM auth.users WHERE id = target_user_id;
END;
$$;


-- 4. Create function to change user password (admin only)
-- =====================================================
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
