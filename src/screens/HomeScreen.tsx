import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { Shield, AlertCircle, CheckCircle, User, Users } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { QuizStorageService } from '../services/quizStorageService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';

export const HomeScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<any>(null);
  const [safetyIndex, setSafetyIndex] = useState(0);
  const [isCompliant, setIsCompliant] = useState(false);
  const [dailyCount, setDailyCount] = useState(0);
  const [streak, setStreak] = useState(0);

  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      setLoading(true);

      // Get user profile
      const { profile: userProfile } = await AuthService.getUserProfile();
      if (userProfile) {
        setProfile(userProfile);
        setSafetyIndex(userProfile.safety_index || 0);

        // Check if completed this week
        const completed = await QuizService.hasCompletedThisWeek(userProfile.id);
        setIsCompliant(completed);

        // Get Daily Stats
        const count = await QuizStorageService.getDailyCount(userProfile.id);
        setDailyCount(count);

        const currentStreak = await QuizStorageService.getStreak(userProfile.id);
        setStreak(currentStreak);

        // Run Decay Check (Side effect, don't await blocking UI)
        QuizService.checkShieldDecay(userProfile.id).then(() => {
           // Optional: Reload profile if decay happened? 
           // For now, next load will show it.
        });
      }
    } catch (error) {
      console.error('Error loading home data:', error);
    } finally {
      setLoading(false);
    }
  };

  const isManager = profile?.role === 'manager';

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>{t('common.loading', 'Loading...')}</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <ScrollView 
          contentContainerStyle={styles.scrollContent} 
          bounces={true}
          showsVerticalScrollIndicator={false}
        >
          {/* Header */}
          <View style={styles.header}>
            <View>
              <Text style={styles.greeting}>{t('home.hello')}, {profile?.full_name || t('home.driver')}</Text>
              <Text style={styles.date}>{new Date().toLocaleDateString(undefined, { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' })}</Text>
            </View>
            <TouchableOpacity 
              style={styles.profileButton}
              onPress={() => navigation.navigate('Profile')}
            >
              <LinearGradient
                colors={colors.gradients.primary as any}
                style={styles.avatar}
              >
                <User size={24} color={colors.text.inverse} />
              </LinearGradient>
            </TouchableOpacity>
          </View>

          {isManager ? (
            /* Manager Dashboard View */
            <GlassCard style={styles.card}>
              <Text style={styles.cardTitle}>{t('manager.dashboardTitle')}</Text>
              <View style={{ alignItems: 'center', paddingVertical: 30 }}>
                <Users size={64} color={colors.primary.DEFAULT} />
                <Text style={[styles.statusText, { textAlign: 'center', marginTop: 16 }]}>{t('manager.teamOverview')}</Text>
                <Text style={[styles.statusSubtext, { textAlign: 'center' }]}>
                  {t('manager.monitorCompliance')}
                </Text>
              </View>
              <GlassButton 
                title={t('manager.viewTeamStats')}
                onPress={() => navigation.navigate('ManagerQuickView')}
                icon={<Shield color={colors.text.primary} size={20} />}
                style={styles.actionButton}
              />
            </GlassCard>
          ) : (
            /* Staff Dashboard View */
            <>
              {/* Daily Progress & Streak Card */}
              <GlassCard style={styles.card}>
                <Text style={styles.cardTitle}>{t('home.dailyGoal', 'Daily Goal')}</Text>
                
                {/* Progress Bar for 3 Questions */}
                <View style={styles.scoreContainer}>
                   <View style={{flex: 1}}>
                      <View style={{flexDirection: 'row', justifyContent: 'space-between', marginBottom: 8}}>
                        <Text style={[styles.statusText, {fontSize: 18, marginVertical: 0}]}>
                            {dailyCount}/3 {t('home.questions', 'Questions')}
                        </Text>
                        <Text style={[styles.statusText, {fontSize: 18, marginVertical: 0, color: colors.primary.DEFAULT}]}>
                            {Math.min(100, Math.round((dailyCount/3)*100))}%
                        </Text>
                      </View>
                      <View style={styles.progressBarBg}>
                        <LinearGradient
                            colors={colors.gradients.primary as any}
                            start={{ x: 0, y: 0 }}
                            end={{ x: 1, y: 0 }}
                            style={[styles.progressBarFill, { width: `${Math.min(100, (dailyCount/3)*100)}%` }]}
                        />
                      </View>
                   </View>
                </View>

                <View style={{flexDirection: 'row', alignItems: 'center', gap: 8, marginTop: 8}}>
                    <Text style={{fontSize: 24}}>🔥</Text>
                    <View>
                        <Text style={[styles.scoreSubtext, {marginBottom: 0}]}>{t('home.currentStreak', 'Current Streak')}</Text>
                        <Text style={[styles.statusText, {fontSize: 20, marginVertical: 0}]}>{streak} {t('home.days', 'Days')}</Text>
                    </View>
                </View>
                
                <Text style={[styles.scoreSubtext, { marginTop: 16, fontStyle: 'italic' }]}>
                    {dailyCount >= 3 
                        ? t('home.greatJobComplete', "Great job! You've reached your daily goal.") 
                        : t('home.keepGoing', "Keep learning to stay safe!")}
                </Text>
              </GlassCard>

              {/* Weekly Status Card */}
              <GlassCard style={[
                styles.card, 
                isCompliant ? styles.cardSuccess : styles.cardDanger
              ]}>
                <View style={styles.statusHeader}>
                  <Text style={styles.cardTitle}>{t('home.weeklyStatus')}</Text>
                  {isCompliant ? (
                    <CheckCircle size={24} color={colors.status.success} />
                  ) : (
                    <AlertCircle size={24} color={colors.status.danger} />
                  )}
                </View>
                <Text style={[styles.statusText, { color: isCompliant ? colors.status.success : colors.status.danger }]}>
                  {isCompliant ? t('home.compliant') : t('home.overdue')}
                </Text>
                <Text style={styles.statusSubtext}>
                  {isCompliant ? t('home.greatJob') : t('home.quizDue')}
                </Text>
                
                <View style={{ marginTop: 16 }}>
                    <TouchableOpacity 
                        style={[styles.modeButton, { backgroundColor: colors.status.danger + '20', borderColor: colors.status.danger }]}
                        onPress={() => navigation.navigate('Quiz', { mode: 'live' })}
                    >
                        <Text style={[styles.modeButtonTitle, { color: colors.status.danger }]}>Start Quiz (Live)</Text>
                        <Text style={styles.modeButtonDesc}>
                          Records results and counts toward the Safety Score and Daily Goal (3 questions).
                        </Text>
                    </TouchableOpacity>

                    <TouchableOpacity 
                        style={[styles.modeButton, { backgroundColor: colors.primary.DEFAULT + '20', borderColor: colors.primary.DEFAULT, marginTop: 12 }]}
                        onPress={() => navigation.navigate('Quiz', { mode: 'practice' })}
                    >
                        <Text style={[styles.modeButtonTitle, { color: colors.primary.DEFAULT }]}>Practice Mode</Text>
                        <Text style={styles.modeButtonDesc}>
                           Unlimited questions, no results recorded, and no impact on the Safety Score.
                        </Text>
                    </TouchableOpacity>
                </View>
              </GlassCard>
            </>
          )}
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

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
    color: colors.text.secondary,
    marginTop: 16,
    fontFamily: typography.fonts.medium,
  },
  scrollContent: {
    padding: 24,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 32,
    marginTop: 10,
  },
  greeting: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
  },
  date: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
  },
  profileButton: {
    shadowColor: colors.primary.DEFAULT,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 5,
  },
  avatar: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
  },
  card: {
    marginBottom: 24,
  },
  cardSuccess: {
    borderColor: colors.status.success + '4D', // 30% opacity
    backgroundColor: colors.status.success + '1A', // 10% opacity
  },
  cardDanger: {
    borderColor: colors.status.danger + '4D',
    backgroundColor: colors.status.danger + '1A',
  },
  cardTitle: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    marginBottom: 16,
  },
  scoreContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 16,
    marginBottom: 16,
  },
  score: {
    fontSize: 56,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textShadowColor: colors.mode === 'dark' ? 'rgba(0, 122, 255, 0.5)' : 'rgba(0,0,0,0.1)',
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 10,
  },
  progressBarBg: {
    height: 8,
    backgroundColor: colors.background.subtle,
    borderRadius: 4,
    overflow: 'hidden',
    marginBottom: 8,
  },
  progressBarFill: {
    height: '100%',
    borderRadius: 4,
  },
  scoreSubtext: {
    fontSize: typography.sizes.xs,
    color: colors.text.tertiary,
    fontFamily: typography.fonts.regular,
  },
  statusHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  statusText: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    marginTop: 8,
    marginBottom: 8,
    color: colors.text.primary,
  },
  statusSubtext: {
    fontSize: typography.sizes.sm,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
    marginBottom: 20,
  },
  actionButton: {
    marginTop: 8,
  },
  modeButton: {
    padding: 16,
    borderRadius: 12,
    borderWidth: 1,
  },
  modeButtonTitle: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    marginBottom: 4,
  },
  modeButtonDesc: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 16,
  },
});

