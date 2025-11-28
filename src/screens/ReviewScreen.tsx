import React from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { CheckCircle, XCircle } from 'lucide-react-native';
import { Question, QuizAttempt } from '../types/models';

export const ReviewScreen = ({ route, navigation }: any) => {
  const { t } = useTranslation();
  const { attempt, questions } = route.params as { attempt: QuizAttempt; questions: Question[] };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content}>
        <View style={styles.scoreHeader}>
          <Text style={styles.scoreTitle}>{t('quiz.score')}</Text>
          <Text style={styles.scoreValue}>{attempt.score}%</Text>
        </View>

        <Text style={styles.sectionTitle}>Review</Text>

        {questions.map((question, index) => {
          const answer = attempt.answers.find(a => a.questionId === question.id);
          const isCorrect = answer?.isCorrect;
          const selectedOption = answer?.selectedOptionIndex;

          return (
            <View key={question.id} style={styles.card}>
              <View style={styles.questionHeader}>
                <Text style={styles.questionNumber}>{index + 1}.</Text>
                <Text style={styles.questionText}>{question.text}</Text>
              </View>

              <View style={styles.resultRow}>
                {isCorrect ? (
                  <CheckCircle color={colors.status.success} size={20} />
                ) : (
                  <XCircle color={colors.status.danger} size={20} />
                )}
                <Text style={[
                  styles.resultText, 
                  { color: isCorrect ? colors.status.success : colors.status.danger }
                ]}>
                  {isCorrect ? t('quiz.correct') : t('quiz.incorrect')}
                </Text>
              </View>

              {!isCorrect && (
                <View style={styles.correctionBox}>
                  <Text style={styles.correctionLabel}>Correct Answer:</Text>
                  <Text style={styles.correctionText}>
                    {question.options[question.correctOptionIndex]}
                  </Text>
                </View>
              )}

              <View style={styles.explanationBox}>
                <Text style={styles.explanationLabel}>{t('quiz.explanation')}:</Text>
                <Text style={styles.explanationText}>{question.explanation}</Text>
              </View>
            </View>
          );
        })}

        <TouchableOpacity 
          style={styles.homeButton}
          onPress={() => navigation.navigate('Main')}
        >
          <Text style={styles.homeButtonText}>Back to Home</Text>
        </TouchableOpacity>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  content: {
    padding: 24,
  },
  scoreHeader: {
    alignItems: 'center',
    marginBottom: 32,
    padding: 24,
    backgroundColor: colors.background.paper,
    borderRadius: 16,
    borderWidth: 1,
    borderColor: colors.border,
  },
  scoreTitle: {
    fontSize: typography.sizes.lg,
    color: colors.text.secondary,
    marginBottom: 8,
  },
  scoreValue: {
    fontSize: 48,
    fontFamily: typography.fonts.bold,
    color: colors.primary.light,
  },
  sectionTitle: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
  },
  card: {
    backgroundColor: colors.background.paper,
    borderRadius: 12,
    padding: 16,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: colors.border,
  },
  questionHeader: {
    flexDirection: 'row',
    marginBottom: 12,
  },
  questionNumber: {
    color: colors.text.secondary,
    marginRight: 8,
    fontFamily: typography.fonts.bold,
  },
  questionText: {
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    flex: 1,
  },
  resultRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 12,
    gap: 8,
  },
  resultText: {
    fontFamily: typography.fonts.bold,
  },
  correctionBox: {
    backgroundColor: 'rgba(16, 185, 129, 0.1)',
    padding: 12,
    borderRadius: 8,
    marginBottom: 12,
  },
  correctionLabel: {
    color: colors.status.success,
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.bold,
    marginBottom: 4,
  },
  correctionText: {
    color: colors.status.success,
    fontFamily: typography.fonts.medium,
  },
  explanationBox: {
    backgroundColor: colors.background.subtle,
    padding: 12,
    borderRadius: 8,
  },
  explanationLabel: {
    color: colors.text.secondary,
    fontSize: typography.sizes.xs,
    fontFamily: typography.fonts.bold,
    marginBottom: 4,
  },
  explanationText: {
    color: colors.text.tertiary,
    fontSize: typography.sizes.sm,
    lineHeight: 20,
  },
  homeButton: {
    backgroundColor: colors.primary.DEFAULT,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 16,
    marginBottom: 32,
  },
  homeButtonText: {
    color: colors.text.primary,
    fontFamily: typography.fonts.bold,
  },
});
