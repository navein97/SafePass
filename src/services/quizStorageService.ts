import AsyncStorage from '@react-native-async-storage/async-storage';

const QUIZ_PROGRESS_KEY = 'quiz_progress';

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
};
