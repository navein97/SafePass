import React, { useState, useCallback, useMemo, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  Alert, 
  ActivityIndicator, 
  Image,
  ScrollView,
  StatusBar
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Check, X, Heart, Clock, AlertCircle } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { useNavigation } from '@react-navigation/native';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { GradientBackground } from '../components/ui/GradientBackground';
import { typography } from '../theme/typography';

const { width: SCREEN_WIDTH } = Dimensions.get('window');

const QUIZ_IMAGES: Record<string, any> = {
  'stop_sign': require('../../assets/quiz/stop_sign.jpg'),
  'pedestrian_crossing': require('../../assets/quiz/pedestrian_crossing.jpg'),
  'no_entry': require('../../assets/quiz/no_entry.jpg'),
  'turn_right': require('../../assets/quiz/turn_right.jpg'),
  'warning': require('../../assets/quiz/warning.jpg'),
};

interface Question {
  id: string;
  question: string;
  text: string;
  options: string[];
  correctIndex: number;
  correctOptionIndex: number;
  imageUrl?: string;
  explanation: string;
  region: any;
  category: string;
}

export function MissionScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const navigation = useNavigation();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string>('');
  
  // Game State
  const [lives, setLives] = useState(3);
  const [timeLeft, setTimeLeft] = useState(120); // Default 2 mins
  const [timerActive, setTimerActive] = useState(false);
  const [selectedOption, setSelectedOption] = useState<number | null>(null);
  const [isAnswered, setIsAnswered] = useState(false);
  const [isGameOver, setIsGameOver] = useState(false);
  const [gameResult, setGameResult] = useState<'win' | 'lose' | null>(null);
  
  const [answers, setAnswers] = useState<{questionId: string, selectedOptionIndex: number, isCorrect: boolean}[]>([]);
  
  // Refs
  const timerRef = useRef<NodeJS.Timeout | null>(null);

  useEffect(() => {
    loadMission();
    return () => stopTimer();
  }, []);

  useEffect(() => {
    if (timerActive && timeLeft > 0) {
      timerRef.current = setTimeout(() => {
        setTimeLeft((prev) => prev - 1);
      }, 1000);
    } else if (timeLeft === 0 && timerActive) {
      handleGameOver('lose');
    }
    return () => {
      if (timerRef.current) clearTimeout(timerRef.current);
    };
  }, [timeLeft, timerActive]);

  const stopTimer = () => {
    if (timerRef.current) clearTimeout(timerRef.current);
    setTimerActive(false);
  };

  const loadMission = async () => {
    try {
      setLoading(true);
      const { profile, error } = await AuthService.getUserProfile();
      
      if (error || !profile) {
        Alert.alert(t('common.error', 'Error'), t('auth.loadProfileError', 'Could not load user profile'));
        return;
      }

      if (profile.role === 'manager') {
        navigation.navigate('ManagerQuickView' as never);
        return;
      }

      setUserId(profile.id);

      // Load specific manager settings or defaults
      const savedCount = await AsyncStorage.getItem('QUIZ_QUESTION_COUNT');
      const savedTimer = await AsyncStorage.getItem('QUIZ_TIMER_DURATION');
      
      const targetCount = savedCount ? parseInt(savedCount, 10) : 5;
      const durationMinutes = savedTimer ? parseInt(savedTimer, 10) : 2;
      
      setTimeLeft(durationMinutes * 60);

      // Fetch questions
      // Let's use getQuestionsForRegion to get a larger pool, then filter.
      let allQuestions = await QuizService.getQuestionsForRegion(profile.region);
      
      // Get previously answered correct questions IDs
      const attempts = await QuizService.getQuizAttempts(profile.id);
      const correctQuestionIds = new Set<string>();
      attempts.forEach(a => {
         a.answers.forEach(ans => {
             if (ans.isCorrect) correctQuestionIds.add(ans.questionId);
         });
      });

      // Filter into New and Old
      const newQuestions = allQuestions.filter(q => !correctQuestionIds.has(q.id));
      const oldQuestions = allQuestions.filter(q => correctQuestionIds.has(q.id));

      console.log(`Pool Stats - Total: ${allQuestions.length}, New: ${newQuestions.length}, Old: ${oldQuestions.length}`);
      
      let finalSelection: typeof allQuestions = [];

      // Helper for Fisher-Yates Shuffle
      const shuffleArray = <T,>(array: T[]): T[] => {
          const arr = [...array];
          for (let i = arr.length - 1; i > 0; i--) {
              const j = Math.floor(Math.random() * (i + 1));
              [arr[i], arr[j]] = [arr[j], arr[i]];
          }
          return arr;
      };

      // 1. Shuffle both pools
      const shuffledNew = shuffleArray(newQuestions);
      const shuffledOld = shuffleArray(oldQuestions);

      // 2. Logic to fill target count
      if (shuffledNew.length >= targetCount) {
          // We have enough new questions
          finalSelection = shuffledNew.slice(0, targetCount);
      } else {
          // We need to fill with old questions
          finalSelection = [...shuffledNew];
          const needed = targetCount - finalSelection.length;
          
          if (shuffledOld.length > 0) {
             const filled = shuffledOld.slice(0, needed);
             finalSelection = [...finalSelection, ...filled];
          }
      }

      // 3. Final Shuffle
      finalSelection = shuffleArray(finalSelection);

      if (finalSelection.length === 0) {
        Alert.alert(t('mission.noQuestions', 'No Questions'), t('mission.noQuestionsRegion', 'No questions found for your region.'));
        navigation.goBack();
        return;
      }

      const mappedQuestions: Question[] = finalSelection.map(q => ({
        id: q.id,
        question: q.text,
        text: q.text,
        options: q.options,
        correctIndex: q.correctOptionIndex,
        correctOptionIndex: q.correctOptionIndex,
        imageUrl: q.imageUrl,
        explanation: q.explanation,
        region: q.region,
        category: q.category
      }));

      setQuestions(mappedQuestions);
      setTimerActive(true);

    } catch (error) {
      console.error('Error loading mission:', error);
      Alert.alert(t('common.error', 'Error'), t('mission.loadError', 'Failed to load mission'));
    } finally {
      setLoading(false);
    }
  };

  const handleOptionSelect = (index: number) => {
    if (isAnswered || isGameOver) return;

    setSelectedOption(index);
    setIsAnswered(true);

    const currentQuestion = questions[currentQuestionIndex];
    const isCorrect = index === currentQuestion.correctIndex;

    const newAnswer = {
      questionId: currentQuestion.id,
      selectedOptionIndex: index,
      isCorrect
    };

    setAnswers([...answers, newAnswer]);

    if (!isCorrect) {
      setLives(prev => {
        const newLives = prev - 1;
        if (newLives === 0) {
           stopTimer();
           setTimeout(() => handleGameOver('lose'), 1500); // Delay to show wrong answer feedback
        }
        return newLives;
      });
    }
  };

  const handleNext = () => {
    if (currentQuestionIndex < questions.length - 1) {
      setCurrentQuestionIndex(prev => prev + 1);
      setSelectedOption(null);
      setIsAnswered(false);
    } else {
      handleGameOver('win');
    }
  };

  const handleGameOver = async (result: 'win' | 'lose') => {
    stopTimer();
    setIsGameOver(true);
    setGameResult(result);

    if (result === 'win') {
       // Submit Score if Win (or partial?)
       // Usually we submit whatever we have.
       try {
         await QuizService.submitQuiz(userId, answers, questions);
       } catch (error) {
         console.error('Submit error', error);
       }
    }
  };

  const handleRetry = () => {
    // Reset state
    setLives(3);
    setCurrentQuestionIndex(0);
    setAnswers([]);
    setSelectedOption(null);
    setIsAnswered(false);
    setIsGameOver(false);
    setGameResult(null);
    loadMission(); // Reload to get fresh shuffle/timer/etc
  };

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs < 10 ? '0' : ''}${secs}`;
  };

  if (loading) {
     return (
       <GradientBackground>
         <SafeAreaView style={styles.loadingContainer}>
           <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
           <Text style={styles.loadingText}>{t('mission.loading')}</Text>
         </SafeAreaView>
       </GradientBackground>
     );
  }

  // Crash prevent check
  if (!questions || questions.length === 0) {
      return null;
  }

  if (isGameOver) {
      return (
        <GradientBackground>
            <SafeAreaView style={styles.gameOverContainer}>
                {gameResult === 'win' ? (
                    <View style={styles.resultCard}>
                        <Check size={80} color={colors.status.success} style={{ marginBottom: 20 }} />
                        <Text style={[styles.resultTitle, { color: colors.status.success }]}>{t('mission.missionAccomplished')}</Text>
                        <Text style={styles.resultScore}>{t('mission.score')}: {Math.round((answers.filter(a => a.isCorrect).length / questions.length) * 100)}%</Text>
                        <GlassButton 
                            title={t('common.done')}
                            onPress={() => navigation.goBack()}
                            style={styles.actionButton}
                        />
                        <TouchableOpacity 
                            onPress={handleRetry}
                            style={[styles.actionButton, { marginTop: 12, backgroundColor: 'transparent', borderWidth: 1, borderColor: colors.border }]}
                        >
                            <Text style={{ 
                                color: colors.text.primary, 
                                fontFamily: typography.fonts.medium, 
                                textAlign: 'center',
                                padding: 12
                            }}>
                                {t('common.tryAgain')}
                            </Text>
                        </TouchableOpacity>
                    </View>
                ) : (
                    <View style={styles.resultCard}>
                        <X size={80} color={colors.status.danger} style={{ marginBottom: 20 }} />
                        <Text style={[styles.resultTitle, { color: colors.status.danger }]}>{t('mission.missionFailed')}</Text>
                        <Text style={styles.resultReason}>
                            {lives === 0 ? t('mission.outOfLives') : t('mission.outOfTime')}
                        </Text>
                         <GlassButton 
                            title={t('common.tryAgain')}
                            onPress={handleRetry}
                            style={styles.actionButton}
                        />
                    </View>
                )}
            </SafeAreaView>
        </GradientBackground>
      );
  }

  const currentQuestion = questions[currentQuestionIndex];

  return (
    <GradientBackground>
      <SafeAreaView style={styles.container}>
        <StatusBar barStyle="light-content" />
        
        {/* Top Bar: Lives & Timer */}
        <View style={styles.topBar}>
           <View style={styles.livesContainer}>
              {[1, 2, 3].map((i) => (
                  <Heart 
                    key={i} 
                    size={24} 
                    fill={i <= lives ? colors.status.danger : 'transparent'} 
                    color={colors.status.danger} 
                    style={{ marginRight: 4 }}
                  />
              ))}
           </View>
           <View style={[styles.timerContainer, timeLeft < 30 && styles.timerWarning]}>
              <Clock size={20} color={timeLeft < 30 ? colors.status.danger : colors.text.primary} style={{ marginRight: 8 }} />
              <Text style={[styles.timerText, timeLeft < 30 && { color: colors.status.danger }]}>{formatTime(timeLeft)}</Text>
           </View>
        </View>

        <ScrollView contentContainerStyle={styles.content}>
           {/* Question */}
           <View style={styles.questionHeader}>
              <Text style={styles.progressText}>{t('quiz.question')} {currentQuestionIndex + 1} / {questions.length}</Text>
           </View>

           <GlassCard style={styles.questionCard}>
              {currentQuestion.imageUrl && QUIZ_IMAGES[currentQuestion.imageUrl] && (
                 <Image 
                   source={QUIZ_IMAGES[currentQuestion.imageUrl]}
                   style={styles.questionImage}
                   resizeMode="contain"
                 />
              )}
              <Text style={styles.questionText}>{currentQuestion.question}</Text>
           </GlassCard>

           {/* Options */}
           <View style={styles.optionsContainer}>
             {currentQuestion.options.map((opt, idx) => {
                let optionStyle = styles.optionButton;
                let textStyle = styles.optionText;
                let icon = null;

                if (isAnswered) {
                    if (idx === currentQuestion.correctIndex) {
                        optionStyle = styles.optionCorrect;
                        textStyle = styles.optionTextCorrect;
                        icon = <Check size={20} color={colors.status.success} />;
                    } else if (idx === selectedOption) {
                        optionStyle = styles.optionWrong;
                        textStyle = styles.optionTextWrong;
                        icon = <X size={20} color={colors.status.danger} />;
                    } else {
                        optionStyle = styles.optionDisabled;
                    }
                } else if (selectedOption === idx) {
                    optionStyle = styles.optionSelected;
                }

                return (
                   <TouchableOpacity 
                      key={idx}
                      style={[styles.optionButtonBase, optionStyle]}
                      onPress={() => handleOptionSelect(idx)}
                      disabled={isAnswered}
                   >
                     <View style={styles.optionRow}>
                        <View style={styles.optionLetterContainer}>
                           <Text style={[styles.optionLetter, textStyle]}>{String.fromCharCode(65 + idx)}</Text>
                        </View>
                        <Text style={[styles.optionContentText, textStyle]}>{opt}</Text>
                        {icon}
                     </View>
                   </TouchableOpacity>
                );
             })}
           </View>

           {/* Feedback / Next */}
           {isAnswered && (
               <View style={styles.footer}>
                   {selectedOption !== currentQuestion.correctIndex && (
                       <View style={styles.feedbackBox}>
                          <AlertCircle size={20} color={colors.status.danger} style={{ marginRight: 8 }} />
                           <Text style={styles.feedbackText}>{t('quiz.correctAnswerIs')} {String.fromCharCode(65 + currentQuestion.correctIndex)}</Text>
                       </View>
                   )}
                   <GlassButton 
                      title={currentQuestionIndex < questions.length - 1 ? t('common.next') : t('quiz.finish')}
                      onPress={handleNext}
                      style={{ marginTop: 16 }}
                   />
               </View>
           )}
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
  container: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: 16,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  topBar: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 12,
    alignItems: 'center',
  },
  livesContainer: {
    flexDirection: 'row',
  },
  timerContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.2)',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 16,
  },
  timerWarning: {
    backgroundColor: 'rgba(255, 68, 68, 0.2)',
    borderWidth: 1,
    borderColor: colors.status.danger,
  },
  timerText: {
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    fontSize: 16,
  },
  content: {
    padding: 20,
    paddingBottom: 40,
  },
  questionHeader: {
    marginBottom: 16,
  },
  progressText: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    fontSize: 14,
    textAlign: 'center',
  },
  questionCard: {
    padding: 24,
    marginBottom: 24,
  },
  questionImage: {
    width: '100%',
    height: 180,
    borderRadius: 8,
    marginBottom: 16,
  },
  questionText: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    lineHeight: 28,
  },
  optionsContainer: {
    gap: 12,
  },
  optionButtonBase: {
    borderRadius: 12,
    borderWidth: 1,
    padding: 4,
  },
  optionRow: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 12,
  },
  optionLetterContainer: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: 'rgba(255,255,255,0.1)',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  optionLetter: {
    fontFamily: typography.fonts.bold,
    fontSize: 14,
    color: colors.text.primary,
  },
  optionContentText: {
    flex: 1,
    fontFamily: typography.fonts.medium,
    fontSize: 16,
    color: colors.text.primary,
  },
  // States
  optionButton: {
    borderColor: colors.border,
    backgroundColor: colors.background.glass,
  },
  optionText: {
    color: colors.text.primary,
  },
  optionSelected: {
    borderColor: colors.primary.DEFAULT,
    backgroundColor: 'rgba(255, 215, 0, 0.1)',
  },
  optionCorrect: {
    borderColor: colors.status.success,
    backgroundColor: 'rgba(0, 200, 83, 0.2)',
  },
  optionTextCorrect: {
    color: colors.status.success,
  },
  optionWrong: {
    borderColor: colors.status.danger,
    backgroundColor: 'rgba(255, 61, 0, 0.2)',
  },
  optionTextWrong: {
    color: colors.text.primary, 
  },
  optionDisabled: {
    opacity: 0.5,
    borderColor: colors.border,
    backgroundColor: colors.background.glass,
  },
  footer: {
    marginTop: 24,
  },
  feedbackBox: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 61, 0, 0.1)',
    padding: 12,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: colors.status.danger,
    marginBottom: 8,
  },
  feedbackText: {
    color: colors.status.danger,
    fontFamily: typography.fonts.medium,
  },
  gameOverContainer: {
    flex: 1,
    justifyContent: 'center',
    padding: 20,
  },
  resultCard: {
    backgroundColor: colors.background.card,
    borderRadius: 24,
    padding: 32,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 8,
  },
  resultTitle: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    marginBottom: 16,
  },
  resultScore: {
    fontSize: 18,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    marginBottom: 32,
  },
  resultReason: {
    fontSize: 16,
    color: colors.text.secondary,
    textAlign: 'center',
    marginBottom: 32,
  },
  actionButton: {
    width: '100%',
  },
});

