import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Switch, Alert, ActivityIndicator, StatusBar } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { ChevronLeft, RotateCcw, AlertTriangle, ShieldCheck, HelpCircle } from 'lucide-react-native';
import { supabase } from '../lib/supabase';
import { BatchService } from '../services/batchService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';

export const DriverDetailScreen = ({ navigation, route }: any) => {
    const { userId } = route.params;
    const { t } = useTranslation();
    const { colors, theme } = useTheme();

    const [loading, setLoading] = useState(true);
    const [driverProfile, setDriverProfile] = useState<any>(null);
    const [batchProgress, setBatchProgress] = useState<any[]>([]);
    const [selectedBatch, setSelectedBatch] = useState<number>(1);
    const [batchQuestions, setBatchQuestions] = useState<any[]>([]);
    const [progressList, setProgressList] = useState<any[]>([]);
    const [actionLoading, setActionLoading] = useState(false);

    useEffect(() => {
        loadDriverData();
    }, [userId]);

    useEffect(() => {
        if (driverProfile) {
            loadBatchQuestionProgress();
        }
    }, [driverProfile, selectedBatch]);

    const loadDriverData = async () => {
        try {
            setLoading(true);
            const { data: profile, error } = await supabase
                .from('profiles')
                .select('*')
                .eq('id', userId)
                .single();

            if (error) throw error;
            setDriverProfile(profile);

            // Fetch batch attempt summaries
            const batchNumbers = [1, 2, 3, 4, 5, 6, 7, 8];
            const scoreResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAverageScore(userId, i)));
            const attemptResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAttempts(userId, i)));
            
            // Query DB question progress to count completed per batch
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('batch_number')
                .eq('user_id', userId);

            const completedCounts = new Array(9).fill(0);
            if (qProgress) {
                qProgress.forEach(p => {
                    completedCounts[p.batch_number] = (completedCounts[p.batch_number] || 0) + 1;
                });
            }

            const summaries = batchNumbers.map((batchNum, index) => {
                const isPassed = scoreResults[index] >= 70 || batchNum < profile.current_batch;
                const resets = (profile.consecutive_resets && profile.consecutive_resets[String(batchNum)]) || 0;

                return {
                    batchNumber: batchNum,
                    averageScore: scoreResults[index],
                    attemptCount: attemptResults[index].length,
                    passed: isPassed,
                    completedCount: isPassed ? 30 : (completedCounts[batchNum] || 0),
                    resets
                };
            });

            setBatchProgress(summaries);

        } catch (error: any) {
            Alert.alert(t('common.error'), error.message || 'Failed to load driver details');
            navigation.goBack();
        } finally {
            setLoading(false);
        }
    };

    const loadBatchQuestionProgress = async () => {
        try {
            // Load all questions for this batch & driver category to get text
            let query = supabase
                .from('questions')
                .select('id, text, text_ms')
                .eq('batch_number', selectedBatch);

            let vType = driverProfile?.vehicle_type;
            const validTypes = ['Box Van', 'Container Haulage', 'General Cargo'];
            if (vType && !validTypes.includes(vType)) vType = 'General Cargo';

            if (vType) {
                query = query.contains('driver_categories', [vType]);
            }

            const { data: questions } = await query;
            const qList = questions || [];
            setBatchQuestions(qList);

            // Load progress rows from DB
            const { data: progress } = await supabase
                .from('user_question_progress')
                .select('*')
                .eq('user_id', userId)
                .eq('batch_number', selectedBatch);

            setProgressList(progress || []);
        } catch (error) {
            console.error('Error loading question progress details:', error);
        }
    };

    const handleToggleDailyLimit = async (value: boolean) => {
        try {
            setActionLoading(true);
            const success = await BatchService.updateOverrides(userId, value, driverProfile.batch_lock_override);
            if (success) {
                setDriverProfile((prev: any) => ({ ...prev, daily_limit_override: value }));
            } else {
                throw new Error('Failed to update toggle');
            }
        } catch (error: any) {
            Alert.alert('Error', error.message || 'Failed to toggle override');
        } finally {
            setActionLoading(false);
        }
    };

    const handleToggleBatchLock = async (value: boolean) => {
        try {
            setActionLoading(true);
            const success = await BatchService.updateOverrides(userId, driverProfile.daily_limit_override, value);
            if (success) {
                setDriverProfile((prev: any) => ({ ...prev, batch_lock_override: value }));
            } else {
                throw new Error('Failed to update toggle');
            }
        } catch (error: any) {
            Alert.alert('Error', error.message || 'Failed to toggle override');
        } finally {
            setActionLoading(false);
        }
    };

    const handleResetQuestion = (questionId: string, text: string) => {
        Alert.alert(
            'Reset MCQ',
            `Are you sure you want to reset this question for this driver?\n\n"${text.substring(0, 60)}..."`,
            [
                { text: 'Cancel', style: 'cancel' },
                {
                    text: 'Reset',
                    style: 'destructive',
                    onPress: async () => {
                        try {
                            setActionLoading(true);
                            const success = await BatchService.resetIndividualQuestion(userId, questionId);
                            if (success) {
                                Alert.alert('Success', 'Question reset successfully');
                                loadDriverData();
                            } else {
                                throw new Error('Reset failed');
                            }
                        } catch (error: any) {
                            Alert.alert('Error', error.message || 'Failed to reset question');
                        } finally {
                            setActionLoading(false);
                        }
                    }
                }
            ]
        );
    };

    const handleResetBatch = (batchNumber: number, passed: boolean) => {
        const resetAction = async () => {
            try {
                setActionLoading(true);
                const success = await BatchService.resetEntireBatch(userId, batchNumber);
                if (success) {
                    Alert.alert('Success', `Batch ${batchNumber} has been reset.`);
                    loadDriverData();
                } else {
                    throw new Error('Reset failed');
                }
            } catch (error: any) {
                Alert.alert('Error', error.message || 'Failed to reset batch');
            } finally {
                setActionLoading(false);
            }
        };

        if (passed) {
            Alert.alert(
                'Warning',
                `Batch ${batchNumber} has been passed. Resetting will remove the score and the driver must retake it. Are you sure?`,
                [
                    { text: 'Cancel', style: 'cancel' },
                    { text: 'Reset Entire Batch', style: 'destructive', onPress: resetAction }
                ]
            );
        } else {
            Alert.alert(
                'Confirm Reset',
                `Are you sure you want to reset Batch ${batchNumber}? All current answers will be removed.`,
                [
                    { text: 'Cancel', style: 'cancel' },
                    { text: 'Reset', style: 'destructive', onPress: resetAction }
                ]
            );
        }
    };

    const handleResetAll = () => {
        Alert.alert(
            'DANGER: Reset All',
            'This will delete ALL quiz scores, batch progress, and individual question progress for this driver. They will start over from Batch 1.\n\nThis cannot be undone. Proceed?',
            [
                { text: 'Cancel', style: 'cancel' },
                {
                    text: 'Reset All Progress',
                    style: 'destructive',
                    onPress: async () => {
                        try {
                            setActionLoading(true);
                            const success = await BatchService.resetAllBatches(userId);
                            if (success) {
                                Alert.alert('Success', 'Driver progress fully reset.');
                                loadDriverData();
                            } else {
                                throw new Error('Reset failed');
                            }
                        } catch (error: any) {
                            Alert.alert('Error', error.message || 'Failed to reset all progress');
                        } finally {
                            setActionLoading(false);
                        }
                    }
                }
            ]
        );
    };

    const selectedSummary = useMemo(() => {
        return batchProgress.find(b => b.batchNumber === selectedBatch);
    }, [batchProgress, selectedBatch]);

    const activeQuestionProgress = useMemo(() => {
        return batchQuestions.map(q => {
            const prog = progressList.find(p => p.question_id === q.id);
            return {
                ...q,
                answered: !!prog,
                attempts: prog?.attempts || 0,
                isCorrect: prog?.is_correct || false,
                score: prog?.score || 0.0
            };
        });
    }, [batchQuestions, progressList]);

    if (loading) {
        return (
            <GradientBackground>
                <SafeAreaView style={styles.loadingContainer}>
                    <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
                </SafeAreaView>
            </GradientBackground>
        );
    }

    return (
        <GradientBackground>
            <SafeAreaView style={styles.safeArea}>
                <StatusBar barStyle="light-content" />
                <View style={styles.header}>
                    <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
                        <ChevronLeft color={colors.text.primary} size={24} />
                    </TouchableOpacity>
                    <Text style={styles.headerTitle}>{driverProfile?.full_name}</Text>
                    <View style={{ width: 24 }} />
                </View>

                {actionLoading && (
                    <View style={styles.actionLoader}>
                        <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
                    </View>
                )}

                <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
                    {/* Driver Profile Summary */}
                    <GlassCard style={styles.overviewCard}>
                        <Text style={styles.cardTitle}>{t('profile.details')}</Text>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>Employee ID:</Text>
                            <Text style={styles.profileVal}>{driverProfile?.employee_id}</Text>
                        </View>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>Transport Category:</Text>
                            <Text style={styles.profileVal}>{driverProfile?.vehicle_type || 'General Cargo'}</Text>
                        </View>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>Current Batch:</Text>
                            <Text style={styles.profileVal}>Batch {driverProfile?.current_batch}</Text>
                        </View>
                    </GlassCard>

                    {/* Overrides Card */}
                    <GlassCard style={styles.card}>
                        <Text style={styles.cardTitle}>Master User Overrides</Text>
                        
                        <View style={styles.overrideRow}>
                            <View style={styles.overrideTextContainer}>
                                <Text style={styles.overrideLabel}>Waive Daily Limit</Text>
                                <Text style={styles.overrideDesc}>Allow driver to answer all 30 questions in one day</Text>
                            </View>
                            <Switch
                                value={driverProfile?.daily_limit_override}
                                onValueChange={handleToggleDailyLimit}
                                trackColor={{ false: '#767577', true: colors.primary.DEFAULT }}
                                thumbColor={driverProfile?.daily_limit_override ? '#FFF' : '#f4f3f4'}
                            />
                        </View>

                        <View style={[styles.overrideRow, { borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.05)', paddingTop: 12, marginTop: 12 }]}>
                            <View style={styles.overrideTextContainer}>
                                <Text style={styles.overrideLabel}>Unlock All Batches</Text>
                                <Text style={styles.overrideDesc}>Allow driver to access any batch out of sequence</Text>
                            </View>
                            <Switch
                                value={driverProfile?.batch_lock_override}
                                onValueChange={handleToggleBatchLock}
                                trackColor={{ false: '#767577', true: colors.primary.DEFAULT }}
                                thumbColor={driverProfile?.batch_lock_override ? '#FFF' : '#f4f3f4'}
                            />
                        </View>
                    </GlassCard>

                    {/* Batch Selection Slider */}
                    <View style={{ marginVertical: 8 }}>
                        <Text style={styles.sectionLabel}>Batch Management</Text>
                        <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.batchScroller}>
                            {batchProgress.map(b => (
                                <TouchableOpacity
                                    key={b.batchNumber}
                                    style={[
                                        styles.batchTab,
                                        selectedBatch === b.batchNumber && styles.batchTabActive,
                                        b.passed && { borderColor: '#00C853' }
                                    ]}
                                    onPress={() => setSelectedBatch(b.batchNumber)}
                                >
                                    <Text style={[
                                        styles.batchTabText,
                                        selectedBatch === b.batchNumber && styles.batchTabTextActive,
                                        b.passed && { color: '#00C853' }
                                    ]}>
                                        Batch {b.batchNumber}
                                    </Text>
                                    {b.passed && <Text style={{ fontSize: 9 }}>✓</Text>}
                                </TouchableOpacity>
                            ))}
                        </ScrollView>
                    </View>

                    {/* Selected Batch Details */}
                    {selectedSummary && (
                        <GlassCard style={styles.card}>
                            <View style={styles.batchSummaryHeader}>
                                <Text style={styles.cardTitle}>Batch {selectedBatch} Summary</Text>
                                <TouchableOpacity 
                                    onPress={() => handleResetBatch(selectedBatch, selectedSummary.passed)}
                                    style={styles.resetBatchButton}
                                >
                                    <RotateCcw size={14} color="#FFF" />
                                    <Text style={styles.resetBatchText}>Reset Batch</Text>
                                </TouchableOpacity>
                            </View>

                            <View style={styles.statsGrid}>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>Progress</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.completedCount}/30</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>Average Score</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.averageScore.toFixed(1)}%</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>Attempts</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.attemptCount}</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>Auto-Resets</Text>
                                    <Text style={[styles.statBoxVal, selectedSummary.resets >= 3 && { color: '#FF3D00' }]}>
                                        {selectedSummary.resets}
                                    </Text>
                                </View>
                            </View>
                        </GlassCard>
                    )}

                    {/* Question Reset List */}
                    <Text style={styles.sectionLabel}>Answered Questions ({progressList.length})</Text>
                    
                    {activeQuestionProgress.filter(q => q.answered).length === 0 ? (
                        <Text style={styles.emptyText}>No answered questions recorded in this batch.</Text>
                    ) : (
                        activeQuestionProgress.filter(q => q.answered).map((q, idx) => (
                            <GlassCard key={q.id} style={styles.questionProgressCard}>
                                <View style={styles.qHeader}>
                                    <Text style={styles.qIndex}>Question #{idx + 1}</Text>
                                    <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12 }}>
                                        <View style={[styles.badge, q.isCorrect ? styles.badgeCorrect : styles.badgeIncorrect]}>
                                            <Text style={q.isCorrect ? styles.badgeTextCorrect : styles.badgeTextIncorrect}>
                                                {q.isCorrect ? `Correct (${q.score} pts)` : 'Incorrect'}
                                            </Text>
                                        </View>
                                        <TouchableOpacity 
                                            onPress={() => handleResetQuestion(q.id, q.text)}
                                            style={styles.trashBtn}
                                        >
                                            <RotateCcw size={16} color="#FF6B6B" />
                                        </TouchableOpacity>
                                    </View>
                                </View>
                                <Text style={styles.qText}>{q.text}</Text>
                                <Text style={styles.qAttempts}>Attempts: {q.attempts}/2</Text>
                            </GlassCard>
                        ))
                    )}

                    {/* Revert / Nuclear Option */}
                    <TouchableOpacity 
                        onPress={handleResetAll}
                        style={styles.nuclearBtn}
                    >
                        <AlertTriangle size={18} color="#FFF" />
                        <Text style={styles.nuclearBtnText}>Reset Driver Entire Profile</Text>
                    </TouchableOpacity>
                </ScrollView>
            </SafeAreaView>
        </GradientBackground>
    );
};

