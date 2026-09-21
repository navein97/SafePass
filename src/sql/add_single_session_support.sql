-- =====================================================
-- SafePass / CNG Driver 360 - Single Session Enforcement
-- =====================================================
-- Run this SQL in your Supabase SQL Editor to support
-- single-device active session enforcement across devices.

ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS current_session_id TEXT,
ADD COLUMN IF NOT EXISTS last_active_at TIMESTAMPTZ;

-- Index to optimize session check lookups
CREATE INDEX IF NOT EXISTS idx_profiles_current_session 
ON public.profiles (id, current_session_id);
