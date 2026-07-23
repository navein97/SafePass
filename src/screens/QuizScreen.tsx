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
import { LinearGradient } from 'expo-linear-gradient';
import { GradientBackground } from '../components/ui/GradientBackground';
import { SubscriptionService } from '../services/subscriptionService';
import { supabase } from '../lib/supabase';

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
  const [showFailedReview, setShowFailedReview] = useState(false);

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

      // Trial gating: block batches beyond subscription limit
      if (!isPractice && batchNumber > 1) {
        const maxBatches = await SubscriptionService.getMaxBatches(profile.company_id);
        if (batchNumber > maxBatches) {
          setLoading(false);
          const title = t('billing.upgradeRequired');
          const message = t('billing.trialBatchLocked');
          if (Platform.OS === 'web') {
            window.alert(`${title}\n\n${message}`);
            navigation.goBack();
          } else {
            Alert.alert(title, message, [
              { text: t('common.ok'), onPress: () => navigation.goBack() }
            ]);
          }
          return;
        }
      }

      if (!isPractice) {
        const isLocked = await BatchService.isBatchLocked(profile.id, batchNumber);
        if (isLocked) {
          setLoading(false);
          const lockTitle = t('quiz.batchLockedTitle') || 'Batch Locked';
          const lockMessage = t('quiz.batchLockedMessage') || 'This batch has been passed and is locked. You cannot retake it unless reset by the Master User.';
          if (Platform.OS === 'web') {
            window.alert(`${lockTitle}\n\n${lockMessage}`);
            navigation.goBack();
          } else {
            Alert.alert(lockTitle, lockMessage, [{ text: 'OK', onPress: () => navigation.goBack() }]);
          }
          return;
        }

        const canAccess = await BatchService.canAccessBatch(profile.id, batchNumber);
        if (!canAccess) {
          setLoading(false);
          const title = t('quiz.batchLocked') || 'Batch Locked';
          const message = t('quiz.batchLockedMessage', { prevBatch: batchNumber - 1 }) || `You must complete Batch ${batchNumber - 1} with at least 70% average score to unlock this batch.`;
          
          if (Platform.OS === 'web') {
            window.alert(`${title}\n\n${message}`);
            navigation.goBack();
          } else {
            Alert.alert(title, message, [{ text: 'OK', onPress: () => navigation.goBack() }]);
          }
          return;
        }
      }

      let dailyStatus;
      if (!isPractice) {
        dailyStatus = await BatchService.getDailyLimitStatus(profile.id, batchNumber);
        if (!dailyStatus.isAccessGranted) {
          setLoading(false);
          const title = t('quiz.dailyLimitTitle') || 'Daily Limit Reached';
          const message = t('quiz.dailyLimitMessage', { number: batchNumber }) || `You have reached your limit of 3 questions for Batch ${batchNumber} today. Come back tomorrow or try Practice Mode!`;
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
        
        let sLimit = 30;
        if (!isPractice && dailyStatus) {
          const quota = (dailyStatus.isOverridden || dailyStatus.isWaived) ? 30 : Math.max(0, 3 - dailyStatus.completedToday);
          sLimit = Math.min(quota, loadedQuestions.length);
        }
        setSessionLimit(sLimit);
        
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

  const exitQuiz = async (save = false) => {
    if (save) {
      await saveProgressLocally();
    } else {
      await QuizStorageService.clearProgress(userId, batchNumber, mode);
    }
    navigation.navigate('MainTabs', { screen: 'Mission', params: { refresh: true } });
  };
  
  const handleBack = () => {
    // Platform-agnostic confirmation with save option
    const title = t('common.exitQuiz') || 'Exit Quiz?';
    const message = t('common.saveExitMessage') || 
      'Would you like to save your progress and continue later?';

    if (Platform.OS === 'web') {
      // Web: Use confirm for simple yes/no, save progress if confirmed
      const saveAndExit = window.confirm(`${String(title)}\n\n${String(message)}\n\n${t('common.saveExitWebConfirm')}`);
      if (saveAndExit) {
        exitQuiz(true);
      }
    } else {
      Alert.alert(
        title,
        message,
        [
          { text: t('common.cancel') || 'Cancel', style: 'cancel' },
          { 
            text: t('common.saveAndExitButton') || 'Save & Exit',
            onPress: () => exitQuiz(true)
          },
          { 
            text: t('common.exitWithoutSaving') || 'Exit Without Saving', 
            style: 'destructive',
            onPress: () => exitQuiz(false)
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

    if (isCorrect) {
      // Record correct answer
      setAnswers(prev => [...prev, {
        questionId: currentBatchQuestion.id,
        attempts: currentAttempts,
        isCorrect: true
      }]);
      setShowFeedback(false);

      if (!isPractice) {
        const score = currentAttempts === 1 ? 1.0 : 0.5;
        await BatchService.recordQuestionProgress(
          userId,
          currentBatchQuestion.id,
          batchNumber,
          currentAttempts,
          true,
          score
        );
      }

      setNextTimer(2);
    } else {
      // Record failed attempt and Show feedback
      setAnswers(prev => [...prev, {
        questionId: currentBatchQuestion.id,
        attempts: currentAttempts,
        isCorrect: false
      }]);
      setShowFeedback(true);

      if (isPractice) {
        setNextTimer(4);
      } else {
        if (currentAttempts === 1) {
          setNextTimer(0);
        } else {
          await BatchService.recordQuestionProgress(
            userId,
            currentBatchQuestion.id,
            batchNumber,
            2,
            false,
            0.0
          );
          setNextTimer(4);
        }
      }
    }
    
    setTimeout(() => {
      scrollViewRef.current?.scrollToEnd({ animated: true });
    }, 100);
  };

  const handleRetry = () => {
    const currentAttempts = attemptCounts[currentIndex] || 0;
    
    if (!isPractice && currentAttempts === 1) {
      // Live Mode 1st attempt failure: Clear state to allow 2nd attempt
      setSelectedOption(null);
      setIsAnswered(false);
      setShowFeedback(false);
      setNextTimer(0);
      return;
    }

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
      
      const { count } = await supabase
        .from('user_question_progress')
        .select('*', { count: 'exact', head: true })
        .eq('user_id', userId)
        .eq('batch_number', batchNumber);

      const completedCount = count || 0;
      console.log(`[QuizScreen] Completed questions count in DB: ${completedCount}`);

      // Clear local progress since this daily session is resolved
      await QuizStorageService.clearProgress(userId, batchNumber, mode);

      if (completedCount >= 30) {
        // Evaluated at exactly 30 questions
        const evalResult = await BatchService.evaluateBatch(userId, batchNumber, timeSpentSeconds);
        if (evalResult.success) {
          const title = evalResult.passed ? (t('quiz.batchCompleted') || 'Batch Passed! 🏆') : (t('quiz.batchAttemptRecorded') || 'Batch Failed');
          setResultData({
            title,
            score: evalResult.score,
            avgScore: evalResult.score,
            passed: evalResult.passed,
            isPractice: false
          });
        } else {
          Alert.alert('Error', 'Failed to evaluate batch. Please check your connection.');
        }
      } else {
        setLoading(false);
        // Show session complete card instead of raw alert
        setResultData({
          title: t('quiz.dailySessionCompleteTitle') || 'Session Complete!',
          score: 0,
          avgScore: 0,
          passed: false,
          isPractice: false,
          isDailySessionComplete: true, // Custom flag to render differently
          completedCount: completedCount
        } as any); // Casting as any to easily append custom fields for rendering
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

  const hasIncorrectAnswers = useMemo(() => {
    return questions.some((q) => {
      const qAnswers = answers.filter(a => a.questionId === q.id);
      return qAnswers.some(a => !a.isCorrect);
    });
  }, [questions, answers]);

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
                activeOpacity={0.8}
              >
                <LinearGradient
                  colors={colors.gradients.primary as any}
                  start={{ x: 0, y: 0 }}
                  end={{ x: 1, y: 0 }}
                  style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
                />
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
              activeOpacity={0.8}
            >
              <LinearGradient
                colors={colors.gradients.primary as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
              />
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
    const isDailySessionComplete = (resultData as any).isDailySessionComplete;
    
    let celebrationEmoji = '🏆';
    let accentColor: string;
    if (isDailySessionComplete) {
      celebrationEmoji = '👍';
      accentColor = colors.status.info || '#2563EB';
    } else if (resultData.passed || isPracticeResult) {
      celebrationEmoji = resultData.score >= 80 ? '🏆' : resultData.score >= 60 ? '🎉' : '💪';
      accentColor = resultData.score >= 60 ? colors.status.success : colors.status.warning;
    } else {
      celebrationEmoji = '📋';
      accentColor = colors.status.danger;
    }

    return (
      <GradientBackground>
        <SafeAreaView style={styles.resumeContainer}>
          <StatusBar barStyle="light-content" />
          <View style={[styles.resumeCard, { borderWidth: 1.5, borderColor: accentColor }]}>
            {/* Big emoji */}
            <Text style={{ fontSize: 72, textAlign: 'center', marginBottom: 8 }}>{celebrationEmoji}</Text>

            <Text style={[styles.resumeTitle, { color: accentColor }]}>{resultData.title}</Text>

              {isDailySessionComplete ? (
                <>
                  <Text style={[styles.resultMessage, { color: colors.text.secondary, marginTop: 12, textAlign: 'center', lineHeight: 22, fontSize: 16 }]}>
                    {t('quiz.dailySessionCompleteMessage', { count: (resultData as any).completedCount }) || `Great work! You've answered ${(resultData as any).completedCount}/30 questions in this batch. Come back tomorrow to continue your progress.`}
                  </Text>
                  
                  <View style={{ backgroundColor: colors.background.subtle, paddingVertical: 16, paddingHorizontal: 20, borderRadius: 12, marginTop: 24, marginBottom: 8, alignItems: 'center', width: '90%', alignSelf: 'center' }}>
                    <Text style={{ fontSize: 13, fontFamily: typography.fonts.medium, color: colors.text.secondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>Current Progress</Text>
                    <Text style={{ fontSize: 28, fontFamily: typography.fonts.bold, color: accentColor, marginTop: 4 }}>{(resultData as any).completedCount}/30</Text>
                  </View>
                </>
              ) : isPracticeResult ? (
                <>
                  <Text style={styles.resultScoreText}>{t('quiz.correctCount', { correct: resultData.correct, total: resultData.total })}</Text>
                  <Text style={[styles.resultScoreValue, { color: accentColor }]}>{resultData.score}%</Text>
                  <Text style={styles.resultSubLabel}>{t('quiz.accuracy')}</Text>
                </>
              ) : (
                <>
                  <Text style={styles.resultSubLabel}>{t('quiz.scoreLabel').replace(':', '')}</Text>
                  <Text style={[styles.resultScoreValue, { color: accentColor, marginTop: -4 }]}>{resultData.score.toFixed(1)}%</Text>
                  
                  <View style={{ backgroundColor: colors.background.subtle, paddingVertical: 12, paddingHorizontal: 20, borderRadius: 12, marginTop: 24, marginBottom: 8, alignItems: 'center', width: '80%', alignSelf: 'center' }}>
                    <Text style={{ fontSize: 12, fontFamily: typography.fonts.medium, color: colors.text.secondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>{t('quiz.averageScore')}</Text>
                    <Text style={{ fontSize: 22, fontFamily: typography.fonts.bold, color: accentColor, marginTop: 4 }}>{resultData.avgScore.toFixed(1)}%</Text>
                  </View>

                  {resultData.passed ? (
                    <Text style={[styles.resultMessage, { color: '#00C853', marginTop: 8 }]}>
                      ✅ {batchNumber < 4 ? t('quiz.nextBatchUnlocked', { number: batchNumber + 1 }) : t('quiz.allBatchesComplete')}
                    </Text>
                  ) : (
                    <Text style={[styles.resultMessage, { color: colors.text.secondary, marginTop: 8 }]}>
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
                  activeOpacity={0.8}
                >
                  <LinearGradient
                    colors={colors.gradients.primary as any}
                    start={{ x: 0, y: 0 }}
                    end={{ x: 1, y: 0 }}
                    style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
                  />
                  <Text style={styles.resumeButtonTextPrimary}>{t('quiz.practiceAgain')}</Text>
                </TouchableOpacity>
              )}

              {!isPracticeResult && !resultData.passed && hasIncorrectAnswers && (
                <TouchableOpacity
                  style={[styles.resumeButton, styles.resumeButtonPrimary]}
                  onPress={() => {
                    setResultData(null);
                    setShowFailedReview(true);
                  }}
                  activeOpacity={0.8}
                >
                  <LinearGradient
                    colors={colors.gradients.primary as any}
                    start={{ x: 0, y: 0 }}
                    end={{ x: 1, y: 0 }}
                    style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
                  />
                  <Text style={styles.resumeButtonTextPrimary}>{t('quiz.reviewIncorrect', 'Review Incorrect Answers')}</Text>
                </TouchableOpacity>
              )}

              <TouchableOpacity
                style={[styles.resumeButton, (isPracticeResult || (!isPracticeResult && !resultData.passed && hasIncorrectAnswers)) ? styles.resumeButtonSecondary : styles.resumeButtonPrimary]}
                onPress={() => exitQuiz(false)}
                activeOpacity={0.8}
              >
                  {!isPracticeResult && resultData.passed && (
                    <LinearGradient
                      colors={colors.gradients.primary as any}
                      start={{ x: 0, y: 0 }}
                      end={{ x: 1, y: 0 }}
                      style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
                    />
                  )}
                  <Text style={(isPracticeResult || (!isPracticeResult && !resultData.passed)) ? styles.resumeButtonTextSecondary : styles.resumeButtonTextPrimary}>
                    {t('quiz.backToMenu')}
                  </Text>
              </TouchableOpacity>
            </View>
          </View>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  if (showFailedReview) {
    const incorrectQuestions = questions.filter((q) => {
      const qAnswers = answers.filter(a => a.questionId === q.id);
      return qAnswers.some(a => !a.isCorrect);
    });

    return (
      <GradientBackground>
        <SafeAreaView style={styles.safeArea}>
          <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} />
          <View style={styles.header}>
            <Text style={[styles.batchTitle, { fontSize: 18, textAlign: 'center' }]}>{t('quiz.failedReviewTitle', 'Incorrect Answers Review')}</Text>
          </View>
          <ScrollView contentContainerStyle={styles.content} showsVerticalScrollIndicator={false}>
            <Text style={{ fontSize: 14, color: colors.text.secondary, marginBottom: 16, textAlign: 'center', fontFamily: typography.fonts.regular }}>
              {t('quiz.failedReviewDesc', 'Please review the explanations below before retaking this batch.')}
            </Text>
            {incorrectQuestions.map((q, index) => {
              const correctOptionText = q.options[q.correctOptionIndex];
              const isMalay = i18n.language === 'ms';
              const text = (isMalay && q.text_ms) ? q.text_ms : q.text;
              const options = (isMalay && q.options_ms) ? q.options_ms : q.options;
              const explanation = (isMalay && q.explanation_ms) ? q.explanation_ms : q.explanation;
              const localizedCorrectOptionText = options[q.correctOptionIndex];

              return (
                <View key={q.id} style={[styles.questionCard, { borderLeftWidth: 4, borderLeftColor: colors.status.danger, marginBottom: 16 }]}>
                  <Text style={{ fontSize: 13, color: colors.text.secondary, fontFamily: typography.fonts.bold, marginBottom: 4 }}>
                    {t('quiz.questionNumber', { number: index + 1 }) || `Question ${index + 1}`}
                  </Text>
                  <Text style={[styles.questionText, { fontSize: 15, lineHeight: 22, marginBottom: 8 }]}>{text}</Text>
                  
                  <View style={{ backgroundColor: colors.mode === 'dark' ? '#0A2412' : '#F0FBF4', padding: 10, borderRadius: 8, marginVertical: 6 }}>
                    <Text style={{ fontSize: 13, color: colors.status.success, fontFamily: typography.fonts.bold }}>✓ {t('quiz.correctAnswer', 'Correct Answer')}:</Text>
                    <Text style={{ fontSize: 14, color: colors.status.success, marginTop: 2, fontFamily: typography.fonts.medium }}>{localizedCorrectOptionText}</Text>
                  </View>

                  {explanation ? (
                    <View style={{ marginTop: 8, paddingTop: 8, borderTopWidth: 1, borderTopColor: colors.border }}>
                      <Text style={{ fontSize: 12, color: colors.text.secondary, fontFamily: typography.fonts.bold }}>💡 {t('quiz.explanation')}:</Text>
                      <Text style={{ fontSize: 14, color: colors.text.primary, marginTop: 2, lineHeight: 20, fontFamily: typography.fonts.regular }}>{explanation}</Text>
                    </View>
                  ) : null}
                </View>
              );
            })}
            
            <TouchableOpacity 
              style={styles.nextButton}
              onPress={() => exitQuiz(false)}
              activeOpacity={0.8}
            >
              <LinearGradient
                colors={colors.gradients.primary as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
              />
              <Text style={styles.nextButtonText}>{t('quiz.restartBatch', 'Return & Restart Batch')}</Text>
            </TouchableOpacity>
          </ScrollView>
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
                    <Check size={24} color={colors.status.success} strokeWidth={3} />
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
                  <Text style={{ fontSize: 14, fontFamily: typography.fonts.regular, color: colors.text.secondary, lineHeight: 20 }}>
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

          <View style={{ marginTop: 40, alignItems: 'center', opacity: 0.6 }}>
            <Text style={{ fontSize: 10, fontFamily: typography.fonts.medium, color: colors.text.tertiary, textAlign: 'center' }}>
              © 2026 CNG Synergy (KT0512750V). All rights reserved.
            </Text>
            <Text style={{ fontSize: 9, fontFamily: typography.fonts.regular, color: colors.text.tertiary, textAlign: 'center', marginTop: 2, paddingHorizontal: 20, lineHeight: 14 }}>
              The questions and logic presented are proprietary. Unauthorized reproduction is strictly prohibited.
            </Text>
          </View>

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
                 (!isPractice && (attemptCounts[currentIndex] || 0) === 1)
                  ? (t('quiz.tryAgain', 'Try Again') || 'Try Again')
                  : isPractice
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
              activeOpacity={0.8}
            >
              <LinearGradient
                colors={colors.gradients.primary as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={[StyleSheet.absoluteFill, { borderRadius: 12 }]}
              />
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
    backgroundColor: colors.background.card,
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
    color: colors.text.primary,
    lineHeight: 24,
  },
  optionsContainer: {
    gap: 10,
  },
  optionCard: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.background.card,
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
    backgroundColor: colors.mode === 'dark' ? '#14291B' : '#E8F8EF',
    borderColor: colors.status.success,
  },
  optionWrong: {
    backgroundColor: colors.mode === 'dark' ? '#2D1611' : '#FFEBE6',
    borderColor: colors.status.danger,
  },
  optionDimmed: {
    opacity: 0.7,
  },
  optionLetter: {
    width: 32,
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.secondary,
  },
  optionLetterCorrect: {
    color: colors.status.success,
  },
  optionLetterWrong: {
    color: colors.status.danger,
  },
  optionText: {
    flex: 1,
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
    lineHeight: 22,
  },
  optionTextCorrect: {
    color: colors.status.success,
  },
  optionTextWrong: {
    color: colors.status.danger,
  },
  
  // Feedback
  feedbackCard: {
    flexDirection: 'column',
    backgroundColor: colors.mode === 'dark' ? '#240F0A' : '#FFF0EE',
    borderWidth: 1.5,
    borderColor: colors.status.danger,
    borderRadius: 12,
    padding: 14,
    marginTop: 20,
  },
  feedbackText: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    color: colors.status.danger,
  },
  
  // Coaching
  coachingCard: {
    backgroundColor: colors.background.subtle,
    borderRadius: 12,
    padding: 16,
    marginTop: 16,
  },
  coachingLabel: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.secondary,
    marginBottom: 6,
  },
  coachingText: {
    fontSize: 15,
    fontFamily: typography.fonts.regular,
    color: colors.text.primary,
    lineHeight: 22,
  },
  
  // Footer
  footer: {
    padding: 20,
    paddingBottom: 30,
  },
  nextButton: {
    backgroundColor: 'transparent',
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
    backgroundColor: colors.background.card,
    borderRadius: 20,
    padding: 30,
    width: '100%',
    maxWidth: 400,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 12,
    elevation: 8,
  },
  reviewIconContainer: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: colors.background.subtle,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
    marginBottom: 20,
  },
  resumeTitle: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
    textAlign: 'center',
  },
  resumeMessage: {
    fontSize: 16,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
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
    backgroundColor: 'transparent',
  },
  resumeButtonSecondary: {
    backgroundColor: 'transparent',
    borderWidth: 2,
    borderColor: colors.border,
  },
  resumeButtonTextPrimary: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: '#FFFFFF',
  },
  resumeButtonTextSecondary: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },

  // Result / Celebration Card styles
  resultScoreText: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
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
    color: colors.text.secondary,
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
