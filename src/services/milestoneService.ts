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
        id: 'vol_25',
        category: 'volume' as const,
        title: 'First Steps',
        description: 'Completed 25 MCQs in SafePass',
        threshold: 25,
        icon: 'book-open',
        color: '#3B82F6',
    },
    {
        id: 'vol_50',
        category: 'volume' as const,
        title: 'Halfway There',
        description: 'Completed 50 MCQs in SafePass',
        threshold: 50,
        icon: 'award',
        color: '#8B5CF6',
    },
    {
        id: 'vol_100',
        category: 'volume' as const,
        title: 'Safety Scholar',
        description: 'Completed 100 MCQs in SafePass',
        threshold: 100,
        icon: 'shield',
        color: '#EC4899',
    },
    {
        id: 'vol_200',
        category: 'volume' as const,
        title: 'Program Graduate',
        description: 'Completed 200 MCQs across all batches',
        threshold: 200,
        icon: 'crown',
        color: '#F59E0B',
    },

    // 2. Training Batches Completed
    {
        id: 'batch_1',
        category: 'mastery' as const,
        title: 'First Batch Completed',
        description: 'Completed your first training batch',
        threshold: 1,
        icon: 'check-circle',
        color: '#10B981',
    },
    {
        id: 'batch_4',
        category: 'mastery' as const,
        title: 'Halfway Checkpoint (4 Batches)',
        description: 'Completed 4 training batches',
        threshold: 4,
        icon: 'zap',
        color: '#06B6D4',
    },
    {
        id: 'batch_8',
        category: 'mastery' as const,
        title: 'All Batches Mastered (8 Batches)',
        description: 'Completed all 8 training batches',
        threshold: 8,
        icon: 'star',
        color: '#F59E0B',
    },

    // 3. Habit / Active Days Milestones
    {
        id: 'hab_7',
        category: 'habit' as const,
        title: 'First Week Streak',
        description: 'Maintained 7 active learning days / streak',
        threshold: 7,
        icon: 'flame',
        color: '#EF4444',
    },
    {
        id: 'hab_14',
        category: 'habit' as const,
        title: 'Consistent Learner',
        description: 'Maintained 14 active learning days / streak',
        threshold: 14,
        icon: 'shield-check',
        color: '#F97316',
    },
    {
        id: 'hab_30',
        category: 'habit' as const,
        title: 'Monthly Habit',
        description: 'Maintained 30 active learning days / streak',
        threshold: 30,
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
                .select('streak, total_batches_completed')
                .eq('id', userId)
                .single();

            const streak = profile?.streak || 0;

            // Fetch Overall Score
            const csiData = await BatchService.getCumulativeSafetyIndex(userId);
            const csiScore = csiData.score;

            // Count unique completed batches
            const { data: batchData } = await supabase
                .from('user_batch_progress')
                .select('batch_number, completion_percentage, is_completed')
                .eq('user_id', userId);

            const completedSet = new Set<number>();
            (batchData || []).forEach((b: any) => {
                if (b.is_completed || (b.completion_percentage && b.completion_percentage >= 100)) {
                    completedSet.add(b.batch_number);
                }
            });
            const completedBatchesCount = Math.max(completedSet.size, csiData.passedBatchesCount || 0, profile?.total_batches_completed || 0);

            // Fetch milestone notifications already awarded
            const { data: awardedNotifs } = await supabase
                .from('notifications')
                .select('title, created_at')
                .eq('user_id', userId)
                .eq('type', 'leaderboard');

            const milestones: Milestone[] = MILESTONE_DEFINITIONS.map(def => {
                let currentValue = 0;
                let isUnlocked = false;

                if (def.category === 'volume') {
                    currentValue = totalMCQs;
                    isUnlocked = totalMCQs >= def.threshold;
                } else if (def.category === 'mastery') {
                    currentValue = completedBatchesCount;
                    isUnlocked = completedBatchesCount >= def.threshold;
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
