import { Question } from '../types/models';

export interface DimensionScores {
    operation: number | null; // Operational Effectiveness (OE)
    discipline: number | null; // Operational Discipline (OD)
    professionalism: number | null; // Professional Conduct (PC)
}

export type PerformanceRatingType =
    | 'High Performing'
    | 'Satisfactory'
    | 'Needs Improvement'
    | 'High Concern'
    | 'Critical Risk'
    | 'N/A';

export interface PerformanceRatingInfo {
    rating: PerformanceRatingType;
    ratingKey: string;
    color: string;
    description?: string;
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

    /**
     * Calculate Dimension percentage scores (PC, OD, OE) based on completed MCQs.
     * 
     * Dimension score (%) = Total weighted marks earned for the dimension ÷ Total available mapped weights for the dimension × 100
     * 
     * - Only completed MCQs mapped to the dimension enter numerator and denominator.
     * - Marks: 1.0 (1st attempt), 0.5 (2nd attempt), 0 (failed).
     * - If no completed MCQ mapped to a dimension, returns null (displayed as "N/A").
     */
    calculateDimensionScores(
        questions: Question[],
        answers: Array<{ questionId: string; attempts?: number; isCorrect?: boolean; score?: number }>
    ): DimensionScores {
        let opEarned = 0;
        let opPossible = 0;
        let discEarned = 0;
        let discPossible = 0;
        let profEarned = 0;
        let profPossible = 0;

        answers.forEach((answer) => {
            const question = questions.find((q) => q.id === answer.questionId);
            if (!question) return;

            const weights = question.componentWeights || this.getDefaultWeights(question.category);
            if (!weights) return;

            // Determine mark earned for this completed MCQ (1.0, 0.5, or 0.0)
            let mark = 0.0;
            if (answer.score !== undefined && answer.score !== null) {
                mark = parseFloat(String(answer.score));
            } else if (answer.isCorrect) {
                mark = (answer.attempts === 2) ? 0.5 : 1.0;
            }

            // Operation (Operational Effectiveness)
            const opWeight = weights.operation || 0;
            if (opWeight > 0) {
                opPossible += opWeight;
                opEarned += opWeight * mark;
            }

            // Discipline (Operational Discipline)
            const discWeight = weights.discipline || 0;
            if (discWeight > 0) {
                discPossible += discWeight;
                discEarned += discWeight * mark;
            }

            // Professionalism (Professional Conduct)
            const profWeight = weights.professionalism || 0;
            if (profWeight > 0) {
                profPossible += profWeight;
                profEarned += profWeight * mark;
            }
        });

        return {
            operation: opPossible > 0 ? Math.round((opEarned / opPossible) * 100) : null,
            discipline: discPossible > 0 ? Math.round((discEarned / discPossible) * 100) : null,
            professionalism: profPossible > 0 ? Math.round((profEarned / profPossible) * 100) : null,
        };
    },

    /**
     * Backward compatibility wrapper returning non-nullable numbers (0 if null)
     */
    calculateComponentScores(
        questions: Question[],
        answers: { questionId: string; isCorrect: boolean; attempts?: number; score?: number }[]
    ): { operation: number; discipline: number; professionalism: number } {
        const dim = this.calculateDimensionScores(questions, answers);
        return {
            operation: dim.operation ?? 0,
            discipline: dim.discipline ?? 0,
            professionalism: dim.professionalism ?? 0,
        };
    },

