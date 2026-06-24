import { supabase } from '../lib/supabase';
import { Question, Region } from '../types/models';

export const PracticeService = {
    /**
     * Get a session of 30 questions for practice
     * Prioritizes questions the user has previously answered incorrectly.
     */
    async getPracticeSession(userId: string, region: Region, limit: number = 30): Promise<Question[]> {
        try {
            console.log('🎯 Generating Smart Practice Session for:', userId);

            // 1. Fetch All Questions (from all regions) from Supabase
            const { data: profile } = await supabase
                .from('profiles')
                .select('vehicle_type')
                .eq('id', userId)
                .single();

            let query = supabase
                .from('questions')
                .select('*');

            let vType = profile?.vehicle_type;
            const validTypes = ['Box Van', 'Container Haulage', 'General Cargo'];
            
            // Failsafe: Default to General Cargo if their vehicle type is old/invalid
            if (vType && !validTypes.includes(vType)) {
                vType = 'General Cargo';
            }

            if (vType) {
                query = query.contains('driver_categories', [vType]);
            }

            const { data: dbData, error: dbError } = await query;

            if (dbError) throw dbError;
            const allQuestions: any[] = dbData || [];

            if (!allQuestions || allQuestions.length === 0) return [];

            // 2. Fetch User's Past Wrong Answers (from quiz_attempts)
            // We look for any attempt where the user got it wrong
            // Note: This requires us to parse the JSON answers column.
            const { data: attempts } = await supabase
                .from('quiz_attempts')
                .select('answers, completed_at')
                .eq('user_id', userId)
                .order('completed_at', { ascending: false })
                .limit(50); // Look at last 50 attempts for performance

            const wrongQuestionIds = new Set<string>();

            attempts?.forEach(attempt => {
                const answers: any[] = attempt.answers;
                if (Array.isArray(answers)) {
                    answers.forEach(a => {
                        if (!a.isCorrect) {
                            wrongQuestionIds.add(a.questionId);
                        }
                    });
                }
            });

            console.log(`🧠 Found ${wrongQuestionIds.size} historically wrong questions.`);

            // 3. Separate Questions into "Priority" (Wrong) and "Standard" (Others)
            const priorityQuestions: any[] = [];
            const standardQuestions: any[] = [];

            allQuestions.forEach(q => {
                if (wrongQuestionIds.has(q.id)) {
                    priorityQuestions.push(q);
                } else {
                    standardQuestions.push(q);
                }
            });

            // 4. Build the Session
            // We want up to 50% priority questions, rest random
            const targetPriorityCount = Math.min(priorityQuestions.length, Math.floor(limit / 2));
            const targetStandardCount = limit - targetPriorityCount;

            // Shuffle both pools
            this.shuffleArray(priorityQuestions);
            this.shuffleArray(standardQuestions);

            const selectedPriority = priorityQuestions.slice(0, targetPriorityCount);
            // If we ran out of standards (unlikely), fill with priority
            const neededStandard = limit - selectedPriority.length;
            const selectedStandard = standardQuestions.slice(0, neededStandard);

            let finalSelection = [...selectedPriority, ...selectedStandard];

            // Final shuffle to mix them
            this.shuffleArray(finalSelection);

            return finalSelection.map(q => this.mapToQuestionModel(q));
        } catch (error) {
            console.error('Error generating practice session:', error);
            // Fallback to random
            return this.getRandomQuestions(userId, region, limit);
        }
    },

    /**
     * Fallback random questions
     */
    async getRandomQuestions(userId: string, region: Region, limit: number): Promise<Question[]> {
        // Load all questions from all regions from Supabase
        const { data: profile } = await supabase
            .from('profiles')
            .select('vehicle_type')
            .eq('id', userId)
            .single();

        let query = supabase
            .from('questions')
            .select('*');

        let vType = profile?.vehicle_type;
        const validTypes = ['Box Van', 'Container Haulage', 'General Cargo'];
        
        // Failsafe: Default to General Cargo if their vehicle type is old/invalid
        if (vType && !validTypes.includes(vType)) {
            vType = 'General Cargo';
        }

        if (vType) {
            query = query.contains('driver_categories', [vType]);
        }

        const { data: dbData, error: dbError } = await query;

        if (dbError) throw dbError;
        const allQuestions: any[] = dbData || [];

        this.shuffleArray(allQuestions);
        return allQuestions.slice(0, limit).map(q => this.mapToQuestionModel(q));
    },

    /**
     * Fisher-Yates Shuffle
     */
    shuffleArray(array: any[]) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
    },

    mapToQuestionModel(q: any): Question {
        // Shuffle options for practice mode too!
        const originalOptions = [...(q.options || [])];
        const correctIdx = q.correct_option_index !== undefined ? q.correct_option_index : q.correctOptionIndex;
        const correctOptionText = originalOptions[correctIdx];
        const indices = originalOptions.map((_, i) => i);

        // Shuffle indices
        for (let i = indices.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [indices[i], indices[j]] = [indices[j], indices[i]];
        }

        const shuffledOptions = indices.map(i => originalOptions[i]);
        const newCorrectIndex = shuffledOptions.indexOf(correctOptionText);

        return {
            id: q.id,
            text: q.text,
            text_ms: q.text_bm || q.text_ms,
            options: shuffledOptions,
            options_ms: q.options_ms ? indices.map(i => q.options_ms[i]) : undefined,
            correctOptionIndex: newCorrectIndex,
            explanation: q.explanation,
            explanation_ms: q.explanation_ms,
            region: q.regions || q.region,
            category: q.category,
            imageUrl: q.image_url || q.imageUrl,
            difficulty: q.difficulty || 'intermediate',
            componentWeights: q.component_weights || q.componentWeights,
        } as Question;
    }
};
