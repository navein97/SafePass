import React, { useState, useEffect, useRef, useMemo } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Platform,
  StatusBar,
  KeyboardAvoidingView,
  ScrollView,
  ActivityIndicator,
  NativeSyntheticEvent,
  TextInputKeyPressEventData,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import {
  ArrowLeft,
  CheckCircle,
  MessageSquare,
  Clock,
  RefreshCw,
  AlertCircle,
  ShieldCheck,
  Smartphone,
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { OtpService } from '../services/otpService';

interface OtpVerificationScreenProps {
  navigation: any;
  route: {
    params: {
      phone: string;
      userId?: string;
      email?: string;
      companyName?: string;
    };
  };
}

const OTP_LENGTH = 6;
const RESEND_COOLDOWN_SECONDS = 60;
const EXPIRY_SECONDS = 300; // 5 minutes

export const OtpVerificationScreen = ({
  navigation,
  route,
}: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();

  const { phone = '', userId = '', email = '', companyName = '' } = route.params || {};

  const [otp, setOtp] = useState<string[]>(Array(OTP_LENGTH).fill(''));
  const [focusedIndex, setFocusedIndex] = useState<number>(0);
  const [resendCooldown, setResendCooldown] = useState<number>(RESEND_COOLDOWN_SECONDS);
  const [expiryCountdown, setExpiryCountdown] = useState<number>(EXPIRY_SECONDS);
  const [loading, setLoading] = useState<boolean>(false);
  const [resending, setResending] = useState<boolean>(false);
  const [error, setError] = useState<string>('');
  const [success, setSuccess] = useState<boolean>(false);
  const [remainingAttempts, setRemainingAttempts] = useState<number | null>(null);

  const inputRefs = useRef<Array<TextInput | null>>([]);

  const styles = useMemo(() => createStyles(colors, theme), [colors, theme]);

  // Cooldown countdown timer
  useEffect(() => {
    let interval: any = null;
    if (resendCooldown > 0) {
      interval = setInterval(() => {
        setResendCooldown((prev) => (prev > 0 ? prev - 1 : 0));
      }, 1000);
    }
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [resendCooldown]);

  // Expiry countdown timer
  useEffect(() => {
    let interval: any = null;
    if (expiryCountdown > 0 && !success) {
      interval = setInterval(() => {
        setExpiryCountdown((prev) => (prev > 0 ? prev - 1 : 0));
      }, 1000);
    }
    return () => {
      if (interval) clearInterval(interval);
    };
  }, [expiryCountdown, success]);

  // Auto-focus the first input on screen load & auto-trigger SMS if no active OTP session
  useEffect(() => {
    const timer = setTimeout(() => {
      if (inputRefs.current[0]) {
        inputRefs.current[0].focus();
      }
    }, 400);

    if (!OtpService.hasActiveSession() && phone) {
      OtpService.sendSmsOtp(phone).then((res) => {
        if (!res.success && res.error) {
          setError(res.error);
        }
      });
    }

    return () => clearTimeout(timer);
  }, []);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins}:${secs < 10 ? '0' : ''}${secs}`;
  };

  const handleOtpChange = (text: string, index: number) => {
    setError('');

    // Handle full paste into a single box (e.g. user copied "123456")
    const cleaned = text.replace(/[^0-9]/g, '');
    if (cleaned.length > 1) {
      const newOtp = [...otp];
      for (let i = 0; i < OTP_LENGTH; i++) {
        if (i < cleaned.length) {
          newOtp[i] = cleaned[i];
        }
      }
      setOtp(newOtp);

      const targetIndex = Math.min(cleaned.length, OTP_LENGTH - 1);
      inputRefs.current[targetIndex]?.focus();

      if (cleaned.length >= OTP_LENGTH) {
        triggerVerification(newOtp.join(''));
      }
      return;
    }

    const newOtp = [...otp];
    newOtp[index] = cleaned;
    setOtp(newOtp);

    // If a digit was entered, move to the next input box
    if (cleaned && index < OTP_LENGTH - 1) {
      inputRefs.current[index + 1]?.focus();
    }

    // If all digits are filled, auto verify
    if (cleaned && index === OTP_LENGTH - 1) {
      const fullCode = newOtp.join('');
      if (fullCode.length === OTP_LENGTH) {
        triggerVerification(fullCode);
      }
    }
  };

  const handleKeyPress = (
    e: NativeSyntheticEvent<TextInputKeyPressEventData>,
    index: number
  ) => {
    if (e.nativeEvent.key === 'Backspace') {
      if (!otp[index] && index > 0) {
        // Current box is empty, move back and clear previous
        const newOtp = [...otp];
        newOtp[index - 1] = '';
        setOtp(newOtp);
        inputRefs.current[index - 1]?.focus();
      } else if (otp[index]) {
        // Clear current box
        const newOtp = [...otp];
        newOtp[index] = '';
        setOtp(newOtp);
      }
    }
  };

  const triggerVerification = async (codeToVerify: string) => {
    if (loading || success) return;

    if (codeToVerify.length !== OTP_LENGTH) {
      setError(t('auth.otpEnterCode', 'Please enter the complete 6-digit code'));
      return;
    }

    if (expiryCountdown <= 0) {
      setError(t('auth.otpExpired', 'Code expired. Please request a new code.'));
      return;
    }

    setLoading(true);
    setError('');

    try {
      const result = await OtpService.verifySmsOtp(phone, codeToVerify);

      setLoading(false);

      if (result.success && result.verified) {
        setSuccess(true);
        // Automatically redirect to Login after 1.8 seconds so user sees the success state
        setTimeout(() => {
          navigation.reset({
            index: 0,
            routes: [{ name: 'Login' }],
          });
        }, 1800);
      } else {
        const errorMsg = result.error || t('auth.otpInvalid', 'Invalid code. Please try again.');
        setError(errorMsg);
      }
    } catch (err: any) {
      setLoading(false);
      setError(err.message || t('common.unexpectedErrorOccurred', 'An unexpected error occurred.'));
    }
  };

  const handleResend = async () => {
    if (resendCooldown > 0 || resending) return;

    setResending(true);
    setError('');

    try {
      const result = await OtpService.sendSmsOtp(phone);
      setResending(false);

      if (result.success) {
        setResendCooldown(RESEND_COOLDOWN_SECONDS);
        setExpiryCountdown(EXPIRY_SECONDS);
        setOtp(Array(OTP_LENGTH).fill(''));
        inputRefs.current[0]?.focus();
      } else {
        setError(result.error || t('auth.otpSendFailed', 'Failed to send code. Please try again.'));
      }
    } catch (err: any) {
      setResending(false);
      setError(err.message || t('auth.otpSendFailed', 'Failed to send code. Please try again.'));
    }
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar
          barStyle={theme === 'dark' ? 'light-content' : 'dark-content'}
          backgroundColor="transparent"
          translucent
        />
        <KeyboardAvoidingView
          style={{ flex: 1 }}
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        >
          <ScrollView
            contentContainerStyle={styles.scrollContent}
            keyboardShouldPersistTaps="handled"
          >
            {/* Top Navigation */}
            <TouchableOpacity
              style={styles.backButton}
              onPress={() => navigation.goBack()}
              accessibilityLabel="Go Back"
            >
              <ArrowLeft size={24} color={colors.text.primary} />
            </TouchableOpacity>

            {/* Header / Brand Icon */}
            <View style={styles.header}>
              <View style={styles.smsIconCircle}>
                <Smartphone size={32} color={colors.primary.DEFAULT} />
              </View>

              <Text style={styles.title}>
                {t('auth.otpTitle', 'SMS Verification')}
              </Text>
              <Text style={styles.subtitle}>
                {t('auth.otpSubtitle', "We've sent a 6-digit verification code via SMS to")}
              </Text>
              <View style={styles.phoneBadge}>
                <Text style={styles.phoneText}>{phone || 'your phone number'}</Text>
              </View>
            </View>

            {/* Main Verification Card */}
            <GlassCard style={styles.card}>
              {/* Expiry Indicator */}
              <View style={styles.expiryRow}>
                <Clock size={16} color={expiryCountdown < 60 ? '#FF3D00' : colors.text.secondary} />
                <Text
                  style={[
                    styles.expiryText,
                    expiryCountdown < 60 && { color: '#FF3D00', fontWeight: '700' },
                  ]}
                >
                  {expiryCountdown > 0
                    ? `${t('auth.otpExpiresIn', 'Code expires in {{minutes}} minutes', { minutes: formatTime(expiryCountdown) })}`
                    : t('auth.otpExpired', 'Code expired. Please request a new code.')}
                </Text>
              </View>

              {/* Error Banner */}
              {error ? (
                <View style={styles.errorBanner}>
                  <AlertCircle size={18} color="#FF3D00" style={{ marginRight: 8 }} />
                  <Text style={styles.errorBannerText}>{error}</Text>
                </View>
              ) : null}

              {/* Success Banner */}
              {success ? (
                <View style={styles.successBanner}>
                  <CheckCircle size={22} color="#00C853" style={{ marginRight: 8 }} />
                  <Text style={styles.successBannerText}>
                    {t('auth.otpVerified', 'Verified Successfully! 🎉')}
                  </Text>
                </View>
              ) : null}

              {/* 6-Digit OTP Input Boxes */}
              <View style={styles.otpContainer}>
                {Array(OTP_LENGTH)
                  .fill(0)
                  .map((_, index) => {
                    const isFocused = focusedIndex === index;
                    const hasValue = !!otp[index];

                    return (
                      <TextInput
                        key={index}
                        ref={(ref) => {
                          inputRefs.current[index] = ref;
                        }}
                        style={[
                          styles.otpInput,
                          isFocused && styles.otpInputFocused,
                          hasValue && styles.otpInputFilled,
                          error && !success ? styles.otpInputError : null,
                          success ? styles.otpInputSuccess : null,
                        ]}
                        value={otp[index]}
                        onChangeText={(text) => handleOtpChange(text, index)}
                        onKeyPress={(e) => handleKeyPress(e, index)}
                        onFocus={() => setFocusedIndex(index)}
                        onBlur={() => setFocusedIndex(-1)}
                        keyboardType="number-pad"
                        maxLength={1}
                        selectTextOnFocus
                        editable={!loading && !success}
                      />
                    );
                  })}
              </View>

              {/* Submit / Verify Button */}
              <GlassButton
                title={
                  loading
                    ? t('auth.otpVerifying', 'Verifying code...')
                    : success
                    ? t('auth.otpVerified', 'Verified! 🎉')
                    : t('common.submit', 'Verify Code')
                }
                onPress={() => triggerVerification(otp.join(''))}
                loading={loading}
                disabled={otp.join('').length !== OTP_LENGTH || loading || success || expiryCountdown <= 0}
                variant={success ? 'success' : 'primary'}
                style={styles.verifyButton}
                icon={success ? <ShieldCheck size={20} color="#FFFFFF" style={{ marginRight: 8 }} /> : undefined}
              />

              {/* SMS Notice */}
              <View style={styles.noteBox}>
                <Text style={styles.noteText}>
                  {t('auth.otpSmsNote', 'Enter the 6-digit code from Firebase')}
                </Text>
              </View>

              {/* Resend Cooldown Section */}
              <View style={styles.resendContainer}>
                <TouchableOpacity
                  onPress={handleResend}
                  disabled={resendCooldown > 0 || resending || success}
                  style={styles.resendButton}
                >
                  {resending ? (
                    <ActivityIndicator size="small" color={colors.primary.DEFAULT} style={{ marginRight: 6 }} />
                  ) : (
                    <RefreshCw
                      size={16}
                      color={
                        resendCooldown > 0 || success
                          ? colors.text.tertiary
                          : colors.primary.DEFAULT
                      }
                      style={{ marginRight: 6 }}
                    />
                  )}
                  <Text
                    style={[
                      styles.resendText,
                      (resendCooldown > 0 || success) && styles.resendTextDisabled,
                    ]}
                  >
                    {resendCooldown > 0
                      ? t('auth.otpResendIn', 'Resend in {{seconds}}s', {
                          seconds: resendCooldown,
                        })
                      : t('auth.otpResend', 'Resend Code via SMS')}
                  </Text>
                </TouchableOpacity>
              </View>
            </GlassCard>

            {/* Change Number Option */}
            <TouchableOpacity
              style={styles.changePhoneButton}
              onPress={() => navigation.goBack()}
              disabled={loading || success}
            >
              <Text style={styles.changePhoneText}>
                {t('auth.otpIncorrectPhone', 'Wrong phone number? Go back to edit')}
              </Text>
            </TouchableOpacity>
          </ScrollView>
        </KeyboardAvoidingView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any, theme: string) =>
  StyleSheet.create({
    safeArea: {
      flex: 1,
    },
    scrollContent: {
      paddingHorizontal: 20,
      paddingTop: 10,
      paddingBottom: 40,
      alignItems: 'center',
    },
    backButton: {
      alignSelf: 'flex-start',
      padding: 10,
      marginBottom: 12,
      borderRadius: 12,
      backgroundColor: theme === 'dark' ? 'rgba(255, 255, 255, 0.08)' : 'rgba(0, 0, 0, 0.05)',
    },
    header: {
      alignItems: 'center',
      marginBottom: 24,
      width: '100%',
    },
    smsIconCircle: {
      width: 68,
      height: 68,
      borderRadius: 34,
      backgroundColor: theme === 'dark' ? 'rgba(225, 37, 124, 0.15)' : 'rgba(225, 37, 124, 0.10)',
      borderWidth: 1.5,
      borderColor: colors.primary.DEFAULT,
      justifyContent: 'center',
      alignItems: 'center',
      marginBottom: 16,
    },
    title: {
      fontSize: 24,
      fontFamily: typography.fonts.bold,
      color: colors.text.primary,
      marginBottom: 8,
      textAlign: 'center',
    },
    subtitle: {
      fontSize: 14,
      fontFamily: typography.fonts.regular,
      color: colors.text.secondary,
      textAlign: 'center',
      paddingHorizontal: 16,
      lineHeight: 20,
    },
    phoneBadge: {
      marginTop: 8,
      paddingHorizontal: 14,
      paddingVertical: 6,
      borderRadius: 20,
      backgroundColor: theme === 'dark' ? 'rgba(255, 255, 255, 0.06)' : 'rgba(0, 0, 0, 0.04)',
      borderWidth: 1,
      borderColor: colors.border,
    },
    phoneText: {
      fontSize: 15,
      fontFamily: typography.fonts.medium,
      color: colors.primary.DEFAULT,
      letterSpacing: 0.5,
    },
    card: {
      width: '100%',
      padding: 24,
      alignItems: 'center',
      borderRadius: 24,
    },
    expiryRow: {
      flexDirection: 'row',
      alignItems: 'center',
      marginBottom: 16,
      gap: 6,
    },
    expiryText: {
      fontSize: 13,
      fontFamily: typography.fonts.medium,
      color: colors.text.secondary,
    },
    errorBanner: {
      flexDirection: 'row',
      alignItems: 'center',
      backgroundColor: 'rgba(255, 61, 0, 0.12)',
      borderWidth: 1,
      borderColor: 'rgba(255, 61, 0, 0.35)',
      paddingHorizontal: 14,
      paddingVertical: 10,
      borderRadius: 12,
      width: '100%',
      marginBottom: 18,
    },
    errorBannerText: {
      flex: 1,
      fontSize: 13,
      fontFamily: typography.fonts.medium,
      color: '#FF3D00',
    },
    successBanner: {
      flexDirection: 'row',
      alignItems: 'center',
      backgroundColor: 'rgba(0, 200, 83, 0.12)',
      borderWidth: 1,
      borderColor: 'rgba(0, 200, 83, 0.35)',
      paddingHorizontal: 14,
      paddingVertical: 10,
      borderRadius: 12,
      width: '100%',
      marginBottom: 18,
    },
    successBannerText: {
      fontSize: 14,
      fontFamily: typography.fonts.bold,
      color: '#00C853',
    },
    otpContainer: {
      flexDirection: 'row',
      justifyContent: 'space-between',
      width: '100%',
      marginBottom: 24,
      paddingHorizontal: 4,
    },
    otpInput: {
      width: 44,
      height: 54,
      borderRadius: 12,
      borderWidth: 1.5,
      borderColor: colors.border,
      backgroundColor: theme === 'dark' ? 'rgba(255, 255, 255, 0.05)' : 'rgba(0, 0, 0, 0.03)',
      fontSize: 22,
      fontFamily: typography.fonts.bold,
      color: colors.text.primary,
      textAlign: 'center',
      ...Platform.select({
        ios: {
          shadowColor: '#000',
          shadowOffset: { width: 0, height: 2 },
          shadowOpacity: 0.1,
          shadowRadius: 3,
        },
        android: {
          elevation: 2,
        },
      }),
    },
    otpInputFocused: {
      borderColor: colors.primary.DEFAULT,
      backgroundColor: theme === 'dark' ? 'rgba(225, 37, 124, 0.08)' : 'rgba(225, 37, 124, 0.04)',
    },
    otpInputFilled: {
      borderColor: colors.primary.DEFAULT,
    },
    otpInputError: {
      borderColor: '#FF3D00',
    },
    otpInputSuccess: {
      borderColor: '#00C853',
      backgroundColor: 'rgba(0, 200, 83, 0.08)',
    },
    verifyButton: {
      width: '100%',
      marginTop: 4,
      marginBottom: 16,
    },
    noteBox: {
      paddingHorizontal: 12,
      paddingVertical: 8,
      borderRadius: 10,
      backgroundColor: theme === 'dark' ? 'rgba(255, 255, 255, 0.04)' : 'rgba(0, 0, 0, 0.03)',
      width: '100%',
      marginBottom: 16,
    },
    noteText: {
      fontSize: 12,
      fontFamily: typography.fonts.regular,
      color: colors.text.tertiary,
      textAlign: 'center',
    },
    resendContainer: {
      flexDirection: 'row',
      alignItems: 'center',
      justifyContent: 'center',
      paddingVertical: 4,
    },
    resendButton: {
      flexDirection: 'row',
      alignItems: 'center',
      padding: 8,
    },
    resendText: {
      fontSize: 14,
      fontFamily: typography.fonts.medium,
      color: colors.primary.DEFAULT,
    },
    resendTextDisabled: {
      color: colors.text.tertiary,
    },
    changePhoneButton: {
      marginTop: 20,
      padding: 10,
    },
    changePhoneText: {
      fontSize: 13,
      fontFamily: typography.fonts.medium,
      color: colors.text.secondary,
      textDecorationLine: 'underline',
    },
  });
