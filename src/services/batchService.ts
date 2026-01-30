import { supabase } from '../lib/supabase';
import { Question } from '../types/models';

// Import batch question data
import batch1Questions from '../data/batches/batch1.json';
import batch2Questions from '../data/batches/batch2.json';
import batch3Questions from '../data/batches/batch3.json';
import batch4Questions from '../data/batches/batch4.json';

const BATCH_QUESTIONS = {
    1: batch1Questions,
    2: batch2Questions,
    3: batch3Questions,
    4: batch4Questions,
};

export interface BatchProgress {
    id: string;
    userId: string;
    batchNumber: number;
    attemptNumber: number;
    score: number;
    accuracyPercentage: number;
    completionPercentage: number;
    componentScores: {
        operation: number;
        discipline: number;
        professionalism: number;
    };
    answers: Array<{
        questionId: string;
        attempts: number;
        isCorrect: boolean;
    }>;
    timeSpentSeconds: number;
    completedAt: string;
}

export const BatchService = {
    /**
     * Get questions for a specific batch
     */
    async getBatchQuestions(batchNumber: number): Promise<Question[]> {
        if (batchNumber < 1 || batchNumber > 4) {
            throw new Error(`Invalid batch number: ${batchNumber}`);
        }

        const batchData = BATCH_QUESTIONS[batchNumber as keyof typeof BATCH_QUESTIONS];

        // Shuffle options for each question to prevent memorization
        const questions = batchData.map(q => {
            const originalOptions = [...q.options];
            const correctOptionText = originalOptions[q.correctOptionIndex];

            // Create shuffled indices
            const indices = originalOptions.map((_, i) => i);
            for (let i = indices.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [indices[i], indices[j]] = [indices[j], indices[i]];
            }

            // Reorder options
            const shuffledOptions = indices.map(i => originalOptions[i]);
            const newCorrectIndex = shuffledOptions.indexOf(correctOptionText);

            // Shuffle Malay options in same order
            const shuffledOptionsMalay = q.options_ms
                ? indices.map(i => q.options_ms![i])
                : undefined;

            return {
                id: q.id,
                text: q.text,
                text_ms: q.text_ms,
                options: shuffledOptions,
                options_ms: shuffledOptionsMalay,
                correctOptionIndex: newCorrectIndex,
                explanation: q.explanation,
                explanation_ms: q.explanation_ms,
                region: q.region,
                category: q.category,
                imageUrl: (q as any).image_url || (q as any).imageUrl,
                difficulty: q.difficulty || 'intermediate',
                componentWeights: q.componentWeights || (q as any).component_weights,
            } as Question;
        });

        // CRITICAL: Return exactly 30 questions
        return questions.slice(0, 30);
    },

    /**
     * Check if user can access a specific batch
     */
    async canAccessBatch(userId: string, batchNumber: number): Promise<boolean> {
        // Batch 1 is always accessible
        if (batchNumber === 1) return true;

        // Check if previous batch has been passed (average score >= 60%)
        const prevBatchNumber = batchNumber - 1;
        const avgScore = await this.getBatchAverageScore(userId, prevBatchNumber);

        return avgScore >= 60;
    },

    /**
     * Get average score for a batch across all attempts
     */
    async getBatchAverageScore(userId: string, batchNumber: number): Promise<number> {
        const { data, error } = await supabase
            .from('user_batch_progress')
            .select('score')
            .eq('user_id', userId)
            .eq('batch_number', batchNumber);

        if (error || !data || data.length === 0) {
            return 0;
        }

        // Simple average of all attempts
        const total = data.reduce((sum, attempt) => sum + attempt.score, 0);
        return total / data.length;
    },

    /**
     * Get all attempts for a specific batch
     */
    async getBatchAttempts(userId: string, batchNumber: number): Promise<BatchProgress[]> {
        const { data, error } = await supabase
            .from('user_batch_progress')
            .select('*')
            .eq('user_id', userId)
            .eq('batch_number', batchNumber)
            .order('attempt_number', { ascending: true });

        if (error) {
            console.error('Error fetching batch attempts:', error);
            return [];
        }

        return (data || []).map(attempt => ({
            id: attempt.id,
            userId: attempt.user_id,
            batchNumber: attempt.batch_number,
            attemptNumber: attempt.attempt_number,
            score: attempt.score,
            accuracyPercentage: attempt.accuracy_percentage,
            completionPercentage: attempt.completion_percentage,
            componentScores: attempt.component_scores,
            answers: attempt.answers,
            timeSpentSeconds: attempt.time_spent_seconds,
            completedAt: attempt.completed_at,
        }));
    },

    /**
     * Get current batch number for a user
     */
    async getCurrentBatch(userId: string): Promise<number> {
        const { data, error } = await supabase
            .from('profiles')
            .select('current_batch')
            .eq('id', userId)
            .single();

        if (error || !data) {
            return 1; // Default to batch 1
        }

        return data.current_batch || 1;
    },

    /**
     * Calculate score with attempt-based weighting
     * 1st attempt: 1.0, 2nd: 0.5, 3rd: 0.25, 4th+: 0
     */
    calculateScoreWithAttempts(
        answers: Array<{ questionId: string; attempts: number; isCorrect: boolean }>
    ): number {
        if (answers.length === 0) return 0;

        let totalScore = 0;

        answers.forEach(a => {
            if (a.isCorrect) {
                totalScore += 1.0;
            } else {
                totalScore += 0;
            }
        });

        const maxScore = answers.length;
        const percentage = (totalScore / maxScore) * 100;

        return Math.max(0, Math.round(percentage * 100) / 100); // Round to 2 decimals
    },

    /**
     * Calculate accuracy and completion percentages
     */
    calculatePercentages(
        answers: Array<{ questionId: string; attempts: number; isCorrect: boolean }>,
        totalQuestions: number
    ): { accuracy: number; completion: number } {
        const attemptedCount = answers.length;
        const correctCount = answers.filter(a => a.isCorrect).length;

        const accuracy = attemptedCount > 0 ? (correctCount / attemptedCount) * 100 : 0;
        const completion = (attemptedCount / totalQuestions) * 100;

        return {
            accuracy: Math.round(accuracy * 100) / 100,
            completion: Math.round(completion * 100) / 100,
        };
    },

    /**
     * Submit batch attempt
     */
    async submitBatchAttempt(
        userId: string,
        batchNumber: number,
        answers: Array<{ questionId: string; attempts: number; isCorrect: boolean }>,
        questions: Question[],
        timeSpentSeconds: number
    ): Promise<{ success: boolean; progress: BatchProgress | null }> {
        try {
            console.log(`[BatchService] submitBatchAttempt called for User: ${userId}, Batch: ${batchNumber}`);

            // Calculate scores
            const score = this.calculateScoreWithAttempts(answers);
            const { accuracy, completion } = this.calculatePercentages(answers, questions.length);

            // Calculate component scores
            const componentScores = this.calculateComponentScores(questions, answers);
            console.log(`[BatchService] Scores calculated: ${score}%, Accuracy: ${accuracy}%`);

            // Check if score is higher than previous best
            console.log(`[BatchService] Fetching existing attempts...`);
            const existingAttempts = await this.getBatchAttempts(userId, batchNumber);

            if (existingAttempts.length > 0) {
                const maxScore = existingAttempts.reduce((max, attempt) => Math.max(max, attempt.score), 0);

                if (score <= maxScore) {
                    console.log(`[BatchService] Score ${score} is not higher than max score ${maxScore}. Not saving.`);
                    return { success: true, progress: null };
                }
            }

            const attemptNumber = existingAttempts.length + 1;
            console.log(`[BatchService] This will be attempt #${attemptNumber}`);

            // Insert batch progress
            console.log(`[BatchService] Inserting into user_batch_progress...`);
            const { data, error } = await supabase
                .from('user_batch_progress')
                .insert({
                    user_id: userId,
                    batch_number: batchNumber,
                    attempt_number: attemptNumber,
                    score,
                    accuracy_percentage: accuracy,
                    completion_percentage: completion,
                    component_scores: componentScores,
                    answers,
                    time_spent_seconds: timeSpentSeconds,
                })
                .select()
                .single();

            if (error) {
                console.error('[BatchService] Insert Error:', JSON.stringify(error));
                throw error;
            }
            console.log(`[BatchService] Insert successful, ID: ${data.id}`);

            // Update user's current batch if passed (score >= 60%) and it's their current batch
            const avgScore = await this.getBatchAverageScore(userId, batchNumber);
            console.log(`[BatchService] New Average Score: ${avgScore}`);

            if (avgScore >= 60 && batchNumber < 4) {
                const currentBatch = await this.getCurrentBatch(userId);
                if (batchNumber === currentBatch) {
                    console.log(`[BatchService] Upgrading user to Batch ${batchNumber + 1}`);
                    const { error: updateError } = await supabase
                        .from('profiles')
                        .update({
                            current_batch: batchNumber + 1,
                            total_batches_completed: batchNumber,
                        })
                        .eq('id', userId);

                    if (updateError) console.error('[BatchService] Error updating profile:', updateError);
                }
            }

            const progress: BatchProgress = {
                id: data.id,
                userId: data.user_id,
                batchNumber: data.batch_number,
                attemptNumber: data.attempt_number,
                score: data.score,
                accuracyPercentage: data.accuracy_percentage,
                completionPercentage: data.completion_percentage,
                componentScores: data.component_scores,
                answers: data.answers,
                timeSpentSeconds: data.time_spent_seconds,
                completedAt: data.completed_at,
            };

            return { success: true, progress };
        } catch (error) {
            console.error('[BatchService] Error submitting batch attempt:', error);
            return { success: false, progress: null };
        }
    },

    /**
     * Calculate component scores (DOPD)
     */
    calculateComponentScores(
        questions: Question[],
        answers: Array<{ questionId: string; attempts: number; isCorrect: boolean }>
    ): { operation: number; discipline: number; professionalism: number } {
        let operationTotal = 0;
        let disciplineTotal = 0;
        let professionalismTotal = 0;
        let operationMax = 0;
        let disciplineMax = 0;
        let professionalismMax = 0;

        answers.forEach(answer => {
            const question = questions.find(q => q.id === answer.questionId);
            if (!question || !question.componentWeights) return;

            const weights = question.componentWeights;
            const score = this.getAttemptScore(answer.attempts, answer.isCorrect);

            // Accumulate weighted scores
            operationTotal += (weights.operation || 0) * score;
            disciplineTotal += (weights.discipline || 0) * score;
            professionalismTotal += (weights.professionalism || 0) * score;

            // Accumulate max possible
            operationMax += weights.operation || 0;
            disciplineMax += weights.discipline || 0;
            professionalismMax += weights.professionalism || 0;
        });

        return {
            operation: operationMax > 0 ? Math.round((operationTotal / operationMax) * 100) : 0,
            discipline: disciplineMax > 0 ? Math.round((disciplineTotal / disciplineMax) * 100) : 0,
            professionalism:
                professionalismMax > 0 ? Math.round((professionalismTotal / professionalismMax) * 100) : 0,
        };
    },

    /**
     * Get score for a single answer based on attempts
     */
    getAttemptScore(attempts: number, isCorrect: boolean): number {
        // Simple Average requested: always full marks if correct, regardless of attempts
        if (!isCorrect) return 0;
        return 1.0;
    },

    /**
     * Get batch statistics for all users (for managers)
     */
    async getAllUsersBatchStats(): Promise<
        Array<{
            userId: string;
            userName: string;
            staffId: string;
            division: string;
            region: string;
            batches: Array<{
                batchNumber: number;
                averageScore: number;
                accuracy: number;
                completion: number;
                attemptCount: number;
                totalTimeSeconds: number;
                componentScores: { operation: number; discipline: number; professionalism: number };
            }>;
            totalTimeMinutes: number;
        }>
    > {
        try {
            // 1. Get all participants (exclude only managers)
            const { data: users, error: userError } = await supabase
                .from('profiles')
                .select('id, full_name, email, division, region, employee_id, role, age, vehicle_type')
                .neq('role', 'manager')
                .order('full_name');

            if (userError) throw userError;

            // 2. Get ALL progress data at once to avoid N+1 queries
            const { data: allProgress, error: progressError } = await supabase
                .from('user_batch_progress')
                .select('*');

            if (progressError) throw progressError;

            // 3. Group progress by user and batch
            const progressMap = new Map<string, BatchProgress[]>();

            (allProgress || []).forEach((row: any) => {
                const key = `${row.user_id}_${row.batch_number}`;
                if (!progressMap.has(key)) {
                    progressMap.set(key, []);
                }

                const attempt: BatchProgress = {
                    id: row.id,
                    userId: row.user_id,
                    batchNumber: row.batch_number,
                    attemptNumber: row.attempt_number,
                    score: row.score,
                    accuracyPercentage: row.accuracy_percentage,
                    completionPercentage: row.completion_percentage,
                    componentScores: row.component_scores,
                    answers: row.answers,
                    timeSpentSeconds: row.time_spent_seconds,
                    completedAt: row.completed_at,
                };

                progressMap.get(key)?.push(attempt);
            });

            // 4. Build statistics
            const stats = (users || []).map(user => {
                const batches = [1, 2, 3, 4].map(batchNum => {
                    const attempts = progressMap.get(`${user.id}_${batchNum}`) || [];

                    if (attempts.length === 0) {
                        return {
                            batchNumber: batchNum,
                            averageScore: 0,
                            accuracy: 0,
                            completion: 0,
                            attemptCount: 0,
                            totalTimeSeconds: 0,
                            componentScores: { operation: 0, discipline: 0, professionalism: 0 },
                        };
                    }

                    // Sort by attempt number just in case
                    attempts.sort((a, b) => a.attemptNumber - b.attemptNumber);

                    const avgScore = attempts.reduce((sum, a) => sum + a.score, 0) / attempts.length;
                    const totalTime = attempts.reduce((sum, a) => sum + (a.timeSpentSeconds || 0), 0);
                    const latestAttempt = attempts[attempts.length - 1];

                    return {
                        batchNumber: batchNum,
                        averageScore: Math.round(avgScore * 100) / 100,
                        accuracy: latestAttempt.accuracyPercentage,
                        completion: latestAttempt.completionPercentage,
                        attemptCount: attempts.length,
                        totalTimeSeconds: totalTime,
                        componentScores: latestAttempt.componentScores,
                    };
                });

                const totalTime = batches.reduce((sum, b) => sum + (b.totalTimeSeconds || 0), 0);

                return {
                    userId: user.id,
                    userName: user.full_name || user.email,
                    staffId: user.employee_id || user.email,
                    division: user.division || '-',
                    region: user.region || 'MY',
                    age: (user as any).age || null,
                    vehicleType: (user as any).vehicle_type || null,
                    totalTimeMinutes: Math.round((totalTime / 60) * 100) / 100,
                    batches,
                };
            });

            return stats;
        } catch (error) {
            console.error('Error fetching batch stats:', error);
            return [];
        }
    },
};
