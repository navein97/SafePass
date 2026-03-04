-- Add expo_push_token column to profiles table
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS expo_push_token TEXT;

-- Create an index for faster lookups
CREATE INDEX IF NOT EXISTS idx_profiles_expo_push_token ON public.profiles(expo_push_token);
