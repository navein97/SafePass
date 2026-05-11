import React, { useState, useMemo } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Alert,
  StatusBar,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
} from 'react-native';
import { useTranslation } from 'react-i18next';
import { Mail, ArrowLeft, CheckCircle } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';

export const ForgotPasswordScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);
  const [errors, setErrors] = useState({ email: '', general: '' });

  const styles = useMemo(() => createStyles(colors), [colors]);

  const validateForm = () => {
    let isValid = true;
    const newErrors = { email: '', general: '' };

    if (!email.trim()) {
      newErrors.email = t('auth.emailRequired');
      isValid = false;
    } else if (!Validation.isValidEmail(email)) {
      newErrors.email = t('auth.invalidEmail');
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const isRequesting = React.useRef(false);

  const handleResetPassword = async () => {
    if (isRequesting.current) return;
    if (!validateForm()) return;

    isRequesting.current = true;
    setLoading(true);
    setErrors({ email: '', general: '' });

    try {
      const { error } = await AuthService.resetPassword(email);
      
      if (error) {
        const friendlyMsg = Validation.getFriendlyErrorMessage(error);
        setErrors(prev => ({ ...prev, general: friendlyMsg }));
        Alert.alert(t('common.error'), friendlyMsg);
      } else {
        setEmailSent(true);
      }
    } catch (error) {
      console.error('Password reset error:', error);
      setErrors(prev => ({ 
        ...prev, 
        general: t('auth.unexpectedError') 
      }));
    } finally {
      isRequesting.current = false;
      setLoading(false);
    }
  };

  if (emailSent) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.safeArea}>
          <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
          <View style={styles.successContainer}>
            <View style={styles.successIconContainer}>
              <CheckCircle size={80} color={colors.status.success} />
            </View>
            
            <Text style={styles.successTitle}>{t('auth.checkYourEmail')}</Text>
            <Text style={styles.successMessage}>
              {t('auth.emailSentInstructions')}
            </Text>
            <Text style={styles.emailText}>{email}</Text>
            
            <Text style={styles.instructionText}>
              {t('auth.resetLinkExpiry')}
            </Text>

            <GlassButton
              title={t('auth.backToLogin')}
              onPress={() => navigation.navigate('Login')}
              style={styles.backButton}
            />

            <TouchableOpacity
              style={styles.resendButton}
              onPress={handleResetPassword}
              disabled={loading}
            >
              <Text style={styles.resendText}>
                {t('auth.notReceivedEmail')} <Text style={styles.resendTextBold}>{t('auth.resend')}</Text>
              </Text>
            </TouchableOpacity>
          </View>
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <KeyboardAvoidingView
          style={{ flex: 1 }}
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
          keyboardVerticalOffset={Platform.OS === 'ios' ? 0 : 20}
        >
          <ScrollView
            contentContainerStyle={styles.content}
            keyboardShouldPersistTaps="handled"
            bounces={true}
            showsVerticalScrollIndicator={false}
          >
            {/* Back Button */}
            <TouchableOpacity
              style={styles.backButtonTop}
              onPress={() => navigation.goBack()}
            >
              <ArrowLeft color={colors.text.primary} size={24} />
              <Text style={styles.backButtonText}>{t('auth.back')}</Text>
            </TouchableOpacity>

            <View style={styles.header}>
              <Text style={styles.title}>{t('auth.forgotPassword')}</Text>
              <Text style={styles.subtitle}>
                {t('auth.forgotPasswordSubtitle')}
              </Text>
            </View>

            <GlassCard style={styles.formCard}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label={t('auth.email')}
                  placeholder={t('auth.emailPlaceholder')}
                  value={email}
                  onChangeText={(text) => {
                    setEmail(text);
                    if (errors.email) setErrors(prev => ({ ...prev, email: '' }));
                  }}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  editable={!loading}
                  error={errors.email}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
                />

                <GlassButton
                  title={t('auth.sendResetLink')}
                  onPress={handleResetPassword}
                  loading={loading}
                  style={styles.submitButton}
                />

                <TouchableOpacity
                  style={styles.linkButton}
                  onPress={() => navigation.navigate('Login')}
                  disabled={loading}
                >
                  <Text style={styles.linkText}>
                    {t('auth.rememberPassword')} <Text style={styles.linkTextBold}>{t('auth.login')}</Text>
                  </Text>
                </TouchableOpacity>
              </View>
            </GlassCard>
          </ScrollView>
        </KeyboardAvoidingView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  content: {
    flexGrow: 1,
    padding: 24,
    justifyContent: 'center',
  },
  backButtonTop: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 20,
  },
  backButtonText: {
    fontFamily: typography.fonts.medium,
    fontSize: 16,
    color: colors.text.primary,
    marginLeft: 8,
  },
  header: {
    marginBottom: 32,
  },
  title: {
    fontSize: 32,
    fontFamily: typography.fonts.bold,
    color: colors.mode === 'light' ? colors.primary.dark : colors.primary.DEFAULT,
    marginBottom: 12,
    textShadowColor: colors.primary.dark,
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 20,
  },
  subtitle: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 24,
  },
  formCard: {
    width: '100%',
  },
  form: {
    gap: 8,
  },
  submitButton: {
    marginTop: 16,
  },
  linkButton: {
    alignItems: 'center',
    marginTop: 24,
  },
  linkText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
  },
  linkTextBold: {
    color: colors.mode === 'light' ? colors.primary.dark : colors.primary.light,
    fontFamily: typography.fonts.bold,
  },
  errorBanner: {
    backgroundColor: 'rgba(255, 59, 48, 0.1)',
    borderWidth: 1,
    borderColor: colors.status.danger,
    borderRadius: 12,
    padding: 12,
    marginBottom: 16,
  },
  errorBannerText: {
    color: colors.status.danger,
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
  },
  successContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 24,
  },
  successIconContainer: {
    marginBottom: 32,
  },
  successTitle: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 12,
    textAlign: 'center',
  },
  successMessage: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
    marginBottom: 8,
  },
  emailText: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
    color: colors.mode === 'light' ? colors.primary.dark : colors.primary.DEFAULT,
    textAlign: 'center',
    marginBottom: 24,
  },
  instructionText: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.regular,
    color: colors.text.tertiary,
    textAlign: 'center',
    lineHeight: 20,
    marginBottom: 32,
    paddingHorizontal: 20,
  },
  backButton: {
    width: '100%',
    marginBottom: 16,
  },
  resendButton: {
    marginTop: 16,
  },
  resendText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
    textAlign: 'center',
  },
  resendTextBold: {
    color: colors.mode === 'light' ? colors.primary.dark : colors.primary.light,
    fontFamily: typography.fonts.bold,
  },
});
