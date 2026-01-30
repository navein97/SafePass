-- Migration: Create Batch-Based Quiz System
-- Generated: 2026-01-29T11:16:49.322Z

-- Create quiz_batches table
CREATE TABLE IF NOT EXISTS quiz_batches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  batch_number INTEGER NOT NULL UNIQUE CHECK (batch_number BETWEEN 1 AND 4),
  question_ids TEXT[] NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create user_batch_progress table
CREATE TABLE IF NOT EXISTS user_batch_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  batch_number INTEGER NOT NULL CHECK (batch_number BETWEEN 1 AND 4),
  attempt_number INTEGER NOT NULL DEFAULT 1,
  score DECIMAL(5,2) NOT NULL,
  accuracy_percentage DECIMAL(5,2),
  completion_percentage DECIMAL(5,2),
  component_scores JSONB,
  answers JSONB NOT NULL,
  time_spent_seconds INTEGER DEFAULT 0,
  completed_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, batch_number, attempt_number)
);

-- Add batch tracking columns to profiles
ALTER TABLE profiles 
  ADD COLUMN IF NOT EXISTS current_batch INTEGER DEFAULT 1 CHECK (current_batch BETWEEN 1 AND 4),
  ADD COLUMN IF NOT EXISTS total_batches_completed INTEGER DEFAULT 0;

-- Insert batch question mappings
INSERT INTO quiz_batches (batch_number, question_ids) VALUES
  (1, ARRAY['my_int_003_dup07', 'my_int_010_dup10', 'my_int_005_dup11', 'my_int_002_dup09', 'my_int_010_dup01', 'my_int_009_dup03', 'my_int_010_dup11', 'my_int_002_dup11', 'my_int_001_dup07', 'my_int_003_dup10', 'my_int_005_dup08', 'my_int_005_dup04', 'my_int_005_dup12', 'my_int_007_dup03', 'my_int_006_dup03', 'my_int_009_dup01', 'my_int_007_dup12', 'my_int_008_dup10', 'my_int_008_dup07', 'my_int_008_dup06', 'my_int_010_dup12', 'my_int_003_dup02', 'my_int_009_dup04', 'my_int_001_dup05', 'my_int_001_dup02', 'my_int_009_dup11', 'my_int_007_dup04', 'my_int_009_dup12', 'my_int_004_dup08', 'my_int_008_dup03']),
  (2, ARRAY['my_int_003_dup09', 'my_int_002_dup07', 'my_int_004_dup05', 'my_int_002_dup06', 'my_int_007_dup06', 'my_int_008_dup09', 'my_int_003_dup08', 'my_int_005_dup01', 'my_int_001_dup04', 'my_int_002_dup08', 'my_int_005_dup03', 'my_int_006_dup12', 'my_int_004_dup06', 'my_int_003_dup11', 'my_int_002_dup01', 'my_int_004_dup11', 'my_int_006_dup07', 'my_int_003_dup06', 'my_int_007_dup05', 'my_int_005_dup02', 'my_int_007_dup01', 'my_int_007_dup07', 'my_int_005_dup06', 'my_int_004_dup04', 'my_int_005_dup05', 'my_int_004_dup02', 'my_int_009_dup08', 'my_int_010_dup08', 'my_int_002_dup02', 'my_int_001_dup08']),
  (3, ARRAY['my_int_001_dup10', 'my_int_001_dup01', 'my_int_006_dup11', 'my_int_003_dup05', 'my_int_004_dup09', 'my_int_006_dup04', 'my_int_008_dup12', 'my_int_008_dup02', 'my_int_009_dup10', 'my_int_002_dup04', 'my_int_010_dup02', 'my_int_005_dup10', 'my_int_008_dup08', 'my_int_002_dup12', 'my_int_003_dup12', 'my_int_004_dup03', 'my_int_001_dup09', 'my_int_003_dup01', 'my_int_008_dup05', 'my_int_010_dup05', 'my_int_002_dup03', 'my_int_010_dup04', 'my_int_007_dup11', 'my_int_004_dup10', 'my_int_006_dup02', 'my_int_007_dup10', 'my_int_003_dup03', 'my_int_006_dup08', 'my_int_009_dup06', 'my_int_007_dup02']),
  (4, ARRAY['my_int_009_dup05', 'my_int_009_dup09', 'my_int_008_dup11', 'my_int_002_dup10', 'my_int_004_dup07', 'my_int_010_dup06', 'my_int_010_dup07', 'my_int_003_dup04', 'my_int_010_dup03', 'my_int_004_dup12', 'my_int_001_dup06', 'my_int_008_dup01', 'my_int_010_dup09', 'my_int_006_dup09', 'my_int_009_dup02', 'my_int_005_dup07', 'my_int_006_dup05', 'my_int_009_dup07', 'my_int_006_dup10', 'my_int_006_dup01', 'my_int_005_dup09', 'my_int_002_dup05', 'my_int_001_dup11', 'my_int_006_dup06', 'my_int_008_dup04', 'my_int_007_dup08', 'my_int_001_dup12', 'my_int_001_dup03', 'my_int_004_dup01', 'my_int_007_dup09'])
ON CONFLICT (batch_number) DO UPDATE SET question_ids = EXCLUDED.question_ids;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_batch_progress_user ON user_batch_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_batch_progress_batch ON user_batch_progress(batch_number);
CREATE INDEX IF NOT EXISTS idx_profiles_current_batch ON profiles(current_batch);

COMMENT ON TABLE quiz_batches IS 'Fixed question sets for each batch (1-4)';
COMMENT ON TABLE user_batch_progress IS 'User progress tracking for batch-based quizzes with unlimited attempts';
COMMENT ON COLUMN user_batch_progress.score IS 'Weighted score based on attempt numbers (1st=1.0, 2nd=0.5, 3rd=0.25, 4th+=0)';
COMMENT ON COLUMN user_batch_progress.accuracy_percentage IS 'Percentage of attempted questions answered correctly';
COMMENT ON COLUMN user_batch_progress.completion_percentage IS 'Percentage of total batch questions attempted';
