import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { ChevronLeft, ChevronRight, RotateCcw, AlertTriangle, UserX, Download } from 'lucide-react-native';
import { supabase } from '../lib/supabase';
import { BatchService } from '../services/batchService';
import { QuizService } from '../services/quizService';
import { ExcelExportService } from '../services/excelExportService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { PerformanceChart } from '../components/PerformanceChart';
import { PracticeService } from '../services/practiceService';
import { LinearGradient } from 'expo-linear-gradient';

export const DriverDetailScreen = ({ navigation, route }: any) => {
    const { userId } = route.params;
    const { t } = useTranslation();
    const { colors, theme } = useTheme();

    const [loading, setLoading] = useState(true);
    const [driverProfile, setDriverProfile] = useState<any>(null);
    const [csiData, setCsiData] = useState<any>(null);
    const [dailyTrends, setDailyTrends] = useState<{ value: number; label: string }[]>([]);
    const [totalQuestionsAnswered, setTotalQuestionsAnswered] = useState<number>(0);
    const [totalMCQsCount, setTotalMCQsCount] = useState<number>(240);
    const [exporting, setExporting] = useState<boolean>(false);
    const [batchProgress, setBatchProgress] = useState<any[]>([]);
    const [selectedBatch, setSelectedBatch] = useState<number>(1);
    const [batchQuestions, setBatchQuestions] = useState<any[]>([]);
    const [progressList, setProgressList] = useState<any[]>([]);
    const [actionLoading, setActionLoading] = useState(false);
    const [incorrectPage, setIncorrectPage] = useState<number>(1);

    const styles = useMemo(() => createStyles(colors, theme), [colors, theme]);

    useEffect(() => {
        loadDriverData();
    }, [userId]);

    useEffect(() => {
        if (driverProfile) {
            loadBatchQuestionProgress();
        }
    }, [driverProfile, selectedBatch]);

    useEffect(() => {
        setIncorrectPage(1);
    }, [selectedBatch, userId]);

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

            // Fetch dynamic batch numbers, CSI, trends, and answered MCQs in parallel
            const batchNumbers = await BatchService.getAvailableBatchNumbers();
            const [csi, trends, totalAnswered, batchTotals] = await Promise.all([
                BatchService.getCumulativeSafetyIndex(userId),
                QuizService.getDailyTrends(userId),
                BatchService.getTotalAnsweredQuestions(userId),
                Promise.all(batchNumbers.map(b => BatchService.getBatchTotalQuestions(b, userId))),
            ]);

            setCsiData(csi);
            setDailyTrends(trends);
            setTotalQuestionsAnswered(totalAnswered);

            const totalAllBatches = batchTotals.reduce((sum, count) => sum + count, 0);
            setTotalMCQsCount(totalAllBatches > 0 ? totalAllBatches : 240);

            const scoreResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAverageScore(userId, i)));
            const attemptResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAttempts(userId, i)));
            const totalQuestionsResults = batchTotals;

            // Query DB question progress to count completed per batch
            const { data: qProgress } = await supabase
                .from('user_question_progress')
                .select('batch_number')
                .eq('user_id', userId);

            const completedCounts: Record<number, number> = {};
            if (qProgress) {
                qProgress.forEach(p => {
                    completedCounts[p.batch_number] = (completedCounts[p.batch_number] || 0) + 1;
                });
            }

            const summaries = batchNumbers.map((batchNum, index) => {
                const score = scoreResults[index];
                const totalQ = totalQuestionsResults[index] || 30;
                const isPassed = score >= 60 || batchNum < profile.current_batch;
                const resets = (profile.consecutive_resets && profile.consecutive_resets[String(batchNum)]) || 0;

                return {
                    batchNumber: batchNum,
                    averageScore: score,
                    attemptCount: attemptResults[index].length,
                    passed: isPassed,
                    completedCount: isPassed ? totalQ : (completedCounts[batchNum] || 0),
                    totalQuestions: totalQ,
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

    const handleExportDriverExcel = async () => {
        try {
            setExporting(true);
            const { success, message } = await ExcelExportService.exportSingleDriver({
                profile: driverProfile,
                csiData,
                batchProgress,
                incorrectQuestions
            });

            if (!success && message) {
                if (Platform.OS === 'web') {
                    window.alert(message);
                } else {
                    Alert.alert(t('common.error'), message);
                }
            }
        } catch (error: any) {
            console.error('Error exporting driver data:', error);
            const errMsg = error?.message || 'Failed to export report';
            if (Platform.OS === 'web') {
                window.alert(errMsg);
            } else {
                Alert.alert(t('common.error'), errMsg);
            }
        } finally {
            setExporting(false);
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

    const handleDeactivateDriver = () => {
        const deactivateAction = async () => {
            try {
                setActionLoading(true);
                
                // Use RPC to bypass RLS and securely deactivate
                const { error } = await supabase.rpc('deactivate_user', {
                    target_user_id: userId
                });

                if (error) throw error;

                const successMsg = t('user.driverDeactivatedSuccess', 'Driver account deactivated successfully.');
                if (Platform.OS === 'web') {
                    window.alert(successMsg);
                } else {
                    Alert.alert(t('common.success', 'Success'), successMsg);
                }
                navigation.goBack();
            } catch (error: any) {
                const errorMsg = error.message || t('user.errorDeactivate', 'Failed to deactivate driver account');
                if (Platform.OS === 'web') {
                    window.alert(errorMsg);
                } else {
                    Alert.alert(t('common.error', 'Error'), errorMsg);
                }
            } finally {
                setActionLoading(false);
            }
        };

        const msg = t('user.deactivateConfirmMessage', {
            name: driverProfile?.full_name || 'this driver',
            defaultValue: `Are you sure you want to deactivate ${driverProfile?.full_name || 'this driver'}? The driver will no longer be able to log in or appear on the team management page.`
        });

        if (Platform.OS === 'web') {
            if (window.confirm(msg)) {
                deactivateAction();
            }
        } else {
            Alert.alert(
                t('user.deactivateConfirmTitle', 'Deactivate Driver Account'),
                msg,
                [
                    { text: t('common.cancel', 'Cancel'), style: 'cancel' },
                    { text: t('user.deactivateDriver', 'Deactivate Driver'), style: 'destructive', onPress: deactivateAction }
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

    const INCORRECT_PER_PAGE = 10;
    const incorrectTotalPages = Math.ceil(incorrectQuestions.length / INCORRECT_PER_PAGE);
    const pagedIncorrectQuestions = incorrectQuestions.slice(
        (incorrectPage - 1) * INCORRECT_PER_PAGE,
        incorrectPage * INCORRECT_PER_PAGE
    );

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
                    <TouchableOpacity
                        onPress={handleExportDriverExcel}
                        style={styles.exportIconButton}
                        disabled={exporting}
                        activeOpacity={0.7}
                    >
                        {exporting ? (
                            <ActivityIndicator size="small" color={colors.primary.DEFAULT} />
                        ) : (
                            <Download size={20} color={colors.text.primary} />
                        )}
                    </TouchableOpacity>
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
                            <Text style={styles.profileLabel}>{t('user.employeeIdLabel', 'Employee ID:')}</Text>
                            <Text style={styles.profileVal}>{driverProfile?.employee_id}</Text>
                        </View>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>{t('user.transportCategory', 'Transport Category:')}</Text>
                            <Text style={styles.profileVal}>{driverProfile?.vehicle_type || 'General Cargo'}</Text>
                        </View>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>{t('user.currentBatch', 'Current Batch:')}</Text>
                            <Text style={styles.profileVal}>{t('quiz.batchTitle', { number: driverProfile?.current_batch })}</Text>
                        </View>
                        <View style={styles.profileRow}>
                            <Text style={styles.profileLabel}>Overall Score:</Text>
                            <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }}>
                                <Text style={[styles.profileVal, { color: csiData?.rankColor || csiData?.bandColor || colors.primary.DEFAULT }]}>
                                    {csiData?.score || 0}%
                                </Text>
                                <View style={[styles.bandBadge, { backgroundColor: (csiData?.rankColor || csiData?.bandColor || '#3B82F6') + '20', borderColor: csiData?.rankColor || csiData?.bandColor || '#3B82F6' }]}>
                                    <Text style={[styles.bandBadgeText, { color: csiData?.rankColor || csiData?.bandColor || '#3B82F6' }]}>
                                        {csiData?.rank || csiData?.band || 'D Rank'}
                                    </Text>
                                </View>
                            </View>
                        </View>
                    </GlassCard>

                    {/* Performance & Competency Dashboard */}
                    <GlassCard style={styles.dashboardCard}>
                        <View style={styles.dashboardHeader}>
                            <View style={styles.dashboardIconCircle}>
                                <Text style={{ fontSize: 16 }}>📊</Text>
                            </View>
                            <Text style={styles.dashboardTitle}>{t('profile.performanceDashboard', 'Performance Dashboard')}</Text>
                        </View>

                        {/* Score Bars */}
                        <View style={styles.scoreSection}>
                            {/* Professional Conduct */}
                            <View style={styles.scoreRow}>
                                <View style={styles.scoreLabelRow}>
                                    <View style={[styles.scoreDot, { backgroundColor: colors.primary.DEFAULT }]} />
                                    <Text style={styles.scoreLabelText}>{t('profile.profConduct', 'Professional Conduct')}</Text>
                                    <Text style={[styles.scoreValueText, { color: colors.primary.DEFAULT }]}>
                                        {driverProfile?.component_scores?.professionalism || csiData?.componentScores?.professionalism || 0}%
                                    </Text>
                                </View>
                                <View style={styles.scoreBarTrack}>
                                    <LinearGradient
                                        colors={colors.gradients.primary as any}
                                        start={{ x: 0, y: 0 }}
                                        end={{ x: 1, y: 0 }}
                                        style={[
                                            styles.scoreBarFill,
                                            { width: `${Math.min(driverProfile?.component_scores?.professionalism || csiData?.componentScores?.professionalism || 0, 100)}%` }
                                        ]}
                                    />
                                </View>
                            </View>

                            {/* Operational Discipline */}
                            <View style={styles.scoreRow}>
                                <View style={styles.scoreLabelRow}>
                                    <View style={[styles.scoreDot, { backgroundColor: colors.mode === 'light' ? '#E64A19' : '#FF7043' }]} />
                                    <Text style={styles.scoreLabelText}>{t('profile.opDiscipline', 'Operational Discipline')}</Text>
                                    <Text style={[styles.scoreValueText, { color: colors.mode === 'light' ? '#E64A19' : '#FF7043' }]}>
                                        {driverProfile?.component_scores?.discipline || csiData?.componentScores?.discipline || 0}%
                                    </Text>
                                </View>
                                <View style={styles.scoreBarTrack}>
                                    <LinearGradient
                                        colors={colors.mode === 'light' ? ['#FF8A65', '#E64A19'] : ['#FF8A65', '#FF7043'] as any}
                                        start={{ x: 0, y: 0 }}
                                        end={{ x: 1, y: 0 }}
                                        style={[
                                            styles.scoreBarFill,
                                            { width: `${Math.min(driverProfile?.component_scores?.discipline || csiData?.componentScores?.discipline || 0, 100)}%` }
                                        ]}
                                    />
                                </View>
                            </View>

                            {/* Operational Effectiveness */}
                            <View style={styles.scoreRow}>
                                <View style={styles.scoreLabelRow}>
                                    <View style={[styles.scoreDot, { backgroundColor: colors.mode === 'light' ? '#2E7D32' : '#81C784' }]} />
                                    <Text style={styles.scoreLabelText}>{t('profile.opEffectiveness', 'Operational Effectiveness')}</Text>
                                    <Text style={[styles.scoreValueText, { color: colors.mode === 'light' ? '#2E7D32' : '#81C784' }]}>
                                        {driverProfile?.component_scores?.operation || csiData?.componentScores?.operation || 0}%
                                    </Text>
                                </View>
                                <View style={styles.scoreBarTrack}>
                                    <LinearGradient
                                        colors={colors.mode === 'light' ? ['#66BB6A', '#2E7D32'] : ['#81C784', '#4CAF50'] as any}
                                        start={{ x: 0, y: 0 }}
                                        end={{ x: 1, y: 0 }}
                                        style={[
                                            styles.scoreBarFill,
                                            { width: `${Math.min(driverProfile?.component_scores?.operation || csiData?.componentScores?.operation || 0, 100)}%` }
                                        ]}
                                    />
                                </View>
                            </View>
                        </View>

                        {/* MCQ Progress Summary */}
                        <View style={styles.mcqProgressSection}>
                            <Text style={styles.mcqProgressLabel}>
                                {t('profile.totalMcqsCompleted', 'TOTAL MCQs COMPLETED')}
                            </Text>
                            <View style={styles.mcqProgressRow}>
                                <Text style={styles.mcqProgressValue}>
                                    {totalQuestionsAnswered}
                                </Text>
                                <Text style={styles.mcqProgressTotal}>
                                    / {totalMCQsCount}
                                </Text>
                            </View>
                            <View style={styles.mcqMiniTrack}>
                                <LinearGradient
                                    colors={[colors.primary.DEFAULT, colors.gradients.gold[1] as string] as any}
                                    start={{ x: 0, y: 0 }}
                                    end={{ x: 1, y: 0 }}
                                    style={[
                                        styles.mcqMiniFill,
                                        { width: `${Math.min((totalQuestionsAnswered / (totalMCQsCount || 240)) * 100, 100)}%` }
                                    ]}
                                />
                            </View>
                        </View>
                    </GlassCard>

                    {/* Weekly Performance Trend Chart */}
                    <GlassCard style={{ padding: 8 }}>
                        <PerformanceChart
                            data={
                                dailyTrends.some(d => d.value > 0)
                                    ? dailyTrends
                                    : [{ value: 0, label: '-' }]
                            }
                        />
                    </GlassCard>

                    {/* Batch Selection Slider */}
                    <View style={{ marginVertical: 4 }}>
                        <Text style={styles.sectionLabel}>{t('user.batchManagement', 'Batch Management')}</Text>
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
                                        {t('quiz.batchTitle', { number: b.batchNumber })}
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
                                <Text style={styles.cardTitle}>{t('user.batchSummary', 'Batch {{number}} Summary', { number: selectedBatch })}</Text>
                                <TouchableOpacity
                                    onPress={() => handleResetBatch(selectedBatch, selectedSummary.passed)}
                                    style={styles.resetBatchButton}
                                >
                                    <RotateCcw size={14} color="#FFF" />
                                    <Text style={styles.resetBatchText}>{t('user.resetBatch', 'Reset Batch')}</Text>
                                </TouchableOpacity>
                            </View>

                            <View style={styles.statsGrid}>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>{t('user.progress', 'Progress')}</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.completedCount}/{selectedSummary.totalQuestions || 30}</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>{t('user.averageScore', 'Average Score')}</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.averageScore.toFixed(1)}%</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>{t('user.attempts', 'Attempts')}</Text>
                                    <Text style={styles.statBoxVal}>{selectedSummary.attemptCount}</Text>
                                </View>
                                <View style={styles.statBox}>
                                    <Text style={styles.statBoxLabel}>{t('user.autoResets', 'Auto-Resets')}</Text>
                                    <Text style={[styles.statBoxVal, selectedSummary.resets >= 3 && { color: '#FF3D00' }]}>
                                        {selectedSummary.resets}
                                    </Text>
                                </View>
                            </View>
                        </GlassCard>
                    )}

                    {/* Incorrect Questions List (Read-only, paginated) */}
                    <Text style={styles.sectionLabel}>
                        {t('user.incorrectQuestions', 'Incorrect Questions')} ({incorrectQuestions.length})
                    </Text>

                    {incorrectQuestions.length === 0 ? (
                        <GlassCard style={styles.emptyCard}>
                            <Text style={styles.emptyText}>
                                {progressList.length === 0
                                    ? t('user.noQuestionsAnswered', 'No questions answered in this batch yet.')
                                    : t('user.noIncorrectQuestions', '✅ No incorrect questions — great performance!')}
                            </Text>
                        </GlassCard>
                    ) : (
                        <>
                            {pagedIncorrectQuestions.map((q, idx) => (
                                <GlassCard key={q.id} style={styles.questionProgressCard}>
                                    <View style={styles.qHeader}>
                                        <Text style={styles.qIndex}>{t('quiz.questionNumber', { number: (incorrectPage - 1) * INCORRECT_PER_PAGE + idx + 1 })}</Text>
                                        <View style={styles.badgeIncorrect}>
                                            <Text style={styles.badgeTextIncorrect}>{t('quiz.incorrect', 'Incorrect')}</Text>
                                        </View>
                                    </View>
                                    <Text style={styles.qText}>{q.text}</Text>
                                    <Text style={styles.qAttempts}>{t('mission.attempts', 'Attempts:')} {q.attempts}/2</Text>
                                </GlassCard>
                            ))}

                            {/* Pagination Controls */}
                            {incorrectTotalPages > 1 && (
                                <View style={styles.paginationRow}>
                                    <TouchableOpacity
                                        style={[styles.pageBtn, incorrectPage === 1 && styles.pageBtnDisabled]}
                                        onPress={() => setIncorrectPage(p => Math.max(1, p - 1))}
                                        disabled={incorrectPage === 1}
                                    >
                                        <ChevronLeft size={16} color={incorrectPage === 1 ? colors.text.tertiary : colors.text.primary} />
                                    </TouchableOpacity>
                                    <Text style={styles.pageLabel}>
                                        {incorrectPage} / {incorrectTotalPages}
                                    </Text>
                                    <TouchableOpacity
                                        style={[styles.pageBtn, incorrectPage === incorrectTotalPages && styles.pageBtnDisabled]}
                                        onPress={() => setIncorrectPage(p => Math.min(incorrectTotalPages, p + 1))}
                                        disabled={incorrectPage === incorrectTotalPages}
                                    >
                                        <ChevronRight size={16} color={incorrectPage === incorrectTotalPages ? colors.text.tertiary : colors.text.primary} />
                                    </TouchableOpacity>
                                </View>
                            )}
                        </>
                    )}

                    {/* Deactivate Button — below Incorrect Questions */}
                    <TouchableOpacity
                        onPress={handleDeactivateDriver}
                        style={styles.deactivateBtn}
                        disabled={actionLoading}
                    >
                        <UserX size={16} color="#FFF" />
                        <Text style={styles.deactivateBtnText}>{t('user.deactivate', 'Deactivate')}</Text>
                    </TouchableOpacity>

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
    deactivateBtn: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
        backgroundColor: '#FF6B6B',
        paddingVertical: 14,
        borderRadius: 12,
        gap: 8,
    },
    deactivateBtnText: {
        color: '#FFF',
        fontSize: 15,
        fontFamily: typography.fonts.bold,
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
    },
    paginationRow: {
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'center',
        gap: 20,
        paddingVertical: 8,
    },
    pageBtn: {
        width: 36,
        height: 36,
        borderRadius: 18,
        borderWidth: 1.5,
        borderColor: colors.border,
        alignItems: 'center',
        justifyContent: 'center',
    },
    pageBtnDisabled: {
        opacity: 0.3,
    },
    pageLabel: {
        fontSize: 14,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    bandBadge: {
        paddingHorizontal: 8,
        paddingVertical: 2,
        borderRadius: 6,
        borderWidth: 1,
    },
    bandBadgeText: {
        fontSize: 11,
        fontFamily: typography.fonts.bold,
    },
    exportIconButton: {
        width: 36,
        height: 36,
        borderRadius: 18,
        backgroundColor: theme === 'dark' ? 'rgba(255,255,255,0.08)' : 'rgba(0,0,0,0.05)',
        justifyContent: 'center',
        alignItems: 'center',
        borderWidth: 1,
        borderColor: colors.border,
    },
    dashboardCard: {
        padding: 20,
    },
    dashboardHeader: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 10,
        marginBottom: 20,
    },
    dashboardIconCircle: {
        width: 34,
        height: 34,
        borderRadius: 17,
        backgroundColor: `${colors.primary.DEFAULT}20`,
        justifyContent: 'center',
        alignItems: 'center',
    },
    dashboardTitle: {
        fontSize: 16,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    scoreSection: {
        gap: 14,
    },
    scoreRow: {
        gap: 6,
    },
    scoreLabelRow: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8,
    },
    scoreDot: {
        width: 10,
        height: 10,
        borderRadius: 5,
    },
    scoreLabelText: {
        flex: 1,
        fontSize: 13,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
    },
    scoreValueText: {
        fontSize: 13,
        fontFamily: typography.fonts.bold,
    },
    scoreBarTrack: {
        height: 10,
        borderRadius: 5,
        backgroundColor: colors.background.subtle,
        overflow: 'hidden',
    },
    scoreBarFill: {
        height: '100%',
        borderRadius: 5,
    },
    mcqProgressSection: {
        marginTop: 18,
        paddingTop: 16,
        borderTopWidth: 1,
        borderTopColor: colors.border,
        alignItems: 'center',
    },
    mcqProgressLabel: {
        fontSize: 11,
        fontFamily: typography.fonts.medium,
        color: colors.text.secondary,
        textTransform: 'uppercase',
        letterSpacing: 1,
        marginBottom: 4,
    },
    mcqProgressRow: {
        flexDirection: 'row',
        alignItems: 'baseline',
        gap: 4,
        marginBottom: 8,
    },
    mcqProgressValue: {
        fontSize: 22,
        fontFamily: typography.fonts.bold,
        color: colors.text.primary,
    },
    mcqProgressTotal: {
        fontSize: 14,
        fontFamily: typography.fonts.medium,
        color: colors.text.tertiary,
    },
    mcqMiniTrack: {
        width: '100%',
        height: 6,
        borderRadius: 3,
        backgroundColor: colors.background.subtle,
        overflow: 'hidden',
    },
    mcqMiniFill: {
        height: '100%',
        borderRadius: 3,
    },
});
