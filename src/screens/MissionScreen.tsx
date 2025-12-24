import React, { useState, useCallback } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  TouchableOpacity,
  Pressable,
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
import { colors } from '../theme/colors';

const { width: SCREEN_WIDTH, height: SCREEN_HEIGHT } = Dimensions.get('window');
const CARD_WIDTH = SCREEN_WIDTH * 0.9;
const CARD_HEIGHT = SCREEN_HEIGHT * 0.55;
const SWIPE_THRESHOLD = SCREEN_WIDTH * 0.25;

interface Question {
  id: number;
  question: string;
  options: string[];
  correctIndex: number;
}

// Sample questions - Replace with real data
const SAMPLE_QUESTIONS: Question[] = [
  {
    id: 1,
    question: "What should you do before starting your vehicle?",
    options: [
      "A) Check mirrors and seatbelt",
      "B) Start driving immediately",
      "C) Check your phone",
      "D) Turn on the radio"
    ],
    correctIndex: 0,
  },
  {
    id: 2,
    question: "When approaching a construction zone, you should:",
    options: [
      "A) Speed up to get through quickly",
      "B) Slow down and follow posted signs",
      "C) Honk to warn workers",
      "D) Change lanes abruptly"
    ],
    correctIndex: 1,
  },
  {
    id: 3,
    question: "What is the safe following distance in normal conditions?",
    options: [
      "A) 1 second",
      "B) 2 seconds",
      "C) 3-4 seconds",
      "D) No specific rule"
    ],
    correctIndex: 2,
  },
  {
    id: 4,
    question: "If your brakes fail, you should:",
    options: [
      "A) Jump out of the vehicle",
      "B) Pump the brakes and use engine braking",
      "C) Turn off the engine immediately",
      "D) Close your eyes and hope"
    ],
    correctIndex: 1,
  },
];

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
            <Text style={styles.questionLabel}>DAILY MISSION</Text>
            <Text style={styles.questionText}>{question.question}</Text>
          </View>

          {/* Current Option Display */}
          <View style={styles.optionContainer}>
            <Text style={styles.optionLabel}>
              Option {String.fromCharCode(65 + currentOptionIndex)}
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
              Tap edges to browse • Swipe right to select
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
  const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
  const [currentOptionIndex, setCurrentOptionIndex] = useState(0);
  const [answers, setAnswers] = useState<number[]>([]);
  const [showFeedback, setShowFeedback] = useState<'correct' | 'wrong' | null>(null);
  const [isComplete, setIsComplete] = useState(false);

  const currentQuestion = SAMPLE_QUESTIONS[currentQuestionIndex];

  const handleTapLeft = useCallback(() => {
    if (currentOptionIndex > 0) {
      setCurrentOptionIndex(prev => prev - 1);
    }
  }, [currentOptionIndex]);

  const handleTapRight = useCallback(() => {
    if (currentOptionIndex < currentQuestion.options.length - 1) {
      setCurrentOptionIndex(prev => prev + 1);
    }
  }, [currentOptionIndex, currentQuestion]);

  const handleSwipeRight = useCallback(() => {
    const isCorrect = currentOptionIndex === currentQuestion.correctIndex;
    setAnswers(prev => [...prev, currentOptionIndex]);
    setShowFeedback(isCorrect ? 'correct' : 'wrong');

    setTimeout(() => {
      setShowFeedback(null);
      if (currentQuestionIndex < SAMPLE_QUESTIONS.length - 1) {
        setCurrentQuestionIndex(prev => prev + 1);
        setCurrentOptionIndex(0);
      } else {
        setIsComplete(true);
      }
    }, 1500);
  }, [currentOptionIndex, currentQuestion, currentQuestionIndex]);

  const handleRewind = useCallback(() => {
    if (currentQuestionIndex > 0) {
      setCurrentQuestionIndex(prev => prev - 1);
      setCurrentOptionIndex(0);
      setAnswers(prev => prev.slice(0, -1));
    }
  }, [currentQuestionIndex]);

  const resetMission = useCallback(() => {
    setCurrentQuestionIndex(0);
    setCurrentOptionIndex(0);
    setAnswers([]);
    setIsComplete(false);
  }, []);

  if (isComplete) {
    const correctCount = answers.filter(
      (ans, idx) => ans === SAMPLE_QUESTIONS[idx].correctIndex
    ).length;

    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.completeContainer}>
          <Text style={styles.completeTitle}>Mission Complete!</Text>
          <Text style={styles.completeScore}>
            {correctCount}/{SAMPLE_QUESTIONS.length}
          </Text>
          <Text style={styles.completeSubtitle}>Correct Answers</Text>
          <TouchableOpacity style={styles.retryButton} onPress={resetMission}>
            <Text style={styles.retryButtonText}>Try Again</Text>
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
          <Text style={styles.headerTitle}>Daily Mission</Text>
          <Text style={styles.headerProgress}>
            {currentQuestionIndex + 1}/{SAMPLE_QUESTIONS.length}
          </Text>
        </View>

        {/* Card Stack */}
        <View style={styles.cardContainer}>
          {/* Tap Zones */}
          <Pressable style={styles.tapZoneLeft} onPress={handleTapLeft} />
          <Pressable style={styles.tapZoneRight} onPress={handleTapRight} />

          <SwipeCard
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
                  ? colors.gradients.success
                  : colors.gradients.danger
              }
              style={styles.feedbackGradient}
            >
              {showFeedback === 'correct' ? (
                <>
                  <Check color={colors.text.primary} size={80} strokeWidth={3} />
                  <Text style={styles.feedbackText}>CORRECT!</Text>
                </>
              ) : (
                <>
                  <X color={colors.text.primary} size={80} strokeWidth={3} />
                  <Text style={styles.feedbackText}>WRONG!</Text>
                </>
              )}
            </LinearGradient>
          </View>
        )}
      </SafeAreaView>
    </GestureHandlerRootView>
  );
}

const styles = StyleSheet.create({
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
    marginBottom: 32,
  },
  questionLabel: {
    fontFamily: 'Inter-Bold',
    fontSize: 12,
    color: colors.primary.DEFAULT,
    letterSpacing: 2,
    marginBottom: 12,
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
});