const styles = StyleSheet.create({
    safeArea: {
        flex: 1,
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        paddingHorizontal: 16,
        paddingVertical: 14,
        borderBottomWidth: 1,
        borderBottomColor: 'rgba(0,0,0,0.05)',
    },
    backButton: {
        padding: 4,
    },
    headerTitle: {
        fontSize: 18,
        fontFamily: typography.fonts.bold,
        color: '#1A1A1A',
    },
    content: {
        padding: 16,
        gap: 16,
        paddingBottom: 40,
    },
    overviewCard: {
        padding: 16,
        backgroundColor: 'rgba(255,255,255,0.7)',
    },
    card: {
        padding: 16,
    },
    cardTitle: {
        fontSize: 15,
        fontFamily: typography.fonts.bold,
        color: '#1A1A1A',
        marginBottom: 12,
    },
    profileRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingVertical: 6,
    },
    profileLabel: {
        fontSize: 14,
        fontFamily: typography.fonts.medium,
        color: '#666',
    },
    profileVal: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: '#1A1A1A',
    },
    overrideRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    overrideTextContainer: {
        flex: 1,
        paddingRight: 16,
    },
    overrideLabel: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: '#1A1A1A',
    },
    overrideDesc: {
        fontSize: 11,
        fontFamily: typography.fonts.regular,
        color: '#888',
        marginTop: 2,
    },
    sectionLabel: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: '#666',
        textTransform: 'uppercase',
        letterSpacing: 0.5,
        marginVertical: 8,
    },
    batchScroller: {
        gap: 8,
        paddingRight: 16,
    },
    batchTab: {
        paddingHorizontal: 16,
        paddingVertical: 8,
        borderRadius: 20,
        backgroundColor: '#FFF',
        borderWidth: 1.5,
        borderColor: '#E2E8F0',
        flexDirection: 'row',
        alignItems: 'center',
        gap: 6,
    },
    batchTabActive: {
        backgroundColor: '#1E293B',
        borderColor: '#1E293B',
    },
    batchTabText: {
        fontSize: 13,
        fontFamily: typography.fonts.bold,
        color: '#475569',
    },
    batchTabTextActive: {
        color: '#FFF',
    },
    batchSummaryHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 16,
    },
    resetBatchButton: {
        flexDirection: 'row',
        alignItems: 'center',
        backgroundColor: '#FF6B6B',
        paddingHorizontal: 10,
        paddingVertical: 6,
        borderRadius: 8,
        gap: 4,
    },
    resetBatchText: {
        color: '#FFF',
        fontSize: 12,
        fontFamily: typography.fonts.bold,
    },
    statsGrid: {
        flexDirection: 'row',
        flexWrap: 'wrap',
        gap: 8,
    },
    statBox: {
        flex: 1,
        minWidth: '45%',
        backgroundColor: 'rgba(0,0,0,0.03)',
        borderRadius: 8,
        padding: 10,
    },
    statBoxLabel: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: '#888',
        marginBottom: 4,
    },
    statBoxVal: {
        fontSize: 15,
        fontFamily: typography.fonts.bold,
        color: '#1A1A1A',
    },
    questionProgressCard: {
        padding: 14,
        marginBottom: 8,
    },
    qHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 8,
    },
    qIndex: {
        fontSize: 12,
        fontFamily: typography.fonts.bold,
        color: '#888',
    },
    qText: {
        fontSize: 14,
        fontFamily: typography.fonts.medium,
        color: '#1A1A1A',
        lineHeight: 20,
    },
    qAttempts: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: '#888',
        marginTop: 6,
    },
    badge: {
        paddingHorizontal: 8,
        paddingVertical: 3,
        borderRadius: 6,
    },
    badgeCorrect: {
        backgroundColor: 'rgba(0, 200, 83, 0.1)',
    },
    badgeIncorrect: {
        backgroundColor: 'rgba(255, 61, 0, 0.1)',
    },
    badgeTextCorrect: {
        color: '#00C853',
        fontSize: 11,
        fontFamily: typography.fonts.bold,
    },
    badgeTextIncorrect: {
        color: '#FF3D00',
        fontSize: 11,
        fontFamily: typography.fonts.bold,
    },
    trashBtn: {
        padding: 4,
    },
    nuclearBtn: {
        flexDirection: 'row',
        backgroundColor: '#FF3D00',
        borderRadius: 12,
        paddingVertical: 14,
        justifyContent: 'center',
        alignItems: 'center',
        gap: 8,
        marginTop: 20,
    },
    nuclearBtnText: {
        color: '#FFF',
        fontSize: 15,
        fontFamily: typography.fonts.bold,
    },
    emptyText: {
        fontSize: 13,
        fontFamily: typography.fonts.medium,
        color: '#888',
        textAlign: 'center',
        marginVertical: 12,
    },
    actionLoader: {
        position: 'absolute',
        top: 20,
        right: 20,
        zIndex: 99,
        backgroundColor: 'rgba(255,255,255,0.9)',
        borderRadius: 50,
        padding: 6,
        shadowColor: '#000',
        shadowOpacity: 0.1,
        shadowRadius: 4,
        elevation: 2,
    }
});
