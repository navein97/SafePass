-- Run this SQL in your Supabase SQL Editor to add the missing columns

ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS age integer,
ADD COLUMN IF NOT EXISTS vehicle_type text;
