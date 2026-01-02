-- =================================================================
-- AUTOMATION & INTERACTIONS SETUP
-- Run this in Supabase SQL Editor to enable auto-notifications and social posts
-- =================================================================

-- 1. NOTIFICATIONS & POSTS AUTOMATION ON QUIZ COMPLETION
CREATE OR REPLACE FUNCTION public.handle_quiz_completion()
RETURNS TRIGGER AS $$
DECLARE
  user_name TEXT;
  current_streak INTEGER;
BEGIN
  -- Get user details
  SELECT full_name, streak INTO user_name, current_streak
  FROM public.profiles
  WHERE id = NEW.user_id;

  -- 1. Create Notification for the user
  INSERT INTO public.notifications (user_id, title, message, type)
  VALUES (
    NEW.user_id,
    'Quiz Completed',
    'You scored ' || NEW.score || '% on ' || (CASE WHEN NEW.score >= 80 THEN 'Great job!' ELSE 'Keep practicing!' END),
    'achievement'
  );

  -- 2. Create Social Post if score is 100%
  IF NEW.score = 100 THEN
    INSERT INTO public.posts (user_id, content, likes_count)
    VALUES (
      NEW.user_id,
      '🎯 Just scored a perfect 100% on the Weekly Safety Quiz! improving our road safety culture one step at a time.',
      0
    );
  END IF;

  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Drop existing trigger if exists
DROP TRIGGER IF EXISTS on_quiz_completed_automation ON public.quiz_attempts;

-- Create Trigger
CREATE TRIGGER on_quiz_completed_automation
  AFTER INSERT ON public.quiz_attempts
  FOR EACH ROW EXECUTE FUNCTION public.handle_quiz_completion();


-- 2. TRIGGER FOR STREAK UPDATES (Optional, if streak logic exists)
-- Assuming streak is updated in profiles table
CREATE OR REPLACE FUNCTION public.handle_streak_update()
RETURNS TRIGGER AS $$
BEGIN
  -- Only trigger if streak increased and is a multiple of 3 (3, 6, 9...)
  IF NEW.streak > OLD.streak AND (NEW.streak % 3 = 0) THEN
    -- Notification
    INSERT INTO public.notifications (user_id, title, message, type)
    VALUES (
      NEW.id,
      '🔥 Streak on Fire!',
      'You reached a ' || NEW.streak || ' week safety streak! Amazing consistency.',
      'streak'
    );

    -- Social Post (Only for significant milestones like 5, 10, 20...)
    IF (NEW.streak % 5 = 0) THEN
      INSERT INTO public.posts (user_id, content)    
      VALUES (
        NEW.id,
        '🔥 I reached a ' || NEW.streak || '-week Safety Streak! Consistency is key to safety logs.'
      );
    END IF;
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_streak_update_automation ON public.profiles;

CREATE TRIGGER on_streak_update_automation
  AFTER UPDATE OF streak ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.handle_streak_update();


-- 3. SEED INITIAL DATA (So users see something immediately)

-- Insert a "Welcome" notification for ALL users who don't have one yet
INSERT INTO public.notifications (user_id, title, message, type)
SELECT id, 'Welcome to SafePass', 'Welcome! Check your dashboard for the latest safety missions.', 'system'
FROM public.profiles
WHERE NOT EXISTS (
    SELECT 1 FROM public.notifications WHERE user_id = public.profiles.id
);

-- Insert a default "System" post from the first admin/manager (or random user if none)
-- (We'll just map it to the first user found to ensure it shows up)
INSERT INTO public.posts (user_id, content, likes_count, created_at)
SELECT id, 'Welcome to the new SafePass Social Feed! 🚀 Share your safety achievements here.', 10, NOW()
FROM public.profiles
ORDER BY created_at ASC
LIMIT 1
ON CONFLICT DO NOTHING;
