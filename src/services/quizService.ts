import { supabase } from '../lib/supabase';
import { Question, Region, QuizAttempt } from '../types/models';
import {
    getWeek,
    getYear,
    startOfWeek,
    addDays,
    subWeeks,
    subMonths,
    addMonths,
    startOfMonth,
    endOfMonth,
    startOfDay,
    endOfDay,
    format,
    isSameDay,
    isWithinInterval,
    isBefore,
    isEqual
} from 'date-fns';
import * as Crypto from 'expo-crypto';
import { ScoringService } from './scoringService';
import { BatchService } from './batchService';


export type PerformanceTimeRange = '1W' | '1M' | 'ALL';

export interface PerformanceTrendPoint {
    value: number;
    label: string;
    fullDate?: string;
    attemptsCount?: number;
}

export interface PerformanceStats {
    averageScore: number;
    highestScore: number;
    lowestScore: number;
    totalAttempts: number;
}

export interface PerformanceTrendResult {
    points: PerformanceTrendPoint[];
    stats: PerformanceStats;
}

export const QuizService = {
    /**
     * Get questions for a specific region from Supabase (Mocked with Local JSON for consistency)
     */
    async getQuestionsForRegion(region: Region): Promise<Question[]> {
        try {


            // Fetch questions directly from Supabase
            const { data: dbData, error } = await supabase
                .from('questions')
                .select('*')
                .contains('regions', [region]);

            if (error) {
                console.error('Error fetching questions from Supabase:', error);
                throw error;
            }

            const data = dbData || [];

            // Fallback to empty if no data
            if (!data || data.length === 0) return [];



            const questions = data.map(q => {
                // Shuffle options
                const originalOptions = [...(q.options || [])];
                const correctIdx = q.correct_option_index !== undefined ? q.correct_option_index : q.correctOptionIndex;
                const correctOptionText = originalOptions[correctIdx];

                // create an array of indices [0, 1, 2, ...]
                const indices = originalOptions.map((_, i) => i);

                // shuffle the indices
                for (let i = indices.length - 1; i > 0; i--) {
                    const j = Math.floor(Math.random() * (i + 1));
                    [indices[i], indices[j]] = [indices[j], indices[i]];
                }

                // reorder options based on shuffled indices
                const shuffledOptions = indices.map(i => originalOptions[i]);

                // find new index of the correct answer
                const newCorrectIndex = shuffledOptions.indexOf(correctOptionText);

                return {
                    id: q.id,
                    text: q.text,
                    text_ms: q.text_bm || q.text_ms, // Support both keys
                    options: shuffledOptions,
                    // We need to shuffle options_ms in the same order as options!
                    options_ms: q.options_ms ? indices.map(i => q.options_ms[i]) : undefined,
                    correctOptionIndex: newCorrectIndex,
                    explanation: q.explanation,
                    explanation_ms: q.explanation_ms,
                    region: q.regions || q.region, // Handle both key styles if present
                    category: q.category,
                    imageUrl: q.image_url || q.imageUrl,
                    difficulty: q.difficulty || 'intermediate',
                    componentWeights: q.component_weights || q.componentWeights,
                } as Question;
            });


            return questions;
        } catch (error) {
            console.error('Error fetching questions:', error);
            return [];
        }
    },

    /**
     * Generate a weekly quiz with 30 random questions
     */
    /**
     * Generate a weekly quiz with varying difficulty based on Manager settings or defaults
     */
    async generateWeeklyQuiz(region: Region, count: number = 5, difficultySettings?: { easy: number, intermediate: number, hard: number }): Promise<Question[]> {


        // Default Distribution if not provided (Mid-level focus)
        const distribution = difficultySettings || { easy: 0, intermediate: 100, hard: 0 };

        const easyCount = Math.round(count * (distribution.easy / 100));
        const hardCount = Math.round(count * (distribution.hard / 100));
        const intermediateCount = count - easyCount - hardCount; // Remainder to ensure total matches count

        // 1. Get current week for the cycle calculation
        const now = new Date();
        const absoluteWeek = getWeek(now);
        const cycleIndex = Math.floor(absoluteWeek / 4);
        const batchIndex = absoluteWeek % 4;



        // 2. Fetch ALL questions
        const allQuestions = await this.getQuestionsForRegion(region);

        if (allQuestions.length === 0) {
            console.warn('⚠️ No questions found for region:', region);
            return [];
        }

        // 3. Separate by difficulty
        const easyPool = allQuestions.filter(q => q.difficulty === 'easy');
        const intermediatePool = allQuestions.filter(q => q.difficulty === 'intermediate' || !q.difficulty); // Fallback to intermediate
        const hardPool = allQuestions.filter(q => q.difficulty === 'hard');

        // 4. Helper to select questions deterministically
        const selectQuestions = (pool: Question[], amount: number, seedSuffix: string) => {
            if (pool.length === 0 || amount === 0) return [];
            const seed = `cycle_${cycleIndex}_${region}_${seedSuffix}`;
            const shuffled = this.shuffleWithSeed(pool, seed);
            const startIndex = (batchIndex * amount) % pool.length;

            const selected = [];
            for (let i = 0; i < amount; i++) {
                const index = (startIndex + i) % shuffled.length;
                selected.push(shuffled[index]);
            }
            return selected;
        };

        const selectedEasy = selectQuestions(easyPool, easyCount, 'easy');
        const selectedInt = selectQuestions(intermediatePool, intermediateCount, 'int');
        const selectedHard = selectQuestions(hardPool, hardCount, 'hard');

        const finalSelection = [...selectedEasy, ...selectedInt, ...selectedHard];

        // Final shuffle so difficulty levels are mixed
        return this.shuffleWithSeed(finalSelection, `final_${absoluteWeek}`);
    },

    /**
     * Simple seeded shuffle (Linear Congruential Generator as a quick pseudo-random source)
     * This ensures all users in the same region get the same "random" order for the cycle.
     */
    shuffleWithSeed<T>(array: T[], seed: string): T[] {
        let hash = 0;
        for (let i = 0; i < seed.length; i++) {
            hash = ((hash << 5) - hash) + seed.charCodeAt(i);
            hash |= 0; // Convert to 32bit integer
        }

        const seededRandom = () => {
            const x = Math.sin(hash++) * 10000;
            return x - Math.floor(x);
        };

        const result = [...array];
        for (let i = result.length - 1; i > 0; i--) {
            const j = Math.floor(seededRandom() * (i + 1));
            [result[i], result[j]] = [result[j], result[i]];
        }
        return result;
    },

    /**
     * Calculate score from answers with RETRY logic
     * 1st Try: Full Mark (1.0)
     * 2nd Try: 0 Mark (0.0)
     * 3rd Try: Right = 0 Mark (0.0), Wrong = Negative (-0.5 penalty?)
     */
    calculateScore(answers: { questionId: string; attempts: number; isCorrect: boolean }[]): number {
        if (answers.length === 0) return 0;

        let totalScore = 0;

        answers.forEach(a => {
            if (a.isCorrect) {
                if (a.attempts === 1) {
                    totalScore += 1;
                } else if (a.attempts === 2) {
                    totalScore += 0.5;
                } else {
                    totalScore += 0.25; // 3rd try (and beyond if logic permited)
                }
            } else {
                // Wrong answer logic - Penalty
                if (a.attempts >= 3) {
                    // 3rd try AND wrong -> Negative
                    totalScore -= 0.5;
                }
            }
        });

        // Normalize to 0-100
        // Max possible score is answers.length * 1
        // Min possible is negative, but we clamp to 0 for display usually, unless specified.
        const maxScore = answers.length;
        let percentage = (totalScore / maxScore) * 100;

        return Math.max(0, Math.round(percentage));
    },

    /**
     * Submit quiz to database
     */
    async submitQuiz(
        userId: string,
        answers: { questionId: string; attempts: number; isCorrect: boolean }[],
        questions: Question[]
    ) {
        try {
            // Calculate Standard Score using new logic
            const rawScore = this.calculateScore(answers);

            // Calculate Component Scores using weighted logic
            const componentScores = ScoringService.calculateComponentScores(questions, answers);



            const now = new Date();
            const weekNumber = getWeek(now);
            const year = getYear(now);

            // Check if there's already a quiz attempt this week
            const { data: existingAttempt, error: existingError } = await supabase
                .from('quiz_attempts')
                .select('id, score')
                .eq('user_id', userId)
                .eq('week_number', weekNumber)
                .eq('year', year)
                .order('score', { ascending: false })
                .limit(1)
                .maybeSingle(); // Use maybeSingle to return null if no rows (not an error)

            // Log for debugging


            // If existing score is higher or equal, don't overwrite
            if (existingAttempt && existingAttempt.score >= rawScore) {

                return {
                    score: rawScore,
                    attempt: {
                        id: 'not-saved',
                        driverId: userId,
                        date: now.toISOString(),
                        score: rawScore,
                        answers,
                        weekNumber,
                        year,
                    },
                    wasSaved: false,
                    bestScore: existingAttempt.score
                };
            }

            // If we have an existing attempt with lower score, delete it first
            if (existingAttempt) {

                await supabase
                    .from('quiz_attempts')
                    .delete()
                    .eq('id', existingAttempt.id);
            }

            // Save new quiz attempt (either first attempt or better score)
            const { data: attemptData, error: attemptError } = await supabase
                .from('quiz_attempts')
                .insert({
                    user_id: userId,
                    score: rawScore,
                    answers: answers,
                    week_number: weekNumber,
                    year,
                    component_scores: componentScores,
                })
                .select()
                .single();

            if (attemptError) throw attemptError;

            // Generate HMAC signature for compliance log
            const dataToSign = JSON.stringify({ userId, weekNumber, year, score: rawScore });
            const signature = await Crypto.digestStringAsync(
                Crypto.CryptoDigestAlgorithm.SHA256,
                dataToSign + 'safe-pass-secret-key-v1'
            );

            // Save compliance log
            const { error: complianceError } = await supabase
                .from('compliance_logs')
                .upsert({
                    user_id: userId,
                    week_number: weekNumber,
                    year,
                    status: 'COMPLIANT',
                    score: rawScore,
                    signature,
                    completed_at: now.toISOString(),
                }, {
                    onConflict: 'user_id,week_number,year'
                });

            if (complianceError) throw complianceError;

            // --- WEIGHTED SAFETY INDEX ---
            // Get previous scores for weighting (last 5 attempts)
            const { data: recentAttempts } = await supabase
                .from('quiz_attempts')
                .select('score')
                .eq('user_id', userId)
                .order('completed_at', { ascending: false })
                .limit(5);

            const history = recentAttempts?.map(a => a.score) || [];
            // Calculate new weighted Safety Index
            const weightedSafetyIndex = ScoringService.calculateWeightedAverage(rawScore, history);

            // Update user's safety index AND component scores
            await this.updateSafetyIndex(userId, weightedSafetyIndex);

            // Update profile with component scores AND total_score for All Time leaderboard
            await supabase
                .from('profiles')
                .update({
                    safety_index: weightedSafetyIndex,
                    component_scores: componentScores,
                    total_score: weightedSafetyIndex // Use safety_index as total_score for leaderboard
                })
                .eq('id', userId);

            // --- SAFETY SHIELD GAMIFICATION ---
            // 1. Get current shield health
            const { data: profile } = await supabase
                .from('profiles')
                .select('shield_health')
                .eq('id', userId)
                .single();

            let currentShield = profile?.shield_health || 100;
            let shieldChange = 0;

            if (rawScore < 80) {
                // Penalty for poor performance
                shieldChange = -20;
            } else {
                // Repair for good performance
                // Note: If they are already 100, this won't go above 100 due to clamping
                shieldChange = 50;
            }

            // Calculate new health and clamp between 0 and 100
            let newShield = Math.max(0, Math.min(100, currentShield + shieldChange));

            // Update profile with new shield health
            await supabase
                .from('profiles')
                .update({ shield_health: newShield })
                .eq('id', userId);
            // ----------------------------------

            // --- WEEKLY STREAK CALCULATION ---
            // Get all compliance logs for this user (completed weeks)
            const { data: complianceLogs } = await supabase
                .from('compliance_logs')
                .select('week_number, year')
                .eq('user_id', userId)
                .eq('status', 'COMPLIANT')
                .order('year', { ascending: false })
                .order('week_number', { ascending: false });

            let streak = 0;
            if (complianceLogs && complianceLogs.length > 0) {
                // Calculate consecutive weeks
                let currentWeek = weekNumber;
                let currentYear = year;

                for (const log of complianceLogs) {
                    // Check if this log is for the expected week
                    if (log.year === currentYear && log.week_number === currentWeek) {
                        streak++;
                        // Move to previous week
                        currentWeek--;
                        if (currentWeek < 1) {
                            currentWeek = 52; // Approximate
                            currentYear--;
                        }
                    } else if (log.year === currentYear && log.week_number === currentWeek - 1) {
                        // Also check previous week if we haven't counted current yet
                        streak++;
                        currentWeek = log.week_number - 1;
                        if (currentWeek < 1) {
                            currentWeek = 52;
                            currentYear--;
                        }
                    } else {
                        break; // Gap found, streak ends
                    }
                }
            }

            // Update streak in profile
            await supabase
                .from('profiles')
                .update({ streak })
                .eq('id', userId);
            // ----------------------------------

            // --- AUTO-NOTIFICATIONS ---
            const notificationsToCreate: any[] = [];

            // 1. Quiz Completion Notification
            notificationsToCreate.push({
                user_id: userId,
                type: 'shield',
                title: 'Mission Complete! 🎯',
                message: `You scored ${rawScore}% on this week's quiz.`,
                is_read: false
            });

            // 2. Streak Milestone Notifications
            if (streak === 3) {
                notificationsToCreate.push({
                    user_id: userId,
                    type: 'streak',
                    title: 'Streak Milestone! 🔥',
                    message: 'You\'ve completed 3 weeks in a row! Keep it up!',
                    is_read: false
                });
            } else if (streak === 5) {
                notificationsToCreate.push({
                    user_id: userId,
                    type: 'streak',
                    title: 'On Fire! 🔥🔥',
                    message: '5 week streak! You\'re unstoppable!',
                    is_read: false
                });
            } else if (streak === 10) {
                notificationsToCreate.push({
                    user_id: userId,
                    type: 'streak',
                    title: 'LEGENDARY! 🏆🔥',
                    message: '10 week streak achieved! You\'re a Safety Champion!',
                    is_read: false
                });
            }

            // 3. Check if user is now in Top 3 for their company
            const { data: currentProfile } = await supabase
                .from('profiles')
                .select('company_id')
                .eq('id', userId)
                .single();

            let topDriversQuery = supabase
                .from('profiles')
                .select('id')
                .order('safety_index', { ascending: false })
                .limit(3);

            if (currentProfile?.company_id) {
                topDriversQuery = topDriversQuery.eq('company_id', currentProfile.company_id);
            }

            const { data: topDrivers } = await topDriversQuery;

            if (topDrivers) {
                const userRank = topDrivers.findIndex(d => d.id === userId);
                if (userRank !== -1) {
                    const placement = userRank + 1;
                    notificationsToCreate.push({
                        user_id: userId,
                        type: 'leaderboard',
                        title: `You're #${placement}! 🏆`,
                        message: `Congratulations! You've reached ${placement === 1 ? '1st' : placement === 2 ? '2nd' : '3rd'} place on the leaderboard!`,
                        is_read: false
                    });
                }
            }

            // Insert all notifications (wrapped in try-catch to not fail quiz submission)
            if (notificationsToCreate.length > 0) {
                try {
                    await supabase
                        .from('notifications')
                        .insert(notificationsToCreate);
                } catch (notifError) {
                    console.warn('⚠️ Failed to create notifications (non-critical):', notifError);
                    // Don't throw - notifications are not critical to quiz submission
                }
            }
            // ----------------------------------

            const attempt: QuizAttempt = {
                id: attemptData.id,
                driverId: userId,
                date: attemptData.completed_at,
                score: rawScore,
                answers: answers.map(a => ({
                    questionId: a.questionId,
                    selectedOptionIndex: -1, // Deprecated/Not tracked in new structure
                    isCorrect: a.isCorrect
                })),
                weekNumber,
                year,
            };

            return { score: rawScore, attempt };
        } catch (error) {
            console.error('Error submitting quiz:', error);
            throw error;
        }
    },

    /**
     * Update driver's safety index (90-day rolling average)
     */
    async updateSafetyIndex(userId: string, overrideIndex?: number) {
        try {
            // Get all attempts from last 90 days
            const ninetyDaysAgo = new Date();
            ninetyDaysAgo.setDate(ninetyDaysAgo.getDate() - 90);

            const { data: attempts, error } = await supabase
                .from('quiz_attempts')
                .select('score')
                .eq('user_id', userId)
                .gte('completed_at', ninetyDaysAgo.toISOString());

            if (error) throw error;

            if (attempts && attempts.length > 0) {
                const totalScore = attempts.reduce((sum, a) => sum + a.score, 0);
                const safetyIndex = Math.round(totalScore / attempts.length);

                // Update profile
                await supabase
                    .from('profiles')
                    .update({ safety_index: overrideIndex ?? safetyIndex })
                    .eq('id', userId);
            }
        } catch (error) {
            console.error('Error updating safety index:', error);
        }
    },

    /**
     * Get driver's safety index
     */
    async getDriverSafetyIndex(userId: string): Promise<number> {
        try {
            const { data, error } = await supabase
                .from('profiles')
                .select('safety_index')
                .eq('id', userId)
                .single();

            if (error) throw error;

            return data?.safety_index || 0;
        } catch (error) {
            console.error('Error getting safety index:', error);
            return 0;
        }
    },

    /**
     * Get quiz attempts for a user
     */
    async getQuizAttempts(userId: string): Promise<QuizAttempt[]> {
        try {
            const { data, error } = await supabase
                .from('quiz_attempts')
                .select('*')
                .eq('user_id', userId)
                .order('completed_at', { ascending: false });

            if (error) throw error;

            return data.map(a => ({
                id: a.id,
                driverId: a.user_id,
                date: a.completed_at,
                score: a.score,
                answers: a.answers,
                weekNumber: a.week_number,
                year: a.year,
            }));
        } catch (error) {
            console.error('Error getting quiz attempts:', error);
            return [];
        }
    },

    /**
     * Get weekly compliance scores for trend chart
     */
    async getWeeklyTrends(userId: string): Promise<{ score: number, weekNumber: number }[]> {
        try {
            const { data, error } = await supabase
                .from('compliance_logs')
                .select('score, week_number')
                .eq('user_id', userId)
                .order('year', { ascending: false })
                .order('week_number', { ascending: false })
                .limit(10);

            if (error) throw error;

            // Reverse to show chronologically (Oldest to Newest) in the chart
            return (data || []).reverse().map(log => ({
                score: log.score || 0,
                weekNumber: log.week_number
            }));
        } catch (error) {
            console.error('Error getting weekly trends:', error);
            return [];
        }
    },

    /**
     * Get performance trends for different time ranges (1W, 1M, 3M, ALL)
     * Uses question-level data (user_question_progress) as primary scoring source
     * to stay consistent with getBatchAverageScore / Batch Card calculations.
     */
    async getPerformanceTrends(
        userId: string,
        range: PerformanceTimeRange = '1W'
    ): Promise<PerformanceTrendResult> {
        try {
            const now = new Date();
            let startDate: Date;

            if (range === '1W') {
                startDate = startOfWeek(now, { weekStartsOn: 1 });
            } else if (range === '1M') {
                startDate = subWeeks(startOfWeek(now, { weekStartsOn: 1 }), 3);
            } else {
                // ALL: Fetch earliest available activity
                startDate = new Date(2020, 0, 1);
            }

            // Fetch ALL user_question_progress (no time filter — computeActiveBatchScore
            // needs the full batch history to produce accurate cumulative scores)
            const { data: qData } = await supabase
                .from('user_question_progress')
                .select('completed_at, score, batch_number')
                .eq('user_id', userId);

            const allQuestions = qData || [];

            // Fetch ALL user_batch_progress (completed batch attempts)
            const { data: bData } = await supabase
                .from('user_batch_progress')
                .select('completed_at, score, batch_number')
                .eq('user_id', userId);

            const allBatches = bData || [];

            // Pre-fetch batch average scores (uses provisional logic matching the Batch card)
            const activeBatches = new Set<number>();
            allQuestions.forEach((q: any) => { if (q.batch_number) activeBatches.add(q.batch_number); });
            allBatches.forEach((b: any) => { if (b.batch_number) activeBatches.add(b.batch_number); });

            const batchScoreMap = new Map<number, number>();
            await Promise.all(
                Array.from(activeBatches).map(async (batchNum) => {
                    const score = await BatchService.getBatchAverageScore(userId, batchNum);
                    batchScoreMap.set(batchNum, score);
                })
            );

            // Fetch total questions per batch for accurate percentage calculation
            const batchTotalMap = new Map<number, number>();
            await Promise.all(
                Array.from(activeBatches).map(async (batchNum) => {
                    const total = await BatchService.getBatchTotalQuestions(batchNum, userId);
                    batchTotalMap.set(batchNum, total);
                })
            );

            /**
             * computeActiveBatchScore(cutoffDate)
             *
             * Returns the Batch Average Score as of a specific moment in time.
             * Uses the EXACT same formula as the Batch Summary card:
             *   (sum of question scores for active batch) / (total questions in batch) × 100
             *
             * - Figures out which batch was "active" as of the cutoff date (most recently touched batch).
             * - If that batch had a completed attempt by then, returns the official attempt score.
             * - If the batch was still in progress, returns the provisional score.
             * - Returns 0 if there was no activity at all up to that cutoff.
             */
            const computeActiveBatchScore = (cutoffDate: Date): number => {
                const questionsUpTo = allQuestions.filter((q: any) =>
                    isBefore(new Date(q.completed_at), cutoffDate) || isEqual(new Date(q.completed_at), cutoffDate)
                );
                const batchesUpTo = allBatches.filter((b: any) =>
                    isBefore(new Date(b.completed_at), cutoffDate) || isEqual(new Date(b.completed_at), cutoffDate)
                );

                if (questionsUpTo.length === 0 && batchesUpTo.length === 0) return 0;

                // Find the most recently touched batch as of the cutoff
                const sortedQ = [...questionsUpTo].sort(
                    (a, b) => new Date(a.completed_at).getTime() - new Date(b.completed_at).getTime()
                );
                const sortedB = [...batchesUpTo].sort(
                    (a, b) => new Date(a.completed_at).getTime() - new Date(b.completed_at).getTime()
                );

                const latestQ = sortedQ.length > 0 ? sortedQ[sortedQ.length - 1] : null;
                const latestB = sortedB.length > 0 ? sortedB[sortedB.length - 1] : null;

                let activeBatchNumber: number = 1;
                if (latestQ && latestB) {
                    activeBatchNumber = new Date(latestQ.completed_at).getTime() >= new Date(latestB.completed_at).getTime()
                        ? (latestQ.batch_number || 1)
                        : (latestB.batch_number || 1);
                } else if (latestQ) {
                    activeBatchNumber = latestQ.batch_number || 1;
                } else if (latestB) {
                    activeBatchNumber = latestB.batch_number || 1;
                }

                // If a completed attempt exists for this batch by the cutoff, use that score
                const completedForBatch = batchesUpTo.filter((b: any) => b.batch_number === activeBatchNumber);
                if (completedForBatch.length > 0) {
                    const latest = completedForBatch[completedForBatch.length - 1];
                    return Math.round(latest.score || 0);
                }

                // Otherwise compute provisional: same formula as Batch Summary card
                const activeQuestions = questionsUpTo.filter((q: any) => q.batch_number === activeBatchNumber);
                if (activeQuestions.length === 0) return 0;

                const totalScore = activeQuestions.reduce(
                    (sum: number, q: any) => sum + parseFloat(String(q.score || 0)), 0
                );
                const totalInBatch = batchTotalMap.get(activeBatchNumber) || activeQuestions.length;
                return Math.round((totalScore / Math.max(1, totalInBatch)) * 100);
            };

            let points: PerformanceTrendPoint[] = [];

            if (range === '1W') {
                const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                const today = startOfDay(now);
                points = dayLabels.map((label, i) => {
                    const dayDate = addDays(startDate, i);
                    const dayCutoff = endOfDay(dayDate);

                    // Don't show scores for future days
                    if (isBefore(today, startOfDay(dayDate))) {
                        return {
                            value: 0,
                            label,
                            fullDate: format(dayDate, 'd MMM yyyy'),
                            attemptsCount: 0,
                        };
                    }

                    const dailyScore = computeActiveBatchScore(dayCutoff);

                    const dayQuestions = allQuestions.filter((q: any) => isSameDay(new Date(q.completed_at), dayDate));
                    const dayBatches = allBatches.filter((b: any) => isSameDay(new Date(b.completed_at), dayDate));

                    return {
                        value: dailyScore,
                        label,
                        fullDate: format(dayDate, 'd MMM yyyy'),
                        attemptsCount: dayBatches.length + (dayQuestions.length > 0 ? 1 : 0),
                    };
                });
            } else if (range === '1M') {
                const today = startOfDay(now);
                points = [0, 1, 2, 3].map((i) => {
                    const wStart = addDays(startDate, i * 7);
                    const wEnd = addDays(wStart, 6);

                    // Don't show scores for future weeks
                    if (isBefore(today, startOfDay(wStart))) {
                        return {
                            value: 0,
                            label: `W${i + 1}`,
                            fullDate: `${format(wStart, 'd MMM')} - ${format(wEnd, 'd MMM')}`,
                            attemptsCount: 0,
                        };
                    }

                    // Use the earlier of wEnd or today as cutoff
                    const effectiveCutoff = isBefore(endOfDay(wEnd), endOfDay(now)) ? endOfDay(wEnd) : endOfDay(now);
                    const weekScore = computeActiveBatchScore(effectiveCutoff);

                    const wQuestions = allQuestions.filter((q: any) =>
                        isWithinInterval(new Date(q.completed_at), { start: startOfDay(wStart), end: endOfDay(wEnd) })
                    );
                    const wBatches = allBatches.filter((b: any) =>
                        isWithinInterval(new Date(b.completed_at), { start: startOfDay(wStart), end: endOfDay(wEnd) })
                    );

                    return {
                        value: weekScore,
                        label: `W${i + 1}`,
                        fullDate: `${format(wStart, 'd MMM')} - ${format(wEnd, 'd MMM')}`,
                        attemptsCount: wBatches.length + (wQuestions.length > 0 ? 1 : 0),
                    };
                });
            } else {
                // ALL: Monthly buckets from earliest activity to today
                const allTimestamps = [
                    ...allQuestions.map((q: any) => new Date(q.completed_at).getTime()),
                    ...allBatches.map((b: any) => new Date(b.completed_at).getTime()),
                ].filter(t => !isNaN(t));

                const earliest = allTimestamps.length > 0 ? new Date(Math.min(...allTimestamps)) : subMonths(now, 5);
                const startMonth = startOfMonth(earliest);
                const currentMonth = startOfMonth(now);

                let cursor = new Date(startMonth);
                const monthsList: Date[] = [];
                while (cursor <= currentMonth) {
                    monthsList.push(new Date(cursor));
                    cursor = addMonths(cursor, 1);
                }
                while (monthsList.length < 4) {
                    monthsList.unshift(subMonths(monthsList[0], 1));
                }

                points = monthsList.map((mStart) => {
                    const mEnd = endOfMonth(mStart);
                    const monthCutoff = endOfDay(mEnd);

                    const hadActivity = allQuestions.some((q: any) =>
                        isBefore(new Date(q.completed_at), monthCutoff) || isEqual(new Date(q.completed_at), monthCutoff)
                    ) || allBatches.some((b: any) =>
                        isBefore(new Date(b.completed_at), monthCutoff) || isEqual(new Date(b.completed_at), monthCutoff)
                    );

                    const monthScore = hadActivity ? computeActiveBatchScore(monthCutoff) : 0;

                    const mQuestions = allQuestions.filter((q: any) =>
                        isWithinInterval(new Date(q.completed_at), { start: startOfDay(mStart), end: endOfDay(mEnd) })
                    );
                    const mBatches = allBatches.filter((b: any) =>
                        isWithinInterval(new Date(b.completed_at), { start: startOfDay(mStart), end: endOfDay(mEnd) })
                    );

                    return {
                        value: monthScore,
                        label: format(mStart, 'MMM'),
                        fullDate: format(mStart, 'MMMM yyyy'),
                        attemptsCount: mBatches.length + (mQuestions.length > 0 ? 1 : 0),
                    };
                });
            }

            // Summary stats — use the current batch score as the reference
            const nonZeroScores = points.map(p => p.value).filter(v => v > 0);
            const averageScore = computeActiveBatchScore(endOfDay(now));
            const highestScore = nonZeroScores.length > 0 ? Math.max(...nonZeroScores) : 0;
            const lowestScore = nonZeroScores.length > 0 ? Math.min(...nonZeroScores) : 0;
            const totalAttempts = allBatches.length;

            return {
                points,
                stats: { averageScore, highestScore, lowestScore, totalAttempts },
            };
        } catch (error) {
            console.error('Error getting performance trends:', error);
            return {
                points: [],
                stats: {
                    averageScore: 0,
                    highestScore: 0,
                    lowestScore: 0,
                    totalAttempts: 0,
                },
            };
        }
    },

    /**
     * Get daily progress scores for trend chart (Fixed Weekly View: Mon-Sun)
     * Backward compatibility method for existing callers.
     */
    async getDailyTrends(userId: string): Promise<{ value: number, label: string }[]> {
        const result = await this.getPerformanceTrends(userId, '1W');
        return result.points.map(p => ({ value: p.value, label: p.label }));
    },

    /**
     * Check if user has completed quiz this week
     */
    async hasCompletedThisWeek(userId: string): Promise<boolean> {
        try {
            const now = new Date();
            const weekNumber = getWeek(now);
            const year = getYear(now);

            const { data, error } = await supabase
                .from('compliance_logs')
                .select('status')
                .eq('user_id', userId)
                .eq('week_number', weekNumber)
                .eq('year', year)
                .single();

            if (error && error.code !== 'PGRST116') throw error; // PGRST116 = no rows

            return data?.status === 'COMPLIANT';
        } catch (error) {
            console.error('Error checking weekly completion:', error);
            return false;
        }
    },

    /**
     * Check and apply Shield Decay if overdue
     * Call this when the app loads (HomeScreen)
     */
    async checkShieldDecay(userId: string) {
        try {


            // First check if we already ran decay check today using AsyncStorage
            const AsyncStorage = (await import('@react-native-async-storage/async-storage')).default;
            const lastDecayCheck = await AsyncStorage.getItem(`decay_check_${userId}`);
            const today = new Date().toDateString();

            if (lastDecayCheck === today) {

                return;
            }

            const completed = await this.hasCompletedThisWeek(userId);

            // If they HAVE completed this week, no decay. Shield is safe.
            if (completed) {

                // Still mark as checked today
                await AsyncStorage.setItem(`decay_check_${userId}`, today);
                return;
            }

            // If NOT completed, check if we are overdue (Today is NOT Monday)
            // Strategy: We penalize if today > Monday ("Deadline passed")
            const dayOfWeek = new Date().getDay(); // 0 (Sun) - 6 (Sat). Monday is 1.

            // If it's Monday (1) or Sunday (0), we give them a grace period.
            // Decay starts Tuesday (2).
            if (dayOfWeek <= 1) {

                await AsyncStorage.setItem(`decay_check_${userId}`, today);
                return;
            }

            // Fetch profile
            const { data: profile } = await supabase
                .from('profiles')
                .select('shield_health')
                .eq('id', userId)
                .single();

            if (!profile) return;

            // Apply Decay: -10%
            const decayAmount = 10;
            const newHealth = Math.max(0, profile.shield_health - decayAmount);

            if (newHealth !== profile.shield_health) {

                await supabase
                    .from('profiles')
                    .update({ shield_health: newHealth })
                    .eq('id', userId);
            }

            // Mark as checked today
            await AsyncStorage.setItem(`decay_check_${userId}`, today);

        } catch (error) {
            console.error('Error processing shield decay:', error);
        }
    }
};
