import AsyncStorage from '@react-native-async-storage/async-storage';

const QUIZ_PROGRESS_KEY = 'quiz_progress';
const DAILY_LIMIT_KEY = 'daily_question_limit';

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
}

export const QuizStorageService = {
    /**
     * Save quiz progress to local storage
     */
    async saveProgress(progress: SavedQuizProgress): Promise<void> {
        try {
            const key = `${QUIZ_PROGRESS_KEY}_${progress.userId}_${progress.batchNumber}`;
            await AsyncStorage.setItem(key, JSON.stringify({
                ...progress,
                savedAt: Date.now(),
            }));
            console.log(`Quiz progress saved for batch ${progress.batchNumber}`);
        } catch (error) {
            console.error('Error saving quiz progress:', error);
        }
    },

    /**
     * Load saved quiz progress from local storage
     */
    async loadProgress(userId: string, batchNumber: number): Promise<SavedQuizProgress | null> {
        try {
            const key = `${QUIZ_PROGRESS_KEY}_${userId}_${batchNumber}`;
            const saved = await AsyncStorage.getItem(key);

            if (!saved) return null;

            const progress: SavedQuizProgress = JSON.parse(saved);

            // Check if progress is still valid (less than 24 hours old)
            const MAX_AGE_MS = 24 * 60 * 60 * 1000; // 24 hours
            if (Date.now() - progress.savedAt > MAX_AGE_MS) {
                await this.clearProgress(userId, batchNumber);
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
    async clearProgress(userId: string, batchNumber: number): Promise<void> {
        try {
            const key = `${QUIZ_PROGRESS_KEY}_${userId}_${batchNumber}`;
            await AsyncStorage.removeItem(key);
            console.log(`Quiz progress cleared for batch ${batchNumber}`);
        } catch (error) {
            console.error('Error clearing quiz progress:', error);
        }
    },

    /**
     * Check if there's saved progress for a batch
     */
    async hasProgress(userId: string, batchNumber: number): Promise<boolean> {
        const progress = await this.loadProgress(userId, batchNumber);
        return progress !== null;
    },

    /**
     * Get daily question count
     */
    async getDailyCount(userId: string): Promise<number> {
        try {
            const today = new Date().toISOString().split('T')[0];
            const key = `${DAILY_LIMIT_KEY}_${userId}`;
            const data = await AsyncStorage.getItem(key);

            if (!data) return 0;

            const progress: DailyProgress = JSON.parse(data);
            if (progress.date !== today) {
                // If it's a new day, we return 0 count.
                // We DON'T reset storage here because incrementDailyCount needs the old data to calculate streak.
                // If we reset here, we lose the streak info if they just open the app but don't play.
                return 0;
            }

            return progress.count;
        } catch (error) {
            console.error('Error getting daily count:', error);
            return 0;
        }
    },

    /**
     * Increment daily question count and update streak
     */
    async incrementDailyCount(userId: string): Promise<number> {
        try {
            const today = new Date().toISOString().split('T')[0];
            const key = `${DAILY_LIMIT_KEY}_${userId}`;
            const data = await AsyncStorage.getItem(key);

            let streak = 1;
            let currentCount = 0;

            if (data) {
                const prev: DailyProgress = JSON.parse(data);

                if (prev.date === today) {
                    currentCount = prev.count;
                    streak = prev.streak || 1;
                } else {
                    // New day
                    currentCount = 0;

                    // Streak Logic: Check if last activity was yesterday
                    const lastDate = new Date(prev.lastActivityDate || prev.date);
                    const yesterday = new Date();
                    yesterday.setDate(yesterday.getDate() - 1);
                    const yesterdayStr = yesterday.toISOString().split('T')[0];

                    // If last activity (or the date of the record) matches yesterday, increment streak
                    if (prev.lastActivityDate === yesterdayStr || prev.date === yesterdayStr) {
                        streak = (prev.streak || 0) + 1;
                    } else if (prev.lastActivityDate === today || prev.date === today) {
                        streak = prev.streak || 1; // Should be covered by first if, but just in case
                    } else {
                        streak = 1; // Broken streak
                    }
                }
            }

            const newCount = currentCount + 1;

            const progress: DailyProgress = {
                date: today,
                count: newCount,
                streak,
                lastActivityDate: today
            };

            await AsyncStorage.setItem(key, JSON.stringify(progress));
            return newCount;
        } catch (error) {
            console.error('Error incrementing daily count:', error);
            return 0;
        }
    },

    /**
     * Reset daily count (internal or for testing)
     */
    async resetDailyCount(userId: string): Promise<void> {
        const today = new Date().toISOString().split('T')[0];
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
            const today = new Date().toISOString().split('T')[0];
            const yesterday = new Date();
            yesterday.setDate(yesterday.getDate() - 1);
            const yesterdayStr = yesterday.toISOString().split('T')[0];

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
