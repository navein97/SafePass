import React, { useState, useCallback, useMemo, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  Pressable,
  Alert, 
  ActivityIndicator, 
  Image
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import Animated, {
  useSharedValue,
  useAnimatedStyle,
  withSpring,
  withTiming,
  runOnJS,
  interpolate,
  Extrapolation,
} from 'react-native-reanimated';
import {
  Gesture,
  GestureDetector,
  GestureHandlerRootView,
} from 'react-native-gesture-handler';
import { RotateCcw, Check, X } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { useNavigation } from '@react-navigation/native';

const QUIZ_IMAGES: Record<string, any> = {
  'stop_sign': require('../../assets/quiz/stop_sign.jpg'),
  'pedestrian_crossing': require('../../assets/quiz/pedestrian_crossing.jpg'),
  'no_entry': require('../../assets/quiz/no_entry.jpg'),
  'turn_right': require('../../assets/quiz/turn_right.jpg'),
  'warning': require('../../assets/quiz/warning.jpg'),
};

const { width: SCREEN_WIDTH, height: SCREEN_HEIGHT } = Dimensions.get('window');
const CARD_WIDTH = SCREEN_WIDTH * 0.9;
const CARD_HEIGHT = SCREEN_HEIGHT * 0.65;
const SWIPE_THRESHOLD = SCREEN_WIDTH * 0.25;

// Local extended interface that satisfies models.Question but adds UI specific fields if needed
interface Question {
  id: string;
  question: string; // Used in UI
  text: string;     // Required by service
  options: string[];
  correctIndex: number; // Used in UI
  correctOptionIndex: number; // Required by service
  imageUrl?: string;
  explanation: string;
  region: any;
  category: string;
}

interface SwipeCardProps {
  question: Question;
  currentOptionIndex: number;
  onSwipeRight: () => void;
  onRewind: () => void;
  canRewind: boolean;
  showCheckmark: boolean;
}

function SwipeCard({ 
  question, 
  currentOptionIndex, 
  onSwipeRight, 
  canRewind,
  onRewind,
  showCheckmark,
}: SwipeCardProps) {
  const { t } = useTranslation();
  const { colors } = useTheme();
  
  // Create styles inside component to use colors
  const styles = useMemo(() => StyleSheet.create({
    card: {
      width: CARD_WIDTH,
      height: CARD_HEIGHT,
      borderRadius: 24,
      overflow: 'hidden',
      borderWidth: 2,
      borderColor: colors.border,
    },
    cardGradient: {
      flex: 1,
      padding: 24,
    },
    rewindButton: {
      position: 'absolute',
      top: 16,
      right: 16,
      width: 44,
      height: 44,
      borderRadius: 22,
      backgroundColor: colors.background.glass,
      justifyContent: 'center',
      alignItems: 'center',
      borderWidth: 1,
      borderColor: colors.primary.DEFAULT,
    },
    questionContainer: {
      marginBottom: 16,
    },
    questionLabel: {
      fontFamily: 'Inter-Bold',
      fontSize: 12,
      color: colors.primary.DEFAULT,
      letterSpacing: 2,
      marginBottom: 8,
    },
    questionImage: {
      width: '100%',
      height: 120,
      marginBottom: 12,
      borderRadius: 12,
    },
    questionText: {
      fontFamily: 'Inter-Bold',
      fontSize: 22,
      color: colors.text.primary,
      lineHeight: 32,
    },
    optionContainer: {
      flex: 1,
      justifyContent: 'center',
      backgroundColor: colors.background.glass,
      borderRadius: 16,
      padding: 20,
      borderWidth: 1,
      borderColor: colors.border,
    },
    optionLabel: {
      fontFamily: 'Inter-Medium',
      fontSize: 14,
      color: colors.primary.DEFAULT,
      marginBottom: 8,
    },
    optionText: {
      fontFamily: 'Inter-Medium',
      fontSize: 18,
      color: colors.text.primary,
      lineHeight: 26,
    },
    dotsContainer: {
      flexDirection: 'row',
      justifyContent: 'center',
      marginTop: 20,
      gap: 8,
    },
    dot: {
      width: 8,
      height: 8,
      borderRadius: 4,
      backgroundColor: colors.text.tertiary,
    },
    dotActive: {
      backgroundColor: colors.primary.DEFAULT,
      width: 24,
    },
    instructionContainer: {
      marginTop: 16,
      alignItems: 'center',
    },
    instructionText: {
      fontFamily: 'Inter-Regular',
      fontSize: 12,
      color: colors.text.secondary,
    },
    checkmarkOverlay: {
      ...StyleSheet.absoluteFillObject,
      justifyContent: 'center',
      alignItems: 'center',
      backgroundColor: 'rgba(0, 0, 0, 0.3)',
    },
    checkmarkCircle: {
      width: 100,
      height: 100,
      borderRadius: 50,
      backgroundColor: colors.primary.DEFAULT,
      justifyContent: 'center',
      alignItems: 'center',
    },
  }), [colors]);

  const translateX = useSharedValue(0);
  const translateY = useSharedValue(0);
  const rotation = useSharedValue(0);
  const checkmarkOpacity = useSharedValue(0);

  const panGesture = Gesture.Pan()
    .onUpdate((event) => {
      translateX.value = event.translationX;
      translateY.value = event.translationY * 0.5;
      rotation.value = interpolate(
        event.translationX,
        [-SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2],
        [-15, 0, 15],
        Extrapolation.CLAMP
      );
      
      // Show checkmark when swiping right
      if (event.translationX > 50) {
        checkmarkOpacity.value = interpolate(
          event.translationX,
          [50, SWIPE_THRESHOLD],
          [0, 1],
          Extrapolation.CLAMP
        );
      } else {
        checkmarkOpacity.value = 0;
      }
    })
    .onEnd((event) => {
      if (event.translationX > SWIPE_THRESHOLD) {
        // Swipe right - select answer
        translateX.value = withTiming(SCREEN_WIDTH * 1.5, { duration: 300 });
        checkmarkOpacity.value = withTiming(1, { duration: 150 });
        runOnJS(onSwipeRight)();
      } else {
        // Reset position
        translateX.value = withSpring(0);
        translateY.value = withSpring(0);
        rotation.value = withSpring(0);
        checkmarkOpacity.value = withTiming(0);
      }
    });

  const cardStyle = useAnimatedStyle(() => ({
    transform: [
      { translateX: translateX.value },
      { translateY: translateY.value },
      { rotate: `${rotation.value}deg` },
    ],
  }));

  const checkmarkStyle = useAnimatedStyle(() => ({
    opacity: checkmarkOpacity.value,
    transform: [{ scale: interpolate(checkmarkOpacity.value, [0, 1], [0.5, 1]) }],
  }));

  return (
    <GestureDetector gesture={panGesture}>
      <Animated.View style={[styles.card, cardStyle]}>
        <LinearGradient
          colors={[colors.background.card, colors.background.subtle]}
          style={styles.cardGradient}
        >
          {/* Rewind Button */}
          {canRewind && (
            <TouchableOpacity style={styles.rewindButton} onPress={onRewind}>
              <RotateCcw color={colors.primary.DEFAULT} size={20} />
            </TouchableOpacity>
          )}

          {/* Question */}
          <View style={styles.questionContainer}>
            <Text style={styles.questionLabel}>{t('mission.dailyMission', 'DAILY MISSION')}</Text>
            {question.imageUrl && QUIZ_IMAGES[question.imageUrl] && (
              <Image 
                source={QUIZ_IMAGES[question.imageUrl]}
                style={styles.questionImage}
                resizeMode="contain"
              />
            )}
            <Text style={styles.questionText}>{question.question}</Text>
          </View>

          <View style={styles.optionContainer}>
            <Text style={styles.optionLabel}>
              {t('quiz.option', 'Option')} {String.fromCharCode(65 + currentOptionIndex)}
            </Text>
            <Text style={styles.optionText}>
              {question.options[currentOptionIndex]}
            </Text>
          </View>

          {/* Option Navigation Dots */}
          <View style={styles.dotsContainer}>
            {question.options.map((_, index) => (
              <View
                key={index}
                style={[
                  styles.dot,
                  index === currentOptionIndex && styles.dotActive,
                ]}
              />
            ))}
          </View>

          {/* Swipe Instruction */}
          <View style={styles.instructionContainer}>
            <Text style={styles.instructionText}>
              {t('mission.instruction', 'Tap edges to browse • Swipe right to select')}
            </Text>
          </View>

          {/* Checkmark Overlay */}
          <Animated.View style={[styles.checkmarkOverlay, checkmarkStyle]}>
            <View style={styles.checkmarkCircle}>
              <Check color={colors.text.inverse} size={48} strokeWidth={3} />
            </View>
          </Animated.View>
        </LinearGradient>
      </Animated.View>
    </GestureDetector>
  );
}

export function MissionScreen() {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const navigation = useNavigation();
  const [questions, setQuestions] = useState<Question[]>([]);
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [currentOptionIndex, setCurrentOptionIndex] = useState(0);
  const [answers, setAnswers] = useState<{questionId: string, selectedOptionIndex: number, isCorrect: boolean}[]>([]);
  const [showFeedback, setShowFeedback] = useState<'correct' | 'wrong' | null>(null);
  const [isComplete, setIsComplete] = useState(false);
  const [loading, setLoading] = useState(true);
  const [userId, setUserId] = useState<string>('');

  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    loadQuiz();
  }, []);

  const loadQuiz = async () => {
    try {
      setLoading(true);
      const { profile, error } = await AuthService.getUserProfile();
      
      if (error || !profile) {
        Alert.alert(t('common.error', 'Error'), t('auth.loadProfileError', 'Could not load user profile'));
        return;
      }

      // Redirect managers to Team Performance
      if (profile.role === 'manager') {
        navigation.navigate('ManagerQuickView' as never);
        return;
      }

      setUserId(profile.id);

      const loadedQuestions = await QuizService.generateWeeklyQuiz(profile.region);
      
      if (loadedQuestions.length === 0) {
        Alert.alert(t('mission.noQuestions', 'No Questions'), t('mission.noQuestionsRegion', 'No questions found for your region.'));
        navigation.goBack();
        return;
      }

      // Map to MissionScreen format but keeping all necessary fields for submission service
      const mappedQuestions: Question[] = loadedQuestions.map(q => ({
        id: q.id,
        question: q.text, // Keep for UI compatibility
        text: q.text,     // Required by type
        options: q.options,
        correctIndex: q.correctOptionIndex, // Keep for UI compatibility
        correctOptionIndex: q.correctOptionIndex, // Required by type
        imageUrl: q.imageUrl,
        explanation: q.explanation,
        region: q.region,
        category: q.category
      }));

      setQuestions(mappedQuestions);
    } catch (error) {
      console.error('Error loading quiz:', error);
      Alert.alert(t('common.error', 'Error'), t('mission.loadError', 'Failed to load quiz'));
    } finally {
      setLoading(false);
    }
  };

  const handleTapLeft = useCallback(() => {
    if (currentOptionIndex > 0) {
      setCurrentOptionIndex(prev => prev - 1);
    }
  }, [currentOptionIndex]);

  const handleTapRight = useCallback(() => {
    if (questions.length > 0 && currentOptionIndex < questions[currentQuestionIndex].options.length - 1) {
      setCurrentOptionIndex(prev => prev + 1);
    }
  }, [currentOptionIndex, questions, currentQuestionIndex]);

  const handleSubmit = async (finalAnswers: typeof answers) => {
    try {
      const { score, attempt } = await QuizService.submitQuiz(userId, finalAnswers, questions);
      // Navigate to review or show breakdown
      setIsComplete(true);
    } catch (error) {
      console.error('Error submitting quiz:', error);
      Alert.alert(t('common.error', 'Error'), t('mission.submitError', 'Failed to submit quiz results'));
    }
  };

  const handleSwipeRight = useCallback(() => {
    if (questions.length === 0) return;
    
    const currentQuestion = questions[currentQuestionIndex];
    const isCorrect = currentOptionIndex === currentQuestion.correctIndex;
    
    const newAnswers = [...answers, {
      questionId: currentQuestion.id,
      selectedOptionIndex: currentOptionIndex,
      isCorrect
    }];
    
    setAnswers(newAnswers);
    setShowFeedback(isCorrect ? 'correct' : 'wrong');

    // Only auto-advance for correct answers; wrong answers require manual "Next" press
    if (isCorrect) {
      setTimeout(() => {
        setShowFeedback(null);
        if (currentQuestionIndex < questions.length - 1) {
          setCurrentQuestionIndex(prev => prev + 1);
          setCurrentOptionIndex(0);
        } else {
          handleSubmit(newAnswers);
        }
      }, 1500);
    }
  }, [currentOptionIndex, questions, currentQuestionIndex, answers, userId]);

  const handleRewind = useCallback(() => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
      setCurrentOptionIndex(0);
      setAnswers(prev => prev.slice(0, -1));
    }
  }, [currentQuestionIndex]);

  const resetMission = useCallback(() => {
    setLoading(true);
    loadQuiz();
    setCurrentQuestionIndex(0);
    setCurrentOptionIndex(0);
    setAnswers([]);
    setIsComplete(false);
  }, []);

  if (loading) {
    return (
      <SafeAreaView style={[styles.container, { justifyContent: 'center', alignItems: 'center' }]}>
        <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
        <Text style={{ color: colors.text.secondary, marginTop: 20 }}>{t('mission.loading', 'Loading Mission...')}</Text>
      </SafeAreaView>
    );
  }

  if (questions.length === 0) return null;

  const currentQuestion = questions[currentQuestionIndex];

  if (isComplete) {
    const correctCount = answers.filter(a => a.isCorrect).length;

    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.completeContainer}>
          <Text style={styles.completeTitle}>{t('mission.complete', 'Mission Complete!')}</Text>
          <Text style={styles.completeScore}>
            {correctCount}/{questions.length}
          </Text>
          <Text style={styles.completeSubtitle}>{t('mission.correctAnswers', 'Correct Answers')}</Text>
          <TouchableOpacity style={styles.retryButton} onPress={resetMission}>
            <Text style={styles.retryButtonText}>{t('common.tryAgain', 'Try Again')}</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <GestureHandlerRootView style={styles.container}>
      <SafeAreaView style={styles.container}>
        {/* Header */}
        <View style={styles.header}>
          <Text style={styles.headerTitle}>{t('mission.dailyMissionTitle', 'Daily Mission')}</Text>
          <Text style={styles.headerProgress}>
            {currentQuestionIndex + 1}/{questions.length}
          </Text>
        </View>

        {/* Card Stack */}
        <View style={styles.cardContainer}>
          {/* Tap Zones */}
          <Pressable style={styles.tapZoneLeft} onPress={handleTapLeft} />
          <Pressable style={styles.tapZoneRight} onPress={handleTapRight} />

          <SwipeCard
            key={currentQuestion.id}
            question={currentQuestion}
            currentOptionIndex={currentOptionIndex}
            onSwipeRight={handleSwipeRight}
            onRewind={handleRewind}
            canRewind={currentQuestionIndex > 0}
            showCheckmark={false}
          />
        </View>

        {/* Feedback Overlay */}
        {showFeedback && (
          <View style={styles.feedbackOverlay}>
            <LinearGradient
              colors={
                showFeedback === 'correct'
                  ? colors.gradients.success as any
                  : colors.gradients.danger as any
              }
              style={styles.feedbackGradient}
            >
              {showFeedback === 'correct' ? (
                <>
                  <Check color={colors.text.primary} size={80} strokeWidth={3} />
                  <Text style={styles.feedbackText}>{t('quiz.correct', 'CORRECT!')}</Text>
                </>
              ) : (
                <>
                  <X color={colors.text.primary} size={80} strokeWidth={3} />
                  <Text style={styles.feedbackText}>{t('quiz.wrong', 'WRONG!')}</Text>
                  
                  {/* Correct Answer Box */}
                  <View style={styles.correctAnswerBox}>
                    <Text style={styles.correctAnswerText}>
                      {t('quiz.correctAnswerIs', 'The correct answer is')} {String.fromCharCode(65 + currentQuestion.correctIndex)}. {currentQuestion.options[currentQuestion.correctIndex]}
                    </Text>
                  </View>
                  
                  {/* Next Button */}
                  <TouchableOpacity 
                    style={styles.nextButton}
                    onPress={() => {
                      setShowFeedback(null);
                      if (currentQuestionIndex < questions.length - 1) {
                        setCurrentQuestionIndex(prev => prev + 1);
                        setCurrentOptionIndex(0);
                      } else {
                        // Last question - submit with current answers state
                        // answers state should be updated by now since user had to read feedback
                        setIsComplete(true);
                        QuizService.submitQuiz(userId, answers, questions).catch(err => {
                          console.error('Error submitting quiz:', err);
                        });
                      }
                    }}
                  >
                    <Text style={styles.nextButtonText}>{t('common.next', 'NEXT')}</Text>
                  </TouchableOpacity>
                </>
              )}
            </LinearGradient>
          </View>
        )}
      </SafeAreaView>
    </GestureHandlerRootView>
  );
}

