-- ==============================================================================
-- SafePass: Dynamically Adjust Batch 1 for BIPIN BABULAL (SINLOG-P0007)
-- ==============================================================================
-- This script does NOT hardcode 100%.
-- Instead, it:
-- 1. Keeps the first 30 questions Bipin answered for Batch 1.
-- 2. Removes the leftover questions answered after the 30th question.
-- 3. Sums his actual earned marks across those 30 questions.
-- 4. Computes his true, authentic score: (sum_of_marks / 30.0) * 100.
-- 5. Updates user_batch_progress, profiles, and compliance_logs to that exact score.
-- ==============================================================================

DO $$
DECLARE
    target_user_id UUID;
    v_b1_total INT;
    v_actual_marks NUMERIC;
    v_actual_correct INT;
    v_calculated_score NUMERIC;
    v_calculated_accuracy NUMERIC;
BEGIN
    -- 1. Find user ID
    SELECT id INTO target_user_id 
    FROM public.profiles 
    WHERE id = '0a4a8448-924c-4e67-9237-d4af81328816' 
       OR employee_id = 'SINLOG-P0007';

    IF target_user_id IS NULL THEN
        RAISE NOTICE 'User BIPIN BABULAL not found.';
        RETURN;
    END IF;

    -- 2. Count current questions in Batch 1
    SELECT count(*) INTO v_b1_total
    FROM public.user_question_progress
    WHERE user_id = target_user_id AND batch_number = 1;

    RAISE NOTICE 'Current questions in Batch 1: %', v_b1_total;

    -- 3. If more than 30, remove the leftover questions answered last
    -- (keeps the original first 30 questions intact)
    IF v_b1_total > 30 THEN
        DELETE FROM public.user_question_progress
        WHERE id IN (
            SELECT id 
            FROM public.user_question_progress
            WHERE user_id = target_user_id AND batch_number = 1
            ORDER BY completed_at DESC
            LIMIT (v_b1_total - 30)
        );
        RAISE NOTICE 'Removed % leftover questions, leaving the original first 30.', (v_b1_total - 30);
    END IF;

    -- 4. Calculate the REAL score and accuracy from the remaining 30 questions
    SELECT 
        COALESCE(SUM(score), 0),
        COUNT(*) FILTER (WHERE is_correct = TRUE)
    INTO 
        v_actual_marks,
        v_actual_correct
    FROM public.user_question_progress
    WHERE user_id = target_user_id AND batch_number = 1;

    -- Exact mathematical score based on the 30 questions
    v_calculated_score := LEAST(100.0, ROUND((v_actual_marks / 30.0) * 100.0, 1));
    v_calculated_accuracy := LEAST(100.0, ROUND((v_actual_correct::NUMERIC / 30.0) * 100.0, 1));

    RAISE NOTICE '------------------------------------------------';
    RAISE NOTICE 'Real Marks Earned: % / 30', v_actual_marks;
    RAISE NOTICE 'Real Questions Correct: % / 30', v_actual_correct;
    RAISE NOTICE 'Real Calculated Score: % %%', v_calculated_score;
    RAISE NOTICE 'Real Calculated Accuracy: % %%', v_calculated_accuracy;
    RAISE NOTICE '------------------------------------------------';

    -- 5. Update user_batch_progress with the true calculated score
    UPDATE public.user_batch_progress
    SET score = v_calculated_score,
        accuracy_percentage = v_calculated_accuracy,
        completion_percentage = 100.0
    WHERE user_id = target_user_id AND batch_number = 1;

    -- 6. Update profile safety_index and total_score to the true calculated score
    UPDATE public.profiles
    SET safety_index = ROUND(v_calculated_score),
        total_score = ROUND(v_calculated_score),
        updated_at = NOW()
    WHERE id = target_user_id;

    -- 7. Update compliance_logs to the true calculated score
    UPDATE public.compliance_logs
    SET score = ROUND(v_calculated_score)
    WHERE user_id = target_user_id;

    RAISE NOTICE 'Successfully updated all records to real values based on the 30 questions.';
END $$;
