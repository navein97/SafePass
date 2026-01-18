import { supabase } from '../lib/supabase';
import { Question, Region, QuizAttempt } from '../types/models';
import { getWeek, getYear } from 'date-fns';
import * as Crypto from 'expo-crypto';
import { ScoringService } from './scoringService';

export const QuizService = {
    /**
     * Get questions for a specific region from Supabase
     */
    async getQuestionsForRegion(region: Region): Promise<Question[]> {
        try {
            console.log('🔍 Fetching questions for region:', region);
            const { data, error } = await supabase
                .from('questions')
                .select('*')
                .contains('regions', [region]);

            if (error) {
                console.error('❌ Supabase error:', error);
                throw error;
            }

            console.log('✅ Raw data from Supabase:', data?.length, 'questions');
            console.log('📋 First question sample:', data?.[0]);

            const questions = data.map(q => {
                // Shuffle options
                const originalOptions = [...q.options];
                const correctOptionText = originalOptions[q.correct_option_index];

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
                    options: shuffledOptions,
                    correctOptionIndex: newCorrectIndex,
                    explanation: q.explanation,
                    region: q.regions,
                    category: q.category,
                    imageUrl: q.image_url,
                    componentWeights: q.component_weights,
                };
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
    async generateWeeklyQuiz(region: Region): Promise<Question[]> {
        console.log('🎲 Generating weekly quiz for region:', region);

        // 1. Get current week for the cycle calculation
        const now = new Date();
        const absoluteWeek = getWeek(now); // Week in user's calendar

        // 2. Calculate Cycle and Batch
        // Cycle updates every 4 weeks. Batch is 0-3 within that cycle.
        const cycleIndex = Math.floor(absoluteWeek / 4);
        const batchIndex = absoluteWeek % 4; // 0, 1, 2, 3

        console.log(`📅 Cycle: ${cycleIndex}, Batch: ${batchIndex}/3 (Week ${absoluteWeek})`);

        // 3. Fetch ALL questions for the region
        const allQuestions = await this.getQuestionsForRegion(region);

        if (allQuestions.length === 0) {
            console.warn('⚠️ No questions found for region:', region);
            return [];
        }

        // 4. Deterministic Shuffle
        // We use a seed based on the Cycle Index so the order is fixed for the duration of the 4-week cycle
        // but changes completely ("resets") when the next cycle starts.
        const seed = `cycle_${cycleIndex}_${region}`;
        const shuffled = this.shuffleWithSeed(allQuestions, seed);

        // 5. Select batch of 5
        const QUESTIONS_PER_WEEK = 5;
        const startIndex = batchIndex * QUESTIONS_PER_WEEK;

        // Handle case where we might run out of questions if pool < 20
        // We wrap around using modulo if needed, or just slice safely
        const selected = [];
        for (let i = 0; i < QUESTIONS_PER_WEEK; i++) {
            const index = (startIndex + i) % shuffled.length;
            selected.push(shuffled[index]);
        }

        console.log(`✨ Selected ${selected.length} questions for Batch ${batchIndex}`);

        return selected;
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
     * Calculate score from answers
     */
    calculateScore(answers: { questionId: string; isCorrect: boolean }[]): number {
        if (answers.length === 0) return 0;
        const correctCount = answers.filter(a => a.isCorrect).length;
        return Math.round((correctCount / answers.length) * 100);
    },

    /**
     * Submit quiz to database
     */
    /**
     * Submit quiz to database
     */
    async submitQuiz(
        userId: string,
        answers: { questionId: string; selectedOptionIndex: number; isCorrect: boolean }[],
        questions: Question[]
    ) {
        try {
            // Calculate Standard Score
            const rawScore = this.calculateScore(answers.map(a => ({ questionId: a.questionId, isCorrect: a.isCorrect })));

            // Calculate Component Scores
            const componentScores = ScoringService.calculateComponentScores(questions, answers.map(a => ({
                questionId: a.questionId,
                isCorrect: a.isCorrect
            })));

            const now = new Date();
            const weekNumber = getWeek(now);
            const year = getYear(now);

            // Save quiz attempt to database
            const { data: attemptData, error: attemptError } = await supabase
                .from('quiz_attempts')
                .insert({
                    user_id: userId,
                    score: rawScore,
                    answers: answers,
                    week_number: weekNumber,
                    year,
                    component_scores: componentScores, // Store in history too
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

            // Update profile with component scores
            await supabase
                .from('profiles')
                .update({
                    safety_index: weightedSafetyIndex,
                    component_scores: componentScores
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

            // 3. Check if user is now in Top 3
            const { data: topDrivers } = await supabase
                .from('profiles')
                .select('id')
                .order('safety_index', { ascending: false })
                .limit(3);

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

            // Insert all notifications
            if (notificationsToCreate.length > 0) {
                await supabase
                    .from('notifications')
                    .insert(notificationsToCreate);
            }
            // ----------------------------------

            const attempt: QuizAttempt = {
                id: attemptData.id,
                driverId: userId,
                date: attemptData.completed_at,
                score: rawScore,
                answers,
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
