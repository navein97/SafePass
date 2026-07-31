import React, { useMemo } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ArrowLeft } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';

export const TermsScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} />
        
        {/* Header */}
        <View style={styles.header}>
          <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
            <ArrowLeft size={24} color={colors.text.primary} />
          </TouchableOpacity>
          <Text style={styles.headerTitle}>{t('terms.title', 'Terms of Service & IP Policy')}</Text>
          <View style={{ width: 24 }} />
        </View>

        <ScrollView 
          contentContainerStyle={styles.content}
          showsVerticalScrollIndicator={false}
          bounces={true}
        >
          <GlassCard style={styles.card}>
            <Text style={styles.lastUpdated}>{t('terms.lastUpdated', 'Last Updated: {{date}}', { date: new Date().toLocaleDateString() })}</Text>

            <Text style={styles.sectionTitle}>{t('terms.section1Title', '1. Acceptance of Terms')}</Text>
            <Text style={styles.paragraph}>
              {t('terms.section1Text', 'By accessing and using this application (the "Platform"), you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by these terms, please do not use this Platform.')}
            </Text>

            <Text style={styles.sectionTitle}>{t('terms.section2Title', '2. Intellectual Property Rights')}</Text>
            <Text style={styles.paragraph}>
              {t('terms.section2Text1', 'All intellectual property rights in the Platform, including but not limited to software code, design, text, graphics, questionnaire content, behavioral conditioning models, and data structures, are owned exclusively by CNG Synergy (KT0512750V).')}
            </Text>
            <Text style={styles.paragraph}>
              {t('terms.section2Text2', 'Your access to the web application grants you a non-exclusive, non-transferable, limited license to use the platform solely for its intended training and evaluation purposes.')}
            </Text>

            <Text style={styles.sectionTitle}>{t('terms.section3Title', '3. Prohibited Uses')}</Text>
            <Text style={styles.paragraph}>
              {t('terms.section3Text', 'You may not reverse-engineer, copy, extract, reproduce, record, or reuse any part of the system, its logic, or its assessment content without prior written consent from CNG Synergy (KT0512750V). Unauthorized use of the Platform\'s proprietary training modules and algorithms is strictly prohibited.')}
            </Text>

            <Text style={styles.sectionTitle}>{t('terms.section4Title', '4. Data Retention')}</Text>
            <Text style={styles.paragraph}>
              {t('terms.section4Text', 'The Platform may retain training records and assessment data for compliance, legal auditing, and historical tracking purposes even after an employee\'s direct access is terminated, subject to our Privacy Policy.')}
            </Text>

            <Text style={styles.sectionTitle}>{t('terms.section5Title', '5. Disclaimer of Warranties')}</Text>
            <Text style={styles.paragraph}>
              {t('terms.section5Text', 'The Platform is provided "as is" without any representations or warranties, express or implied. We make no representations or warranties in relation to this Platform or the information and materials provided on it.')}
            </Text>

            <View style={styles.footer}>
              <Text style={styles.footerText}>{t('terms.copyright', '© 2026 CNG Synergy (KT0512750V). All rights reserved.')}</Text>
            </View>
          </GlassCard>
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 16,
    borderBottomWidth: 1,
    borderBottomColor: colors.border + '50',
  },
  backButton: {
    padding: 8,
    marginLeft: -8,
  },
  headerTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  content: {
    padding: 16,
    paddingBottom: 40,
  },
  card: {
    padding: 24,
    borderRadius: 20,
  },
  lastUpdated: {
    fontSize: 12,
    color: colors.text.tertiary,
    fontFamily: typography.fonts.medium,
    marginBottom: 24,
    textAlign: 'right',
  },
  sectionTitle: {
    fontSize: 16,
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
    marginTop: 20,
    marginBottom: 10,
  },
  paragraph: {
    fontSize: 14,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
    lineHeight: 22,
    marginBottom: 12,
  },
  footer: {
    marginTop: 40,
    paddingTop: 20,
    borderTopWidth: 1,
    borderTopColor: colors.border + '50',
    alignItems: 'center',
  },
  footerText: {
    fontSize: 12,
    color: colors.text.tertiary,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
  }
});
