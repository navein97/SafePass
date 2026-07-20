import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { ChevronLeft, RotateCcw, AlertTriangle } from 'lucide-react-native';
import { supabase } from '../lib/supabase';
import { BatchService } from '../services/batchService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { PracticeService } from '../services/practiceService';

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

    const styles = useMemo(() => createStyles(colors, theme), [colors, theme]);

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
            const validTypes = await PracticeService.getVehicleTypes();
            if (vType && !validTypes.includes(vType)) {
                vType = validTypes.includes('General Cargo') ? 'General Cargo' : (validTypes[0] || 'General Cargo');
            }

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

    const handleResetBatch = (batchNumber: number, passed: boolean) => {
        const resetAction = async () => {
            try {
                setActionLoading(true);
                const success = await BatchService.resetEntireBatch(userId, batchNumber);
                if (success) {
                    if (Platform.OS === 'web') {
                        window.alert(`Success: Batch ${batchNumber} has been reset.`);
                    } else {
                        Alert.alert('Success', `Batch ${batchNumber} has been reset.`);
                    }
                    loadDriverData();
                } else {
                    throw new Error('Reset failed');
                }
            } catch (error: any) {
                if (Platform.OS === 'web') {
                    window.alert(error.message || 'Failed to reset batch');
                } else {
                    Alert.alert('Error', error.message || 'Failed to reset batch');
                }
            } finally {
                setActionLoading(false);
            }
        };

        const msg = passed 
            ? `Batch ${batchNumber} has been passed. Resetting will remove the score and the driver must retake it. Are you sure?`
            : `Are you sure you want to reset Batch ${batchNumber}? All current answers will be removed.`;

        if (Platform.OS === 'web') {
            if (window.confirm(msg)) {
                resetAction();
            }
        } else {
            Alert.alert(
                passed ? 'Warning' : 'Confirm Reset',
                msg,
                [
                    { text: 'Cancel', style: 'cancel' },
                    { text: 'Reset', style: 'destructive', onPress: resetAction }
                ]
            );
        }
    };

    const selectedSummary = useMemo(() => {
        return batchProgress.find(b => b.batchNumber === selectedBatch);
    }, [batchProgress, selectedBatch]);

    // Only show incorrect answered questions
    const incorrectQuestions = useMemo(() => {
        return batchQuestions
            .map(q => {
                const prog = progressList.find(p => p.question_id === q.id);
                return {
                    ...q,
                    answered: !!prog,
                    attempts: prog?.attempts || 0,
                    isCorrect: prog?.is_correct || false,
                    score: prog?.score || 0.0
                };
            })
            .filter(q => q.answered && !q.isCorrect);
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
                <StatusBar barStyle={theme === 'dark' ? 'light-content' : 'dark-content'} />
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
                                        b.passed && selectedBatch !== b.batchNumber && { color: '#00C853' }
                                    ]}>
                                        Batch {b.batchNumber}
                                    </Text>
                                    {b.passed && <Text style={{ fontSize: 9, color: selectedBatch === b.batchNumber ? '#FFF' : '#00C853' }}>✓</Text>}
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

                    {/* Incorrect Questions List (Read-only) */}
                    <Text style={styles.sectionLabel}>
                        Incorrect Questions ({incorrectQuestions.length})
                    </Text>

                    {incorrectQuestions.length === 0 ? (
                        <GlassCard style={styles.emptyCard}>
                            <Text style={styles.emptyText}>
                                {progressList.length === 0
                                    ? 'No questions answered in this batch yet.'
                                    : '✅ No incorrect questions — great performance!'}
                            </Text>
                        </GlassCard>
                    ) : (
                        incorrectQuestions.map((q, idx) => (
                            <GlassCard key={q.id} style={styles.questionProgressCard}>
                                <View style={styles.qHeader}>
                                    <Text style={styles.qIndex}>Question #{idx + 1}</Text>
                                    <View style={styles.badgeIncorrect}>
                                        <Text style={styles.badgeTextIncorrect}>Incorrect</Text>
                                    </View>
                                </View>
                                <Text style={styles.qText}>{q.text}</Text>
                                <Text style={styles.qAttempts}>Attempts: {q.attempts}/2</Text>
                            </GlassCard>
                        ))
                    )}

                </ScrollView>
            </SafeAreaView>
        </GradientBackground>
    );
};

