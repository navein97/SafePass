import React from 'react';
import { View, Text, StyleSheet, ScrollView, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { CheckCircle, XCircle, Home } from 'lucide-react-native';
import { Question, QuizAttempt } from '../types/models';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';

export const ReviewScreen = ({ route, navigation }: any) => {
  const { t } = useTranslation();
  const { attempt, questions } = route.params as { attempt: QuizAttempt; questions: Question[] };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <ScrollView contentContainerStyle={styles.content} bounces={true} showsVerticalScrollIndicator={false}>
          <GlassCard style={styles.scoreHeader}>
            <Text style={styles.scoreTitle}>{t('quiz.score')}</Text>
            <Text style={styles.scoreValue}>{attempt.score}%</Text>
          </GlassCard>

          <Text style={styles.sectionTitle}>Review</Text>

          {questions.map((question, index) => {
            const answer = attempt.answers.find(a => a.questionId === question.id);
            const isCorrect = answer?.isCorrect;

            return (
              <GlassCard key={question.id} style={styles.card}>
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
              </GlassCard>
            );
          })}

          <GlassButton
            title="Back to Home"
            onPress={() => navigation.navigate('Main')}
            icon={<Home color={colors.text.primary} size={20} />}
            style={styles.homeButton}
          />
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  content: {
    padding: 24,
  },
  scoreHeader: {
    alignItems: 'center',
    marginBottom: 32,
    padding: 24,
  },
  scoreTitle: {
    fontSize: typography.sizes.lg,
    color: colors.text.secondary,
    marginBottom: 8,
    fontFamily: typography.fonts.medium,
  },
  scoreValue: {
    fontSize: 48,
    fontFamily: typography.fonts.bold,
    color: colors.primary.light,
    textShadowColor: 'rgba(0, 122, 255, 0.5)',
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 10,
  },
  sectionTitle: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
  },
  card: {
    marginBottom: 16,
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
    borderWidth: 1,
    borderColor: 'rgba(16, 185, 129, 0.2)',
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
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
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
    marginTop: 16,
    marginBottom: 32,
  },
});