    /**
     * Get performance rating category and display styling for a dimension percentage score
     * 
     * Score	Rating
     * 81–100%	High Performing
     * 61–80%	Satisfactory
     * 41–60%	Needs Improvement
     * 21–40%	High Concern
     * 0–20%	Critical Risk
     */
    getPerformanceRating(score: number | null | undefined): PerformanceRatingInfo {
        if (score === null || score === undefined || isNaN(score)) {
            return {
                rating: 'N/A',
                ratingKey: 'ratings.na',
                color: '#9CA3AF',
                description: 'No data available'
            };
        }

        const rounded = Math.round(score);

        if (rounded >= 81) {
            return {
                rating: 'High Performing',
                ratingKey: 'ratings.highPerforming',
                color: '#10B981',
                description: 'High Performing (81-100%)'
            };
        }
        if (rounded >= 61) {
            return {
                rating: 'Satisfactory',
                ratingKey: 'ratings.satisfactory',
                color: '#3B82F6',
                description: 'Satisfactory (61-80%)'
            };
        }
        if (rounded >= 41) {
            return {
                rating: 'Needs Improvement',
                ratingKey: 'ratings.needsImprovement',
                color: '#F59E0B',
                description: 'Needs Improvement (41-60%)'
            };
        }
        if (rounded >= 21) {
            return {
                rating: 'High Concern',
                ratingKey: 'ratings.highConcern',
                color: '#EF4444',
                description: 'High Concern (21-40%)'
            };
        }
        return {
            rating: 'Critical Risk',
            ratingKey: 'ratings.criticalRisk',
            color: '#DC2626',
            description: 'Critical Risk (0-20%)'
        };
    },

    /**
     * Get Management Action recommendation tailored to a specific dimension & rating
     */
    getManagementAction(
        dimension: 'PC' | 'OD' | 'OE' | 'professionalism' | 'discipline' | 'operation',
        score: number | null | undefined,
        t?: (key: string, options?: any) => string
    ): string {
        const { rating } = this.getPerformanceRating(score);

        // Competency description replacements
        let compKey = 'user.competencyOE';
        let fallbackComp = 'operational effectiveness, vehicle handling, and efficiency';
        if (dimension === 'PC' || dimension === 'professionalism') {
            compKey = 'user.competencyPC';
            fallbackComp = 'professional conduct, ethics, and workplace standards';
        } else if (dimension === 'OD' || dimension === 'discipline') {
            compKey = 'user.competencyOD';
            fallbackComp = 'compliance with regulations, SOPs, and operational requirements';
        }

        const competency = t ? t(compKey, { defaultValue: fallbackComp }) : fallbackComp;

        if (t) {
            switch (rating) {
                case 'High Performing':
                    return t('user.actionHighPerforming', {
                        competency,
                        defaultValue: `Maintain and reinforce the current behavioural standard in ${competency} to sustain high performance.`
                    });
                case 'Satisfactory':
                    return t('user.actionSatisfactory', {
                        competency,
                        defaultValue: `Further strengthen ${competency} to achieve consistently high performance.`
                    });
                case 'Needs Improvement':
                    return t('user.actionNeedsImprovement', {
                        competency,
                        defaultValue: `Improve ${competency} through continuous reinforcement.`
                    });
                case 'High Concern':
                    return t('user.actionHighConcern', {
                        competency,
                        defaultValue: `Prioritise improvement in ${competency} to reduce operational risk.`
                    });
                case 'Critical Risk':
                    return t('user.actionCriticalRisk', {
                        competency,
                        defaultValue: `Immediate improvement is required in ${competency} to minimise operational risk.`
                    });
                case 'N/A':
                default:
                    return t('user.actionNA', {
                        defaultValue: 'Pending completed MCQs mapped to this dimension before management actions can be generated.'
                    });
            }
        }

        switch (rating) {
            case 'High Performing':
                return `Maintain and reinforce the current behavioural standard in ${competency} to sustain high performance.`;
            case 'Satisfactory':
                return `Further strengthen ${competency} to achieve consistently high performance.`;
            case 'Needs Improvement':
                return `Improve ${competency} through continuous reinforcement.`;
            case 'High Concern':
                return `Prioritise improvement in ${competency} to reduce operational risk.`;
            case 'Critical Risk':
                return `Immediate improvement is required in ${competency} to minimise operational risk.`;
                case 'N/A':
            default:
                return `Pending completed MCQs mapped to this dimension before management actions can be generated.`;
        }
    },

    calculateWeightedAverage(currentScore: number, history: number[]): number {
        // Latest Attempt method: Return current score directly without historic degradation
        return currentScore;
    }
};
