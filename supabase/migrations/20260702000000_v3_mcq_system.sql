-- Migration: Update to MCQ System v3
-- Generated: 2026-07-02T12:00:00.000Z

-- 1. Alter check constraints to allow batches 1-8
ALTER TABLE public.quiz_batches DROP CONSTRAINT IF EXISTS quiz_batches_batch_number_check;
ALTER TABLE public.quiz_batches ADD CONSTRAINT quiz_batches_batch_number_check CHECK (batch_number BETWEEN 1 AND 8);

ALTER TABLE public.user_batch_progress DROP CONSTRAINT IF EXISTS user_batch_progress_batch_number_check;
ALTER TABLE public.user_batch_progress ADD CONSTRAINT user_batch_progress_batch_number_check CHECK (batch_number BETWEEN 1 AND 8);

ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_current_batch_check;
ALTER TABLE public.profiles ADD CONSTRAINT profiles_current_batch_check CHECK (current_batch BETWEEN 1 AND 8);

-- 2. Add override and reset tracking columns to profiles
ALTER TABLE public.profiles 
  ADD COLUMN IF NOT EXISTS daily_limit_override BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS batch_lock_override BOOLEAN DEFAULT FALSE,
  ADD COLUMN IF NOT EXISTS daily_limit_waived_batch INTEGER DEFAULT NULL CHECK (daily_limit_waived_batch BETWEEN 1 AND 8),
  ADD COLUMN IF NOT EXISTS consecutive_resets JSONB DEFAULT '{}'::jsonb;

-- 3. Create user_question_progress table to track individual question attempts within a batch
CREATE TABLE IF NOT EXISTS public.user_question_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  question_id UUID REFERENCES public.questions(id) ON DELETE CASCADE NOT NULL,
  batch_number INTEGER NOT NULL CHECK (batch_number BETWEEN 1 AND 8),
  attempts INTEGER NOT NULL DEFAULT 0,
  is_correct BOOLEAN NOT NULL DEFAULT FALSE,
  score DECIMAL(3,2) NOT NULL DEFAULT 0.00,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, question_id)
);

-- 4. Enable Row Level Security (RLS) and policies
ALTER TABLE public.user_question_progress ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Users can manage own question progress" ON public.user_question_progress;
CREATE POLICY "Users can manage own question progress" 
  ON public.user_question_progress FOR ALL 
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

DROP POLICY IF EXISTS "Managers can view all question progress" ON public.user_question_progress;
CREATE POLICY "Managers can view all question progress" 
  ON public.user_question_progress FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role IN ('manager', 'admin')
    )
  );

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_question_progress_user ON public.user_question_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_question_progress_batch ON public.user_question_progress(batch_number, user_id);
