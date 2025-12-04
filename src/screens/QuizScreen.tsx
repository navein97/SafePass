import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { QuizService } from '../services/quizService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { ChevronRight, ChevronLeft } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';

export const QuizScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<{ questionId: string; selectedOptionIndex: number; isCorrect: boolean }[]>([]);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [loading, setLoading] = useState(true);
  const [loadingStatus, setLoadingStatus] = useState('Initializing...');
  const [userId, setUserId] = useState<string>('');

  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    try {
      setLoading(true);
      setLoadingStatus('Fetching user profile...');
      
      // Get user profile to determine region
      const { profile, error } = await AuthService.getUserProfile();
      
      if (error || !profile) {
        console.error('Profile load error:', error);
        Alert.alert(
          'Session Error', 
          'Could not load user profile. Please try again or re-login.',
          [
            { text: 'Retry', onPress: () => loadQuiz() },
            { text: 'Login', onPress: () => navigation.replace('Login') }
          ]
        );
        return;
      }

      console.log('User Profile loaded:', profile.region);
      setUserId(profile.id);
      setLoadingStatus(`Loading questions for ${profile.region}...`);

      // Load questions for user's region
      const loadedQuestions = await QuizService.generateWeeklyQuiz(profile.region);
      console.log('Questions loaded for region:', loadedQuestions.length);
      
      if (loadedQuestions.length === 0) {
        Alert.alert(
          'No Questions', 
          `No questions found for your region (${profile.region}).`
        );
        navigation.goBack();
        return;
      }

      setQuestions(loadedQuestions);
    } catch (error) {
      console.error('Error loading quiz:', error);
      Alert.alert('Error', 'Failed to load quiz. Please try again.');
      navigation.goBack();
    } finally {
      setLoading(false);
    }
  };

  const handleNext = () => {
    if (selectedOption === null) {
      Alert.alert('Please select an answer');
      return;
    }

    const currentQuestion = questions[currentIndex];
    const isCorrect = selectedOption === currentQuestion.correctOptionIndex;

    const newAnswers = [...answers, {
      questionId: currentQuestion.id,
      selectedOptionIndex: selectedOption,
      isCorrect
    }];

    setAnswers(newAnswers);

    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setSelectedOption(null);
    } else {
      handleSubmit(newAnswers);
    }
  };

  const handleSubmit = async (finalAnswers: typeof answers) => {
    try {
      setLoading(true);
      setLoadingStatus('Submitting results...');
      const { score, attempt } = await QuizService.submitQuiz(userId, finalAnswers);
      navigation.replace('Review', { attempt, questions });
    } catch (error) {
      console.error('Error submitting quiz:', error);
      Alert.alert('Error', 'Failed to submit quiz. Please try again.');
      setLoading(false);
    }
  };

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>
            {loadingStatus}
          </Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  if (questions.length === 0) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <Text style={styles.errorTitle}>
            Unable to load quiz
          </Text>
          <Text style={styles.errorText}>
            We couldn't find any questions for your region, or there was a connection error.
          </Text>
          <GlassButton 
            title="Go Back"
            onPress={() => navigation.goBack()}
            style={{ width: 200 }}
          />
          <TouchableOpacity 
            onPress={loadQuiz}
            style={{ marginTop: 20 }}
          >
            <Text style={{ color: colors.primary.light, fontFamily: typography.fonts.medium }}>Try Again</Text>
          </TouchableOpacity>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  const currentQuestion = questions[currentIndex];
  const progress = ((currentIndex + 1) / questions.length) * 100;

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        {/* Header / Progress */}
        <View style={styles.header}>
          <View style={styles.headerTop}>
            <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
              <ChevronLeft color={colors.text.primary} size={28} />
            </TouchableOpacity>
            <Text style={styles.progressText}>
              {t('quiz.question')} {currentIndex + 1} {t('quiz.of')} {questions.length}
            </Text>
          </View>
          <View style={styles.progressBarBg}>
            <LinearGradient
              colors={colors.gradients.primary as any}
              start={{ x: 0, y: 0 }}
              end={{ x: 1, y: 0 }}
              style={[styles.progressBarFill, { width: `${progress}%` }]}
            />
          </View>
        </View>

        <ScrollView contentContainerStyle={styles.content} bounces={true} showsVerticalScrollIndicator={false}>
          <GlassCard style={styles.questionCard}>
            <Text style={styles.questionText}>{currentQuestion.text}</Text>
          </GlassCard>

          <View style={styles.optionsContainer}>
            {currentQuestion.options.map((option, index) => (
              <TouchableOpacity
                key={index}
                activeOpacity={0.8}
                onPress={() => setSelectedOption(index)}
              >
                <GlassCard 
                  style={[
                    styles.optionButton,
                    selectedOption === index && styles.optionSelected
                  ]}
                  intensity={selectedOption === index ? 40 : 20}
                >
                  <View style={styles.optionContent}>
                    <View style={[
                      styles.radioCircle,
                      selectedOption === index && styles.radioSelected
                    ]}>
                      {selectedOption === index && <View style={styles.radioInner} />}
                    </View>
                    <Text style={[
                      styles.optionText,
                      selectedOption === index && styles.optionTextSelected
                    ]}>
                      {option}
                    </Text>
                  </View>
                </GlassCard>
              </TouchableOpacity>
            ))}
          </View>
        </ScrollView>

        <View style={styles.footer}>
          <GlassButton
            title={currentIndex === questions.length - 1 ? t('quiz.finish') : t('common.next')}
            onPress={handleNext}
            icon={<ChevronRight color={colors.text.primary} size={20} />}
            style={styles.nextButton}
          />
        </View>
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
    padding: 20,
  },
  loadingText: {
    color: colors.text.primary,
    marginTop: 20,
    textAlign: 'center',
    fontFamily: typography.fonts.medium,
  },
  errorTitle: {
    color: colors.text.primary,
    fontSize: 18,
    marginBottom: 10,
    textAlign: 'center',
    fontFamily: typography.fonts.bold,
  },
  errorText: {
    color: colors.text.secondary,
    marginBottom: 30,
    textAlign: 'center',
  },
  header: {
    padding: 24,
    paddingBottom: 12,
    marginTop: 10,
  },
  headerTop: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 16,
  },
  backButton: {
    marginRight: 16,
  },
  progressText: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    fontSize: 16,
  },
  progressBarBg: {
    height: 6,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    borderRadius: 3,
    overflow: 'hidden',
  },
  progressBarFill: {
    height: '100%',
    borderRadius: 3,
  },
  content: {
    padding: 24,
  },
  questionCard: {
    marginBottom: 24,
    minHeight: 150,
    justifyContent: 'center',
  },
  questionText: {
    fontSize: 22,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    lineHeight: 32,
    textAlign: 'center',
  },
  optionsContainer: {
    gap: 16,
  },
  optionButton: {
    padding: 0, // Reset padding since GlassCard has padding
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.1)',
  },
  optionContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  optionSelected: {
    borderColor: colors.primary.DEFAULT,
    backgroundColor: 'rgba(0, 122, 255, 0.2)',
  },
  radioCircle: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: colors.text.secondary,
    marginRight: 16,
    justifyContent: 'center',
    alignItems: 'center',
  },
  radioSelected: {
    borderColor: colors.primary.DEFAULT,
  },
  radioInner: {
    width: 12,
    height: 12,
    borderRadius: 6,
    backgroundColor: colors.primary.DEFAULT,
  },
  optionText: {
    fontSize: 16,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    flex: 1,
  },
  optionTextSelected: {
    color: colors.primary.light,
    fontFamily: typography.fonts.bold,
  },
  footer: {
    padding: 24,
    paddingBottom: 34,
  },
  nextButton: {
    width: '100%',
  },
});

