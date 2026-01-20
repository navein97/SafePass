import React, { useState, useEffect, useMemo, useRef } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar, Image } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { QuizService } from '../services/quizService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { ChevronRight, ChevronLeft, Check, XCircle, AlertCircle } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';

const QUIZ_IMAGES: Record<string, any> = {
  'stop_sign': require('../../assets/quiz/stop_sign.jpg'),
  'pedestrian_crossing': require('../../assets/quiz/pedestrian_crossing.jpg'),
  'no_entry': require('../../assets/quiz/no_entry.jpg'),
  'turn_right': require('../../assets/quiz/turn_right.jpg'),
  'warning': require('../../assets/quiz/warning.jpg'),
};

export const QuizScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<{ questionId: string; selectedOptionIndex: number; isCorrect: boolean }[]>([]);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadingStatus, setLoadingStatus] = useState(t('common.initializing'));
  const [userId, setUserId] = useState<string>('');

  const styles = useMemo(() => createStyles(colors), [colors]);
  const scrollViewRef = useRef<ScrollView>(null);

  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    try {
      setLoading(true);
      setLoadingStatus(t('common.fetchingProfile'));
      
      const { profile, error } = await AuthService.getUserProfile();
      
      if (error || !profile) {
        console.error('Profile load error:', error);
        Alert.alert(
          t('common.error'), 
          t('auth.sessionError'),
          [
            { text: t('common.retry'), onPress: () => loadQuiz() },
            { text: t('auth.login'), onPress: () => navigation.replace('Login') }
          ]
        );
        return;
      }

      console.log('User Profile loaded:', profile.region);
      setUserId(profile.id);
      setLoadingStatus(t('quiz.loadingQuestionsFor', { region: profile.region }));

      const loadedQuestions = await QuizService.generateWeeklyQuiz(profile.region);
      console.log('Questions loaded for region:', loadedQuestions.length);
      
      if (loadedQuestions.length === 0) {
        Alert.alert(
          t('quiz.noQuestionsTitle'), 
          t('quiz.noQuestionsMessage', { region: profile.region })
        );
        navigation.goBack();
        return;
      }

      setQuestions(loadedQuestions);
    } catch (error) {
      console.error('Error loading quiz:', error);
      Alert.alert(t('common.error'), t('quiz.loadFailed'));
      navigation.goBack();
    } finally {
      setLoading(false);
    }
  };

  const handleOptionSelect = (index: number) => {
    if (isAnswered) return;

    setSelectedOption(index);
    setIsAnswered(true);

    const currentQuestion = questions[currentIndex];
    const isCorrect = index === currentQuestion.correctOptionIndex;

    const newAnswer = {
      questionId: currentQuestion.id,
      selectedOptionIndex: index,
      isCorrect
    };

    setAnswers([...answers, newAnswer]);
    
    // Auto-scroll to show feedback
    setTimeout(() => {
      scrollViewRef.current?.scrollToEnd({ animated: true });
    }, 100);
  };

  const handleNext = () => {
    if (currentIndex < questions.length - 1) {
      setCurrentIndex(currentIndex + 1);
      setSelectedOption(null);
      setIsAnswered(false);
    } else {
      handleSubmit(answers);
    }
  };

  const handleSubmit = async (finalAnswers: typeof answers) => {
    try {
      setLoading(true);
      setLoadingStatus(t('quiz.submitting'));
      const { score, attempt } = await QuizService.submitQuiz(userId, finalAnswers, questions);
      navigation.replace('Review', { attempt, questions });
    } catch (error) {
      console.error('Error submitting quiz:', error);
      Alert.alert(t('common.error'), t('quiz.submitFailed'));
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
            {t('quiz.unableToLoad')}
          </Text>
          <Text style={styles.errorText}>
            {t('quiz.noQuestionsFound')}
          </Text>
          <GlassButton 
            title={t('common.goBack')}
            onPress={() => navigation.goBack()}
            style={{ width: 200 }}
          />
          <TouchableOpacity 
            onPress={loadQuiz}
            style={{ marginTop: 20 }}
          >
            <Text style={{ color: colors.primary.light, fontFamily: typography.fonts.medium }}>{t('common.tryAgain')}</Text>
          </TouchableOpacity>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  const currentQuestion = questions[currentIndex];
  const progress = ((currentIndex + 1) / questions.length) * 100;

  // Feedback Rendering Logic
  const getOptionStyle = (index: number) => {
    if (!isAnswered) {
      return selectedOption === index ? styles.optionSelected : {};
    }

    if (index === currentQuestion.correctOptionIndex) {
      return styles.optionCorrect;
    }

    if (selectedOption === index && index !== currentQuestion.correctOptionIndex) {
      return styles.optionWrong;
    }

    return styles.optionDisabled; // Dim other options
  };

  const getOptionIcon = (index: number) => {
    if (!isAnswered) {
      return selectedOption === index ? <View style={styles.radioInner} /> : null;
    }
    
    if (index === currentQuestion.correctOptionIndex) {
      return <Check size={16} color={colors.status.success} strokeWidth={4} />;
    }

    if (selectedOption === index && index !== currentQuestion.correctOptionIndex) {
      return <XCircle size={16} color={colors.status.danger} />;
    }

    return null;
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        
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

        <ScrollView 
          ref={scrollViewRef}
          contentContainerStyle={styles.content} 
          bounces={true} 
          showsVerticalScrollIndicator={false}
        >
          <GlassCard style={styles.questionCard}>
            {currentQuestion.imageUrl && QUIZ_IMAGES[currentQuestion.imageUrl] && (
              <Image 
                source={QUIZ_IMAGES[currentQuestion.imageUrl]}
                style={styles.questionImage}
                resizeMode="contain"
              />
            )}
            <Text style={styles.questionText}>{currentQuestion.text}</Text>
          </GlassCard>

          <View style={styles.optionsContainer}>
            {currentQuestion.options.map((option, index) => (
              <TouchableOpacity
                key={index}
                activeOpacity={isAnswered ? 1 : 0.8}
                onPress={() => handleOptionSelect(index)}
                disabled={isAnswered}
              >
                <GlassCard 
                  style={[
                    styles.optionButton,
                    getOptionStyle(index)
                  ]}
                  intensity={selectedOption === index || (isAnswered && index === currentQuestion.correctOptionIndex) ? 40 : 20}
                >
                  <View style={styles.optionContent}>
                    <View style={[
                      styles.radioCircle,
                      isAnswered && index === currentQuestion.correctOptionIndex && styles.radioCorrect,
                      isAnswered && selectedOption === index && index !== currentQuestion.correctOptionIndex && styles.radioWrong,
                      !isAnswered && selectedOption === index && styles.radioSelected
                    ]}>
                      {getOptionIcon(index)}
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

          {/* Instant Feedback Section */}
          {isAnswered && (
             <View style={styles.feedbackContainer}>
                {selectedOption === currentQuestion.correctOptionIndex ? (
                    <GlassCard style={[styles.feedbackCard, { borderColor: colors.status.success, borderLeftWidth: 4 }]}>
                         <View style={styles.feedbackHeader}>
                            <Check size={24} color={colors.status.success} />
                            <Text style={[styles.feedbackTitle, { color: colors.status.success }]}>{t('quiz.correct')}</Text>
                         </View>
                         {currentQuestion.explanation && (
                             <Text style={styles.feedbackText}>{currentQuestion.explanation}</Text>
                         )}
                    </GlassCard>
                ) : (
                    <GlassCard style={[styles.feedbackCard, { borderColor: colors.status.danger, borderLeftWidth: 4 }]}>
                         <View style={styles.feedbackHeader}>
                            <AlertCircle size={24} color={colors.status.danger} />
                            <Text style={[styles.feedbackTitle, { color: colors.status.danger }]}>{t('quiz.incorrect')}</Text>
                         </View>
                         <Text style={styles.feedbackText}>
                             {t('quiz.correctAnswerIs')} <Text style={{fontFamily: typography.fonts.bold}}>{currentQuestion.options[currentQuestion.correctOptionIndex]}</Text>.
                         </Text>
                         {currentQuestion.explanation && (
                             <Text style={[styles.feedbackText, { marginTop: 8 }]}>{currentQuestion.explanation}</Text>
                         )}
                    </GlassCard>
                )}
             </View>
          )}

        </ScrollView>

        {isAnswered && (
          <View style={styles.footer}>
            <GlassButton
              title={currentIndex === questions.length - 1 ? t('quiz.finish') : t('common.next')}
              onPress={handleNext}
              icon={<ChevronRight color={colors.text.primary} size={20} />}
              style={styles.nextButton}
            />
          </View>
        )}
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
    backgroundColor: colors.background.subtle,
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
  questionImage: {
    width: '100%',
    height: 200,
    marginBottom: 20,
    borderRadius: 8,
  },
  optionsContainer: {
    gap: 16,
  },
  optionButton: {
    padding: 0,
    borderWidth: 1,
    borderColor: colors.border,
  },
  optionContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  optionSelected: {
    borderColor: colors.primary.DEFAULT,
    backgroundColor: colors.mode === 'dark' ? 'rgba(255, 215, 0, 0.15)' : 'rgba(255, 215, 0, 0.1)',
  },
  optionCorrect: {
    borderColor: colors.status.success,
    backgroundColor: colors.mode === 'dark' ? 'rgba(0, 200, 83, 0.15)' : 'rgba(0, 200, 83, 0.1)',
  },
  optionWrong: {
    borderColor: colors.status.danger,
    backgroundColor: colors.mode === 'dark' ? 'rgba(255, 61, 0, 0.15)' : 'rgba(255, 61, 0, 0.1)',
  },
  optionDisabled: {
    opacity: 0.5,
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
  radioCorrect: {
    borderColor: colors.status.success,
    backgroundColor: 'rgba(0, 200, 83, 0.2)',
  },
  radioWrong: {
     borderColor: colors.status.danger,
     backgroundColor: 'rgba(255, 61, 0, 0.2)',
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
  feedbackContainer: {
    marginTop: 24,
    marginBottom: 20,
  },
  feedbackCard: {
    padding: 16,
  },
  feedbackHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    gap: 8,
  },
  feedbackTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
  },
  feedbackText: {
    color: colors.text.primary,
    fontSize: 15,
    lineHeight: 22,
    fontFamily: typography.fonts.regular,
  },
  footer: {
    padding: 24,
    paddingBottom: 34,
  },
  nextButton: {
    width: '100%',
  },
});

