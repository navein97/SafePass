-- ==============================================================================
-- SafePass: Preview Bipin Babulal's Real Score (Read-Only)
-- ==============================================================================
-- Run this in Supabase SQL Editor to see the exact numbers for the first 30 questions
-- and the 3 leftover questions WITHOUT changing any data.

-- 1. Summary of what the REAL score will be across the first 30 questions:
SELECT 
    COUNT(*) as total_questions,
    SUM(score) as total_marks_earned,
    COUNT(*) FILTER (WHERE is_correct = TRUE) as correct_questions,
    ROUND((SUM(score) / 30.0) * 100.0, 1) as real_score_percentage,
    ROUND((COUNT(*) FILTER (WHERE is_correct = TRUE)::NUMERIC / 30.0) * 100.0, 1) as real_accuracy_percentage
FROM (
    SELECT score, is_correct, completed_at
    FROM public.user_question_progress
    WHERE user_id = '0a4a8448-924c-4e67-9237-d4af81328816' AND batch_number = 1
    ORDER BY completed_at ASC
    LIMIT 30
) as first_30;

-- 2. The 3 leftover questions that were answered last:
SELECT id, question_id, attempts, is_correct, score, completed_at
FROM public.user_question_progress
WHERE user_id = '0a4a8448-924c-4e67-9237-d4af81328816' AND batch_number = 1
ORDER BY completed_at DESC
LIMIT 3;
