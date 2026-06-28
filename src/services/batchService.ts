import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { getWeek, getYear } from 'date-fns';
import * as Crypto from 'expo-crypto';


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
     * Get questions for a specific batch based on Smart Learning logic:
     * 1. Unseen questions first
     * 2. Questions answered wrong previously
     * 3. Random pool (Reshuffle all) if all were answered correctly
     */
    async getBatchQuestions(batchNumber: number, userId: string): Promise<Question[]> {
        if (batchNumber < 1 || batchNumber > 8) {
            throw new Error(`Invalid batch number: ${batchNumber}`);
        }

        const { data: profile } = await supabase
            .from('profiles')
            .select('vehicle_type')
            .eq('id', userId)
            .single();

        let query = supabase
            .from('questions')
            .select('*')
            .eq('batch_number', batchNumber);

        let vType = profile?.vehicle_type;
        const validTypes = ['Box Van', 'Container Haulage', 'General Cargo'];
        
        // Failsafe: If they have an old/invalid vehicle type, default to General Cargo so the app doesn't break
        if (vType && !validTypes.includes(vType)) {
            vType = 'General Cargo';
        }

        if (vType) {
            query = query.contains('driver_categories', [vType]);
        }

        const { data: dbData, error } = await query;

        if (error) {
            console.error('Error fetching batch questions from Supabase:', error);
            throw error;
        }

        const batchData = dbData || [];

        // We need to fetch the past attempts for THIS user and THIS batch
        const attempts = await this.getBatchAttempts(userId, batchNumber);

        // Track user's success on each question
        const questionStatus = new Map<string, boolean>();
        
        attempts.forEach(attempt => {
            attempt.answers?.forEach(answer => {
                // If they ever got it right, mark as true.
                if (answer.isCorrect) {
                    questionStatus.set(answer.questionId, true);
                } else if (!questionStatus.has(answer.questionId)) {
                    // Start as false if they got it wrong and it's not already true
                    questionStatus.set(answer.questionId, false);
                }
            });
        });

        // Sort the source pool based on learning priority
        const unseenPool: typeof batchData = [];
        const incorrectPool: typeof batchData = [];
        const masteredPool: typeof batchData = [];

        batchData.forEach(q => {
            if (!questionStatus.has(q.id)) {
                unseenPool.push(q);
            } else if (questionStatus.get(q.id) === false) {
                incorrectPool.push(q);
            } else {
                masteredPool.push(q);
            }
        });

        const shufflePool = (pool: typeof batchData) => {
            const shuffled = [...pool];
            for (let i = shuffled.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
            }
            return shuffled;
        };

        // Combine pools in priority order: Unseen -> Incorrect -> Mastered
        const prioritizedData = [
            ...shufflePool(unseenPool),
            ...shufflePool(incorrectPool),
            ...shufflePool(masteredPool)
        ];

        // Map and format options for the prioritized list
        const questions = prioritizedData.map(q => {
            const originalOptions = [...(q.options || [])];
            const correctIdx = q.correct_option_index !== undefined ? q.correct_option_index : q.correctOptionIndex;
            const correctOptionText = originalOptions[correctIdx];

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
        // For Live Mode, the QuizScreen will only show the first 3
        return questions.slice(0, 30);
    },

    /**
     * Check if user can access a specific batch
     */
    async canAccessBatch(userId: string, batchNumber: number): Promise<boolean> {
        // Batch 1 is always accessible
        if (batchNumber === 1) return true;

        // Permanent unlock: if the user has already started this batch, always allow access
        // (prevents re-locking when previous batch average drops after new all-attempts logic)
        const thisAttempts = await this.getBatchAttempts(userId, batchNumber);
        if (thisAttempts.length > 0) return true;

        // First-time access: check if the user has EVER scored >= 60% in a single session
        // on the previous batch (best score, not running average)
        const prevBatchNumber = batchNumber - 1;
        const prevAttempts = await this.getBatchAttempts(userId, prevBatchNumber);
        if (prevAttempts.length === 0) return false;

        const bestScore = Math.max(...prevAttempts.map(a => a.score));
        return bestScore >= 60;
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

            // Fetch past attempts to calculate cumulative component scores for the batch
            const existingAttempts = await this.getBatchAttempts(userId, batchNumber);
            const allAnswers = existingAttempts.flatMap(a => a.answers || []);
            allAnswers.push(...answers);

            // Calculate component scores cumulatively across all unique questions answered in this batch
            const componentScores = this.calculateComponentScores(questions, allAnswers);
            console.log(`[BatchService] Scores calculated for User ${userId}: ${score}%, Accuracy: ${accuracy}%, Completion: ${completion}%`);

            // --- ADDED FOR MANAGER VISIBILITY ---
            // Update compliance_logs and profile stats so managers see progress on Team page
            // This happens BEFORE the batch PB check to ensure weekly activity is recorded
            try {
                const now = new Date();
                const weekNumber = getWeek(now);
                const year = getYear(now);

                // Check for existing compliance log to see if this is a new weekly best
                const { data: existingLog } = await supabase
                    .from('compliance_logs')
                    .select('score')
                    .eq('user_id', userId)
                    .eq('week_number', weekNumber)
                    .eq('year', year)
                    .maybeSingle();

                if (!existingLog || score > (existingLog.score || 0)) {
                    // Generate HMAC signature for compliance log (consistency with QuizService)
                    const dataToSign = JSON.stringify({ userId, weekNumber, year, score });
                    const signature = await Crypto.digestStringAsync(
                        Crypto.CryptoDigestAlgorithm.SHA256,
                        dataToSign + 'safe-pass-secret-key-v1'
                    );

                    // Save or update compliance log (Leaderboard source)
                    console.log(`[BatchService] Updating compliance log for Week ${weekNumber}, Score: ${score}%`);
                    await supabase
                        .from('compliance_logs')
                        .upsert({
                            user_id: userId,
                            week_number: weekNumber,
                            year,
                            status: 'COMPLIANT',
                            score: score,
                            signature,
                            completed_at: now.toISOString(),
                        }, {
                            onConflict: 'user_id,week_number,year'
                        });
                } else {
                    console.log(`[BatchService] Weekly best (${existingLog.score}%) is higher than current (${score}%). Log not updated but user is active.`);
                }

            } catch (complianceUpdateError) {
                console.warn('[BatchService] Post-submission updates failed:', complianceUpdateError);
            }
            // -------------------------------------

            // Every attempt is saved — average reflects genuine daily performance
            // (Previously only saved if score beat previous best; removed for daily 3Q limit flow)
            console.log(`[BatchService] Fetching existing attempts for User: ${userId}, Batch: ${batchNumber}`);
            const existingAttempts = await this.getBatchAttempts(userId, batchNumber);
            console.log(`[BatchService] Found ${existingAttempts.length} existing attempts`);

            const attemptNumber = existingAttempts.length + 1;
            console.log(`[BatchService] Saving attempt #${attemptNumber} with score ${score}%...`);

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

            // --- POST-INSERT: Update profile with averaged stats ---
            // Now that the new attempt is saved, compute rolling safety_index
            // and average component scores from DB (includes the just-inserted row)
            try {
                // Safety index: rolling average of last 5 attempts (includes new row)
                const { data: recentAttempts } = await supabase
                    .from('user_batch_progress')
                    .select('score')
                    .eq('user_id', userId)
                    .order('completed_at', { ascending: false })
                    .limit(5);

                const recentScores = recentAttempts?.map((a: any) => a.score) || [score];
                const avgSafetyIndex = Math.round(
                    recentScores.reduce((sum: number, s: number) => sum + s, 0) / recentScores.length
                );

                // Average component scores: take latest attempt per batch, then average across batches
                const { data: allAttempts } = await supabase
                    .from('user_batch_progress')
                    .select('batch_number, component_scores')
                    .eq('user_id', userId)
                    .order('completed_at', { ascending: false });

                const processedBatches = new Set<number>();
                let opTotal = 0, discTotal = 0, profTotal = 0, batchCount = 0;
                (allAttempts || []).forEach((a: any) => {
                    if (!processedBatches.has(a.batch_number) && a.component_scores) {
                        opTotal += a.component_scores.operation || 0;
                        discTotal += a.component_scores.discipline || 0;
                        profTotal += a.component_scores.professionalism || 0;
                        batchCount++;
                        processedBatches.add(a.batch_number);
                    }
                });

                const avgComponentScores = {
                    operation: batchCount > 0 ? Math.round(opTotal / batchCount) : componentScores.operation,
                    discipline: batchCount > 0 ? Math.round(discTotal / batchCount) : componentScores.discipline,
                    professionalism: batchCount > 0 ? Math.round(profTotal / batchCount) : componentScores.professionalism,
                };

                await supabase
                    .from('profiles')
                    .update({
                        safety_index: avgSafetyIndex,
                        component_scores: avgComponentScores,
                        total_score: avgSafetyIndex,
                    })
                    .eq('id', userId);

                console.log(`[BatchService] Profile synced — Safety Index: ${avgSafetyIndex}, Components:`, avgComponentScores);
            } catch (profileUpdateError) {
                console.warn('[BatchService] Profile stats update failed (non-critical):', profileUpdateError);
            }
            // -------------------------------------------------------

            // Update user's current batch if passed (score >= 60%) and it's their current batch
            const avgScore = await this.getBatchAverageScore(userId, batchNumber);
            console.log(`[BatchService] New Average Score: ${avgScore}`);

            if (avgScore >= 60) {
                const currentBatch = await this.getCurrentBatch(userId);
                if (batchNumber === currentBatch) {
                    console.log(`[BatchService] Upgrading user to Batch ${batchNumber + 1}`);
                    const { error: updateError } = await supabase
                        .from('profiles')
                        .update({
                            current_batch: batchNumber < 8 ? batchNumber + 1 : 8,
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

        // Group answers by questionId, taking the BEST result (true overrides false)
        const bestAnswers = new Map<string, boolean>();
        answers.forEach(a => {
            if (a.isCorrect) bestAnswers.set(a.questionId, true);
            else if (!bestAnswers.has(a.questionId)) bestAnswers.set(a.questionId, false);
        });

        bestAnswers.forEach((isCorrect, questionId) => {
            const question = questions.find(q => q.id === questionId);
            if (!question || !question.componentWeights) return;

            const weights = question.componentWeights;
            const score = isCorrect ? 1.0 : 0;

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
            // Get current user's company to filter
            const { data: { user } } = await supabase.auth.getUser();
            if (!user) throw new Error('Not authenticated');

            const { data: currentProfile } = await supabase
                .from('profiles')
                .select('company_id')
                .eq('id', user.id)
                .single();

            // 1. Get all participants in the SAME company
            let usersQuery = supabase
                .from('profiles')
                .select('id, full_name, division, region, employee_id, role, age, vehicle_type')
                .neq('role', 'manager')
                .order('full_name');

            if (currentProfile?.company_id) {
                usersQuery = usersQuery.eq('company_id', currentProfile.company_id);
            }

            const { data: users, error: userError } = await usersQuery;

            if (userError) throw userError;

            // 2. Get ALL progress data at once to avoid N+1 queries. 
            // Note: If RLS is enabled, this will ONLY return rows the user is allowed to see.
            // But we filter by user IDs anyway for extra safety.
            const userIds = users?.map(u => u.id) || [];

            if (userIds.length === 0) return [];

            const { data: allProgress, error: progressError } = await supabase
                .from('user_batch_progress')
                .select('*')
                .in('user_id', userIds);


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
                const batches = [1, 2, 3, 4, 5, 6, 7, 8].map(batchNum => {
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
                    userName: user.full_name || 'Staff',
                    staffId: user.employee_id,
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

    /**
     * Force synchronization of profile metrics (safety_index, component_scores)
     * by aggregating all past batch attempts.
     */
    async syncProfileStats(userId: string): Promise<void> {
        try {
            console.log(`[BatchService] Syncing profile stats for user: ${userId}`);

            // 1. Get ALL batch attempts for this user
            const { data: attempts, error } = await supabase
                .from('user_batch_progress')
                .select('*')
                .eq('user_id', userId)
                .order('completed_at', { ascending: false });

            if (error || !attempts || attempts.length === 0) {
                console.log('[BatchService] No attempts found to sync.');
                return;
            }

            // 2. Calculate Safety Index (rolling average of last 5 unique batch attempts)
            // Strategy: Get the BEST score from each batch, then average them
            const batchBestScores = new Map<number, number>();
            attempts.forEach(a => {
                const currentBest = batchBestScores.get(a.batch_number) || 0;
                if (a.score > currentBest) {
                    batchBestScores.set(a.batch_number, a.score);
                }
            });

            const scores = Array.from(batchBestScores.values());
            const avgSafetyIndex = Math.round(scores.reduce((sum, s) => sum + s, 0) / scores.length);

            // 3. Aggregate Component Scores (Average from latest attempts of each batch)
            let opTotal = 0, discTotal = 0, profTotal = 0, count = 0;

            const processedBatches = new Set<number>();
            attempts.forEach(a => {
                if (!processedBatches.has(a.batch_number) && a.component_scores) {
                    opTotal += a.component_scores.operation || 0;
                    discTotal += a.component_scores.discipline || 0;
                    profTotal += a.component_scores.professionalism || 0;
                    count++;
                    processedBatches.add(a.batch_number);
                }
            });

            const componentScores = {
                operation: count > 0 ? Math.round(opTotal / count) : 0,
                discipline: count > 0 ? Math.round(discTotal / count) : 0,
                professionalism: count > 0 ? Math.round(profTotal / count) : 0,
            };

            let passedBatchesCount = 0;
            for (const score of batchBestScores.values()) {
                if (score >= 60) {
                    passedBatchesCount++;
                }
            }

            // 4. Update Profile
            console.log(`[BatchService] Synced: Safety Index ${avgSafetyIndex}, Components:`, componentScores);
            await supabase
                .from('profiles')
                .update({
                    safety_index: avgSafetyIndex,
                    component_scores: componentScores,
                    total_score: avgSafetyIndex,
                    total_batches_completed: passedBatchesCount
                })
                .eq('id', userId);

            // 5. Ensure trending exists (Create initial log for chart if missing)
            const now = new Date();
            const year = now.getFullYear();
            // Simple week calculation
            const firstDayOfYear = new Date(year, 0, 1);
            const pastDaysOfYear = (now.getTime() - firstDayOfYear.getTime()) / 86400000;
            const weekNumber = Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);

            await supabase
                .from('compliance_logs')
                .upsert({
                    user_id: userId,
                    week_number: weekNumber,
                    year: year,
                    score: avgSafetyIndex,
                    component_scores: componentScores,
                    updated_at: now.toISOString()
                }, {
                    onConflict: 'user_id,week_number,year'
                });

        } catch (error) {
            console.error('[BatchService] Error syncing profile stats:', error);
        }
    },

    /**
     * Get total cumulative XP for a user.
     * XP = sum of all batch attempt scores ever submitted.
     * Each daily attempt adds to the total — the more you do and
     * the more correct answers you get, the higher your XP.
     */
    async getTotalXP(userId: string): Promise<number> {
        try {
            const { data, error } = await supabase
                .from('user_batch_progress')
                .select('score')
                .eq('user_id', userId);

            if (error || !data || data.length === 0) return 0;

            const total = data.reduce((sum: number, a: any) => sum + (a.score || 0), 0);
            return Math.round(total);
        } catch (error) {
            console.error('[BatchService] Error getting total XP:', error);
            return 0;
        }
    },

    /**
     * Get the actual number of questions answered by a user across all batches
     */
    async getTotalAnsweredQuestions(userId: string): Promise<number> {
        try {
            const { data, error } = await supabase
                .from('user_batch_progress')
                .select('answers')
                .eq('user_id', userId);

            if (error || !data || data.length === 0) return 0;

            let totalQuestions = 0;
            data.forEach((row: any) => {
                if (row.answers && Array.isArray(row.answers)) {
                    totalQuestions += row.answers.length;
                }
            });

            return totalQuestions;
        } catch (error) {
            console.error('[BatchService] Error getting total answered questions:', error);
            return 0;
        }
    },
};
