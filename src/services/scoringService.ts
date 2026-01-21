import { Question } from '../types/models';

interface ComponentScore {
    operation: number;
    professionalism: number;
    discipline: number;
}

export const ScoringService = {
    // Default component weights by category
    getDefaultWeights(category?: string): { operation: number; professionalism: number; discipline: number } {
        switch (category?.toLowerCase()) {
            case 'safety':
            case 'road_safety':
                return { operation: 40, professionalism: 30, discipline: 30 };
            case 'traffic':
            case 'traffic_rules':
                return { operation: 50, professionalism: 20, discipline: 30 };
            case 'vehicle':
            case 'vehicle_maintenance':
                return { operation: 60, professionalism: 20, discipline: 20 };
            case 'conduct':
            case 'professional_conduct':
                return { operation: 20, professionalism: 50, discipline: 30 };
            case 'compliance':
                return { operation: 30, professionalism: 30, discipline: 40 };
            default:
                // Equal distribution as fallback
                return { operation: 34, professionalism: 33, discipline: 33 };
        }
    },

    calculateComponentScores(
        questions: Question[],
        answers: { questionId: string; isCorrect: boolean; attempts?: number }[]
    ): ComponentScore {
        let earned = { operation: 0, professionalism: 0, discipline: 0 };
        let totalPossible = { operation: 0, professionalism: 0, discipline: 0 };

        answers.forEach((answer) => {
            const question = questions.find((q) => q.id === answer.questionId);
            if (!question) return;

            // Use componentWeights if available, otherwise use defaults based on category
            const weights = question.componentWeights || this.getDefaultWeights(question.category);

            // Add to possible totals (Always full potential currently)
            if (weights.operation) totalPossible.operation += weights.operation;
            if (weights.professionalism) totalPossible.professionalism += weights.professionalism;
            if (weights.discipline) totalPossible.discipline += weights.discipline;

            // Add to earned totals if correct, with WEIGHTING based on attempts
            if (answer.isCorrect) {
                let attemptMultiplier = 1.0;
                const attempts = answer.attempts || 1;

                if (attempts === 1) attemptMultiplier = 1.0;
                else if (attempts === 2) attemptMultiplier = 0.5;
                else if (attempts >= 3) attemptMultiplier = 0.25;

                if (weights.operation) earned.operation += weights.operation * attemptMultiplier;
                if (weights.professionalism) earned.professionalism += weights.professionalism * attemptMultiplier;
                if (weights.discipline) earned.discipline += weights.discipline * attemptMultiplier;
            }
        });

        // Normalize to 0-100%
        const normalize = (earned: number, total: number) => {
            return total === 0 ? 0 : Math.round((earned / total) * 100);
        };

        return {
            operation: normalize(earned.operation, totalPossible.operation),
            professionalism: normalize(earned.professionalism, totalPossible.professionalism),
            discipline: normalize(earned.discipline, totalPossible.discipline),
        };
    },

    calculateWeightedAverage(currentScore: number, history: number[]): number {
        // History: array of previous scores (last 5 days)
        // Formula: (Today * 0.7) + (AverageOfHistory * 0.3)
        // This rewards consistency but prioritizes current performance.

        if (history.length === 0) return currentScore;

        const historySum = history.reduce((sum, val) => sum + val, 0);
        const historyAvg = historySum / history.length;

        const weightedScore = (currentScore * 0.7) + (historyAvg * 0.3);
        return Math.round(weightedScore);
    }
};
