import React, { useState, useEffect, useMemo, useRef } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, StatusBar, Image, Platform } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { BatchService } from '../services/batchService';
import { AuthService } from '../services/authService';
import { QuizStorageService, SavedQuizProgress } from '../services/quizStorageService';
import { Question } from '../types/models';
import { Check, X, AlertCircle, ArrowLeft } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';

const QUIZ_IMAGES: Record<string, any> = {
  'stop_sign': require('../../assets/quiz/stop_sign.jpg'),
  'pedestrian_crossing': require('../../assets/quiz/pedestrian_crossing.jpg'),
  'no_entry': require('../../assets/quiz/no_entry.jpg'),
  'turn_right': require('../../assets/quiz/turn_right.jpg'),
  'warning': require('../../assets/quiz/warning.jpg'),
};

const OPTION_LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];

export const QuizScreen = ({ navigation, route }: any) => {
  // Ensure batchNumber is a number
  const rawBatchNumber = route.params?.batchNumber ?? 1;
  const batchNumber = parseInt(String(rawBatchNumber), 10);
  const mode = route.params?.mode || 'live'; // 'live' or 'practice'
  const isPractice = mode === 'practice';

  
  const { t, i18n } = useTranslation();
  const { colors, theme } = useTheme();
  
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentIndex, setCurrentIndex] = useState(0);
  const [answers, setAnswers] = useState<{ questionId: string; attempts: number; isCorrect: boolean }[]>([]);
  const [attemptCounts, setAttemptCounts] = useState<Record<number, number>>({});
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [showFeedback, setShowFeedback] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadingStatus, setLoadingStatus] = useState(t('common.initializing'));
  const [userId, setUserId] = useState<string>('');
  const [startTime, setStartTime] = useState<number>(Date.now());
  const [savedProgress, setSavedProgress] = useState<SavedQuizProgress | null>(null);
  const [showResumePrompt, setShowResumePrompt] = useState(false);
  
  const styles = useMemo(() => createStyles(colors), [colors]);
  const scrollViewRef = useRef<ScrollView>(null);

  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    let shouldUpdateLoading = true;
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

      setUserId(profile.id);
      
      if (profile.role === 'manager') {
        navigation.replace('ManagerQuickView');
        return;
      }

      // Check Daily Limit for Live Mode - Now on a per-batch basis
      if (!isPractice) {
        const dailyCount = await QuizStorageService.getDailyCount(profile.id, batchNumber);
        if (dailyCount >= 3) {
          // If limit reached, we will navigate back. 
          // Keep loading=true to prevent "Unable to Load Questions" flicker
          shouldUpdateLoading = false;
          Alert.alert(
            t('quiz.dailyLimitTitle') || 'Daily Limit Reached',
            t('quiz.dailyLimitMessage') || 'You have reached your limit of 3 questions for this batch today. Come back tomorrow or try Practice Mode!',
            [{ text: 'OK', onPress: () => navigation.goBack() }]
          );
          return;
        }
      }

      // Check access - Bypassed for Practice Mode
      if (!isPractice) {
        const canAccess = await BatchService.canAccessBatch(profile.id, batchNumber);
        if (!canAccess) {
          shouldUpdateLoading = false;
          Alert.alert(
            t('quiz.batchLocked') || 'Batch Locked',
            t('quiz.batchLockedMessage', { prevBatch: batchNumber - 1 }) || `You must complete Batch ${batchNumber - 1} with at least 60% average score to unlock this batch.`,
            [{ text: 'OK', onPress: () => navigation.goBack() }]
          );
          return;
        }
      }

      setLoadingStatus(t('quiz.loadingQuestions', { mode: isPractice ? (t('mission.practiceModeTitle') || 'Practice') : 'Batch ' + batchNumber }));

      // Load batch questions
      try {
        let loadedQuestions;
        
        if (isPractice) {
          // Use PracticeService for Practice Mode (Smart + Randomized)
          const { PracticeService } = await import('../services/practiceService');
          loadedQuestions = await PracticeService.getPracticeSession(profile.id, profile.region, 30);
          console.log(`[QuizScreen Practice] Loaded ${loadedQuestions.length} practice questions`);
        } else {
          // Use BatchService for Live Mode (Deterministic batches)
          loadedQuestions = await BatchService.getBatchQuestions(batchNumber);
          console.log(`[QuizScreen] Loaded ${loadedQuestions.length} questions for Batch ${batchNumber}`);
        }
        
        if (!loadedQuestions || loadedQuestions.length === 0) {
          throw new Error('Questions array is empty');
        }

        setQuestions(loadedQuestions);
        
        // Wait for next tick to ensure questions state is accessible if needed
        // then check for saved progress (only for live mode)
        if (!isPractice) {
          const saved = await QuizStorageService.loadProgress(profile.id, batchNumber);
          if (saved && saved.currentIndex > 0) {
            setSavedProgress(saved);
            setShowResumePrompt(true);
          } else {
            setStartTime(Date.now());
          }
        } else {
          setStartTime(Date.now());
        }
      } catch (qError) {
        console.error('Error fetching questions:', qError);
        Alert.alert(
          t('quiz.loadingError') || 'Loading Error',
          t('quiz.couldNotLoadQuestions', { mode: isPractice ? (t('mission.practiceModeTitle') || 'Practice') : 'Batch ' + batchNumber }) || `Could not load questions${isPractice ? ' for Practice.' : ' for Batch ' + batchNumber + '.'} Please try again.`
        );
        navigation.goBack();
        return;
      }

    } catch (error) {
      console.error('Error loading quiz:', error);
      Alert.alert(t('common.error'), t('quiz.failedToLoadQuiz') || 'Failed to load quiz');
      navigation.goBack();
    } finally {
      if (shouldUpdateLoading) {
        setLoading(false);
      }
    }
  };

  // Restore saved progress
  const restoreProgress = () => {
    if (savedProgress) {
      setCurrentIndex(savedProgress.currentIndex);
      setAnswers(savedProgress.answers);
      setAttemptCounts(savedProgress.attemptCounts);
      setStartTime(savedProgress.startTime);
      setShowResumePrompt(false);
      setSavedProgress(null);
    }
  };

  // Start fresh (discard saved progress)
  const startFresh = async () => {
    if (userId && !isPractice) {
      await QuizStorageService.clearProgress(userId, batchNumber);
    }
    setStartTime(Date.now());
    setShowResumePrompt(false);
    setSavedProgress(null);
  };

  // Save current progress to local storage
  const saveProgressLocally = async () => {
    if (userId && questions.length > 0 && !isPractice) {
      await QuizStorageService.saveProgress({
        batchNumber,
        currentIndex,
        answers,
        attemptCounts,
        startTime,
        savedAt: Date.now(),
        userId,
      });
    }
  };
  
  const handleBack = () => {
    // Practice mode goes back immediately without alert
    if (isPractice) {
      navigation.navigate('MainTabs', { screen: 'Mission' });
      return;
    }

    // Platform-agnostic confirmation with save option
    const title = t('common.exitQuiz') || 'Exit Quiz?';
    const message = t('common.saveExitMessage') || 
      'Would you like to save your progress and continue later?';

    if (Platform.OS === 'web') {
      // Web: Use confirm for simple yes/no, save progress if confirmed
      const saveAndExit = window.confirm(`${String(title)}\n\n${String(message)}\n\n${t('common.saveExitWebConfirm')}`);
      if (saveAndExit) {
        saveProgressLocally().then(() => {
          navigation.navigate('MainTabs', { screen: 'Mission' });
        });
      }
    } else {
      Alert.alert(
        title,
        message,
        [
          { text: t('common.cancel') || 'Cancel', style: 'cancel' },
          { 
            text: t('common.saveAndExitButton') || 'Save & Exit',
            onPress: async () => {
              await saveProgressLocally();
              navigation.navigate('MainTabs', { screen: 'Mission' });
            }
          },
          { 
            text: t('common.exitWithoutSaving') || 'Exit Without Saving', 
            style: 'destructive',
            onPress: async () => {
              await QuizStorageService.clearProgress(userId, batchNumber);
              navigation.navigate('MainTabs', { screen: 'Mission' });
            }
          }
        ]
      );
    }
  };

  const handleOptionSelect = async (index: number) => {
    if (isAnswered) return;

    setSelectedOption(index);
    setIsAnswered(true);

    const rawQuestion = questions[currentIndex];
    const isCorrect = index === rawQuestion.correctOptionIndex;
    const currentAttempts = (attemptCounts[currentIndex] || 0) + 1;

    setAttemptCounts(prev => ({
      ...prev,
      [currentIndex]: currentAttempts
    }));

    if (isCorrect) {
      // Record correct answer
      setAnswers(prev => [...prev, {
        questionId: rawQuestion.id,
        attempts: currentAttempts,
        isCorrect: true
      }]);
      
      // Increment Daily Count if Live Mode - Now on a per-batch basis
      if (!isPractice) {
        await QuizStorageService.incrementDailyCount(userId, batchNumber);
      }

      setShowFeedback(false);
      
      // No auto-advance
      // setTimeout(() => {
      //   handleNext();
      // }, 1000);
    } else {
      // Show feedback
      setShowFeedback(true);
    }
    
    setTimeout(() => {
      scrollViewRef.current?.scrollToEnd({ animated: true });
    }, 100);
  };

  const handleRetry = () => {
    setSelectedOption(null);
    setIsAnswered(false);
    setShowFeedback(false);
  };

  const handleNext = async () => {
    setSelectedOption(null);
    setIsAnswered(false);
    setShowFeedback(false);
    
    const maxSessionQuestions = isPractice ? 30 : 3;

    if (currentIndex < maxSessionQuestions - 1) {
      setCurrentIndex(currentIndex + 1);
    } else {
      // Finish session (both Practice and Live)
      handleFinish();
    }
  };

  const handleFinish = async () => {
    try {
      console.log('Starting handleFinish...');
      setLoading(true);
      setLoadingStatus(t('quiz.submitting'));
      
      if (isPractice) {
        // Calculate practice session results
        const correctCount = answers.filter(a => a.isCorrect).length;
        const totalAnswered = answers.length;
        const accuracy = totalAnswered > 0 ? Math.round((correctCount / totalAnswered) * 100) : 0;
        
        const title = accuracy >= 80 ? t('quiz.excellentPractice') : accuracy >= 60 ? t('quiz.goodPractice') : t('quiz.keepPracticing');
        const message = `${t('quiz.practiceResult', { correct: correctCount, total: totalAnswered, accuracy: accuracy })}\n\n${t('quiz.practiceMoreQuestion')}`;
        
        if (Platform.OS === 'web') {
          const practiceAgain = window.confirm(`${String(title)}\n\n${String(message)}\n\n${t('quiz.practiceWebConfirm')}`);
          if (practiceAgain) {
            navigation.replace('Quiz', { mode: 'practice', batchNumber: 1 });
          } else {
            navigation.navigate('MainTabs', { screen: 'Mission' });
          }
        } else {
          Alert.alert(String(title), String(message), [
            { text: t('common.backToHome') || 'Back to Menu', onPress: () => navigation.navigate('MainTabs', { screen: 'Mission' }) },
            { text: t('quiz.practiceAgain') || 'Practice Again', onPress: () => {
              // Reload the practice screen
              navigation.replace('Quiz', { mode: 'practice', batchNumber: 1 });
            }}
          ]);
        }
        return;
      }

      const timeSpentSeconds = Math.floor((Date.now() - startTime) / 1000);
      console.log(`Submitting attempt for User: ${userId}, Batch: ${batchNumber}, Time: ${timeSpentSeconds}s`);
      
      const result = await BatchService.submitBatchAttempt(
        userId,
        batchNumber,
        answers,
        questions,
        timeSpentSeconds
      );

      console.log('Submission result:', result);

      if (result.success && result.progress) {
        // Clear saved progress since quiz is complete
        await QuizStorageService.clearProgress(userId, batchNumber);
        
        const avgScore = await BatchService.getBatchAverageScore(userId, batchNumber);
        const passed = avgScore >= 60;
        
        const title = passed ? t('quiz.batchCompleted') : t('quiz.batchAttemptRecorded');
        const message = `${t('common.score')}: ${result.progress.score.toFixed(2)}%\n${t('quiz.averageScore') || 'Average'}: ${avgScore.toFixed(2)}%\n\n${
          passed 
            ? batchNumber < 4 ? t('quiz.batchNextUnlocked', { nextBatch: batchNumber + 1 }) : t('quiz.allBatchesCompleted')
            : t('quiz.neededToPass', { needed: (60 - avgScore).toFixed(2) })
        }`;

        // Platform-specific alert handling
        if (Platform.OS === 'web') {
          window.alert(`${title}\n\n${message}`);
          navigation.navigate('MainTabs', { screen: 'Mission', params: { refresh: true } });
        } else {
          Alert.alert(title, message, [
            { text: 'OK', onPress: () => navigation.navigate('MainTabs', { screen: 'Mission', params: { refresh: true } }) }
          ]);
        }
      } else {
        console.error('Submission returned failure');
        Alert.alert('Error', 'Failed to submit batch attempt. Please try again.');
        // Don't auto navigate on error
      }
    } catch (error) {
      console.error('Error finishing quiz:', error);
      Alert.alert('Error', 'Failed to submit answers. Please check your connection.');
    } finally {
      setLoading(false);
    }
  };

  // Calculate current progress
  const attemptedCount = answers.length;
  const correctCount = answers.filter(a => a.isCorrect).length;
  const accuracy = attemptedCount > 0 ? (correctCount / attemptedCount) * 100 : 0;
  const completion = (attemptedCount / questions.length) * 100;

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

  if (questions.length === 0) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <Text style={styles.errorTitle}>Unable to Load Questions</Text>
          <Text style={styles.errorText}>No questions found for this batch</Text>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  // Resume Prompt
  if (showResumePrompt && savedProgress) {
    const savedQuestion = savedProgress.currentIndex + 1;
    const totalQuestions = questions.length;
    const answeredCount = savedProgress.answers.length;
    
    return (
      <GradientBackground>
        <SafeAreaView style={styles.resumeContainer}>
          <View style={styles.resumeCard}>
            <Text style={styles.resumeTitle}>{t('quiz.savedProgressTitle') || 'Resume Quiz?'}</Text>
            <Text style={styles.resumeMessage}>
              {t('quiz.savedProgressMessage', { 
                question: savedQuestion, 
                total: totalQuestions,
                answered: answeredCount 
              }) || `You have saved progress at Question ${savedQuestion}.\n\n${answeredCount} questions answered.`}
            </Text>
            
            <View style={styles.resumeButtons}>
              <TouchableOpacity 
                style={[styles.resumeButton, styles.resumeButtonPrimary]} 
                onPress={restoreProgress}
              >
                <Text style={styles.resumeButtonTextPrimary}>
                  {t('quiz.resumeButton', { question: savedQuestion }) || `Resume from Q${savedQuestion}`}
                </Text>
              </TouchableOpacity>
              
              <TouchableOpacity 
                style={[styles.resumeButton, styles.resumeButtonSecondary]} 
                onPress={startFresh}
              >
                <Text style={styles.resumeButtonTextSecondary}>
                  {t('quiz.startFreshButton') || 'Start Fresh'}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        
        {/* Header */}
        <View style={styles.header}>
          <View style={styles.headerTopRow}>
            <TouchableOpacity onPress={handleBack} style={styles.backButton}>
              <ArrowLeft size={20} color={colors.text.primary} />
            </TouchableOpacity>
            <Text style={styles.batchTitle}>
                {isPractice ? (t('mission.practiceModeTitle') || 'Practice') : t('quiz.batchTitle', { number: batchNumber })}
            </Text>
            <View style={{ width: 20 }} />
          </View>
          <View style={styles.statsRow}>
             <Text style={styles.progressText}>
                {t('quiz.question')} {currentIndex + 1}/{isPractice ? '30' : '3'}
             </Text>
            <View style={[styles.statItem, {flexDirection: 'row', gap: 4}]}>
              <Text style={styles.statLabel}>Accuracy:</Text>
              <Text style={styles.statValue}>{accuracy.toFixed(0)}%</Text>
            </View>
          </View>
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
              const showAsCorrect = isAnswered && isCorrectOption && !showFeedback;
              const isDimmed = isAnswered && !isSelected && !showAsCorrect;

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
                  
                  {showAsCorrect && (
                    <Check size={24} color="#00C853" strokeWidth={3} />
                  )}
                  {/* Remove X mark for wrong answers */}
                </TouchableOpacity>
              );
            })}
          </View>

          {/* Feedback: "Try Again" when wrong */}
          {showFeedback && (
            <View style={styles.feedbackCard}>
              <Text style={styles.feedbackText}>
                {t('quiz.oopsTryAgain')}
              </Text>
            </View>
          )}

          {/* Explanation Section - Only show when answer is CORRECT */}
          {isAnswered && !showFeedback && currentQuestion.explanation && (
            <View style={styles.coachingCard}>
              <Text style={styles.coachingLabel}>{t('quiz.explanation')}:</Text>
              <Text style={styles.coachingText}>{currentQuestion.explanation}</Text>
            </View>
          )}

        </ScrollView>

        {/* Action Buttons */}
        <View style={styles.footer}>
          {showFeedback ? (
            <TouchableOpacity style={styles.retryButton} onPress={handleRetry}>
              <Text style={styles.retryButtonText}>{t('common.tryAgain')}</Text>
            </TouchableOpacity>
          ) : isAnswered && (
            <TouchableOpacity style={styles.nextButton} onPress={handleNext}>
              <Text style={styles.nextButtonText}>
                {currentIndex === questions.length - 1 ? t('quiz.finish') : t('common.next')}
              </Text>
            </TouchableOpacity>
          )}
        </View>
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
  
  content: {
    padding: 16,
    paddingBottom: 40,
    width: '100%',
    maxWidth: 600,
    alignSelf: 'center',
  },
  header: {
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(0,0,0,0.05)',
  },
  headerTopRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  backButton: {
    padding: 8,
    marginLeft: -8,
  },
  batchTitle: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  progressText: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  statsRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: 4,
  },
  statItem: {
    alignItems: 'center',
  },
  statLabel: {
    fontSize: 10,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    textTransform: 'uppercase',
  },
  statValue: {
    fontSize: 12,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  questionCard: {
    backgroundColor: '#FFF',
    borderRadius: 16,
    padding: 16,
    marginBottom: 16,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.05,
    shadowRadius: 8,
    elevation: 3,
  },
  questionImage: {
    width: '100%',
    height: 150,
    marginBottom: 12,
    borderRadius: 8,
  },
  questionText: {
    fontSize: 17,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
    lineHeight: 24,
  },
  optionsContainer: {
    gap: 10,
  },
  optionCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FFF',
    borderRadius: 12,
    padding: 12,
    borderWidth: 2,
    borderColor: 'transparent',
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
    flex: 1,
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
  retryButton: {
    backgroundColor: '#FF6B6B',
    borderRadius: 12,
    paddingVertical: 16,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.15,
    shadowRadius: 6,
    elevation: 4,
  },
  retryButtonText: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: '#FFFFFF',
  },
  
  // Resume Prompt Styles
  resumeContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  resumeCard: {
    backgroundColor: 'rgba(255, 255, 255, 0.95)',
    borderRadius: 20,
    padding: 30,
    width: '100%',
    maxWidth: 400,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.2,
    shadowRadius: 12,
    elevation: 8,
  },
  resumeTitle: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
    marginBottom: 16,
    textAlign: 'center',
  },
  resumeMessage: {
    fontSize: 16,
    fontFamily: typography.fonts.regular,
    color: '#666',
    textAlign: 'center',
    lineHeight: 24,
    marginBottom: 24,
  },
  resumeButtons: {
    width: '100%',
    gap: 12,
  },
  resumeButton: {
    borderRadius: 12,
    paddingVertical: 16,
    paddingHorizontal: 24,
    alignItems: 'center',
    justifyContent: 'center',
  },
  resumeButtonPrimary: {
    backgroundColor: '#FFD700',
  },
  resumeButtonSecondary: {
    backgroundColor: 'transparent',
    borderWidth: 2,
    borderColor: '#CCC',
  },
  resumeButtonTextPrimary: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: '#1A1A1A',
  },
  resumeButtonTextSecondary: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: '#666',
  },
});
