-- Run this script in the Supabase SQL Editor to add audit tracking for account deactivations

ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS deactivated_by UUID REFERENCES public.profiles(id),
ADD COLUMN IF NOT EXISTS deactivated_at TIMESTAMP WITH TIME ZONE;
