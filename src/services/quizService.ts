import { supabase } from '../lib/supabase';
import { Question, Region, QuizAttempt } from '../types/models';
import { getWeek, getYear } from 'date-fns';
import * as Crypto from 'expo-crypto';

export const QuizService = {
    /**
     * Get questions for a specific region from Supabase
     */
    async getQuestionsForRegion(region: Region): Promise<Question[]> {
        try {
            const { data, error } = await supabase
                .from('questions')
                .select('*')
                .contains('regions', [region]);

            if (error) throw error;

            return data.map(q => ({
                id: q.id,
                text: q.text,
                options: q.options,
                correctOptionIndex: q.correct_option_index,
                explanation: q.explanation,
                region: q.regions,
                category: q.category,
            }));
        } catch (error) {
            console.error('Error fetching questions:', error);
            return [];
        }
    },

    /**
     * Generate a weekly quiz with 30 random questions
     */
    async generateWeeklyQuiz(region: Region): Promise<Question[]> {
        const allQuestions = await this.getQuestionsForRegion(region);

        if (allQuestions.length === 0) {
            console.warn('No questions found for region:', region);
            return [];
        }

        // Shuffle array
        const shuffled = [...allQuestions].sort(() => 0.5 - Math.random());

        // Return top 30 (or fewer if not enough questions)
        return shuffled.slice(0, Math.min(30, shuffled.length));
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
    async submitQuiz(
        userId: string,
        answers: { questionId: string; selectedOptionIndex: number; isCorrect: boolean }[]
    ) {
        try {
            const score = this.calculateScore(answers.map(a => ({ questionId: a.questionId, isCorrect: a.isCorrect })));
            const now = new Date();
            const weekNumber = getWeek(now);
            const year = getYear(now);

            // Save quiz attempt to database
            const { data: attemptData, error: attemptError } = await supabase
                .from('quiz_attempts')
                .insert({
                    user_id: userId,
                    score,
                    answers: answers,
                    week_number: weekNumber,
                    year,
                })
                .select()
                .single();

            if (attemptError) throw attemptError;

            // Generate HMAC signature for compliance log
            const dataToSign = JSON.stringify({ userId, weekNumber, year, score });
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
                    score,
                    signature,
                    completed_at: now.toISOString(),
                }, {
                    onConflict: 'user_id,week_number,year'
                });

            if (complianceError) throw complianceError;

            // Update user's safety index
            await this.updateSafetyIndex(userId);

            const attempt: QuizAttempt = {
                id: attemptData.id,
                driverId: userId,
                date: attemptData.completed_at,
                score,
                answers,
                weekNumber,
                year,
            };

            return { score, attempt };
        } catch (error) {
            console.error('Error submitting quiz:', error);
            throw error;
        }
    },

    /**
     * Update driver's safety index (90-day rolling average)
     */
    async updateSafetyIndex(userId: string) {
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
                    .update({ safety_index: safetyIndex })
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
};