const createStyles = (colors: any, theme: string) => StyleSheet.create({
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
        borderBottomColor: colors.border,
    },
    backButton: {
        padding: 4,
    },
    headerTitle: {
        fontSize: 18,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    content: {
        padding: 16,
        gap: 16,
        paddingBottom: 40,
    },
    overviewCard: {
        padding: 16,
    },
    card: {
        padding: 16,
    },
    cardTitle: {
        fontSize: 15,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
        marginBottom: 12,
    },
    profileRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingVertical: 6,
        borderBottomWidth: StyleSheet.hairlineWidth,
        borderBottomColor: colors.border,
    },
    profileLabel: {
        fontSize: 14,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
    },
    profileVal: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    sectionLabel: {
        fontSize: 12,
        fontFamily: typography.fonts.bold,
        color: colors.text.secondary,
        textTransform: 'uppercase',
        letterSpacing: 0.8,
        marginVertical: 4,
    },
    batchScroller: {
        gap: 8,
        paddingRight: 16,
        paddingVertical: 8,
    },
    batchTab: {
        paddingHorizontal: 16,
        paddingVertical: 8,
        borderRadius: 20,
        backgroundColor: theme === 'dark' ? colors.background.subtle : '#FFFFFF',
        borderWidth: 1.5,
        borderColor: colors.border,
        flexDirection: 'row',
        alignItems: 'center',
        gap: 4,
    },
    batchTabActive: {
        backgroundColor: '#1E293B',
        borderColor: '#1E293B',
    },
    batchTabText: {
        fontSize: 13,
        fontFamily: typography.fonts.bold,
        color: colors.text.secondary,
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
        backgroundColor: theme === 'dark' ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.04)',
        borderRadius: 10,
        padding: 12,
    },
    statBoxLabel: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
        marginBottom: 4,
        textTransform: 'uppercase',
        letterSpacing: 0.3,
    },
    statBoxVal: {
        fontSize: 18,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
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
        color: colors.text.secondary,
    },
    qText: {
        fontSize: 14,
        fontFamily: typography.fonts.medium,
        color: colors.text.primary,
        lineHeight: 20,
    },
    qAttempts: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: colors.text.tertiary,
        marginTop: 6,
    },
    badgeIncorrect: {
        paddingHorizontal: 8,
        paddingVertical: 3,
        borderRadius: 6,
        backgroundColor: 'rgba(255, 61, 0, 0.12)',
    },
    badgeTextIncorrect: {
        color: '#FF3D00',
        fontSize: 11,
        fontFamily: typography.fonts.bold,
    },
    emptyCard: {
        padding: 20,
        alignItems: 'center',
    },
    emptyText: {
        fontSize: 13,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
        textAlign: 'center',
    },
    nuclearBtn: {
        flexDirection: 'row',
        backgroundColor: '#FF3D00',
        borderRadius: 12,
        paddingVertical: 14,
        justifyContent: 'center',
        alignItems: 'center',
        gap: 8,
        marginTop: 12,
    },
    nuclearBtnText: {
        color: '#FFF',
        fontSize: 15,
        fontFamily: typography.fonts.bold,
    },
    actionLoader: {
        position: 'absolute',
        top: 20,
        right: 20,
        zIndex: 99,
        backgroundColor: theme === 'dark' ? 'rgba(20,20,20,0.9)' : 'rgba(255,255,255,0.9)',
        borderRadius: 50,
        padding: 6,
        shadowColor: '#000',
        shadowOpacity: 0.1,
        shadowRadius: 4,
        elevation: 2,
    }
});
