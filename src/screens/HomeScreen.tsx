import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { Shield, AlertCircle, CheckCircle, User } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';

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
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.light} />
          <Text style={styles.loadingText}>Loading...</Text>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContent} bounces={true}>
        {/* Header */}
        <View style={styles.header}>
          <View>
            <Text style={styles.greeting}>Hello, {profile?.full_name || 'Driver'}</Text>
            <Text style={styles.date}>{new Date().toLocaleDateString()}</Text>
          </View>
          <TouchableOpacity 
            style={styles.profileButton}
            onPress={() => navigation.navigate('Profile')}
          >
            <View style={styles.avatar}>
              <User size={24} color={colors.primary.light} />
            </View>
          </TouchableOpacity>
        </View>

        {/* Safety Index Card */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>{t('home.safetyIndex')}</Text>
          <View style={styles.scoreContainer}>
            <Shield size={48} color={colors.primary.light} />
            <Text style={styles.score}>{safetyIndex}</Text>
          </View>
          <View style={styles.progressBarBg}>
            <View style={[styles.progressBarFill, { width: `${safetyIndex}%` }]} />
          </View>
          <Text style={styles.scoreSubtext}>90-day rolling average</Text>
        </View>

        {/* Weekly Status Card */}
        <View style={[styles.card, isCompliant ? styles.cardSuccess : styles.cardDanger]}>
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
          
          {/* Always show quiz button for easy access */}
          <TouchableOpacity 
            style={[styles.actionButton, isCompliant && styles.actionButtonSecondary]}
            onPress={() => navigation.navigate('Quiz')}
          >
            <Text style={styles.actionButtonText}>
              {isCompliant ? 'Practice Quiz' : t('home.startQuiz')}
            </Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
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
  },
  greeting: {
    fontSize: typography.sizes['2xl'],
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  date: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
  },
  profileButton: {
    padding: 4,
  },
  avatar: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: colors.primary.dark,
    borderWidth: 2,
    borderColor: colors.primary.light,
    justifyContent: 'center',
    alignItems: 'center',
  },
  card: {
    backgroundColor: colors.background.paper,
    borderRadius: 16,
    padding: 24,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: colors.border,
  },
  cardSuccess: {
    borderColor: 'rgba(16, 185, 129, 0.2)',
    backgroundColor: 'rgba(16, 185, 129, 0.05)',
  },
  cardDanger: {
    borderColor: 'rgba(239, 68, 68, 0.2)',
    backgroundColor: 'rgba(239, 68, 68, 0.05)',
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
    fontSize: 48,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
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
    backgroundColor: colors.primary.light,
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
    fontSize: typography.sizes['2xl'],
    fontFamily: typography.fonts.bold,
    marginTop: 8,
    marginBottom: 8,
  },
  statusSubtext: {
    fontSize: typography.sizes.sm,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
  },
  actionButton: {
    backgroundColor: colors.status.danger,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 16,
  },
  actionButtonSecondary: {
    backgroundColor: colors.primary.DEFAULT,
  },
  actionButtonText: {
    color: colors.text.primary,
    fontFamily: typography.fonts.bold,
    fontSize: typography.sizes.base,
  },
});
