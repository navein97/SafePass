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
import { Mail, Phone, ArrowLeft, CheckCircle } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';

type RecoveryMethod = 'email' | 'sms';

export const ForgotPasswordScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [recoveryMethod, setRecoveryMethod] = useState<RecoveryMethod>('email');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [loading, setLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);
  const [errors, setErrors] = useState({ email: '', phone: '', general: '' });

  const styles = useMemo(() => createStyles(colors), [colors]);

  const validateForm = () => {
    let isValid = true;
    const newErrors = { email: '', phone: '', general: '' };

    if (recoveryMethod === 'email') {
      if (!email.trim()) {
        newErrors.email = 'Email is required';
        isValid = false;
      } else if (!Validation.isValidEmail(email)) {
        newErrors.email = 'Please enter a valid email address';
        isValid = false;
      }
    } else {
      if (!phone.trim()) {
        newErrors.phone = 'Phone number is required';
        isValid = false;
      }
      // Basic phone validation - you can enhance this
      if (phone.trim() && !/^\+?[\d\s-()]+$/.test(phone)) {
        newErrors.phone = 'Please enter a valid phone number';
        isValid = false;
      }
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleResetPassword = async () => {
    if (!validateForm()) return;

    setLoading(true);
    setErrors({ email: '', phone: '', general: '' });

    try {
      if (recoveryMethod === 'email') {
        const { error } = await AuthService.resetPassword(email);
        
        if (error) {
          const friendlyMsg = Validation.getFriendlyErrorMessage(error);
          setErrors(prev => ({ ...prev, general: friendlyMsg }));
          Alert.alert('Error', friendlyMsg);
        } else {
          setEmailSent(true);
        }
      } else {
        // SMS recovery - This would need to be implemented in your backend
        // For now, show a placeholder message
        Alert.alert(
          'SMS Recovery',
          'SMS password recovery is not yet implemented. Please use email recovery or contact your administrator.',
          [{ text: 'OK' }]
        );
      }
    } catch (error) {
      console.error('Password reset error:', error);
      setErrors(prev => ({ 
        ...prev, 
        general: 'An unexpected error occurred. Please try again.' 
      }));
    } finally {
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
            
            <Text style={styles.successTitle}>Check Your Email</Text>
            <Text style={styles.successMessage}>
              We've sent password reset instructions to:
            </Text>
            <Text style={styles.emailText}>{email}</Text>
            
            <Text style={styles.instructionText}>
              Click the link in the email to reset your password. The link will expire in 1 hour.
            </Text>

            <GlassButton
              title="Back to Login"
              onPress={() => navigation.navigate('Login')}
              style={styles.backButton}
            />

            <TouchableOpacity
              style={styles.resendButton}
              onPress={handleResetPassword}
              disabled={loading}
            >
              <Text style={styles.resendText}>
                Didn't receive the email? <Text style={styles.resendTextBold}>Resend</Text>
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
              <Text style={styles.backButtonText}>Back</Text>
            </TouchableOpacity>

            <View style={styles.header}>
              <Text style={styles.title}>Forgot Password?</Text>
              <Text style={styles.subtitle}>
                Don't worry! It happens. Please select your preferred recovery method.
              </Text>
            </View>

            {/* Recovery Method Selector */}
            <View style={styles.methodSelector}>
              <TouchableOpacity
                style={[
                  styles.methodButton,
                  recoveryMethod === 'email' && styles.methodButtonActive,
                ]}
                onPress={() => setRecoveryMethod('email')}
                disabled={loading}
              >
                <Mail
                  size={24}
                  color={recoveryMethod === 'email' ? colors.text.inverse : colors.text.secondary}
                />
                <Text
                  style={[
                    styles.methodButtonText,
                    recoveryMethod === 'email' && styles.methodButtonTextActive,
                  ]}
                >
                  Email
                </Text>
              </TouchableOpacity>

              <TouchableOpacity
                style={[
                  styles.methodButton,
                  recoveryMethod === 'sms' && styles.methodButtonActive,
                ]}
                onPress={() => setRecoveryMethod('sms')}
                disabled={loading}
              >
                <Phone
                  size={24}
                  color={recoveryMethod === 'sms' ? colors.text.inverse : colors.text.secondary}
                />
                <Text
                  style={[
                    styles.methodButtonText,
                    recoveryMethod === 'sms' && styles.methodButtonTextActive,
                  ]}
                >
                  SMS
                </Text>
              </TouchableOpacity>
            </View>

            <GlassCard style={styles.formCard}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                {recoveryMethod === 'email' ? (
                  <GlassInput
                    label="Email Address"
                    placeholder="driver@company.com"
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
                ) : (
                  <GlassInput
                    label="Phone Number"
                    placeholder="+1 (555) 123-4567"
                    value={phone}
                    onChangeText={(text) => {
                      setPhone(text);
                      if (errors.phone) setErrors(prev => ({ ...prev, phone: '' }));
                    }}
                    keyboardType="phone-pad"
                    editable={!loading}
                    error={errors.phone}
                    leftIcon={<Phone size={20} color={colors.text.secondary} />}
                  />
                )}

                <GlassButton
                  title="Send Reset Link"
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
                    Remember your password? <Text style={styles.linkTextBold}>Login</Text>
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
  methodSelector: {
    flexDirection: 'row',
    gap: 12,
    marginBottom: 24,
  },
  methodButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
    borderRadius: 16,
    backgroundColor: colors.background.card,
    borderWidth: 2,
    borderColor: colors.border,
    gap: 8,
  },
  methodButtonActive: {
    backgroundColor: colors.primary.DEFAULT,
    borderColor: colors.primary.DEFAULT,
  },
  methodButtonText: {
    fontFamily: typography.fonts.medium,
    fontSize: 15,
    color: colors.text.secondary,
  },
  methodButtonTextActive: {
    color: colors.text.inverse,
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