const createStyles = (colors: any) => StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 16,
  },
  headerTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 24,
    color: colors.text.primary,
  },
  headerProgress: {
    fontFamily: 'Inter-Medium',
    fontSize: 16,
    color: colors.primary.DEFAULT,
  },
  cardContainer: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  tapZoneLeft: {
    position: 'absolute',
    left: 0,
    top: 0,
    bottom: 0,
    width: '25%',
    zIndex: 10,
  },
  tapZoneRight: {
    position: 'absolute',
    right: 0,
    top: 0,
    bottom: 0,
    width: '25%',
    zIndex: 10,
  },
  feedbackOverlay: {
    ...StyleSheet.absoluteFillObject,
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 100,
  },
  feedbackGradient: {
    width: SCREEN_WIDTH,
    height: SCREEN_HEIGHT,
    justifyContent: 'center',
    alignItems: 'center',
  },
  feedbackText: {
    fontFamily: 'Inter-Bold',
    fontSize: 48,
    color: colors.text.primary,
    marginTop: 20,
    letterSpacing: 4,
  },
  completeContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 40,
  },
  completeTitle: {
    fontFamily: 'Inter-Bold',
    fontSize: 32,
    color: colors.primary.DEFAULT,
    marginBottom: 20,
  },
  completeScore: {
    fontFamily: 'Inter-Bold',
    fontSize: 72,
    color: colors.text.primary,
  },
  completeSubtitle: {
    fontFamily: 'Inter-Medium',
    fontSize: 18,
    color: colors.text.secondary,
    marginBottom: 40,
  },
  retryButton: {
    backgroundColor: colors.primary.DEFAULT,
    paddingHorizontal: 40,
    paddingVertical: 16,
    borderRadius: 30,
  },
  retryButtonText: {
    fontFamily: 'Inter-Bold',
    fontSize: 18,
    color: colors.text.inverse,
  },
  correctAnswerBox: {
    backgroundColor: '#FFFFFF',
    borderRadius: 12,
    paddingHorizontal: 24,
    paddingVertical: 16,
    marginTop: 32,
    marginHorizontal: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  correctAnswerText: {
    fontFamily: 'Inter-Medium',
    fontSize: 18,
    color: '#1A1A1A',
    textAlign: 'center',
  },
  nextButton: {
    position: 'absolute',
    bottom: 50,
    right: 30,
    backgroundColor: '#FFFFFF',
    paddingHorizontal: 28,
    paddingVertical: 14,
    borderRadius: 8,
  },
  nextButtonText: {
    fontFamily: 'Inter-Bold',
    fontSize: 16,
    color: '#1A1A1A',
  },
});
