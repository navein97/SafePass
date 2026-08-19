-- Fix Notifications RLS Policies
-- Allow authenticated users (Super Admin, Master Users, etc.) to insert notifications for recipients

-- 1. Enable RLS on notifications table (if not already enabled)
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- 2. Drop existing insert policies that may be conflicting or overly restrictive
DROP POLICY IF EXISTS "Users can insert own notifications" ON public.notifications;
DROP POLICY IF EXISTS "Managers can insert notifications" ON public.notifications;
DROP POLICY IF EXISTS "Authenticated users can insert notifications" ON public.notifications;
DROP POLICY IF EXISTS "Enable insert for authenticated users" ON public.notifications;

-- 3. Create clean insert policy allowing authenticated users to insert notification records
CREATE POLICY "Authenticated users can insert notifications" 
    ON public.notifications FOR INSERT
    TO authenticated
    WITH CHECK (true);

-- 4. Ensure read/select policy exists so users can see notifications sent to them
DROP POLICY IF EXISTS "Users can read own notifications" ON public.notifications;
DROP POLICY IF EXISTS "Users can view own notifications" ON public.notifications;
DROP POLICY IF EXISTS "Users can select own notifications" ON public.notifications;

CREATE POLICY "Users can read own notifications" 
    ON public.notifications FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

-- 5. Ensure update policy exists so users can mark their own notifications as read
DROP POLICY IF EXISTS "Users can update own notifications" ON public.notifications;

CREATE POLICY "Users can update own notifications" 
    ON public.notifications FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);
