-- =================================================================
-- ENHANCED SOCIAL TRACKING & LEADERBOARD UPDATES
-- Run this to enable real-time "Taking the Lead" posts
-- =================================================================

-- 1. ADD RANK TRACKING COLUMN
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS last_rank INTEGER;

-- 2. SYNC SAFETY_INDEX WITH TOTAL_SCORE
-- Ensure Social Screen (using safety_index) matches Leaderboard (using total_score)
UPDATE public.profiles 
SET safety_index = total_score 
WHERE total_score IS NOT NULL;

-- 3. INITIALIZE RANK for existing users
-- This prevents a flood of "New #1!" posts when we first turn this on.
WITH RankedProfiles AS (
    SELECT id, RANK() OVER (ORDER BY total_score DESC) as rnk
    FROM public.profiles
)
UPDATE public.profiles
SET last_rank = RankedProfiles.rnk
FROM RankedProfiles
WHERE public.profiles.id = RankedProfiles.id;


-- 4. TRIGGER FUNCTION: HANDLE RANK CHANGES & SYNC
CREATE OR REPLACE FUNCTION public.handle_rank_and_social_updates()
RETURNS TRIGGER AS $$
DECLARE
  new_rank INTEGER;
  participants_count INTEGER;
  prev_rank INTEGER;
  user_full_name TEXT;
BEGIN
  -- A. SYNC safety_index with total_score
  NEW.safety_index := NEW.total_score;

  -- B. CALCULATE NEW RANK
  -- "Rank" is 1 + number of people with a higher score than the NEW score
  SELECT COUNT(*) + 1 INTO new_rank
  FROM public.profiles
  WHERE total_score > NEW.total_score;

  -- C. GET TOTAL PARTICIPANTS (for "Last Place" check)
  SELECT COUNT(*) INTO participants_count FROM public.profiles;

  -- D. RETRIEVE PREVIOUS RANK
  -- Treat NULL as a rank lower than everyone (e.g., participants_count + 1)
  prev_rank := COALESCE(OLD.last_rank, participants_count + 1);
  
  -- Update the Last Rank field on the record
  NEW.last_rank := new_rank;
  
  -- E. GENERATE SOCIAL POSTS ON SIGNIFICANT CHANGES
  
  -- Only trigger if the rank has actually changed
  IF new_rank IS DISTINCT FROM prev_rank THEN
  
    user_full_name := COALESCE(NEW.full_name, 'Driver');

    -- SCENARIO 1: ENTERING THE TOP 3 (Improvement)
    IF new_rank < prev_rank AND new_rank <= 3 THEN
    
       IF new_rank = 1 THEN
          INSERT INTO public.posts (user_id, content, type)
          VALUES (NEW.id, '👑 ' || user_full_name || ' has claimed the 1st Place spot on the Leaderboard!', 'leaderboard');
          
       ELSIF new_rank = 2 THEN
          INSERT INTO public.posts (user_id, content, type)
          VALUES (NEW.id, '🥈 ' || user_full_name || ' has overtaken 2nd Place! The chase is on.', 'leaderboard');
          
       ELSIF new_rank = 3 THEN
          INSERT INTO public.posts (user_id, content, type)
          VALUES (NEW.id, '🥉 ' || user_full_name || ' has cracked the Top 3!', 'leaderboard');
       END IF;
       
    END IF;

    -- SCENARIO 2: DROPPING TO LAST PLACE
    -- If new_rank is the last possible rank, and they weren't there before
    IF new_rank = participants_count AND new_rank > prev_rank THEN
       INSERT INTO public.posts (user_id, content, type)
       VALUES (NEW.id, '🔧 ' || user_full_name || ' is now in the Pit Lane (Last Place). Time for a recovery!', 'pitlane');
    END IF;

  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;


-- 5. ATTACH TRIGGER
DROP TRIGGER IF EXISTS on_profile_score_change_updates ON public.profiles;

CREATE TRIGGER on_profile_score_change_updates
  BEFORE UPDATE OF total_score ON public.profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_rank_and_social_updates();
