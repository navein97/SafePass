import { supabase } from '../lib/supabase';
import { BatchService } from './batchService';

export interface Milestone {
    id: string;
    category: 'volume' | 'mastery' | 'habit' | 'progression';
    title: string;
    description: string;
    threshold: number;
    icon: string;
    color: string;
    isUnlocked: boolean;
    unlockedAt?: string;
    currentValue: number;
    progressPercentage: number;
}

export const MILESTONE_DEFINITIONS = [
    // 1. Volume Milestones (MCQs Completed)
    {
        id: 'vol_100',
        category: 'volume' as const,
        title: 'Century Scholar',
        description: 'Completed 100 MCQs in ProHayat180',
        threshold: 100,
        icon: 'book-open',
        color: '#3B82F6',
    },
    {
        id: 'vol_250',
        category: 'volume' as const,
        title: 'Safety Specialist',
        description: 'Completed 250 MCQs in ProHayat180',
        threshold: 250,
        icon: 'award',
        color: '#8B5CF6',
    },
    {
        id: 'vol_500',
        category: 'volume' as const,
        title: 'Road Veteran',
        description: 'Completed 500 MCQs in ProHayat180',
        threshold: 500,
        icon: 'shield',
        color: '#EC4899',
    },
    {
        id: 'vol_1000',
        category: 'volume' as const,
        title: 'Grandmaster of Safety',
        description: 'Completed 1,000 MCQs in ProHayat180',
        threshold: 1000,
        icon: 'crown',
        color: '#F59E0B',
    },

    // 2. Mastery Milestones (Perfect Sessions - 100% score)
    {
        id: 'mas_10',
        category: 'mastery' as const,
        title: 'Sharp Shooter (10)',
        description: 'Achieved 10 perfect 100% quiz sessions',
        threshold: 10,
        icon: 'target',
        color: '#10B981',
    },
    {
        id: 'mas_25',
        category: 'mastery' as const,
        title: 'Flawless Navigator (25)',
        description: 'Achieved 25 perfect 100% quiz sessions',
        threshold: 25,
        icon: 'zap',
        color: '#06B6D4',
    },
    {
        id: 'mas_50',
        category: 'mastery' as const,
        title: 'Master of Precision (50)',
        description: 'Achieved 50 perfect 100% quiz sessions',
        threshold: 50,
        icon: 'star',
        color: '#F59E0B',
    },

    // 3. Habit / Active Days Milestones
    {
        id: 'hab_30',
        category: 'habit' as const,
        title: 'Dedicated Driver',
        description: 'Maintained 30 active learning days / streak',
        threshold: 30,
        icon: 'flame',
        color: '#EF4444',
    },
    {
        id: 'hab_60',
        category: 'habit' as const,
        title: 'Safety Guardian',
        description: 'Maintained 60 active learning days / streak',
        threshold: 60,
        icon: 'shield-check',
        color: '#F97316',
    },
    {
        id: 'hab_100',
        category: 'habit' as const,
        title: 'Century of Consistency',
        description: 'Maintained 100 active learning days / streak',
        threshold: 100,
        icon: 'trophy',
        color: '#FBBF24',
    },

    // 4. Rank Progression
    {
        id: 'band_p3',
        category: 'progression' as const,
        title: 'Reached B Rank',
        description: 'Achieve an Overall Score of 70% or higher',
        threshold: 70,
        icon: 'trending-up',
        color: '#3B82F6',
    },
    {
        id: 'band_p4',
        category: 'progression' as const,
        title: 'Reached A Rank',
        description: 'Achieve an Overall Score of 80% or higher',
        threshold: 80,
        icon: 'sparkles',
        color: '#8B5CF6',
    },
    {
        id: 'band_p5',
        category: 'progression' as const,
        title: 'Reached S Rank',
        description: 'Achieve an Overall Score of 90% or higher',
        threshold: 90,
        icon: 'crown',
        color: '#E11D48',
    },
];

