import React, { useState, useEffect, useMemo } from 'react';
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
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { BatchService } from '../services/batchService';
import { useNavigation, useRoute } from '@react-navigation/native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { typography } from '../theme/typography';
import { Lock, CheckCircle, PlayCircle, AlertCircle } from 'lucide-react-native';

interface BatchStatus {
  batchNumber: number;
  canAccess: boolean;
  averageScore: number;
  attemptCount: number;
  passed: boolean;
}

export function MissionScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const navigation = useNavigation();
  const route = useRoute<any>();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState('');
  const [batchStatuses, setBatchStatuses] = useState<BatchStatus[]>([]);
  const [isInitialLoad, setIsInitialLoad] = useState(true);
  
  // Cache mechanism - don't reload if data was fetched recently
  const lastLoadTime = React.useRef<number>(0);
  const CACHE_DURATION_MS = 10000; // 10 seconds cache

  // Use focus effect to refresh data whenever user returns to this screen
  React.useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      // Check if we need to force refresh (after quiz completion)
      const shouldRefresh = route.params?.refresh === true;
      if (shouldRefresh) {
        // Reset the refresh param to prevent repeated refreshes
        navigation.setParams({ refresh: false } as any);
      }
      loadBatchStatuses(shouldRefresh);
    });

    return unsubscribe;
  }, [navigation, route.params?.refresh]);

  const loadBatchStatuses = async (forceRefresh = false) => {
    try {
      // Skip reload if data was loaded recently (unless force refresh)
      const now = Date.now();
      if (!forceRefresh && lastLoadTime.current > 0 && (now - lastLoadTime.current) < CACHE_DURATION_MS) {
        // Data is still fresh, skip reload
        return;
      }
      
      // Only show loading spinner on initial load, not when returning from quiz
      if (isInitialLoad) {
        setLoading(true);
      }
      
      const { profile } = await AuthService.getUserProfile();

      if (!profile) return;

      // Redirect managers
      if (profile.role === 'manager') {
        navigation.navigate('ManagerQuickView' as never);
        return;
      }

      setUserId(profile.id);

      // Fetch all batch data in parallel instead of sequentially
      const batchNumbers = [1, 2, 3, 4];
      const [accessResults, scoreResults, attemptResults] = await Promise.all([
        Promise.all(batchNumbers.map(i => BatchService.canAccessBatch(profile.id, i))),
        Promise.all(batchNumbers.map(i => BatchService.getBatchAverageScore(profile.id, i))),
        Promise.all(batchNumbers.map(i => BatchService.getBatchAttempts(profile.id, i))),
      ]);

      // Build statuses array from parallel results
      const statuses: BatchStatus[] = batchNumbers.map((batchNum, index) => ({
        batchNumber: batchNum,
        canAccess: accessResults[index],
        averageScore: scoreResults[index],
        attemptCount: attemptResults[index].length,
        passed: scoreResults[index] >= 60,
      }));

      setBatchStatuses(statuses);
      lastLoadTime.current = Date.now(); // Update cache timestamp
    } catch (error) {
      console.error('Error loading batch statuses:', error);
      // Only show error alert on initial failures
      if (isInitialLoad) {
        Alert.alert(t('common.error', 'Error'), 'Failed to load batch progress');
      }
    } finally {
      setLoading(false);
      setIsInitialLoad(false);
    }
  };

  const handleBatchPress = (batchNumber: number, canAccess: boolean) => {
    if (canAccess) {
      // @ts-ignore - navigation type mismatch
      navigation.navigate('Quiz', { batchNumber });
    }
  };

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>{t('mission.loading', 'Loading...')}</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" />
        
        <View style={styles.header}>
          <Text style={styles.title}>SafePass Training</Text>
          <Text style={styles.subtitle}>Select a batch to continue your training</Text>
        </View>

        <ScrollView contentContainerStyle={styles.content}>
          {batchStatuses.map((batch) => (
            <TouchableOpacity
              key={batch.batchNumber}
              style={[
                styles.batchCard,
                !batch.canAccess && styles.batchCardLocked,
                batch.passed && styles.batchCardPassed,
              ]}
              onPress={() => handleBatchPress(batch.batchNumber, batch.canAccess)}
              disabled={!batch.canAccess}
              activeOpacity={0.7}
            >
              <View style={styles.batchHeader}>
                <View style={styles.batchTitleRow}>
                  {!batch.canAccess ? (
                    <Lock size={32} color="#999" />
                  ) : batch.passed ? (
                    <CheckCircle size={32} color="#00C853" />
                  ) : batch.attemptCount > 0 ? (
                    <AlertCircle size={32} color="#FF9800" />
                  ) : (
                    <PlayCircle size={32} color={colors.primary.DEFAULT} />
                  )}
                  <View style={styles.batchTitleContainer}>
                    <Text style={styles.batchTitle}>Batch {batch.batchNumber}</Text>
                    <Text style={styles.batchSubtitle}>30 Questions • Unlimited Attempts</Text>
                  </View>
                </View>
              </View>

              <View style={styles.batchStats}>
                {batch.attemptCount > 0 ? (
                  <>
                    <View style={styles.statRow}>
                      <Text style={styles.statLabel}>Average Score:</Text>
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
                    <View style={styles.statRow}>
                      <Text style={styles.statLabel}>Attempts:</Text>
                      <Text style={styles.statValue}>{batch.attemptCount}</Text>
                    </View>
                    <View style={styles.statRow}>
                      <Text style={styles.statLabel}>Status:</Text>
                      <Text
                        style={[
                          styles.statValue,
                          batch.passed && styles.statValuePassed,
                          !batch.passed && styles.statValueFailed,
                        ]}
                      >
                        {batch.passed
                          ? '✓ Passed'
                          : `Need ${(60 - batch.averageScore).toFixed(1)}% more to pass`}
                      </Text>
                    </View>
                  </>
                ) : batch.canAccess ? (
                  <Text style={styles.notStartedText}>Tap to start →</Text>
                ) : (
                  <Text style={styles.lockedText}>
                    🔒 Complete Batch {batch.batchNumber - 1} with ≥60% average to unlock
                  </Text>
                )}
              </View>
            </TouchableOpacity>
          ))}

          <View style={styles.infoCard}>
            <Text style={styles.infoTitle}>How it works:</Text>
            <Text style={styles.infoText}>
              • Each batch has 30 questions{'\n'}
              • Unlimited attempts per question{'\n'}
              • 1st try: 1 mark | 2nd: 0.5 | 3rd: 0.25 | 4th+: 0{'\n'}
              • Pass with ≥60% average to unlock next batch{'\n'}
              • Re-attempts average with previous scores
            </Text>
          </View>
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
});
