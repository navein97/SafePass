-- =================================================================
-- FIX LEADERBOARD VISIBILITY AND SCORING
-- Run this in Supabase SQL Editor to fix the leaderboard issues
-- =================================================================

-- 1. FIX VISIBILITY (RLS)
-- Allow all authenticated users to view all quiz attempts (needed for Weekly/Monthly calculations)
DROP POLICY IF EXISTS "Users can view own quiz attempts" ON public.quiz_attempts;
DROP POLICY IF EXISTS "Managers can view all quiz attempts" ON public.quiz_attempts;

CREATE POLICY "Users can view all quiz attempts" 
  ON public.quiz_attempts FOR SELECT 
  USING (auth.role() = 'authenticated');

-- Ensure profiles are visible to everyone (needed for All Time leaderboards)
-- (It seems they might already be visible, but this ensures consistency)
DROP POLICY IF EXISTS "Users can view own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can view all profiles" ON public.profiles;

CREATE POLICY "Users can view all profiles" 
  ON public.profiles FOR SELECT 
  USING (auth.role() = 'authenticated');


-- 2. FIX ALL TIME SCORES (0% Issue)
-- Create a trigger to automatically calculate and update 'total_score' in profiles
-- based on the average of their quiz attempts.

CREATE OR REPLACE FUNCTION public.update_leaderboard_score()
RETURNS TRIGGER AS $$
DECLARE
  new_avg INTEGER;
  target_user_id UUID;
BEGIN
  -- Determine user_id based on operation
  IF (TG_OP = 'DELETE') THEN
    target_user_id := OLD.user_id;
  ELSE
    target_user_id := NEW.user_id;
  END IF;

  -- Calculate average score for the user (Average of all attempts)
  -- We use Average because the UI displays it as a percentage (%)
  SELECT COALESCE(ROUND(AVG(score)), 0) INTO new_avg
  FROM public.quiz_attempts
  WHERE user_id = target_user_id;

  -- Update profile's total_score
  UPDATE public.profiles
  SET total_score = new_avg
  WHERE id = target_user_id;

  RETURN NULL; -- Trigger return value for AFTER triggers is ignored
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop existing trigger if it exists to avoid duplicates
DROP TRIGGER IF EXISTS on_quiz_attempt_update_score ON public.quiz_attempts;

-- Create the trigger
CREATE TRIGGER on_quiz_attempt_update_score
  AFTER INSERT OR UPDATE OR DELETE ON public.quiz_attempts
  FOR EACH ROW EXECUTE FUNCTION public.update_leaderboard_score();


-- 3. RECALCULATE EXISTING SCORES
-- Fix the "0%" for existing users immediately
DO $$
DECLARE 
  r RECORD;
  avg_score INTEGER;
BEGIN
  FOR r IN SELECT id FROM public.profiles LOOP
    -- Calculate average
    SELECT COALESCE(ROUND(AVG(score)), 0) INTO avg_score
    FROM public.quiz_attempts
    WHERE user_id = r.id;
    
    -- Update profile
    UPDATE public.profiles 
    SET total_score = avg_score 
    WHERE id = r.id;
  END LOOP;
END $$;
