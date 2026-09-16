-- ==============================================================================
-- SafePass: Detailed Question History for BIPIN BABULAL (SINLOG-P0007)
-- ==============================================================================
-- Run this in your Supabase SQL Editor to see:
-- 1. Daily breakdown of all questions answered (dates, attempts, scores).
-- 2. Details of every individual question answered in Batch 1.
-- 3. Batch attempt history.
-- ==============================================================================

-- 1. Daily Summary: See which days he took quizzes and if he got all correct each day
SELECT 
    DATE(completed_at) AS quiz_date,
    batch_number,
    COUNT(*) AS total_answered,
    COUNT(*) FILTER (WHERE is_correct = TRUE AND attempts = 1) AS correct_on_1st_attempt,
    COUNT(*) FILTER (WHERE is_correct = TRUE AND attempts = 2) AS correct_on_2nd_attempt,
    COUNT(*) FILTER (WHERE is_correct = FALSE) AS total_wrong,
    SUM(score) AS marks_earned,
    ROUND((SUM(score) / COUNT(*)) * 100, 1) AS accuracy_pct
FROM public.user_question_progress
WHERE user_id = '0a4a8448-924c-4e67-9237-d4af81328816'
GROUP BY DATE(completed_at), batch_number
ORDER BY quiz_date ASC, batch_number ASC;

-- 2. Every single question answered in Batch 1 (ordered chronologically):
SELECT 
    ROW_NUMBER() OVER (ORDER BY completed_at ASC) AS q_order,
    question_id,
    attempts,
    is_correct,
    score,
    completed_at
FROM public.user_question_progress
WHERE user_id = '0a4a8448-924c-4e67-9237-d4af81328816' 
  AND batch_number = 1
ORDER BY completed_at ASC;

-- 3. Batch Attempt Summary:
SELECT 
    batch_number,
    attempt_number,
    score,
    accuracy_percentage,
    completion_percentage,
    completed_at
FROM public.user_batch_progress
WHERE user_id = '0a4a8448-924c-4e67-9237-d4af81328816'
ORDER BY completed_at ASC;
