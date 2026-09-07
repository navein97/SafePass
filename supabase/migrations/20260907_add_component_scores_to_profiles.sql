-- Migration: Add component_scores to public.profiles
-- Ensures Driver Performance Index dimension scores (PC, OD, OE) persist on the profile table

ALTER TABLE public.profiles 
  ADD COLUMN IF NOT EXISTS component_scores JSONB;

-- Comment for documentation
COMMENT ON COLUMN public.profiles.component_scores IS 'Cumulative driver dimension percentage scores: { operation: number, discipline: number, professionalism: number }';
