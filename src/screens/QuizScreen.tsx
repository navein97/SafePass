import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { QuizService } from '../services/quizService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { Question } from '../types/models';
import { ChevronRight } from 'lucide-react-native';

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

      // DEBUG: Fetch ALL questions to see if any exist
      const { data: allQuestions, error: debugError } = await supabase
        .from('questions')
        .select('*');
      
      console.log('DEBUG: Total questions in DB:', allQuestions?.length);
      console.log('DEBUG: First question regions:', allQuestions?.[0]?.regions);
      console.log('DEBUG: User region:', profile.region);

      if (debugError) console.error('DEBUG Error:', debugError);

      // Load questions for user's region
      const loadedQuestions = await QuizService.generateWeeklyQuiz(profile.region);
      console.log('Questions loaded for region:', loadedQuestions.length);
      
      if (loadedQuestions.length === 0) {
        // If no questions found, show debug info
        Alert.alert(
          'Debug Info', 
          `User Region: ${profile.region}\nTotal Questions in DB: ${allQuestions?.length}\nFirst Question Regions: ${JSON.stringify(allQuestions?.[0]?.regions)}`
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
      <SafeAreaView style={styles.container}>
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', padding: 20 }}>
          <ActivityIndicator size="large" color={colors.primary.light} />
          <Text style={{ color: colors.text.primary, marginTop: 20, textAlign: 'center', fontFamily: typography.fonts.medium }}>
            {loadingStatus}
          </Text>
        </View>
      </SafeAreaView>
    );
  }

  if (questions.length === 0) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center', padding: 20 }}>
          <Text style={{ color: colors.text.primary, fontSize: 18, marginBottom: 10, textAlign: 'center', fontFamily: typography.fonts.bold }}>
            Unable to load quiz
          </Text>
          <Text style={{ color: colors.text.secondary, marginBottom: 30, textAlign: 'center' }}>
            We couldn't find any questions for your region, or there was a connection error.
          </Text>
          <TouchableOpacity 
            onPress={() => navigation.goBack()}
            style={{ backgroundColor: colors.primary.DEFAULT, paddingHorizontal: 24, paddingVertical: 12, borderRadius: 8 }}
          >
            <Text style={{ color: colors.text.primary, fontFamily: typography.fonts.bold }}>Go Back</Text>
          </TouchableOpacity>
          <TouchableOpacity 
            onPress={loadQuiz}
            style={{ marginTop: 20 }}
          >
            <Text style={{ color: colors.primary.light, fontFamily: typography.fonts.medium }}>Try Again</Text>
          </TouchableOpacity>
        </View>
      </SafeAreaView>
    );
  }

  const currentQuestion = questions[currentIndex];
  const progress = ((currentIndex + 1) / questions.length) * 100;

  return (
    <SafeAreaView style={styles.container}>
      {/* Header / Progress */}
      <View style={styles.header}>
        <Text style={styles.progressText}>
          {t('quiz.question')} {currentIndex + 1} {t('quiz.of')} {questions.length}
        </Text>
        <View style={styles.progressBarBg}>
          <View style={[styles.progressBarFill, { width: `${progress}%` }]} />
        </View>
      </View>

      <ScrollView contentContainerStyle={styles.content}>
        <Text style={styles.questionText}>{currentQuestion.text}</Text>

        <View style={styles.optionsContainer}>
          {currentQuestion.options.map((option, index) => (
            <TouchableOpacity
              key={index}
              style={[
                styles.optionButton,
                selectedOption === index && styles.optionSelected
              ]}
              onPress={() => setSelectedOption(index)}
            >
              <View style={[
                styles.radioCircle,
                selectedOption === index && styles.radioSelected
              ]} />
              <Text style={[
                styles.optionText,
                selectedOption === index && styles.optionTextSelected
              ]}>
                {option}
              </Text>
            </TouchableOpacity>
          ))}
        </View>
      </ScrollView>

      <View style={styles.footer}>
        <TouchableOpacity style={styles.nextButton} onPress={handleNext}>
          <Text style={styles.nextButtonText}>
            {currentIndex === questions.length - 1 ? t('quiz.finish') : t('common.next')}
          </Text>
          <ChevronRight color={colors.text.primary} size={20} />
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  header: {
    padding: 24,
    paddingBottom: 12,
  },
  progressText: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
  },
  progressBarBg: {
    height: 6,
    backgroundColor: colors.background.subtle,
    borderRadius: 3,
  },
  progressBarFill: {
    height: '100%',
    backgroundColor: colors.primary.light,
    borderRadius: 3,
  },
  content: {
    padding: 24,
  },
  questionText: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 32,
    lineHeight: 28,
  },
  optionsContainer: {
    gap: 16,
  },
  optionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.background.paper,
    padding: 20,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: colors.border,
  },
  optionSelected: {
    borderColor: colors.primary.light,
    backgroundColor: 'rgba(59, 130, 246, 0.1)',
  },
  radioCircle: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: colors.text.secondary,
    marginRight: 16,
  },
  radioSelected: {
    borderColor: colors.primary.light,
    backgroundColor: colors.primary.light,
  },
  optionText: {
    fontSize: typography.sizes.base,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    flex: 1,
  },
  optionTextSelected: {
    color: colors.primary.light,
  },
  footer: {
    padding: 24,
    borderTopWidth: 1,
    borderTopColor: colors.border,
  },
  nextButton: {
    backgroundColor: colors.primary.DEFAULT,
    padding: 16,
    borderRadius: 8,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    gap: 8,
  },
  nextButtonText: {
    color: colors.text.primary,
    fontFamily: typography.fonts.bold,
    fontSize: typography.sizes.base,
  },
});
