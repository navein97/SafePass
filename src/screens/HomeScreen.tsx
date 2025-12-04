import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { Shield, AlertCircle, CheckCircle, User } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';

export const HomeScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<any>(null);
  const [safetyIndex, setSafetyIndex] = useState(0);
  const [isCompliant, setIsCompliant] = useState(false);

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
      }
    } catch (error) {
      console.error('Error loading home data:', error);
    } finally {
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>Loading...</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <ScrollView 
          contentContainerStyle={styles.scrollContent} 
          bounces={true}
          showsVerticalScrollIndicator={false}
        >
          {/* Header */}
          <View style={styles.header}>
            <View>
              <Text style={styles.greeting}>Hello, {profile?.full_name || 'Driver'}</Text>
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
                <User size={24} color={colors.text.primary} />
              </LinearGradient>
            </TouchableOpacity>
          </View>

          {/* Safety Index Card */}
          <GlassCard style={styles.card}>
            <Text style={styles.cardTitle}>{t('home.safetyIndex')}</Text>
            <View style={styles.scoreContainer}>
              <Shield size={48} color={colors.primary.DEFAULT} />
              <Text style={styles.score}>{safetyIndex}</Text>
            </View>
            <View style={styles.progressBarBg}>
              <LinearGradient
                colors={colors.gradients.primary as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={[styles.progressBarFill, { width: `${safetyIndex}%` }]}
              />
            </View>
            <Text style={styles.scoreSubtext}>90-day rolling average</Text>
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
              {isCompliant ? 'Great job! You are up to date.' : t('home.quizDue')}
            </Text>
            
            <GlassButton
              title={isCompliant ? 'Practice Quiz' : t('home.startQuiz')}
              onPress={() => navigation.navigate('Quiz')}
              variant={isCompliant ? 'primary' : 'danger'}
              style={styles.actionButton}
            />
          </GlassCard>
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
    borderColor: 'rgba(52, 199, 89, 0.3)',
    backgroundColor: 'rgba(52, 199, 89, 0.05)',
  },
  cardDanger: {
    borderColor: 'rgba(255, 59, 48, 0.3)',
    backgroundColor: 'rgba(255, 59, 48, 0.05)',
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
    textShadowColor: 'rgba(0, 122, 255, 0.5)',
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 10,
  },
  progressBarBg: {
    height: 8,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
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
});

