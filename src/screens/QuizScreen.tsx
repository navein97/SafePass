import React, { useState, useEffect, useMemo, useRef } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar, Image } from 'react-native';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { QuizService } from '../services/quizService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { ChevronRight, Check, X, AlertCircle, Heart, Clock } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';

const QUIZ_IMAGES: Record<string, any> = {
  'stop_sign': require('../../assets/quiz/stop_sign.jpg'),
  'pedestrian_crossing': require('../../assets/quiz/pedestrian_crossing.jpg'),
  'no_entry': require('../../assets/quiz/no_entry.jpg'),
  'turn_right': require('../../assets/quiz/turn_right.jpg'),
  'warning': require('../../assets/quiz/warning.jpg'),
};

// Option letters
const OPTION_LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

// End state types
type QuizEndState = 'completed' | 'timeout' | 'out_of_lives' | null;

export const QuizScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme } = useTheme();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<{ questionId: string; selectedOptionIndex: number; isCorrect: boolean }[]>([]);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadingStatus, setLoadingStatus] = useState(t('common.initializing'));
  const [userId, setUserId] = useState<string>('');
  
  // 3 Lives System
  const [lives, setLives] = useState(3);
  
  // Timer
  const [timeLeft, setTimeLeft] = useState<number | null>(null);
  const timerRef = useRef<NodeJS.Timeout | null>(null);
  
  // End State
  const [endState, setEndState] = useState<QuizEndState>(null);
  const [finalScore, setFinalScore] = useState(0);

  const styles = useMemo(() => createStyles(colors), [colors]);
  const scrollViewRef = useRef<ScrollView>(null);

  // Timer Effect
  useEffect(() => {
    if (questions.length > 0 && timeLeft !== null && timeLeft > 0 && !endState) {
      timerRef.current = setTimeout(() => {
        setTimeLeft(prev => (prev !== null && prev > 0 ? prev - 1 : 0));
      }, 1000);
    } else if (timeLeft === 0 && !endState) {
      handleEndQuiz('timeout');
    }
    return () => {
      if (timerRef.current) clearTimeout(timerRef.current);
    };
  }, [timeLeft, questions, endState]);

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
      
      if (profile.role === 'manager') {
        navigation.replace('ManagerQuickView');
        return;
      }

      setLoadingStatus(t('quiz.loadingQuestionsFor', { region: profile.region }));

      const savedCount = await AsyncStorage.getItem('QUIZ_QUESTION_COUNT');
      const savedDiff = await AsyncStorage.getItem('QUIZ_DIFFICULTY_PARAMS');
      
      const count = savedCount ? parseInt(savedCount, 10) : 5;
      let difficultySettings = undefined;
      if (savedDiff) {
        try { difficultySettings = JSON.parse(savedDiff); } catch(e) {}
      }

      const loadedQuestions = await QuizService.generateWeeklyQuiz(profile.region, count, difficultySettings);
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

      const savedTimer = await AsyncStorage.getItem('QUIZ_TIMER_DURATION');
      let calculatedDuration = loadedQuestions.length * 60;
      
      if (savedTimer) {
        calculatedDuration = parseInt(savedTimer, 10) * 60;
      }
      
      setTimeLeft(calculatedDuration);

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

    const rawQuestion = questions[currentIndex];
    const isCorrect = index === rawQuestion.correctOptionIndex;

    const newAnswer = {
      questionId: rawQuestion.id,
      selectedOptionIndex: index,
      isCorrect
    };

    const updatedAnswers = [...answers, newAnswer];
    setAnswers(updatedAnswers);

    if (!isCorrect) {
      const newLives = lives - 1;
      setLives(newLives);
      
      if (newLives <= 0) {
        setTimeout(() => {
          handleEndQuiz('out_of_lives', updatedAnswers);
        }, 1500);
        return;
      }
    }
    
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
      handleEndQuiz('completed');
    }
  };

  const handleEndQuiz = async (state: QuizEndState, currentAnswers?: typeof answers) => {
    const finalAnswers = currentAnswers || answers;
    const correctCount = finalAnswers.filter(a => a.isCorrect).length;
    const score = questions.length > 0 ? Math.round((correctCount / questions.length) * 100) : 0;
    
    setFinalScore(score);
    setEndState(state);
    
    if (timerRef.current) {
      clearTimeout(timerRef.current);
    }
  };

  const handleSubmitAndExit = async () => {
    try {
      setLoading(true);
      setLoadingStatus(t('quiz.submitting'));
      
      const formattedAnswers = answers.map(a => ({
        questionId: a.questionId,
        attempts: 1,
        isCorrect: a.isCorrect
      }));
      
      const { score, attempt } = await QuizService.submitQuiz(userId, formattedAnswers, questions);
      navigation.replace('Review', { attempt, questions });
    } catch (error) {
      console.error('Error submitting quiz:', error);
      Alert.alert(t('common.error'), t('quiz.submitFailed'));
      setLoading(false);
    }
  };

  const handleTryAgain = () => {
    setCurrentIndex(0);
    setAnswers([]);
    setSelectedOption(null);
    setIsAnswered(false);
    setLives(3);
    setEndState(null);
    
    const duration = questions.length * 60;
    setTimeLeft(duration);
  };

  // Language Selection Logic
  const rawQuestion = questions[currentIndex] || { options: [], text: '' };
  const currentQuestion = useMemo(() => {
    const isMalay = i18n.language === 'ms';
    return {
      ...rawQuestion,
      text: (isMalay && rawQuestion.text_ms) ? rawQuestion.text_ms : rawQuestion.text,
      options: (isMalay && rawQuestion.options_ms) ? rawQuestion.options_ms : rawQuestion.options,
      explanation: (isMalay && rawQuestion.explanation_ms) ? rawQuestion.explanation_ms : rawQuestion.explanation
    };
  }, [rawQuestion, i18n.language]);

  // Render Loading State
  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          <Text style={styles.loadingText}>{loadingStatus}</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  // Render End State Screen
  if (endState) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.endStateContainer}>
          <View style={styles.endStateCard}>
            {endState === 'completed' ? (
              <>
                <Check size={80} color="#00C853" strokeWidth={3} />
                <Text style={[styles.endStateTitle, { color: '#00C853' }]}>
                  {t('quiz.missionAccomplished', 'MISSION\nACCOMPLISHED!')}
                </Text>
              </>
            ) : endState === 'out_of_lives' ? (
              <>
                <X size={80} color="#FF3D00" />
                <Text style={[styles.endStateTitle, { color: '#FF3D00' }]}>
                  {t('quiz.outOfLives', 'OUT OF LIVES!')}
                </Text>
              </>
            ) : (
              <>
                <AlertCircle size={80} color="#FF9800" />
                <Text style={[styles.endStateTitle, { color: '#FF9800' }]}>
                  {t('quiz.timeUp', "TIME'S UP!")}
                </Text>
              </>
            )}
            
            <Text style={styles.endStateScore}>
              {t('quiz.score', 'Score')}: {finalScore}%
            </Text>
            
            <TouchableOpacity style={styles.doneButton} onPress={handleSubmitAndExit}>
              <Text style={styles.doneButtonText}>{t('common.done', 'Done')}</Text>
            </TouchableOpacity>
            
            <TouchableOpacity style={styles.tryAgainButton} onPress={handleTryAgain}>
              <Text style={styles.tryAgainText}>{t('common.tryAgain', 'Try Again')}</Text>
            </TouchableOpacity>
          </View>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  if (questions.length === 0) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <Text style={styles.errorTitle}>{t('quiz.unableToLoad')}</Text>
          <Text style={styles.errorText}>{t('quiz.noQuestionsFound')}</Text>
          <GlassButton 
            title={t('common.goBack')}
            onPress={() => navigation.goBack()}
            style={{ width: 200 }}
          />
        </SafeAreaView>
      </GradientBackground>
    );
  }

  // Get correct answer letter
  const correctAnswerLetter = OPTION_LETTERS[rawQuestion.correctOptionIndex];

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        
        {/* Header: Lives on LEFT, Timer on RIGHT */}
        <View style={styles.header}>
          <View style={styles.headerRow}>
            {/* Lives - Left Side */}
            <View style={styles.livesContainer}>
              {[...Array(3)].map((_, i) => (
                <Heart
                  key={i}
                  size={28}
                  color="#FF4444"
                  fill={i < lives ? '#FF4444' : 'transparent'}
                  strokeWidth={2}
                />
              ))}
            </View>

            {/* Timer - Right Side */}
            {timeLeft !== null && (
              <View style={[styles.timerPill, timeLeft < 60 && styles.timerWarning]}>
                <Clock size={18} color={timeLeft < 60 ? '#FF3D00' : colors.text.primary} />
                <Text style={[styles.timerText, { color: colors.text.primary }, timeLeft < 60 && styles.timerTextWarning]}>
                  {Math.floor(timeLeft / 60)}:{(timeLeft % 60).toString().padStart(2, '0')}
                </Text>
              </View>
            )}
          </View>

          {/* Question Progress - Centered */}
          <Text style={styles.progressText}>
            {t('quiz.question', 'Question')} {currentIndex + 1} / {questions.length}
          </Text>
        </View>

        <ScrollView 
          ref={scrollViewRef}
          contentContainerStyle={styles.content} 
          bounces={true} 
          showsVerticalScrollIndicator={false}
        >
          {/* Question Card */}
          <View style={styles.questionCard}>
            {currentQuestion.imageUrl && QUIZ_IMAGES[currentQuestion.imageUrl] && (
              <Image 
                source={QUIZ_IMAGES[currentQuestion.imageUrl]}
                style={styles.questionImage}
                resizeMode="contain"
              />
            )}
            <Text style={styles.questionText}>{currentQuestion.text}</Text>
          </View>

          {/* Options with A, B, C, D */}
          <View style={styles.optionsContainer}>
            {currentQuestion.options.map((option, index) => {
              const isSelected = selectedOption === index;
              const isCorrectOption = index === rawQuestion.correctOptionIndex;
              const userWasWrong = isAnswered && isSelected && !isCorrectOption;
              const showAsCorrect = isAnswered && isCorrectOption; // Always show correct answer in green when answered
              const isDimmed = isAnswered && !isSelected && !isCorrectOption;

              return (
                <TouchableOpacity
                  key={index}
                  activeOpacity={isAnswered ? 1 : 0.7}
                  onPress={() => handleOptionSelect(index)}
                  disabled={isAnswered}
                  style={[
                    styles.optionCard,
                    showAsCorrect && styles.optionCorrect,
                    userWasWrong && styles.optionWrong,
                    isDimmed && styles.optionDimmed,
                  ]}
                >
                  <Text style={[
                    styles.optionLetter,
                    showAsCorrect && styles.optionLetterCorrect,
                    userWasWrong && styles.optionLetterWrong,
                  ]}>
                    {OPTION_LETTERS[index]}
                  </Text>
                  <Text style={[
                    styles.optionText,
                    showAsCorrect && styles.optionTextCorrect,
                    userWasWrong && styles.optionTextWrong,
                  ]}>
                    {option}
                  </Text>
                  
                  {/* Icons on the right */}
                  {showAsCorrect && (
                    <Check size={24} color="#00C853" strokeWidth={3} />
                  )}
                  {userWasWrong && (
                    <X size={24} color="#FF3D00" strokeWidth={3} />
                  )}
                </TouchableOpacity>
              );
            })}
          </View>

          {/* Feedback: "The correct answer is X" */}
          {isAnswered && selectedOption !== rawQuestion.correctOptionIndex && (
            <View style={styles.feedbackCard}>
              <AlertCircle size={20} color="#FF3D00" />
              <Text style={styles.feedbackText}>
                {t('quiz.correctAnswerIs', 'The correct answer is')} {correctAnswerLetter}
              </Text>
            </View>
          )}

          {/* Explanation Section */}
          {isAnswered && currentQuestion.explanation && (
            <View style={styles.coachingCard}>
              <Text style={styles.coachingLabel}>{t('quiz.explanation', 'Explanation')}:</Text>
              <Text style={styles.coachingText}>{currentQuestion.explanation}</Text>
            </View>
          )}

        </ScrollView>

        {/* Next Button */}
        {isAnswered && lives > 0 && (
          <View style={styles.footer}>
            <TouchableOpacity style={styles.nextButton} onPress={handleNext}>
              <Text style={styles.nextButtonText}>
                {currentIndex === questions.length - 1 ? t('quiz.finish', 'Finish') : t('common.next', 'Next')}
              </Text>
            </TouchableOpacity>
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
  
  // Header
  header: {
    paddingHorizontal: 20,
    paddingTop: 16,
    paddingBottom: 12,
  },
  headerRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 16,
  },
  livesContainer: {
    flexDirection: 'row',
    gap: 4,
  },
  timerPill: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.background.subtle,
    paddingHorizontal: 14,
    paddingVertical: 8,
    borderRadius: 20,
    gap: 6,
    borderWidth: 1,
    borderColor: colors.border,
  },
  timerWarning: {
    backgroundColor: 'rgba(255, 61, 0, 0.15)',
    borderColor: '#FF3D00',
  },
  timerText: {
    fontFamily: typography.fonts.bold,
    fontSize: 16,
    color: colors.text.primary,
  },
  timerTextWarning: {
    color: '#FF3D00',
  },
  progressText: {
    textAlign: 'center',
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    fontSize: 16,
  },
  
  // Content
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  questionCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 16,
    padding: 24,
    marginBottom: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.08,
    shadowRadius: 8,
    elevation: 3,
  },
  questionText: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
    lineHeight: 28,
  },
  questionImage: {
    width: '100%',
    height: 180,
    marginBottom: 16,
    borderRadius: 8,
  },
  
  // Options
  optionsContainer: {
    gap: 12,
  },
  optionCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    padding: 16,
    borderWidth: 1.5,
    borderColor: '#E0E0E0',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 4,
    elevation: 2,
  },
  optionCorrect: {
    backgroundColor: 'rgba(0, 200, 83, 0.15)',
    borderColor: '#00C853',
  },
  optionWrong: {
    backgroundColor: 'rgba(255, 61, 0, 0.12)',
    borderColor: '#FF3D00',
  },
  optionDimmed: {
    opacity: 0.5,
  },
  optionLetter: {
    width: 32,
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: '#666',
  },
  optionLetterCorrect: {
    color: '#00C853',
  },
  optionLetterWrong: {
    color: '#FF3D00',
  },
  optionText: {
    flex: 1,
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: '#1A1A1A',
    lineHeight: 22,
  },
  optionTextCorrect: {
    color: '#00C853',
  },
  optionTextWrong: {
    color: '#FF3D00',
  },
  
  // Feedback
  feedbackCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 61, 0, 0.08)',
    borderWidth: 1.5,
    borderColor: '#FF3D00',
    borderRadius: 12,
    padding: 14,
    marginTop: 20,
    gap: 10,
  },
  feedbackText: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    color: '#FF3D00',
  },
  
  // Coaching
  coachingCard: {
    backgroundColor: '#F5F5F5',
    borderRadius: 12,
    padding: 16,
    marginTop: 16,
  },
  coachingLabel: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: '#666',
    marginBottom: 6,
  },
  coachingText: {
    fontSize: 15,
    fontFamily: typography.fonts.regular,
    color: '#333',
    lineHeight: 22,
  },
  
  // Footer
  footer: {
    padding: 20,
    paddingBottom: 30,
  },
  nextButton: {
    backgroundColor: '#FFD700',
    borderRadius: 12,
    paddingVertical: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 6,
    elevation: 4,
  },
  nextButtonText: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
  },
  
  // End State
  endStateContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 24,
  },
  endStateCard: {
    backgroundColor: '#FFFFFF',
    borderRadius: 24,
    padding: 40,
    alignItems: 'center',
    width: '100%',
    maxWidth: 340,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.1,
    shadowRadius: 12,
    elevation: 6,
  },
  endStateTitle: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    marginTop: 20,
    marginBottom: 16,
    textAlign: 'center',
    lineHeight: 36,
  },
  endStateScore: {
    fontSize: 22,
    fontFamily: typography.fonts.medium,
    color: '#1A1A1A',
    marginBottom: 32,
  },
  doneButton: {
    backgroundColor: '#FFD700',
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 60,
    width: '100%',
    alignItems: 'center',
    marginBottom: 12,
  },
  doneButtonText: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
  },
  tryAgainButton: {
    borderWidth: 1.5,
    borderColor: '#E0E0E0',
    borderRadius: 12,
    paddingVertical: 14,
    paddingHorizontal: 60,
    width: '100%',
    alignItems: 'center',
  },
  tryAgainText: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: '#666',
  },
});
