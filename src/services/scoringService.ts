import { Question } from '../types/models';

interface ComponentScore {
    operation: number;
    professionalism: number;
    discipline: number;
}

export const ScoringService = {
    calculateComponentScores(
        questions: Question[],
        answers: { questionId: string; isCorrect: boolean }[]
    ): ComponentScore {
        let earned = { operation: 0, professionalism: 0, discipline: 0 };
        let totalPossible = { operation: 0, professionalism: 0, discipline: 0 };

        answers.forEach((answer) => {
            const question = questions.find((q) => q.id === answer.questionId);
            if (!question || !question.componentWeights) return;

            const weights = question.componentWeights;

            // Add to possible totals
            if (weights.operation) totalPossible.operation += weights.operation;
            if (weights.professionalism) totalPossible.professionalism += weights.professionalism;
            if (weights.discipline) totalPossible.discipline += weights.discipline;

            // Add to earned totals if correct
            if (answer.isCorrect) {
                if (weights.operation) earned.operation += weights.operation;
                if (weights.professionalism) earned.professionalism += weights.professionalism;
                if (weights.discipline) earned.discipline += weights.discipline;
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
