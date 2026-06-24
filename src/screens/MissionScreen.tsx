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
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { BatchService } from '../services/batchService';
import { QuizStorageService } from '../services/quizStorageService';
import { useNavigation, useRoute, useFocusEffect } from '@react-navigation/native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { typography } from '../theme/typography';
import { Lock, CheckCircle, PlayCircle, AlertCircle, Target } from 'lucide-react-native';
import { SubscriptionService } from '../services/subscriptionService';

interface BatchStatus {
  batchNumber: number;
  canAccess: boolean;
  averageScore: number;
  attemptCount: number;
  passed: boolean;
  dailyCount: number;
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
  
  // Ref to track if it's the very first load to avoid spinner on subsequent visits
  const isFirstLoadRef = useRef(true);
  // Cache timestamp
  const lastLoadTime = useRef<number>(0);
  const CACHE_DURATION_MS = 10000; // 10 seconds

  // useFocusEffect is safer than useEffect for screen focus events
  useFocusEffect(
    useCallback(() => {
      let isActive = true; // Prevents state updates if screen unmounts

      const loadData = async () => {
        // Check if we need to force refresh from QuizScreen params
        const shouldRefresh = route.params?.refresh === true;
        
        // Cache Check: Skip if data is fresh and we aren't forced to refresh
        const now = Date.now();
        if (!shouldRefresh && lastLoadTime.current > 0 && (now - lastLoadTime.current) < CACHE_DURATION_MS) {
          return; 
        }

        // Clear the refresh param so we don't loop
        if (shouldRefresh) {
          navigation.setParams({ refresh: undefined } as any);
        }

        // Only show spinner on the very first mount or explicit refresh
        if (isFirstLoadRef.current) {
          setLoading(true);
        }

        try {
          // 1. Get User Profile
          const { profile } = await AuthService.getUserProfile();
          if (!isActive || !profile) return;

          // Redirect managers immediately
          if (profile.role === 'manager') {
            navigation.navigate('ManagerQuickView' as never);
            return;
          }

          // Check subscription level for trial gating
          const batches = await SubscriptionService.getMaxBatches(profile.company_id);
          if (isActive) setMaxBatches(batches);

          // 2. Fetch Batch Data Sequentially to prevent network hang
          // (Fetching 12 requests at once can freeze the network layer on mobile)
          const batchNumbers = [1, 2, 3, 4, 5, 6, 7, 8];
          const statuses: BatchStatus[] = [];

          // Create a promise with a timeout to prevent infinite loading
          const fetchPromise = async () => {
            // we use a simple loop or Promise.all on smaller chunks
            const accessResults = await Promise.all(batchNumbers.map(i => BatchService.canAccessBatch(profile.id, i)));
            const scoreResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAverageScore(profile.id, i)));
            const attemptResults = await Promise.all(batchNumbers.map(i => BatchService.getBatchAttempts(profile.id, i)));
            const dailyCounts = await Promise.all(batchNumbers.map(i => QuizStorageService.getDailyCount(profile.id, i)));
            
            return batchNumbers.map((batchNum, index) => ({
              batchNumber: batchNum,
              canAccess: accessResults[index],
              averageScore: scoreResults[index],
              attemptCount: attemptResults[index].length,
              passed: scoreResults[index] >= 60,
              dailyCount: dailyCounts[index],
            }));
          };

          const quotaPromise = QuizStorageService.getDailyCount(profile.id);

          // Race the fetch against a 10-second timeout
          const timeoutPromise = new Promise((_, reject) => 
            setTimeout(() => reject(new Error('Request timed out')), 10000)
          );

          const [resultStatuses] = await Promise.race([
            Promise.all([fetchPromise()]), 
            timeoutPromise
          ]) as [BatchStatus[]];

          if (isActive) {
            // Append Coming Soon batches 5-8
            const finalStatuses = [...resultStatuses];
            for (let i = 5; i <= 8; i++) {
              finalStatuses.push({
                batchNumber: i,
                canAccess: false,
                averageScore: 0,
                attemptCount: 0,
                passed: false,
                dailyCount: 0,
              });
            }
            setBatchStatuses(finalStatuses);
            lastLoadTime.current = Date.now();
            isFirstLoadRef.current = false; // Mark first load as complete
          }

        } catch (error) {
          console.error('Error loading batch statuses:', error);
          if (isActive && isFirstLoadRef.current) {
            Alert.alert(t('common.error'), t('quiz.failedToLoadQuiz'));
          }
        } finally {
          if (isActive) {
            setLoading(false);
          }
        }
      };

      loadData();

      return () => {
        isActive = false; // Cleanup flag
      };
    }, [route.params?.refresh, navigation]) // Re-run if refresh param changes
  );

  const handleBatchPress = (batchNumber: number, canAccess: boolean) => {
    const batch = batchStatuses.find(b => b.batchNumber === batchNumber);
    
    // [TESTING] Daily limit gate disabled — re-enable for production
    // if (selectedMode === 'live' && batch && (batch.dailyCount >= 3 || batch.passed)) {
    //   const title = t('quiz.batchCompleted') || 'Goal Done';
    //   const message = t('quiz.goalDoneMessage') || `Batch Goal Completed! Try Practice Mode for more study.`;
    //   if (Platform.OS === 'web') {
    //     window.alert(`${title}\n\n${message}`);
    //   } else {
    //     Alert.alert(title, message);
    //   }
    //   return;
    // }

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
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" />
        
        <View style={styles.header}>
          <Text style={styles.title}>{t('mission.trainingTitle')}</Text>
          <Text style={styles.subtitle}>{t('mission.trainingSubtitle')}</Text>
        </View>

        <ScrollView contentContainerStyle={styles.content}>
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
                <TouchableOpacity style={styles.backToMode} onPress={() => setSelectedMode(null)}>
                  <Text style={styles.backToModeText}>← {t('mission.changeMode')} ({selectedMode === 'live' ? t('mission.liveModeTitle') : t('mission.practiceModeTitle')})</Text>
                </TouchableOpacity>
              </View>
              
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
                        <Text style={styles.batchSubtitle}>{t('mission.trainingCourse')}</Text>
                      </View>
                    </View>
                  </View>

                  <View style={styles.batchStats}>
                    {batch.attemptCount > 0 ? (
                      <>
                        {selectedMode !== 'practice' && (
                          <View style={styles.statRow}>
                            <Text style={styles.statLabel}>{t('mission.averageScore')}</Text>
                            <Text
                              style={[
                                styles.statValue,
                                batch.passed && styles.statValuePassed,
                                !batch.passed && batch.attemptCount > 0 && styles.statValueFailed,
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
                                (batch.passed || (selectedMode === 'live' && batch.dailyCount >= 3)) && styles.statValuePassed,
                                !batch.passed && !(selectedMode === 'live' && batch.dailyCount >= 3) && styles.statValueFailed,
                              ]}
                            >
                              {selectedMode === 'live' && (batch.dailyCount >= 3 || batch.passed)
                                ? `✓ ${t('mission.goalDone')}` 
                                : batch.passed
                                  ? `✓ ${t('mission.passed')}`
                                  : t('mission.needMoreToPass', { percent: (60 - batch.averageScore).toFixed(1) })}
                            </Text>
                          </View>
                        )}
                      </>
                    ) : (batch.canAccess || selectedMode === 'practice') && batch.batchNumber <= maxBatches ? (
                      <Text style={styles.notStartedText}>{t('mission.tapToStart')}</Text>
                    ) : batch.batchNumber > 4 ? (
                      <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8 }}>
                        <Lock size={16} color="#999" />
                        <Text style={styles.lockedText}>{t('mission.comingSoon', 'Coming Soon')}</Text>
                      </View>
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
  modeHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
    flexWrap: 'wrap',
    gap: 8,
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
});