export const MilestoneService = {
    /**
     * Get all milestone statuses for a user
     */
    async getUserMilestones(userId: string): Promise<{
        milestones: Milestone[];
        totalUnlocked: number;
        totalCount: number;
        latestUnlocked: Milestone | null;
    }> {
        try {
            // 1. Fetch user stats
            const totalMCQs = await BatchService.getTotalAnsweredQuestions(userId);

            // Fetch profile for streak & csi
            const { data: profile } = await supabase
                .from('profiles')
                .select('streak')
                .eq('id', userId)
                .single();

            const streak = profile?.streak || 0;

            // Fetch CSI score
            const csiData = await BatchService.getCumulativeSafetyIndex(userId);
            const csiScore = csiData.score;

            // Fetch perfect attempts (score = 100) from user_batch_progress and quiz_attempts
            const { data: perfectBatchData } = await supabase
                .from('user_batch_progress')
                .select('id')
                .eq('user_id', userId)
                .gte('score', 100);

            const perfectAttemptsCount = perfectBatchData?.length || 0;

            // Fetch milestone notifications already awarded
            const { data: awardedNotifs } = await supabase
                .from('notifications')
                .select('title, created_at')
                .eq('user_id', userId)
                .eq('type', 'leaderboard');

            const awardedTitles = new Set(awardedNotifs?.map(n => n.title) || []);

            const milestones: Milestone[] = MILESTONE_DEFINITIONS.map(def => {
                let currentValue = 0;
                let isUnlocked = false;

                if (def.category === 'volume') {
                    currentValue = totalMCQs;
                    isUnlocked = totalMCQs >= def.threshold;
                } else if (def.category === 'mastery') {
                    currentValue = perfectAttemptsCount;
                    isUnlocked = perfectAttemptsCount >= def.threshold;
                } else if (def.category === 'habit') {
                    currentValue = streak;
                    isUnlocked = streak >= def.threshold;
                } else if (def.category === 'progression') {
                    currentValue = csiScore;
                    isUnlocked = csiScore >= def.threshold;
                }

                const progressPercentage = Math.min(100, Math.round((currentValue / Math.max(1, def.threshold)) * 100));

                return {
                    ...def,
                    currentValue,
                    isUnlocked,
                    progressPercentage,
                };
            });

            const unlockedList = milestones.filter(m => m.isUnlocked);
            const latestUnlocked = unlockedList.length > 0 ? unlockedList[unlockedList.length - 1] : null;

            return {
                milestones,
                totalUnlocked: unlockedList.length,
                totalCount: milestones.length,
                latestUnlocked,
            };
        } catch (error) {
            console.error('[MilestoneService] Error getting user milestones:', error);
            return {
                milestones: [],
                totalUnlocked: 0,
                totalCount: MILESTONE_DEFINITIONS.length,
                latestUnlocked: null,
            };
        }
    },

    /**
     * Check for any newly earned milestones and post a notification to the Notification Page
     */
    async checkAndAwardMilestones(userId: string): Promise<Milestone[]> {
        try {
            const { milestones } = await this.getUserMilestones(userId);
            const newlyUnlocked: Milestone[] = [];

            // Get existing milestone notifications to prevent duplicate inserts
            const { data: existingNotifs } = await supabase
                .from('notifications')
                .select('title')
                .eq('user_id', userId)
                .eq('type', 'leaderboard');

            const existingTitles = new Set(existingNotifs?.map(n => n.title) || []);

            for (const m of milestones) {
                if (m.isUnlocked) {
                    const expectedTitle = `🏆 Milestone Unlocked: ${m.title}`;
                    if (!existingTitles.has(expectedTitle)) {
                        // Award notification
                        const { error } = await supabase.from('notifications').insert({
                            user_id: userId,
                            type: 'leaderboard',
                            title: expectedTitle,
                            message: `Congratulations! You have reached the milestone: ${m.description}. Keep up the stellar performance!`,
                            is_read: false,
                        });

                        if (!error) {
                            newlyUnlocked.push(m);
                        }
                    }
                }
            }

            return newlyUnlocked;
        } catch (error) {
            console.error('[MilestoneService] Error checking and awarding milestones:', error);
            return [];
        }
    },
};
