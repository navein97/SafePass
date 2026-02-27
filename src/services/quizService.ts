import { supabase } from '../lib/supabase';
import { Question, Region, QuizAttempt } from '../types/models';
import { getWeek, getYear, startOfWeek, addDays, format, isSameDay } from 'date-fns';
import * as Crypto from 'expo-crypto';
import { ScoringService } from './scoringService';

import questionsMY from '../data/questionsMY.json';

export const QuizService = {
    /**
     * Get questions for a specific region from Supabase (Mocked with Local JSON for consistency)
     */
    async getQuestionsForRegion(region: Region): Promise<Question[]> {
        try {
            console.log('🔍 Fetching questions for region:', region);

            // Use local JSON instead of Supabase to ensure new Intermediate questions are used
            let data: any[] = [];
            if (region === 'MY') {
                data = questionsMY;
            }

            // Fallback to empty if no data
            if (!data) return [];

            console.log('✅ Data from Local JSON:', data?.length, 'questions');

            const questions = data.map(q => {
                // Shuffle options
                const originalOptions = [...q.options];
                const correctOptionText = originalOptions[q.correctOptionIndex];

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

            console.log('🎯 Mapped questions:', questions.length);
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
        console.log('🎲 Generating weekly quiz for region:', region);

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

        console.log(`📅 Cycle: ${cycleIndex}, Batch: ${batchIndex}/3 (Week ${absoluteWeek})`);

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
            console.log(`📋 Existing attempt check: ${existingAttempt ? `Found with score ${existingAttempt.score}%` : 'None found (first attempt this week)'}`);

            // If existing score is higher or equal, don't overwrite
            if (existingAttempt && existingAttempt.score >= rawScore) {
                console.log(`📊 Previous best (${existingAttempt.score}%) is higher than current (${rawScore}%). Keeping best score.`);
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
                console.log(`🔄 New score (${rawScore}%) beats previous (${existingAttempt.score}%). Updating best score.`);
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
     * Get daily progress scores for trend chart (Fixed Weekly View: Mon-Sun)
     * Active days show the current all-time batch average (matches MissionScreen).
     * Inactive days show 0.
     */
    async getDailyTrends(userId: string): Promise<{ value: number, label: string }[]> {
        try {
            const now = new Date();
            const weekStart = startOfWeek(now, { weekStartsOn: 1 });

            // 1. All-time batch scores to compute current overall average
            const { data: allData, error: allError } = await supabase
                .from('user_batch_progress')
                .select('score, batch_number')
                .eq('user_id', userId);

            if (allError) throw allError;

            // 2. This week's records — just need timestamps to find active days
            const { data: weekData, error: weekError } = await supabase
                .from('user_batch_progress')
                .select('completed_at')
                .eq('user_id', userId)
                .gte('completed_at', weekStart.toISOString());

            if (weekError) throw weekError;

            // 3. Compute current overall avg: average per batch → average across batches
            const batchMap = new Map<number, number[]>();
            (allData || []).forEach((a: any) => {
                if (!batchMap.has(a.batch_number)) batchMap.set(a.batch_number, []);
                batchMap.get(a.batch_number)!.push(a.score);
            });

            const batchAvgs = Array.from(batchMap.values()).map(
                scores => scores.reduce((s: number, v: number) => s + v, 0) / scores.length
            );
            const overallAvg = batchAvgs.length > 0
                ? Math.round(batchAvgs.reduce((s: number, v: number) => s + v, 0) / batchAvgs.length)
                : 0;

            // 4. Build Mon–Sun chart: show overallAvg on active days, 0 on inactive
            const dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
            return dayLabels.map((label, i) => {
                const dayDate = addDays(weekStart, i);
                const hadActivity = (weekData || []).some((log: any) =>
                    isSameDay(new Date(log.completed_at), dayDate)
                );
                return { value: hadActivity ? overallAvg : 0, label };
            });

        } catch (error) {
            console.error('Error getting daily trends:', error);
            return [];
        }
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
            console.log('🛡️ Checking shield decay for:', userId);

            // First check if we already ran decay check today using AsyncStorage
            const AsyncStorage = (await import('@react-native-async-storage/async-storage')).default;
            const lastDecayCheck = await AsyncStorage.getItem(`decay_check_${userId}`);
            const today = new Date().toDateString();

            if (lastDecayCheck === today) {
                console.log('📅 Decay already checked today. Skipping.');
                return;
            }

            const completed = await this.hasCompletedThisWeek(userId);

            // If they HAVE completed this week, no decay. Shield is safe.
            if (completed) {
                console.log('✅ User is compliant. Shield is safe.');
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
                console.log('⏳ Grace period (Monday/Sunday). No decay yet.');
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
                console.log(`📉 Applying decay. ${profile.shield_health} -> ${newHealth}`);
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
