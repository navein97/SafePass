import AsyncStorage from '@react-native-async-storage/async-storage';

import { Question } from '../types/models';

const QUIZ_PROGRESS_KEY = 'quiz_progress';
const DAILY_LIMIT_KEY = 'daily_question_limit';

const getLocalDateString = (d: Date = new Date()) => {
    // Offset by +8 hours for MYT/SGT
    const mytDate = new Date(d.getTime() + 8 * 60 * 60 * 1000);
    return mytDate.toISOString().split('T')[0];
};

export interface DailyProgress {
    date: string; // YYYY-MM-DD
    count: number;
    streak: number;
    lastActivityDate: string;
}

export interface SavedQuizProgress {
    batchNumber: number;
    currentIndex: number;
    answers: Array<{ questionId: string; attempts: number; isCorrect: boolean }>;
    attemptCounts: Record<number, number>;
    startTime: number;
    savedAt: number;
    userId: string;
    mode?: 'live' | 'practice';
    questions?: Question[];
    sessionLimit?: number;
    hasAnnouncedReview?: boolean;
    primarySessionLimit?: number;
}

export const QuizStorageService = {
    /**
     * Save quiz progress to local storage
     */
    async saveProgress(progress: SavedQuizProgress): Promise<void> {
        try {
            const mode = progress.mode || 'live';
            const key = `${QUIZ_PROGRESS_KEY}_${progress.userId}_${progress.batchNumber}_${mode}`;
            await AsyncStorage.setItem(key, JSON.stringify({
                ...progress,
                savedAt: Date.now(),
            }));

        } catch (error) {
            console.error('Error saving quiz progress:', error);
        }
    },

    /**
     * Load saved quiz progress from local storage
     */
    async loadProgress(userId: string, batchNumber: number, mode: 'live' | 'practice' = 'live'): Promise<SavedQuizProgress | null> {
        try {
            const key = `${QUIZ_PROGRESS_KEY}_${userId}_${batchNumber}_${mode}`;
            const saved = await AsyncStorage.getItem(key);

            if (!saved) return null;

            const progress: SavedQuizProgress = JSON.parse(saved);

            // Check if progress is still valid (less than 24 hours old)
            const MAX_AGE_MS = 24 * 60 * 60 * 1000; // 24 hours
            if (Date.now() - progress.savedAt > MAX_AGE_MS) {
                await this.clearProgress(userId, batchNumber, mode);
                return null;
            }

            return progress;
        } catch (error) {
            console.error('Error loading quiz progress:', error);
            return null;
        }
    },

    /**
     * Clear saved quiz progress (after completion or manual clear)
     */
    async clearProgress(userId: string, batchNumber: number, mode: 'live' | 'practice' = 'live'): Promise<void> {
        try {
            const key = `${QUIZ_PROGRESS_KEY}_${userId}_${batchNumber}_${mode}`;
            await AsyncStorage.removeItem(key);

        } catch (error) {
            console.error('Error clearing quiz progress:', error);
        }
    },

    /**
     * Check if there's saved progress for a batch
     */
    async hasProgress(userId: string, batchNumber: number, mode: 'live' | 'practice' = 'live'): Promise<boolean> {
        const progress = await this.loadProgress(userId, batchNumber, mode);
        return progress !== null;
    },

    /**
     * Get daily question count for a specific batch
     */
    async getDailyCount(userId: string, batchNumber?: number): Promise<number> {
        try {
            const today = getLocalDateString();
            const key = batchNumber
                ? `${DAILY_LIMIT_KEY}_${userId}_batch_${batchNumber}`
                : `${DAILY_LIMIT_KEY}_${userId}`;

            const data = await AsyncStorage.getItem(key);

            if (!data) return 0;

            const progress: DailyProgress = JSON.parse(data);
            if (progress.date !== today) {
                return 0;
            }

            return progress.count;
        } catch (error) {
            console.error('Error getting daily count:', error);
            return 0;
        }
    },

    /**
     * Increment daily question count for a specific batch and update streak
     */
    async incrementDailyCount(userId: string, batchNumber?: number): Promise<number> {
        try {
            const today = getLocalDateString();

            // 1. Update Global Record (for Streak/Activity tracking)
            const globalKey = `${DAILY_LIMIT_KEY}_${userId}`;
            const globalData = await AsyncStorage.getItem(globalKey);
            let streak = 1;
            let totalCount = 0;

            if (globalData) {
                const prev: DailyProgress = JSON.parse(globalData);
                if (prev.date === today) {
                    totalCount = prev.count;
                    streak = prev.streak || 1;
                } else {
                    const yesterday = new Date();
                    yesterday.setDate(yesterday.getDate() - 1);
                    const yesterdayStr = getLocalDateString(yesterday);

                    if (prev.lastActivityDate === yesterdayStr || prev.date === yesterdayStr) {
                        streak = (prev.streak || 0) + 1;
                    } else {
                        streak = 1;
                    }
                }
            }

            await AsyncStorage.setItem(globalKey, JSON.stringify({
                date: today,
                count: totalCount + 1,
                streak,
                lastActivityDate: today
            }));

            // 2. Update Batch-Specific Record (if batchNumber provided)
            if (batchNumber) {
                const batchKey = `${DAILY_LIMIT_KEY}_${userId}_batch_${batchNumber}`;
                const batchData = await AsyncStorage.getItem(batchKey);
                let batchCount = 0;

                if (batchData) {
                    const prev: DailyProgress = JSON.parse(batchData);
                    if (prev.date === today) {
                        batchCount = prev.count;
                    }
                }

                await AsyncStorage.setItem(batchKey, JSON.stringify({
                    date: today,
                    count: batchCount + 1,
                    streak, // Keep streak in batch record too just in case
                    lastActivityDate: today
                }));

                return batchCount + 1;
            }

            return totalCount + 1;
        } catch (error) {
            console.error('Error incrementing daily count:', error);
            return 0;
        }
    },

    /**
     * Reset daily count (internal or for testing)
     */
    async resetDailyCount(userId: string): Promise<void> {
        const today = getLocalDateString();
        const key = `${DAILY_LIMIT_KEY}_${userId}`;
        const progress: DailyProgress = { date: today, count: 0, streak: 0, lastActivityDate: today };
        await AsyncStorage.setItem(key, JSON.stringify(progress));
    },

    /**
     * Get current streak
     */
    async getStreak(userId: string): Promise<number> {
        try {
            const key = `${DAILY_LIMIT_KEY}_${userId}`;
            const data = await AsyncStorage.getItem(key);
            if (!data) return 0;

            const progress: DailyProgress = JSON.parse(data);
            const today = getLocalDateString();
            const yesterday = new Date();
            yesterday.setDate(yesterday.getDate() - 1);
            const yesterdayStr = getLocalDateString(yesterday);

            // Streak is valid if last activity was today or yesterday
            const lastActive = progress.lastActivityDate || progress.date;

            if (lastActive === today || lastActive === yesterdayStr) {
                return progress.streak || 0;
            }

            return 0;
        } catch (error) {
            return 0;
        }
    }
};
