import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { getWeek, getYear } from 'date-fns';
import * as Crypto from 'expo-crypto';
import { PracticeService } from './practiceService';


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
    _availableBatchesCache: null as number[] | null,

    /**
     * Dynamically fetch all unique batch numbers available in the database
     */
    async getAvailableBatchNumbers(forceRefresh = false): Promise<number[]> {
        if (!forceRefresh && this._availableBatchesCache && this._availableBatchesCache.length > 0) {
            return this._availableBatchesCache;
        }
        try {
            const { data, error } = await supabase
                .from('questions')
                .select('batch_number');

            if (error) throw error;

            const batchSet = new Set<number>();
            data?.forEach(row => {
                const b = parseInt(String(row.batch_number), 10);
                if (!isNaN(b) && b > 0) {
                    batchSet.add(b);
                }
            });

            const sorted = Array.from(batchSet).sort((a, b) => a - b);
            this._availableBatchesCache = sorted.length > 0 ? sorted : [1, 2, 3, 4, 5, 6, 7, 8];
            return this._availableBatchesCache;
        } catch (err) {
            console.error('Error fetching available batch numbers:', err);
            return [1, 2, 3, 4, 5, 6, 7, 8];
        }
    },

    /**
     * Get maximum batch number currently configured
     */
    async getMaxBatchNumber(): Promise<number> {
        const batches = await this.getAvailableBatchNumbers();
        return batches.length > 0 ? Math.max(...batches) : 8;
    },

    /**
     * Get questions for a specific batch based on Smart Learning logic:
     * 1. Unseen questions first
     * 2. Questions answered wrong previously
     * 3. Random pool (Reshuffle all) if all were answered correctly
     * Caps pool at maximum 30 questions per batch.
     */
    async getBatchQuestions(batchNumber: number, userId: string): Promise<Question[]> {
        if (batchNumber < 1) {
            throw new Error(`Invalid batch number: ${batchNumber}`);
        }

        const { data: profile } = await supabase
            .from('profiles')
            .select('vehicle_type')
            .eq('id', userId)
            .single();

        let { data: dbData, error } = await supabase
            .from('questions')
            .select('*')
            .eq('batch_number', batchNumber);

        if (error) {
            console.error('Error fetching batch questions from Supabase:', error);
            throw error;
        }

        const rawQuestions = dbData || [];
        let vType = profile?.vehicle_type;
        let batchData = rawQuestions;

        if (vType && rawQuestions.length > 0) {
            const matching = rawQuestions.filter(q => {
                if (!q.driver_categories || !Array.isArray(q.driver_categories) || q.driver_categories.length === 0) {
                    return true;
                }
                return q.driver_categories.includes(vType) || q.driver_categories.includes('All');
            });

            if (matching.length > 0) {
                batchData = matching;
            }
        }

        // Failsafe: If the batch has no questions at all in DB, fallback to any available questions
        if (!batchData || batchData.length === 0) {
            const { data: fallbackDb } = await supabase.from('questions').select('*').limit(30);
            batchData = fallbackDb || [];
        }

        // Fetch question progress for this user & batch
        const { data: progressData, error: progressError } = await supabase
            .from('user_question_progress')
            .select('question_id, attempts, is_correct')
            .eq('user_id', userId)
            .eq('batch_number', batchNumber);

        if (progressError) {
            console.error('Error fetching question progress:', progressError);
        }

        const progressMap = new Map<string, { attempts: number; is_correct: boolean }>();
        if (progressData) {
            progressData.forEach(p => {
                progressMap.set(p.question_id, {
                    attempts: p.attempts,
                    is_correct: p.is_correct
                });
            });
        }

        // Filter out completed questions (correct or 2 wrong attempts)
        const uncompletedData = batchData.filter(q => {
            const prog = progressMap.get(q.id);
            if (!prog) return true;
            return !prog.is_correct && prog.attempts < 2;
        });

        // Failsafe: If all questions in this batch have already been completed or attempted,
        // use all batch questions so the driver can retake/review the batch.
        const pool = (uncompletedData && uncompletedData.length > 0) ? uncompletedData : batchData;

        // Shuffle remaining questions and cap at max 30 questions
        const cappedPool = pool.slice(0, 30);
        const shuffledData = [...cappedPool];
        for (let i = shuffledData.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [shuffledData[i], shuffledData[j]] = [shuffledData[j], shuffledData[i]];
        }

        // Map and format options
        const questions = shuffledData.map(q => {
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

        return questions.slice(0, 30);
    },

    /**
     * Get total number of configured questions in a batch for a user's vehicle category.
     * If <= 30 (e.g. 24 for Box Van), returns the exact count (24).
     * If > 30 (e.g. 80 for Curtain Sider), caps at 30.
     */
    async getBatchTotalQuestions(batchNumber: number, userId: string): Promise<number> {
        try {
            const { data: profile } = await supabase
                .from('profiles')
                .select('vehicle_type')
                .eq('id', userId)
                .single();

            const { data: dbData, error } = await supabase
                .from('questions')
                .select('id, driver_categories')
                .eq('batch_number', batchNumber);

            if (error || !dbData || dbData.length === 0) return 30;

            const vType = profile?.vehicle_type;
            let matchingCount = dbData.length;
            if (vType) {
                const matching = dbData.filter(q => {
                    if (!q.driver_categories || !Array.isArray(q.driver_categories) || q.driver_categories.length === 0) {
                        return true;
                    }
                    return q.driver_categories.includes(vType) || q.driver_categories.includes('All');
                });
                if (matching.length > 0) {
                    matchingCount = matching.length;
                }
            }

            // Cap at 30 max, but preserve exact count if below 30 (e.g. 24)
            return Math.min(30, matchingCount);
        } catch {
            return 30;
        }
    },

    /**
     * Check if user can access a specific batch
     */
    async canAccessBatch(userId: string, batchNumber: number): Promise<boolean> {
        if (batchNumber === 1) return true;

        const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('batch_lock_override, current_batch')
            .eq('id', userId)
            .single();

        if (profileError) {
            console.error('Error fetching profile overrides for canAccessBatch:', profileError);
        }

        if (profile?.batch_lock_override) {
            return true;
        }

        const currentBatch = profile?.current_batch || 1;
        return batchNumber <= currentBatch;
    },

    /**
     * Get score for a batch using the latest attempt
     */
    async getBatchAverageScore(userId: string, batchNumber: number): Promise<number> {
        const attempts = await this.getBatchAttempts(userId, batchNumber);
        if (!attempts || attempts.length === 0) {
            return 0;
        }

        // Return latest attempt score for this batch
        const latestAttempt = attempts[attempts.length - 1];
        return latestAttempt ? latestAttempt.score : 0;
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

        const attempts: BatchProgress[] = (data || []).map(attempt => ({
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

        // PROVISIONAL SCORE LOGIC: Fetch in-progress questions
        const { data: qProgress } = await supabase
            .from('user_question_progress')
            .select('*')
            .eq('user_id', userId)
            .eq('batch_number', batchNumber);

        if (qProgress && qProgress.length > 0) {
            const { data: questionsData } = await supabase
                .from('questions')
                .select('id, component_weights')
                .eq('batch_number', batchNumber);

            const questions = (questionsData || []).map(q => ({
                id: q.id,
                componentWeights: q.component_weights || (q as any).componentWeights
            })) as Question[];

            const mappedAnswers = qProgress.map(a => ({
                questionId: a.question_id,
                attempts: a.attempts,
                isCorrect: a.is_correct
            }));

            const componentScores = this.calculateComponentScores(questions, mappedAnswers);
            let totalScore = 0;
            qProgress.forEach(a => {
                totalScore += parseFloat(String(a.score || 0));
            });
            const totalQuestionsInBatch = await this.getBatchTotalQuestions(batchNumber, userId);
            const score = Math.max(0, Math.round((totalScore / Math.max(1, totalQuestionsInBatch)) * 100));
            const accuracy = Math.round((qProgress.filter(a => a.is_correct).length / Math.max(1, qProgress.length)) * 100);
            const completion = Math.min(100, Math.round((qProgress.length / Math.max(1, totalQuestionsInBatch)) * 100));

            attempts.push({
                id: `provisional_${batchNumber}`,
                userId,
                batchNumber,
                attemptNumber: attempts.length + 1,
                score,
                accuracyPercentage: accuracy,
                completionPercentage: completion,
                componentScores,
                answers: mappedAnswers,
                timeSpentSeconds: 0,
                completedAt: new Date().toISOString() // Represents "now" since it's active
            });
        }

        return attempts;
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
                if (a.attempts === 1) {
                    totalScore += 1.0;
                } else if (a.attempts === 2) {
                    totalScore += 0.5;
                }
            }
        });

        const maxScore = answers.length;
        const percentage = (totalScore / maxScore) * 100;

        return Math.max(0, Math.round(percentage));
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


            // Calculate scores
            const score = this.calculateScoreWithAttempts(answers);

            // Fetch past attempts to aggregate all answers
            const existingAttempts = await this.getBatchAttempts(userId, batchNumber);
            const allAnswers = existingAttempts.flatMap(a => a.answers || []);
            allAnswers.push(...answers);

            // Deduplicate all answers to find unique questions and best correctness
            const uniqueAnswersMap = new Map<string, { questionId: string, attempts: number, isCorrect: boolean }>();
            allAnswers.forEach(a => {
                const existing = uniqueAnswersMap.get(a.questionId);
                if (!existing || a.isCorrect) {
                    uniqueAnswersMap.set(a.questionId, a);
                }
            });
            const uniqueAnswers = Array.from(uniqueAnswersMap.values());

            // Calculate cumulative stats
            const { accuracy, completion } = this.calculatePercentages(uniqueAnswers, questions.length);

            // Fetch all questions for this batch to ensure previous answers find their weights correctly
            const { data: batchQuestions } = await supabase
                .from('questions')
                .select('id, component_weights')
                .eq('batch_number', batchNumber);
            
            const allBatchQuestions = (batchQuestions || []).map(q => ({
                id: q.id,
                componentWeights: q.component_weights || (q as any).componentWeights
            })) as Question[];

            // Calculate component scores cumulatively across all unique questions answered in this batch
            const componentScores = this.calculateComponentScores(allBatchQuestions, allAnswers);


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

                }

            } catch (complianceUpdateError) {
                console.warn('[BatchService] Post-submission updates failed:', complianceUpdateError);
            }
            // -------------------------------------

            // Every attempt is saved — average reflects genuine daily performance
            // (Previously only saved if score beat previous best; removed for daily 3Q limit flow)
            const attemptNumber = existingAttempts.length + 1;

            // Insert batch progress
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


            // --- POST-INSERT: Update profile with latest attempt stats ---
            try {
                await this.syncProfileStats(userId);
            } catch (profileUpdateError) {
                console.warn('[BatchService] Profile stats update failed (non-critical):', profileUpdateError);
            }
            // -------------------------------------------------------

            // Update user's current batch if passed (score >= 60%) and it's their current batch
            const avgScore = await this.getBatchAverageScore(userId, batchNumber);


            if (avgScore >= 60) {
                const currentBatch = await this.getCurrentBatch(userId);
                if (batchNumber === currentBatch) {
                    const maxBatches = await this.getMaxBatchNumber();
                    const nextBatch = batchNumber < maxBatches ? batchNumber + 1 : maxBatches;
                    const { error: updateError } = await supabase
                        .from('profiles')
                        .update({
                            current_batch: nextBatch,
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
     * Calculate Overall Score (%) and Rank (S Rank, A Rank, B Rank, C Rank, D Rank) across all history.
     */
    async getCumulativeSafetyIndex(userId: string): Promise<{
        score: number; // percentage (0 - 100)
        rank: 'S Rank' | 'A Rank' | 'B Rank' | 'C Rank' | 'D Rank';
        rankColor: string;
        band: string;
        bandLabel: string;
        bandColor: string;
        passedBatchesCount: number;
        totalMCQsAnswered: number;
        componentScores: { operation: number; discipline: number; professionalism: number };
    }> {
        try {
            // Get all completed batch attempts
            const { data: attempts, error } = await supabase
                .from('user_batch_progress')
                .select('*')
                .eq('user_id', userId)
                .order('batch_number', { ascending: true });

            if (error) throw error;

            // Also check profile for safety_index and total_batches_completed
            const { data: profile } = await supabase
                .from('profiles')
                .select('safety_index, total_batches_completed, component_scores')
                .eq('id', userId)
                .single();

            // Unique passed batches map (best score per batch)
            const batchBestScores = new Map<number, number>();
            (attempts || []).forEach(a => {
                const currentBest = batchBestScores.get(a.batch_number) || 0;
                if ((a.score || 0) > currentBest) {
                    batchBestScores.set(a.batch_number, a.score);
                }
            });

            // Total MCQs answered
            const totalMCQs = await this.getTotalAnsweredQuestions(userId);

            // Fetch all answered questions to compute true Cumulative Average Score
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('score, is_correct')
                .eq('user_id', userId);

            let csiScore = 0;
            if (qProgress && qProgress.length > 0) {
                const totalEarned = qProgress.reduce((sum, q) => sum + parseFloat(String(q.score || 0)), 0);
                csiScore = Math.min(100, Math.round((totalEarned / Math.max(1, qProgress.length)) * 100));
            } else if (profile?.safety_index && profile.safety_index > 0) {
                csiScore = Math.round(profile.safety_index);
            }

            // Determine Rank (S Rank, A Rank, B Rank, C Rank, D Rank)
            let rank: 'S Rank' | 'A Rank' | 'B Rank' | 'C Rank' | 'D Rank' = 'D Rank';
            let rankColor = '#EF4444';

            if (csiScore >= 90) {
                rank = 'S Rank';
                rankColor = '#E11D48';
            } else if (csiScore >= 80) {
                rank = 'A Rank';
                rankColor = '#8B5CF6';
            } else if (csiScore >= 70) {
                rank = 'B Rank';
                rankColor = '#3B82F6';
            } else if (csiScore >= 60) {
                rank = 'C Rank';
                rankColor = '#F59E0B';
            } else {
                rank = 'D Rank';
                rankColor = '#EF4444';
            }

            const componentScores = profile?.component_scores || {
                operation: csiScore,
                discipline: csiScore,
                professionalism: csiScore,
            };

            return {
                score: csiScore,
                rank,
                rankColor,
                band: rank,
                bandLabel: rank,
                bandColor: rankColor,
                passedBatchesCount: batchBestScores.size,
                totalMCQsAnswered: totalMCQs,
                componentScores,
            };
        } catch (error) {
            console.error('[BatchService] Error getting Overall Score:', error);
            return {
                score: 0,
                rank: 'D Rank',
                rankColor: '#EF4444',
                band: 'D Rank',
                bandLabel: 'D Rank',
                bandColor: '#EF4444',
                passedBatchesCount: 0,
                totalMCQsAnswered: 0,
                componentScores: { operation: 0, discipline: 0, professionalism: 0 },
            };
        }
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
            age: number | null;
            vehicleType: string | null;
            overallScore: number;
            rank: string;
            csiPercentage: number;
            proHayatBand: string;
            proHayatBandLabel: string;
            batches: Array<{
                batchNumber: number;
                averageScore: number;
                accuracy: number;
                completion: number;
                attemptCount: number;
                totalTimeSeconds: number;
                componentScores?: { operation: number; discipline: number; professionalism: number };
            }>;
            totalTimeMinutes: number;
        }>
    > {
        try {
            // Get available batch numbers dynamically
            const availableBatches = await this.getAvailableBatchNumbers();

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

            const userIds = users?.map(u => u.id) || [];

            if (userIds.length === 0) return [];

            const { data: allProgress, error: progressError } = await supabase
                .from('user_batch_progress')
                .select('*')
                .in('user_id', userIds);

            if (progressError) throw progressError;

            // Group progress by user and batch
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

            // Provisional in-progress questions for all users
            const { data: allQProgress } = await supabase
                .from('user_question_progress')
                .select('*')
                .in('user_id', userIds);

            if (allQProgress && allQProgress.length > 0) {
                const { data: questionsData } = await supabase
                    .from('questions')
                    .select('id, batch_number, component_weights, driver_categories');
                
                const questions = (questionsData || []).map(q => ({
                    id: q.id,
                    batchNumber: q.batch_number,
                    componentWeights: q.component_weights || (q as any).componentWeights,
                    driverCategories: q.driver_categories || (q as any).driverCategories,
                })) as unknown as (Question & { batchNumber?: number; driverCategories?: string[] })[];

                const qProgressMap = new Map<string, any[]>();
                allQProgress.forEach((row: any) => {
                    const key = `${row.user_id}_${row.batch_number}`;
                    if (!qProgressMap.has(key)) qProgressMap.set(key, []);
                    qProgressMap.get(key)?.push(row);
                });

                qProgressMap.forEach((qRows, key) => {
                    const [userId, batchStr] = key.split('_');
                    const batchNum = parseInt(batchStr, 10);
                    const userObj = users?.find(u => u.id === userId);
                    const vType = (userObj as any)?.vehicle_type;
                    
                    const mappedAnswers = qRows.map(a => ({
                        questionId: a.question_id,
                        attempts: a.attempts,
                        isCorrect: a.is_correct
                    }));

                    const batchQuestions = questions.filter(q => {
                        if (q.batchNumber !== batchNum) return false;
                        if (!vType || !q.driverCategories || q.driverCategories.length === 0) return true;
                        return q.driverCategories.includes(vType) || q.driverCategories.includes('All');
                    });
                    const componentScores = this.calculateComponentScores(batchQuestions as any, mappedAnswers);
                    
                    let totalScore = 0;
                    qRows.forEach(a => {
                        totalScore += parseFloat(String(a.score || 0));
                    });
                    
                    const totalQuestionsInBatch = Math.min(30, Math.max(1, batchQuestions.length > 0 ? batchQuestions.length : 30));
                    const score = Math.max(0, Math.round((totalScore / totalQuestionsInBatch) * 100));
                    const accuracy = Math.round((qRows.filter(a => a.is_correct).length / Math.max(1, qRows.length)) * 100);
                    const completion = Math.min(100, Math.round((qRows.length / totalQuestionsInBatch) * 100));

                    if (!progressMap.has(key)) {
                        progressMap.set(key, []);
                    }
                    
                    const existingAttempts = progressMap.get(key) || [];
                    
                    existingAttempts.push({
                        id: `provisional_${batchNum}`,
                        userId,
                        batchNumber: batchNum,
                        attemptNumber: existingAttempts.length + 1,
                        score,
                        accuracyPercentage: accuracy,
                        completionPercentage: completion,
                        componentScores,
                        answers: mappedAnswers,
                        timeSpentSeconds: 0,
                        completedAt: new Date().toISOString()
                    });
                });
            }

            // Build statistics with dynamic batch numbers
            const stats = (users || []).map(user => {
                const batches = availableBatches.map(batchNum => {
                    const attempts = progressMap.get(`${user.id}_${batchNum}`) || [];

                    if (attempts.length === 0) {
                        return {
                            batchNumber: batchNum,
                            averageScore: 0,
                            accuracy: 0,
                            completion: 0,
                            attemptCount: 0,
                            totalTimeSeconds: 0,
                        };
                    }

                    attempts.sort((a, b) => a.attemptNumber - b.attemptNumber);

                    const latestAttempt = attempts[attempts.length - 1];
                    const totalTime = attempts.reduce((sum, a) => sum + (a.timeSpentSeconds || 0), 0);

                    return {
                        batchNumber: batchNum,
                        averageScore: latestAttempt.score,
                        accuracy: latestAttempt.accuracyPercentage,
                        completion: latestAttempt.completionPercentage,
                        attemptCount: attempts.length,
                        totalTimeSeconds: totalTime,
                        componentScores: latestAttempt.componentScores,
                    };
                });

                const totalTime = batches.reduce((sum, b) => sum + (b.totalTimeSeconds || 0), 0);

                // Compute Overall Score percentage across batches with attempts
                const attemptedBatches = batches.filter(b => b.attemptCount > 0);
                const overallScore = attemptedBatches.length > 0
                    ? Math.round(attemptedBatches.reduce((s, b) => s + b.averageScore, 0) / attemptedBatches.length)
                    : 0;

                let rank = 'D Rank';
                if (overallScore >= 90) rank = 'S Rank';
                else if (overallScore >= 80) rank = 'A Rank';
                else if (overallScore >= 70) rank = 'B Rank';
                else if (overallScore >= 60) rank = 'C Rank';

                return {
                    userId: user.id,
                    userName: user.full_name || 'Staff',
                    staffId: user.employee_id,
                    division: user.division || '-',
                    region: user.region || 'MY',
                    age: (user as any).age || null,
                    vehicleType: (user as any).vehicle_type || null,
                    overallScore,
                    rank,
                    csiPercentage: overallScore,
                    proHayatBand: rank,
                    proHayatBandLabel: rank,
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


            // 1. Get ALL batch attempts for this user
            const { data: attempts, error } = await supabase
                .from('user_batch_progress')
                .select('*')
                .eq('user_id', userId)
                .order('completed_at', { ascending: false });

            if (error) throw error;

            if (!attempts || attempts.length === 0) {

                
                // Fetch all answered questions from user_question_progress
                const { data: qProgress, error: qError } = await supabase
                    .from('user_question_progress')
                    .select('question_id, is_correct')
                    .eq('user_id', userId);

                let componentScores = { operation: 0, discipline: 0, professionalism: 0 };
                
                if (!qError && qProgress && qProgress.length > 0) {
                    const questionIds = qProgress.map(q => q.question_id);
                    const { data: questionsData } = await supabase
                        .from('questions')
                        .select('id, category, component_weights')
                        .in('id', questionIds);

                    if (questionsData && questionsData.length > 0) {
                        const questionList = questionsData.map(q => ({
                            id: q.id,
                            category: q.category,
                            componentWeights: q.component_weights || (q as any).componentWeights
                        })) as Question[];

                        const mappedAnswers = qProgress.map(q => ({
                            questionId: q.question_id,
                            attempts: 1,
                            isCorrect: q.is_correct
                        }));

                        const computedScores = this.calculateComponentScores(questionList, mappedAnswers);
                        componentScores = {
                            operation: computedScores.operation,
                            discipline: computedScores.discipline,
                            professionalism: computedScores.professionalism
                        };
                    }
                }

                // Update profile with provisional scores

                await supabase
                    .from('profiles')
                    .update({
                        safety_index: 0,
                        component_scores: componentScores,
                        total_score: 0,
                        total_batches_completed: 0
                    })
                    .eq('id', userId);
                
                return;
            }

            // 2. Latest Attempt Evaluation (Driver's most recent active batch performance)
            const latestAttempt = attempts[0];
            const latestScore = latestAttempt.score ?? 0;
            const componentScores = latestAttempt.component_scores || {
                operation: latestScore,
                discipline: latestScore,
                professionalism: latestScore,
            };

            // 3. Count unique passed batches (score >= 60 in any attempt)
            const passedBatches = new Set<number>();
            attempts.forEach(a => {
                if (a.score >= 60) {
                    passedBatches.add(a.batch_number);
                }
            });
            const passedBatchesCount = passedBatches.size;

            // Fetch all answered questions from user_question_progress to calculate true cumulative average
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('score, is_correct')
                .eq('user_id', userId);

            let cumulativeScore = latestScore;
            if (qProgress && qProgress.length > 0) {
                const totalEarned = qProgress.reduce((sum, q) => sum + parseFloat(String(q.score || 0)), 0);
                cumulativeScore = Math.min(100, Math.round((totalEarned / Math.max(1, qProgress.length)) * 100));
            }

            // 4. Update Profile with Cumulative Score & Latest DOP
            await supabase
                .from('profiles')
                .update({
                    safety_index: cumulativeScore, // True Cumulative Average Score
                    component_scores: componentScores, // Represents driver's latest attempt DOP
                    total_score: cumulativeScore,
                    total_batches_completed: passedBatchesCount
                })
                .eq('id', userId);

            // 5. Update compliance logs for trending chart with latest attempt score
            const now = new Date();
            const year = now.getFullYear();
            const firstDayOfYear = new Date(year, 0, 1);
            const pastDaysOfYear = (now.getTime() - firstDayOfYear.getTime()) / 86400000;
            const weekNumber = Math.ceil((pastDaysOfYear + firstDayOfYear.getDay() + 1) / 7);

            await supabase
                .from('compliance_logs')
                .upsert({
                    user_id: userId,
                    week_number: weekNumber,
                    year: year,
                    score: latestScore,
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
            // Completed batches XP
            const { data, error } = await supabase
                .from('user_batch_progress')
                .select('score')
                .eq('user_id', userId);

            const completedXP = (error || !data) ? 0 : data.reduce((sum: number, a: any) => sum + (a.score || 0), 0);

            // In-progress questions XP (provisional: score each answered question out of 30 total)
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('score')
                .eq('user_id', userId);

            let provisionalScore = 0;
            if (qProgress && qProgress.length > 0) {
                const totalRaw = qProgress.reduce((sum: number, a: any) => sum + parseFloat(String(a.score || 0)), 0);
                provisionalScore = Math.round((totalRaw / 30) * 100);
            }

            return Math.round(completedXP + provisionalScore);
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
            // Count from completed batches
            const { data, error } = await supabase
                .from('user_batch_progress')
                .select('answers')
                .eq('user_id', userId);

            let completedTotal = 0;
            if (!error && data) {
                data.forEach((row: any) => {
                    if (row.answers && Array.isArray(row.answers)) {
                        completedTotal += row.answers.length;
                    }
                });
            }

            // Also count from in-progress questions (not yet submitted as a full batch)
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('id')
                .eq('user_id', userId);

            const inProgressTotal = qProgress?.length || 0;

            return completedTotal + inProgressTotal;
        } catch (error) {
            console.error('[BatchService] Error getting total answered questions:', error);
            return 0;
        }
    },

    /**
     * Record progress of an individual question attempt in Live Mode
     */
    async recordQuestionProgress(
        userId: string,
        questionId: string,
        batchNumber: number,
        attempts: number,
        isCorrect: boolean,
        score: number
    ): Promise<void> {
        try {

            const { error } = await supabase
                .from('user_question_progress')
                .upsert({
                    user_id: userId,
                    question_id: questionId,
                    batch_number: batchNumber,
                    attempts,
                    is_correct: isCorrect,
                    score,
                    completed_at: new Date().toISOString()
                }, {
                    onConflict: 'user_id,question_id'
                });

            if (error) throw error;
        } catch (error) {
            console.error('[BatchService] Error recording question progress:', error);
            throw error;
        }
    },

    /**
     * Check if a batch is passed and locked for a driver
     */
    async isBatchLocked(userId: string, batchNumber: number): Promise<boolean> {
        const { data: profile } = await supabase
            .from('profiles')
            .select('current_batch, batch_lock_override')
            .eq('id', userId)
            .single();

        if (!profile) return false;
        if (profile.batch_lock_override) return false;

        if (batchNumber < profile.current_batch) {
            return true;
        }

        const maxBatches = await this.getMaxBatchNumber();
        if (batchNumber === maxBatches) {
            const { data } = await supabase
                .from('user_batch_progress')
                .select('score')
                .eq('user_id', userId)
                .eq('batch_number', maxBatches)
                .gte('score', 60)
                .limit(1);

            return !!(data && data.length > 0);
        }

        return false;
    },

    /**
     * Get daily completion status and overrides for a driver (midnight UTC+8 refresh)
     */
    async getDailyLimitStatus(userId: string, batchNumber: number): Promise<{
        completedToday: number;
        limit: number;
        isWaived: boolean;
        isOverridden: boolean;
        isAccessGranted: boolean;
    }> {
        const { data: profile, error: profileError } = await supabase
            .from('profiles')
            .select('daily_limit_override, daily_limit_waived_batch')
            .eq('id', userId)
            .single();

        if (profileError) {
            console.error('Error fetching overrides:', profileError);
        }

        const isOverridden = profile?.daily_limit_override || false;
        const isWaived = profile?.daily_limit_waived_batch === batchNumber;

        // Calculate start of today in UTC+8 (KL/Singapore timezone)
        const now = new Date();
        const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
        const serverTime = new Date(utc + (3600000 * 8)); 
        serverTime.setHours(0, 0, 0, 0);
        const startOfTodayUtc8 = new Date(serverTime.getTime() - (3600000 * 8));

        const { count, error: countError } = await supabase
            .from('user_question_progress')
            .select('*', { count: 'exact', head: true })
            .eq('user_id', userId)
            .gte('completed_at', startOfTodayUtc8.toISOString());

        if (countError) {
            console.error('Error querying completed count:', countError);
        }

        const completedToday = count || 0;
        // Read global daily quiz limit from app_settings (set by Super Admin); default 5
        const { data: limitSetting } = await supabase
            .from('app_settings')
            .select('value')
            .eq('key', 'global_daily_quiz_limit')
            .maybeSingle();
        const parsedLimit = parseInt(String(limitSetting?.value ?? '5'), 10);
        const limit = isNaN(parsedLimit) || parsedLimit < 1 ? 5 : parsedLimit;
        const isAccessGranted = isOverridden || isWaived || completedToday < limit;

        return {
            completedToday,
            limit,
            isWaived,
            isOverridden,
            isAccessGranted
        };
    },

    /**
     * Evaluate batch after all 30 questions are resolved
     */
    async evaluateBatch(
        userId: string,
        batchNumber: number,
        timeSpentSeconds: number
    ): Promise<{ success: boolean; passed: boolean; score: number; attemptNumber: number }> {
        try {


            // Fetch question progress
            const { data: progressRows, error: progressError } = await supabase
                .from('user_question_progress')
                .select('*')
                .eq('user_id', userId)
                .eq('batch_number', batchNumber);

            if (progressError) throw progressError;

            const answers = progressRows || [];
            
            // Calculate score based on attempts
            let totalScore = 0;
            answers.forEach(a => {
                totalScore += parseFloat(String(a.score));
            });

            const totalQuestionsInBatch = await this.getBatchTotalQuestions(batchNumber, userId);
            const maxScore = Math.max(1, totalQuestionsInBatch);
            const score = Math.max(0, Math.round((totalScore / maxScore) * 100));
            const passed = score >= 60;

            const { data: pastAttempts } = await supabase
                .from('user_batch_progress')
                .select('attempt_number')
                .eq('user_id', userId)
                .eq('batch_number', batchNumber);

            const attemptNumber = (pastAttempts?.length || 0) + 1;

            const { data: questionsData } = await supabase
                .from('questions')
                .select('id, component_weights')
                .eq('batch_number', batchNumber);

            const questions = (questionsData || []).map(q => ({
                id: q.id,
                componentWeights: q.component_weights || (q as any).componentWeights
            })) as Question[];

            const mappedAnswers = answers.map(a => ({
                questionId: a.question_id,
                attempts: a.attempts,
                isCorrect: a.is_correct
            }));

            const componentScores = this.calculateComponentScores(questions, mappedAnswers);

            // Record batch attempt
            const { error: insertError } = await supabase
                .from('user_batch_progress')
                .insert({
                    user_id: userId,
                    batch_number: batchNumber,
                    attempt_number: attemptNumber,
                    score,
                    accuracy_percentage: Math.round((answers.filter(a => a.is_correct).length / maxScore) * 100),
                    completion_percentage: 100,
                    component_scores: componentScores,
                    answers: mappedAnswers,
                    time_spent_seconds: timeSpentSeconds,
                });

            if (insertError) throw insertError;

            const { data: profile } = await supabase
                .from('profiles')
                .select('current_batch, consecutive_resets, company_id')
                .eq('id', userId)
                .single();

            const resetsMap = profile?.consecutive_resets || {};
            const companyId = profile?.company_id;

            if (passed) {
                resetsMap[String(batchNumber)] = 0;

                const maxBatches = await this.getMaxBatchNumber();
                const nextBatch = batchNumber < maxBatches ? batchNumber + 1 : maxBatches;
                await supabase
                    .from('profiles')
                    .update({
                        current_batch: nextBatch,
                        total_batches_completed: batchNumber,
                        daily_limit_waived_batch: null,
                        consecutive_resets: resetsMap
                    })
                    .eq('id', userId);

                try {
                    await supabase.from('notifications').insert({
                        user_id: userId,
                        type: 'shield',
                        title: 'Batch Passed! 🏆',
                        message: `Congratulations! You passed Batch ${batchNumber} with ${score}%.`,
                        is_read: false
                    });
                } catch (notifErr) {
                    console.warn('Failed to send passed notification:', notifErr);
                }
            } else {
                const currentResets = (resetsMap[String(batchNumber)] || 0) + 1;
                resetsMap[String(batchNumber)] = currentResets;

                await supabase
                    .from('profiles')
                    .update({
                        daily_limit_waived_batch: batchNumber,
                        consecutive_resets: resetsMap
                    })
                    .eq('id', userId);

                // Notify MU if consecutive resets reaches 3
                if (currentResets >= 3) {
                    try {
                        const { data: managers } = await supabase
                            .from('profiles')
                            .select('id')
                            .eq('company_id', companyId)
                            .eq('role', 'manager');

                        if (managers && managers.length > 0) {
                            const notifications = managers.map(m => ({
                                user_id: m.id,
                                type: 'alert',
                                title: 'Driver Requires Assistance ⚠️',
                                message: `Driver has failed Batch ${batchNumber} ${currentResets} consecutive times.`,
                                is_read: false
                            }));
                            await supabase.from('notifications').insert(notifications);
                        }
                    } catch (notifErr) {
                        console.warn('Failed to notify manager:', notifErr);
                    }
                }

                // Question progress is intentionally NOT deleted here.
                // If a driver fails, the failure remains on record and they are locked.
                // The manager must use the manual "Reset Batch" function to allow a retake.
            }

            await this.syncProfileStats(userId);

            return { success: true, passed, score, attemptNumber };
        } catch (error) {
            console.error('[BatchService] Error evaluating batch:', error);
            return { success: false, passed: false, score: 0, attemptNumber: 1 };
        }
    },

    /**
     * Reset a single MCQ for a driver (Master User control)
     */
    async resetIndividualQuestion(userId: string, questionId: string): Promise<boolean> {
        try {

            const { error } = await supabase
                .from('user_question_progress')
                .delete()
                .eq('user_id', userId)
                .eq('question_id', questionId);

            if (error) throw error;
            return true;
        } catch (error) {
            console.error('Error resetting individual question:', error);
            return false;
        }
    },

    /**
     * Reset an entire batch for a driver (Master User control)
     */
    async resetEntireBatch(userId: string, batchNumber: number): Promise<boolean> {
        try {


            // Delete all question progress for this batch
            const { error: qProgressError } = await supabase
                .from('user_question_progress')
                .delete()
                .eq('user_id', userId)
                .eq('batch_number', batchNumber);

            if (qProgressError) throw qProgressError;

            // Intentionally NOT deleting user_batch_progress here.
            // We must preserve the audit trail of past failed attempts for compliance tracking.

            // Reset consecutive resets count for this batch
            const { data: profile } = await supabase
                .from('profiles')
                .select('current_batch, consecutive_resets')
                .eq('id', userId)
                .single();

            const resetsMap = profile?.consecutive_resets || {};
            resetsMap[String(batchNumber)] = 0;

            // Revert current_batch if they had unlocked a higher batch
            let nextBatch = profile?.current_batch || 1;
            if (batchNumber < nextBatch) {
                nextBatch = batchNumber;
            }

            await supabase
                .from('profiles')
                .update({
                    current_batch: nextBatch,
                    consecutive_resets: resetsMap,
                    daily_limit_waived_batch: null
                })
                .eq('id', userId);

            // Sync metrics to profile
            await this.syncProfileStats(userId);

            return true;
        } catch (error) {
            console.error('Error resetting entire batch:', error);
            return false;
        }
    },

    /**
     * Reset all batches for a driver (Master User control)
     */
    async resetAllBatches(userId: string): Promise<boolean> {
        try {

            
            // Delete all question progress
            const { error: qProgressError } = await supabase
                .from('user_question_progress')
                .delete()
                .eq('user_id', userId);

            if (qProgressError) throw qProgressError;

            // Delete all batch attempts
            const { error: batchProgressError } = await supabase
                .from('user_batch_progress')
                .delete()
                .eq('user_id', userId);

            if (batchProgressError) throw batchProgressError;

            // Reset profile batch attributes
            await supabase
                .from('profiles')
                .update({
                    current_batch: 1,
                    total_batches_completed: 0,
                    daily_limit_waived_batch: null,
                    consecutive_resets: {},
                    safety_index: 0,
                    total_score: 0,
                    component_scores: { operation: 0, discipline: 0, professionalism: 0 }
                })
                .eq('id', userId);

            return true;
        } catch (error) {
            console.error('Error resetting all batches:', error);
            return false;
        }
    },

    /**
     * Update driver overrides (Master User control)
     */
    async updateOverrides(
        userId: string,
        dailyLimitOverride: boolean,
        batchLockOverride: boolean
    ): Promise<boolean> {
        try {

            const { error } = await supabase
                .from('profiles')
                .update({
                    daily_limit_override: dailyLimitOverride,
                    batch_lock_override: batchLockOverride
                })
                .eq('id', userId);

            if (error) throw error;
            return true;
        } catch (error) {
            console.error('Error updating overrides:', error);
            return false;
        }
    }
};
