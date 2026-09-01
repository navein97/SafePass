import React, { useState, useCallback, useMemo, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
  StatusBar,
  ScrollView,
  Platform,
  RefreshControl,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { BatchService } from '../services/batchService';
import { QuizStorageService } from '../services/quizStorageService';
import { useNavigation, useRoute, useFocusEffect } from '@react-navigation/native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { typography } from '../theme/typography';
import { Lock, CheckCircle, PlayCircle, AlertCircle, Target, ArrowLeft } from 'lucide-react-native';
import { SubscriptionService } from '../services/subscriptionService';
import { supabase } from '../lib/supabase';
import { CacheService, formatTimeAgo, isDataEqual } from '../services/cacheService';

interface BatchStatus {
  batchNumber: number;
  canAccess: boolean;
  averageScore: number;
  attemptCount: number;
  passed: boolean;
  dailyCount: number;
  completedCount: number;
  totalQuestions?: number;
}

export function MissionScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const navigation = useNavigation();
  const route = useRoute<any>();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [loading, setLoading] = useState(true);
  const [batchStatuses, setBatchStatuses] = useState<BatchStatus[]>([]);
  const [selectedMode, setSelectedMode] = useState<'live' | 'practice' | null>(null);
  const [maxBatches, setMaxBatches] = useState(8); // 1 = trial, 8 = subscribed

  const isFirstLoadRef = useRef(true);

  // SWR Caching & Last Updated State
  const [lastUpdatedTime, setLastUpdatedTime] = useState<number | null>(null);
  const [lastUpdatedText, setLastUpdatedText] = useState<string>('');
  const [refreshing, setRefreshing] = useState(false);

  // Live timer update for "Last updated X ago"
  React.useEffect(() => {
    if (!lastUpdatedTime) return;
    setLastUpdatedText(formatTimeAgo(lastUpdatedTime));
    const interval = setInterval(() => {
      setLastUpdatedText(formatTimeAgo(lastUpdatedTime));
    }, 30000);
    return () => clearInterval(interval);
  }, [lastUpdatedTime]);

  const loadData = useCallback(async () => {
    // 1. Instant Cache-First Read (Stale-While-Revalidate)
    const cached = await CacheService.get<BatchStatus[]>('mission_batch_statuses');
    if (cached && cached.data && cached.data.length > 0) {
      // If cache is from a previous day (midnight UTC+8), dailyCount is 0 for today
      const now = new Date();
      const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
      const serverTime = new Date(utc + (3600000 * 8));
      serverTime.setHours(0, 0, 0, 0);
      const startOfTodayUtc8Ms = serverTime.getTime() - (3600000 * 8);

      const isCacheFromPreviousDay = cached.lastUpdated < startOfTodayUtc8Ms;
      const initialStatuses = isCacheFromPreviousDay
        ? cached.data.map(b => ({ ...b, dailyCount: 0 }))
        : cached.data;

      setBatchStatuses(initialStatuses);
      setLastUpdatedTime(cached.lastUpdated);
      setLastUpdatedText(formatTimeAgo(cached.lastUpdated));
      setLoading(false); // Immediate 0-wait render
    } else if (isFirstLoadRef.current) {
      setLoading(true); // Show skeleton/spinner only on cold start with 0 cache
    }

    // 2. Parallel Background Fetch with 8s Timeout (Fail silently)
    try {
      const { profile } = await AuthService.getUserProfile();
      if (!profile) return;

      // Redirect managers immediately
      if (profile.role === 'manager') {
        navigation.navigate('ManagerQuickView' as never);
        return;
      }

      // Check subscription level for trial gating
      const batches = await SubscriptionService.getMaxBatches(profile.company_id);
      setMaxBatches(batches);

      // Fetch Batch Data in Background with 8s timeout
      const batchNumbers = await BatchService.getAvailableBatchNumbers();

      const fetchPromise = async () => {
        // Fetch user batch attempts, question progress, and questions metadata in parallel
        const [
          { data: allBatchAttempts },
          { data: allQProgress },
          { data: allQuestionsData },
        ] = await Promise.all([
          supabase
            .from('user_batch_progress')
            .select('*')
            .eq('user_id', profile.id),
          supabase
            .from('user_question_progress')
            .select('*')
            .eq('user_id', profile.id),
          supabase
            .from('questions')
            .select('id, batch_number, driver_categories'),
        ]);

        // Calculate start of today in UTC+8
        const now = new Date();
        const utc = now.getTime() + (now.getTimezoneOffset() * 60000);
        const serverTime = new Date(utc + (3600000 * 8));
        serverTime.setHours(0, 0, 0, 0);
        const startOfTodayUtc8 = new Date(serverTime.getTime() - (3600000 * 8));

        const dailyCountToday = (allQProgress || []).filter(
          q => new Date(q.completed_at) >= startOfTodayUtc8
        ).length;

        const vType = profile.vehicle_type;
        const currentBatch = profile.current_batch || 1;
        const isOverridden = profile.batch_lock_override || false;

        return batchNumbers.map(batchNum => {
          // Attempts for this batch
          const batchAttempts = (allBatchAttempts || []).filter(a => a.batch_number === batchNum);
          const batchQProgress = (allQProgress || []).filter(q => q.batch_number === batchNum);
          const batchDailyCount = batchQProgress.filter(
            q => new Date(q.completed_at) >= startOfTodayUtc8
          ).length;

          // Matching questions count
          const batchQuestions = (allQuestionsData || []).filter(q => {
            if (q.batch_number !== batchNum) return false;
            if (!vType || !q.driver_categories || !Array.isArray(q.driver_categories) || q.driver_categories.length === 0) return true;
            return q.driver_categories.includes(vType) || q.driver_categories.includes('All');
          });
          const totalQ = Math.min(30, batchQuestions.length > 0 ? batchQuestions.length : 30);

          // Score calculation
          let score = 0;
          if (batchAttempts.length > 0) {
            score = batchAttempts[batchAttempts.length - 1]?.score || 0;
          } else if (batchQProgress.length > 0) {
            const totalEarned = batchQProgress.reduce((sum, q) => sum + parseFloat(String(q.score || 0)), 0);
            score = Math.max(0, Math.round((totalEarned / Math.max(1, totalQ)) * 100));
          }

          const passed = batchNum < currentBatch || (batchAttempts.length > 0 && score >= 60);

          // Access check
          let canAccess = false;
          if (batchNum === 1 || isOverridden || batchNum <= currentBatch) {
            canAccess = true;
          } else {
            const prevAttempts = (allBatchAttempts || []).filter(a => a.batch_number === batchNum - 1);
            const prevBest = Math.max(0, ...prevAttempts.map(a => a.score || 0));
            canAccess = prevBest >= 60;
          }

          const batchCompletedCount = passed
            ? (batchQProgress.length > 0 ? batchQProgress.length : totalQ)
            : batchQProgress.length;

          return {
            batchNumber: batchNum,
            canAccess,
            averageScore: score,
            attemptCount: batchAttempts.length,
            passed,
            dailyCount: batchDailyCount,
            completedCount: batchCompletedCount,
            totalQuestions: totalQ,
          };
        });
      };

      const freshStatuses = await CacheService.fetchWithTimeout(fetchPromise, 8000);

      if (freshStatuses) {
        if (!cached || !isDataEqual(cached.data, freshStatuses)) {
          setBatchStatuses(freshStatuses);
          await CacheService.set('mission_batch_statuses', freshStatuses);
          const now = Date.now();
          setLastUpdatedTime(now);
          setLastUpdatedText(formatTimeAgo(now));
        }
        isFirstLoadRef.current = false;
      }

    } catch (error) {
      console.warn('[MissionScreen] Background batch fetch failed, keeping cached data:', error);
    } finally {
      setLoading(false);
    }
  }, [navigation]);

  const onRefresh = async () => {
    setRefreshing(true);
    try {
      await loadData();
    } finally {
      setRefreshing(false);
    }
  };

  // useFocusEffect is safer than useEffect for screen focus events
  useFocusEffect(
    useCallback(() => {
      // Clear the refresh param so we don't loop
      if (route.params?.refresh === true) {
        navigation.setParams({ refresh: undefined } as any);
      }

      loadData();
    }, [route.params?.refresh, loadData, navigation])
  );

  const handleBatchPress = (batchNumber: number, canAccess: boolean) => {
    const batch = batchStatuses.find(b => b.batchNumber === batchNumber);

    if (selectedMode === 'live' && batch) {
      if (batch.passed) {
        const title = t('quiz.batchCompleted') || 'Goal Done';
        const message = t('quiz.goalDoneMessage') || `Batch Goal Completed! Try Practice Mode for more study.`;
        if (Platform.OS === 'web') {
          window.alert(`${title}\n\n${message}`);
        } else {
          Alert.alert(title, message);
        }
        return;
      }
    }

    // Check general access (locked batch)
    if (!canAccess && selectedMode === 'live') {
      const title = t('quiz.batchLocked');
      const message = t('quiz.batchLockedMessage', { prevBatch: batchNumber - 1 });

      if (Platform.OS === 'web') {
        window.alert(`${title}\n\n${message}`);
      } else {
        Alert.alert(title, message);
      }
      return;
    }

    if (canAccess && selectedMode) {
      // Trial gating: block batches beyond maxBatches
      if (batchNumber > maxBatches) {
        const title = t('billing.upgradeRequired');
        const message = t('billing.trialBatchLocked');
        if (Platform.OS === 'web') {
          const shouldUpgrade = window.confirm(`${title}\n\n${message}`);
          if (shouldUpgrade) {
            navigation.navigate('Billing' as never);
          }
        } else {
          Alert.alert(title, message, [
            { text: t('common.cancel'), style: 'cancel' },
            { text: t('billing.upgrade'), onPress: () => navigation.navigate('Billing' as never) }
          ]);
        }
        return;
      }
      // @ts-ignore
      navigation.navigate('Quiz', { batchNumber, mode: selectedMode });
    }
  };

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>{t('mission.loading')}</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView edges={['top', 'left', 'right']} style={styles.safeArea}>
        <StatusBar barStyle="light-content" />

        <View style={styles.header}>
          <Text style={styles.title}>{t('mission.trainingTitle')}</Text>
          <Text style={styles.subtitle}>{t('mission.trainingSubtitle')}</Text>
          {lastUpdatedText ? (
            <Text style={{ fontSize: 11, color: colors.text.tertiary, marginTop: 4, fontFamily: typography.fonts.regular }}>
              {t('common.lastUpdated', 'Last updated')} {lastUpdatedText}
            </Text>
          ) : null}
        </View>

        <ScrollView 
          contentContainerStyle={styles.content}
          refreshControl={
            <RefreshControl
              refreshing={refreshing}
              onRefresh={onRefresh}
              tintColor={colors.primary.DEFAULT}
              colors={[colors.primary.DEFAULT]}
            />
          }
        >
          {!selectedMode ? (
            <View style={styles.selectionContainer}>
              <TouchableOpacity
                style={[styles.modeCard, { borderColor: colors.status.success }]}
                onPress={() => setSelectedMode('live')}
              >
                <View style={[styles.modeIconContainer, { backgroundColor: colors.status.success + '20' }]}>
                  <PlayCircle size={32} color={colors.status.success} />
                </View>
                <View style={styles.modeTextContainer}>
                  <Text style={styles.modeTitle}>{t('mission.liveModeTitle')}</Text>
                  <Text style={styles.modeDescription}>
                    {t('mission.liveModeDescription')}
                  </Text>
                </View>
              </TouchableOpacity>

              <TouchableOpacity
                style={[styles.modeCard, { borderColor: colors.primary.DEFAULT }]}
                onPress={() => setSelectedMode('practice')}
              >
                <View style={[styles.modeIconContainer, { backgroundColor: colors.primary.DEFAULT + '20' }]}>
                  <Target size={32} color={colors.primary.DEFAULT} />
                </View>
                <View style={styles.modeTextContainer}>
                  <Text style={styles.modeTitle}>{t('mission.practiceModeTitle')}</Text>
                  <Text style={styles.modeDescription}>
                    {t('mission.practiceModeDescription')}
                  </Text>
                </View>
              </TouchableOpacity>
            </View>
          ) : (
            <>
              <View style={styles.modeHeader}>
                <TouchableOpacity style={styles.backButton} onPress={() => setSelectedMode(null)}>
                  <ArrowLeft size={20} color={colors.text.primary} />
                </TouchableOpacity>
                <View style={[
                  styles.modePill,
                  { backgroundColor: selectedMode === 'live' ? colors.status.success + '22' : colors.primary.DEFAULT + '22' }
                ]}>
                  {selectedMode === 'live'
                    ? <PlayCircle size={15} color={colors.status.success} />
                    : <Target size={15} color={colors.primary.DEFAULT} />
                  }
                  <Text style={[
                    styles.modePillText,
                    { color: selectedMode === 'live' ? colors.status.success : colors.primary.DEFAULT }
                  ]}>
                    {selectedMode === 'live' ? t('mission.liveModeTitle') : t('mission.practiceModeTitle')}
                  </Text>
                </View>
                {/* Spacer to keep title truly centered */}
                <View style={{ width: 40 }} />
              </View>

              {selectedMode === 'live' && (
                <View style={styles.dailyRefreshBanner}>
                  <Text style={styles.dailyRefreshIcon}>🕛</Text>
                  <Text style={styles.dailyRefreshText}>
                    {t('mission.dailyRefreshNote', 'Daily question limit refreshes every midnight (12:00 AM)')}
                  </Text>
                </View>
              )}

              {batchStatuses.map((batch) => (
                <TouchableOpacity
                  key={batch.batchNumber}
                  style={[
                    styles.batchCard,
                    !(batch.canAccess || selectedMode === 'practice') && styles.batchCardLocked,
                    batch.passed && styles.batchCardPassed,
                    batch.batchNumber > maxBatches && { opacity: 0.5 },
                  ]}
                  onPress={() => handleBatchPress(batch.batchNumber, batch.canAccess || selectedMode === 'practice')}
                  disabled={!(batch.canAccess || selectedMode === 'practice') && batch.batchNumber <= maxBatches}
                  activeOpacity={0.7}
                >
                  <View style={styles.batchHeader}>
                    <View style={styles.batchTitleRow}>
                      {!(batch.canAccess || selectedMode === 'practice') ? (
                        <Lock size={32} color="#999" />
                      ) : batch.passed ? (
                        <CheckCircle size={32} color="#00C853" />
                      ) : batch.attemptCount > 0 ? (
                        <AlertCircle size={32} color={colors.primary.DEFAULT} />
                      ) : (
                        <PlayCircle size={32} color={colors.primary.DEFAULT} />
                      )}
                      <View style={styles.batchTitleContainer}>
                        <Text style={styles.batchTitle}>{t('quiz.batchTitle', { number: batch.batchNumber })}</Text>
                      </View>
                    </View>
                  </View>

                  <View style={styles.batchStats}>
                    {batch.attemptCount > 0 || batch.completedCount > 0 ? (
                      <>
                        <View style={styles.statRow}>
                          <Text style={styles.statLabel}>{t('mission.progress', 'Progress')}</Text>
                          <Text style={styles.statValue}>{batch.completedCount}/{batch.totalQuestions || 30} {t('quiz.completed', 'completed')}</Text>
                        </View>
                        {selectedMode !== 'practice' && batch.averageScore > 0 && (
                          <View style={styles.statRow}>
                            <Text style={styles.statLabel}>{t('mission.averageScore')}</Text>
                            <Text
                              style={[
                                styles.statValue,
                                batch.passed && styles.statValuePassed,
                                !batch.passed && styles.statValueFailed,
                              ]}
                            >
                              {batch.averageScore.toFixed(1)}%
                            </Text>
                          </View>
                        )}
                        <View style={styles.statRow}>
                          <Text style={styles.statLabel}>{t('mission.attempts')}</Text>
                          <Text style={styles.statValue}>{batch.attemptCount}</Text>
                        </View>
                        {selectedMode !== 'practice' && (
                          <View style={styles.statRow}>
                            <Text style={styles.statLabel}>{t('mission.status')}</Text>
                            <Text
                              style={[
                                styles.statValue,
                                batch.passed && styles.statValuePassed,
                                !batch.passed && styles.statValueFailed,
                              ]}
                            >
                              {batch.passed
                                ? `✓ ${t('mission.passed')}`
                                : `${t('mission.inProgress', 'In Progress')}`}
                            </Text>
                          </View>
                        )}
                      </>
                    ) : (batch.canAccess || selectedMode === 'practice') && batch.batchNumber <= maxBatches ? (
                      <Text style={styles.notStartedText}>{t('mission.tapToStart')}</Text>
                    ) : batch.batchNumber > maxBatches ? (
                      <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8 }}>
                        <Lock size={16} color={colors.primary.DEFAULT} />
                        <Text style={[styles.notStartedText, { color: colors.primary.DEFAULT }]}>{t('billing.upgradeToUnlock')}</Text>
                      </View>
                    ) : (
                      <Text style={styles.lockedText}>
                        {t('mission.lockMessage', { number: batch.batchNumber - 1 })}
                      </Text>
                    )}
                  </View>
                </TouchableOpacity>
              ))}

              {/* [REMOVED] "How it works" card — redundant:
                  Mode cards already describe each mode. Marking (1 correct = 1 mark)
                  is self-evident. Pass threshold is shown on batch cards already.
              <View style={styles.infoCard}>
                <Text style={styles.infoTitle}>{t('mission.howItWorks', 'How it works:')}</Text>
                <Text style={styles.infoText}>
                  • {t('mission.liveModeTitle')}: {t('mission.liveModeDescription')}{'\n'}
                  • {t('mission.practiceModeTitle')}: {t('mission.practiceModeDescription')}{'\n'}
                  • 1st try: 1 mark | 2nd+: 0 marks{'\n'}
                  • Pass with ≥60% average to unlock next batch
                </Text>
              </View>
              */}
            </>
          )}
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: 16,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
  },
  header: {
    paddingHorizontal: 20,
    paddingVertical: 24,
    alignItems: 'center',
  },
  title: {
    fontSize: 32,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
  },
  content: {
    padding: 20,
    paddingBottom: 120,
    gap: 16,
  },
  batchCard: {
    backgroundColor: colors.background.card,
    borderRadius: 16,
    padding: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  batchCardLocked: {
    backgroundColor: colors.background.card,
    opacity: 0.6,
    borderWidth: 1,
    borderColor: colors.border,
  },
  batchCardPassed: {
    borderColor: '#00C853',
  },
  batchHeader: {
    marginBottom: 16,
  },
  batchTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
  },
  batchTitleContainer: {
    flex: 1,
  },
  batchTitle: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  batchSubtitle: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    marginTop: 2,
  },
  batchStats: {
    gap: 8,
  },
  statRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  statLabel: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  statValue: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  statValuePassed: {
    color: '#00C853',
  },
  statValueFailed: {
    color: '#FF6B6B',
  },
  notStartedText: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: colors.primary.DEFAULT,
    textAlign: 'center',
    paddingVertical: 8,
  },
  lockedText: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.tertiary,
    textAlign: 'center',
    fontStyle: 'italic',
  },
  infoCard: {
    backgroundColor: 'rgba(255, 215, 0, 0.1)',
    borderRadius: 12,
    padding: 16,
    borderWidth: 1,
    borderColor: 'rgba(255, 215, 0, 0.3)',
    marginTop: 8,
  },
  infoTitle: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 8,
  },
  infoText: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 22,
  },
  selectionContainer: {
    gap: 16,
    paddingBottom: 20,
  },
  modeCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.background.card,
    borderRadius: 16,
    padding: 16,
    borderWidth: 2,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 4,
  },
  modeIconContainer: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  modeTextContainer: {
    flex: 1,
  },
  modeTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
  },
  modeDescription: {
    fontSize: 13,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 18,
  },
  backToMode: {
    marginBottom: 16,
    paddingVertical: 8,
  },
  backToModeText: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  modeTitleRow: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    width: '100%',
  },
  modePill: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
  },
  modePillText: {
    fontSize: 15,
    fontFamily: typography.fonts.bold,
  },
  changeButton: {
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1.5,
    borderColor: colors.border,
  },
  changeButtonText: {
    fontSize: 13,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  modeHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
    paddingHorizontal: 4,
  },
  backButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: colors.background.subtle,
    justifyContent: 'center',
    alignItems: 'center',
  },
  modeHeaderTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'center',
    flex: 1,
  },
  quotaAlert: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 107, 107, 0.1)',
    paddingHorizontal: 10,
    paddingVertical: 6,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: 'rgba(255, 107, 107, 0.3)',
  },
  quotaAlertText: {
    fontSize: 12,
    fontFamily: typography.fonts.bold,
    color: '#FF6B6B',
    marginLeft: 6,
  },
  dailyRefreshBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.mode === 'dark' ? 'rgba(37, 99, 235, 0.15)' : 'rgba(37, 99, 235, 0.08)',
    borderRadius: 12,
    paddingVertical: 10,
    paddingHorizontal: 14,
    borderWidth: 1,
    borderColor: colors.mode === 'dark' ? 'rgba(37, 99, 235, 0.3)' : 'rgba(37, 99, 235, 0.18)',
    gap: 8,
    marginBottom: 4,
  },
  dailyRefreshIcon: {
    fontSize: 16,
  },
  dailyRefreshText: {
    flex: 1,
    fontSize: 13,
    fontFamily: typography.fonts.medium,
    color: colors.mode === 'dark' ? '#93C5FD' : '#1D4ED8',
    lineHeight: 18,
  },
});