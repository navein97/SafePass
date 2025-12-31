-- Add role column to profiles table
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS role text DEFAULT 'staff';

-- Update RLS policies if needed (optional, assuming exist policies cover update for self)
-- Verify existing column
SELECT * FROM public.profiles LIMIT 1;
