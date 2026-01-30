-- Enable RLS
ALTER TABLE user_batch_progress ENABLE ROW LEVEL SECURITY;
ALTER TABLE quiz_batches ENABLE ROW LEVEL SECURITY;

-- 1. Policies for user_batch_progress

-- Drop existing policies if they exist to avoid errors
DROP POLICY IF EXISTS "Enable read access for all users" ON user_batch_progress;
DROP POLICY IF EXISTS "Enable insert for users based on user_id" ON user_batch_progress;
DROP POLICY IF EXISTS "Enable update for users based on user_id" ON user_batch_progress;

-- Allow users to see EVERYONE's progress (required for Leaderboard)
CREATE POLICY "Enable read access for all users" 
ON user_batch_progress FOR SELECT 
TO authenticated 
USING (true);

-- Allow users to insert/update ONLY their own progress
CREATE POLICY "Enable insert for users based on user_id" 
ON user_batch_progress FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Enable update for users based on user_id" 
ON user_batch_progress FOR UPDATE 
TO authenticated 
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- 2. Policies for quiz_batches

DROP POLICY IF EXISTS "Allow public read access to batches" ON quiz_batches;

-- Allow everyone to read batch questions
CREATE POLICY "Allow public read access to batches" 
ON quiz_batches FOR SELECT 
TO authenticated 
USING (true);

-- 3. Verify profiles RLS (Ensuring users can see basic profile info of others for Leaderboard names)
-- Note: 'profiles' usually has existing RLS. We ensure 'select' is open for authenticated users.
-- IF NOT EXISTS, we create it:
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'profiles' AND policyname = 'Public profiles are viewable by everyone'
    ) THEN
        CREATE POLICY "Public profiles are viewable by everyone" 
        ON profiles FOR SELECT 
        USING ( true );
    END IF;
END
$$;
