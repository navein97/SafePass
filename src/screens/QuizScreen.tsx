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
  const [sessionLimit, setSessionLimit] = useState(isPractice ? 30 : 3);
  const [hasAnnouncedReview, setHasAnnouncedReview] = useState(false);
  const [resultData, setResultData] = useState<{
    title: string;
    score: number;
    avgScore: number;
    passed: boolean;
    isPractice: boolean;
    accuracy?: number;
    correct?: number;
    total?: number;
  } | null>(null);
  const [nextTimer, setNextTimer] = useState(0);

  useEffect(() => {
    if (nextTimer > 0) {
      const timer = setTimeout(() => setNextTimer(prev => prev - 1), 1000);
      return () => clearTimeout(timer);
    }
  }, [nextTimer]);

  
  const styles = useMemo(() => createStyles(colors), [colors]);
  const scrollViewRef = useRef<ScrollView>(null);

  useEffect(() => {
    loadQuiz();
  }, []);

  // Handle review phase announcement for Practice Mode - MODAL VERSION
  const showReviewAnnouncement = isPractice && currentIndex === 30 && !hasAnnouncedReview;

  const loadQuiz = async () => {
    let shouldUpdateLoading = true;
    try {
      setLoading(true);
      setLoadingStatus(t('common.fetchingProfile'));
      
      // Add timeout to prevent infinite hang
      const profilePromise = AuthService.getUserProfile();
      const timeoutPromise = new Promise((_, reject) => 
        setTimeout(() => reject(new Error('Profile fetch timeout')), 8000)
      );
      
      const result = await Promise.race([profilePromise, timeoutPromise]) as any;
      const profile = result.profile;
      const error = result.error;
      
      if (error || !profile) {
        console.error('Profile load error:', error);
        Alert.alert(
          t('common.error'), 
          t('auth.sessionError') || 'Your session may have expired. Please log in again.',
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

      // [TESTING] Daily limit disabled — re-enable for production
      // if (!isPractice) {
      //   const dailyCount = await QuizStorageService.getDailyCount(profile.id, batchNumber);
      //   if (dailyCount >= 3) {
      //     setLoading(false);
      //     const title = t('quiz.dailyLimitTitle') || 'Daily Limit Reached';
      //     const message = t('quiz.dailyLimitMessage', { number: batchNumber }) || `You have reached your limit of 3 questions for Batch ${batchNumber} today. Come back tomorrow or try Practice Mode!`;
      //     if (Platform.OS === 'web') {
      //       window.alert(`${title}\n\n${message}`);
      //       navigation.goBack();
      //     } else {
      //       Alert.alert(title, message, [{ text: 'OK', onPress: () => navigation.goBack() }]);
      //     }
      //     return;
      //   }
      // }

      // Check access - Bypassed for Practice Mode
      if (!isPractice) {
        const canAccess = await BatchService.canAccessBatch(profile.id, batchNumber);
        if (!canAccess) {
          setLoading(false);
          const title = t('quiz.batchLocked') || 'Batch Locked';
          const message = t('quiz.batchLockedMessage', { prevBatch: batchNumber - 1 }) || `You must complete Batch ${batchNumber - 1} with at least 60% average score to unlock this batch.`;
          
          if (Platform.OS === 'web') {
            window.alert(`${title}\n\n${message}`);
            navigation.goBack();
          } else {
            Alert.alert(title, message, [{ text: 'OK', onPress: () => navigation.goBack() }]);
          }
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
          loadedQuestions = await BatchService.getBatchQuestions(batchNumber, profile.id);
          console.log(`[QuizScreen] Loaded ${loadedQuestions.length} questions for Batch ${batchNumber}`);
        }
        
        if (!loadedQuestions || loadedQuestions.length === 0) {
          throw new Error('Questions array is empty');
        }

        setQuestions(loadedQuestions);
        
        // Wait for next tick to ensure questions state is accessible if needed
        // then check for saved progress
        const saved = await QuizStorageService.loadProgress(profile.id, batchNumber, mode);
        if (saved && saved.currentIndex > 0) {
          setSavedProgress(saved);
          setShowResumePrompt(true);
        } else {
          setStartTime(Date.now());
        }
      } catch (qError) {
        console.error('Error fetching questions:', qError);
        Alert.alert(
          t('quiz.loadingError') || 'Loading Error',
          t('quiz.couldNotLoadQuestions', { mode: isPractice ? (t('mission.practiceModeTitle') || 'Practice') : t('quiz.batchTitle', { number: batchNumber }) })
        );
        navigation.goBack();
        return;
      }

    } catch (error) {
      console.error('Error loading quiz:', error);
      Alert.alert(t('common.error'), t('quiz.failedToLoadQuiz') || 'Failed to load quiz');
      navigation.goBack();
    } finally {
      // In normal flow, we stop loading here. 
      // If we returned early for limit/locked check, setLoading(false) was called explicitly.
      if (shouldUpdateLoading) {
        setLoading(false);
      }
    }
  };

  // Restore saved progress
  const restoreProgress = () => {
    if (savedProgress) {
      // If we have saved questions (for practice mode), use them
      if (savedProgress.questions && savedProgress.questions.length > 0) {
        setQuestions(savedProgress.questions);
      }
      
      // Use saved session limit if available
      if (savedProgress.sessionLimit !== undefined) {
        setSessionLimit(savedProgress.sessionLimit);
      } else {
        // Fallback: recalculate if not saved
        const extras = savedProgress.answers.filter(a => !a.isCorrect).length;
        setSessionLimit((isPractice ? 30 : 3) + (isPractice ? extras : 0));
      }

      // Restore review announcement state
      if (savedProgress.hasAnnouncedReview !== undefined) {
        setHasAnnouncedReview(savedProgress.hasAnnouncedReview);
      }

      // Safety check: ensure saved index is within question set
      const questionSet = savedProgress.questions || questions;
      const validIndex = Math.min(savedProgress.currentIndex, questionSet.length - 1);
      
      setCurrentIndex(validIndex);
      setAnswers(savedProgress.answers);
      setAttemptCounts(savedProgress.attemptCounts);
      setStartTime(savedProgress.startTime);
      setShowResumePrompt(false);
      setSavedProgress(null);
    }
  };

  // Start fresh (discard saved progress)
  const startFresh = async () => {
    if (userId) {
      await QuizStorageService.clearProgress(userId, batchNumber, mode);
    }
    setStartTime(Date.now());
    setShowResumePrompt(false);
    setSavedProgress(null);
  };

  // Save current progress to local storage
  const saveProgressLocally = async () => {
    if (userId && questions.length > 0) {
      await QuizStorageService.saveProgress({
        batchNumber,
        currentIndex,
        answers,
        attemptCounts,
        startTime,
        savedAt: Date.now(),
        userId,
        mode,
        questions, // Crucial for Practice Mode to save the randomized session
        sessionLimit,
        hasAnnouncedReview,
      });
    }
  };

  // Auto-save progress whenever important state changes
  useEffect(() => {
    if (!loading && userId && questions.length > 0 && (answers.length > 0 || currentIndex > 0)) {
      saveProgressLocally();
    }
  }, [currentIndex, answers.length, hasAnnouncedReview]);
  
  const handleBack = () => {
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
              await QuizStorageService.clearProgress(userId, batchNumber, mode);
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

    const currentBatchQuestion = questions[currentIndex];
    const isCorrect = index === currentBatchQuestion.correctOptionIndex;
    const currentAttempts = (attemptCounts[currentIndex] || 0) + 1;

    setAttemptCounts(prev => ({
      ...prev,
      [currentIndex]: currentAttempts
    }));

    // Increment Daily Count if Live Mode - Every answer (Correct or Incorrect) counts towards the quota
    if (!isPractice) {
      await QuizStorageService.incrementDailyCount(userId, batchNumber);
    }

    if (isCorrect) {
      // Record correct answer
      setAnswers(prev => [...prev, {
        questionId: currentBatchQuestion.id,
        attempts: currentAttempts,
        isCorrect: true
      }]);
      setShowFeedback(false);
    } else {
      // Record failed attempt and Show feedback
      setAnswers(prev => [...prev, {
        questionId: currentBatchQuestion.id,
        attempts: currentAttempts,
        isCorrect: false
      }]);
      setShowFeedback(true);
    }
    
    // Start 4s delay timer before user can continue
    setNextTimer(4);
    
    setTimeout(() => {
      scrollViewRef.current?.scrollToEnd({ animated: true });
    }, 100);
  };

  const handleRetry = () => {
    if (isPractice) {
      // Requeue the question to the end of the session (Practice Mode only)
      const currentQ = { ...questions[currentIndex] };
      
      // Reshuffle options so they appear in different positions next time!
      const originalOptions = [...currentQ.options];
      const correctOptionText = originalOptions[currentQ.correctOptionIndex];
      const indices = originalOptions.map((_, i) => i);
      
      for (let i = indices.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [indices[i], indices[j]] = [indices[j], indices[i]];
      }
      
      currentQ.options = indices.map(i => originalOptions[i]);
      currentQ.correctOptionIndex = currentQ.options.indexOf(correctOptionText);
      
      // Sync Malay options if they exist
      if (currentQ.options_ms) {
        const originalOptionsMs = [...currentQ.options_ms];
        currentQ.options_ms = indices.map(i => originalOptionsMs[i]);
      }

      const newQuestions = [...questions];
      // Insert after the current planned session questions
      newQuestions.splice(sessionLimit, 0, currentQ);
      
      setQuestions(newQuestions);
      setSessionLimit(prev => prev + 1);
    }
    
    // Move to next question immediately
    handleNext();
  };

  const handleNext = async () => {
    setSelectedOption(null);
    setIsAnswered(false);
    setShowFeedback(false);
    setNextTimer(0);

    
    if (currentIndex < sessionLimit - 1) {
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
        // Clear saved progress on completion
        await QuizStorageService.clearProgress(userId, batchNumber, mode);
        
        // Calculate practice session results
        const correctCount = answers.filter(a => a.isCorrect).length;
        const totalAnswered = answers.length;
        const accuracy = totalAnswered > 0 ? Math.round((correctCount / totalAnswered) * 100) : 0;
        
        const title = accuracy >= 80 ? t('quiz.excellentPractice') : accuracy >= 60 ? t('quiz.goodPractice') : t('quiz.keepPracticing');

        // Always show full-screen celebration card (works on both web and native)
        setResultData({ title, score: accuracy, avgScore: accuracy, passed: accuracy >= 60, isPractice: true, accuracy, correct: correctCount, total: totalAnswered });
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

      if (result.success) {
        // Clear saved progress since quiz is complete
        await QuizStorageService.clearProgress(userId, batchNumber);
        
        // result.progress might be null if current score didn't beat high score
        const score = result.progress ? result.progress.score : BatchService.calculateScoreWithAttempts(answers);
        const avgScore = await BatchService.getBatchAverageScore(userId, batchNumber);
        const passed = avgScore >= 60;
        
        const title = passed ? t('quiz.batchCompleted') : t('quiz.batchAttemptRecorded');

        // Always show full-screen celebration card (works on both web and native)
        setResultData({ title, score, avgScore, passed, isPractice: false });
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
          <Text style={styles.errorTitle}>{t('quiz.unableToLoadQuestions')}</Text>
          <Text style={styles.errorText}>{t('quiz.noQuestionsFoundBatch')}</Text>
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

  // Review Mode Announcement Card
  if (showReviewAnnouncement) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.resumeContainer}>
           <StatusBar barStyle="light-content" />
           <View style={styles.resumeCard}>
            <View style={styles.reviewIconContainer}>
               <Check size={48} color={colors.primary.DEFAULT} />
            </View>
            <Text style={styles.resumeTitle}>{t('quiz.reviewPhaseTitle') || 'Review Mode'}</Text>
            <Text style={styles.resumeMessage}>
              {t('quiz.reviewPhaseMessage') || "You've reached question 30! Now, we'll review the questions you missed to help you master them."}
            </Text>
            
            <TouchableOpacity 
              style={[styles.resumeButton, styles.resumeButtonPrimary]} 
              onPress={() => setHasAnnouncedReview(true)}
            >
              <Text style={styles.resumeButtonTextPrimary}>
                {t('common.continue') || 'Continue'}
              </Text>
            </TouchableOpacity>
          </View>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  // Batch Result / Celebration Card
  if (resultData) {
    const isPracticeResult = resultData.isPractice;
    const celebrationEmoji = resultData.passed || isPracticeResult
      ? resultData.score >= 80 ? '🏆' : resultData.score >= 60 ? '🎉' : '💪'
      : '📋';
    const bgColor = resultData.passed || (isPracticeResult && resultData.score >= 60)
      ? 'rgba(0, 200, 83, 0.12)'
      : 'rgba(255, 107, 107, 0.10)';
    const accentColor = resultData.passed || (isPracticeResult && resultData.score >= 60)
      ? '#00C853'
      : '#B45309'; // dark amber — readable on the light beige background

    return (
      <GradientBackground>
        <SafeAreaView style={styles.resumeContainer}>
          <StatusBar barStyle="light-content" />
          <View style={[styles.resumeCard, { backgroundColor: bgColor, borderWidth: 1.5, borderColor: accentColor + '60' }]}>
            {/* Big emoji */}
            <Text style={{ fontSize: 72, textAlign: 'center', marginBottom: 8 }}>{celebrationEmoji}</Text>

            <Text style={[styles.resumeTitle, { color: accentColor }]}>{resultData.title}</Text>

              {isPracticeResult ? (
                <>
                  <Text style={styles.resultScoreText}>{t('quiz.correctCount', { correct: resultData.correct, total: resultData.total })}</Text>
                  <Text style={[styles.resultScoreValue, { color: accentColor }]}>{resultData.score}%</Text>
                  <Text style={styles.resultSubLabel}>{t('quiz.accuracy')}</Text>
                </>
              ) : (
                <>
                  <Text style={styles.resultScoreText}>{t('quiz.scoreLabel')} {resultData.score.toFixed(1)}%</Text>
                  <Text style={[styles.resultScoreValue, { color: accentColor }]}>{resultData.avgScore.toFixed(1)}%</Text>
                  <Text style={styles.resultSubLabel}>{t('quiz.averageScore')}</Text>
                  {resultData.passed ? (
                    <Text style={[styles.resultMessage, { color: '#00C853' }]}>
                      ✅ {batchNumber < 4 ? t('quiz.nextBatchUnlocked', { number: batchNumber + 1 }) : t('quiz.allBatchesComplete')}
                    </Text>
                  ) : (
                    <Text style={[styles.resultMessage, { color: colors.text.secondary }]}>
                      {t('mission.needMoreToPass', { percent: (60 - resultData.avgScore).toFixed(1) })}
                    </Text>
                  )}
                </>
              )}

            {/* Buttons */}
            <View style={{ gap: 12, width: '100%', marginTop: 24 }}>
              {isPracticeResult && (
                <TouchableOpacity
                  style={[styles.resumeButton, styles.resumeButtonPrimary]}
                  onPress={() => navigation.replace('Quiz', { mode: 'practice', batchNumber: 1 })}
                >
                  <Text style={styles.resumeButtonTextPrimary}>{t('quiz.practiceAgain')}</Text>
                </TouchableOpacity>
              )}
              <TouchableOpacity
                style={[styles.resumeButton, isPracticeResult ? styles.resumeButtonSecondary : styles.resumeButtonPrimary]}
                onPress={() => navigation.navigate('MainTabs', { screen: 'Mission', params: { refresh: true } })}
              >
                  <Text style={isPracticeResult ? styles.resumeButtonTextSecondary : styles.resumeButtonTextPrimary}>
                    {t('quiz.backToMenu')}
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
                {isPractice && currentIndex >= 30 
                  ? (t('quiz.reviewPhaseTitle') || 'Review Mode')
                  : `${t('quiz.question')} ${currentIndex + 1}/${isPractice ? '30' : '3'}`}
             </Text>
            {!isPractice && (
              <View style={[styles.statItem, {flexDirection: 'row', gap: 4}]}>
                <Text style={styles.statLabel}>{t('quiz.accuracy')}:</Text>
                <Text style={styles.statValue}>{accuracy.toFixed(0)}%</Text>
              </View>
            )}
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

          {/* Feedback: wrong answer card — header differs by mode, hint always shown */}
          {showFeedback && (
            <View style={styles.feedbackCard}>
              <Text style={styles.feedbackText}>
                {isPractice ? t('quiz.oopsTryAgain') : t('quiz.wrongAnswer')}
              </Text>
              {currentQuestion.explanation ? (
                <View style={{ marginTop: 10, paddingTop: 10, borderTopWidth: 1, borderTopColor: 'rgba(255,107,107,0.3)' }}>
                  <Text style={{ fontSize: 12, fontFamily: typography.fonts.bold, color: '#FF6B6B', marginBottom: 4, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                    💡 {isPractice ? t('quiz.hint') : t('quiz.explanation')}
                  </Text>
                  <Text style={{ fontSize: 14, fontFamily: typography.fonts.regular, color: '#555', lineHeight: 20 }}>
                    {currentQuestion.explanation}
                  </Text>
                </View>
              ) : null}
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
            <TouchableOpacity 
              style={[styles.retryButton, nextTimer > 0 && { opacity: 0.5 }]} 
              onPress={handleRetry}
              disabled={nextTimer > 0}
            >
              <Text style={styles.retryButtonText}>
                {nextTimer > 0 ? `${t('common.wait', 'Wait...')} (${nextTimer}s)` :
                 isPractice
                  ? (t('common.continue') || 'Continue')
                  : currentIndex === sessionLimit - 1
                    ? (t('quiz.finish') || 'Finish ✓')
                    : t('quiz.nextQuestion')}
              </Text>
            </TouchableOpacity>
          ) : isAnswered && (
            <TouchableOpacity 
              style={[styles.nextButton, nextTimer > 0 && { opacity: 0.5 }]} 
              onPress={handleNext}
              disabled={nextTimer > 0}
            >
              <Text style={styles.nextButtonText}>
                {nextTimer > 0 ? `${t('common.wait', 'Wait...')} (${nextTimer}s)` :
                 currentIndex === sessionLimit - 1 ? t('quiz.finish') : t('common.next')}
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
    flexDirection: 'column',
    backgroundColor: 'rgba(255, 61, 0, 0.08)',
    borderWidth: 1.5,
    borderColor: '#FF3D00',
    borderRadius: 12,
    padding: 14,
    marginTop: 20,
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
    backgroundColor: colors.primary.DEFAULT,
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
    color: '#FFFFFF',
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
  reviewIconContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: colors.primary.DEFAULT + '26', // 15% opacity
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
    marginBottom: 20,
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
    backgroundColor: colors.primary.DEFAULT,
  },
  resumeButtonSecondary: {
    backgroundColor: 'transparent',
    borderWidth: 2,
    borderColor: '#CCC',
  },
  resumeButtonTextPrimary: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: '#FFFFFF',
  },
  resumeButtonTextSecondary: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: '#666',
  },

  // Result / Celebration Card styles
  resultScoreText: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: '#888',
    textAlign: 'center',
    marginTop: 8,
  },
  resultScoreValue: {
    fontSize: 56,
    fontFamily: typography.fonts.bold,
    textAlign: 'center',
    marginTop: 4,
  },
  resultSubLabel: {
    fontSize: 13,
    fontFamily: typography.fonts.regular,
    color: '#888',
    textAlign: 'center',
    marginBottom: 8,
    textTransform: 'uppercase',
    letterSpacing: 1,
  },
  resultMessage: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
    marginTop: 8,
  },
});
