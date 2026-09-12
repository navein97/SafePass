import React, { useState, useMemo, useRef } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Platform, StatusBar, KeyboardAvoidingView, ScrollView, Modal, Alert, Linking } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Mail, Lock, User, Building, ArrowLeft, CheckCircle, Eye, EyeOff, Phone } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { WorkspaceService } from '../services/workspaceService';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { LinearGradient } from 'expo-linear-gradient';
import { PasscodeGateModal } from '../components/PasscodeGateModal';
import AppCaptcha, { AppCaptchaRef } from '../components/AppCaptcha';

export const RegisterWorkspaceScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  
  const captchaRef = useRef<AppCaptchaRef>(null);
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [companyName, setCompanyName] = useState('');
  const [companyCode, setCompanyCode] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({ fullName: '', email: '', password: '', confirmPassword: '', companyName: '', companyCode: '', phoneNumber: '', general: '' });

  const styles = useMemo(() => createStyles(colors), [colors]);

  const validateForm = () => {
    let isValid = true;
    const newErrors = { fullName: '', email: '', password: '', confirmPassword: '', companyName: '', companyCode: '', phoneNumber: '', general: '' };

    if (!fullName.trim()) {
      newErrors.fullName = t('auth.fullNameRequired', 'Full Name is required');
      isValid = false;
    }
    if (!email.trim() || !Validation.isValidEmail(email)) {
      newErrors.email = t('auth.invalidEmail', 'Invalid email address');
      isValid = false;
    }
    if (password.length < 6) {
      newErrors.password = t('auth.passwordTooShort', 'Password must be at least 6 characters');
      isValid = false;
    }
    if (password !== confirmPassword) {
      newErrors.confirmPassword = t('auth.passwordsDoNotMatch', 'Passwords do not match');
      isValid = false;
    }
    if (!companyName.trim()) {
      newErrors.companyName = t('auth.companyNameRequired', 'Company Name is required');
      isValid = false;
    }
    if (!companyCode.trim()) {
      newErrors.companyCode = t('auth.companyCodeRequired', 'Company Code is required (e.g. PRO, HAYAT)');
      isValid = false;
    } else if (!/^[A-Za-z0-9]+$/.test(companyCode.trim())) {
      newErrors.companyCode = t('auth.invalidCompanyCode', 'Company Code must contain letters and numbers only');
      isValid = false;
    }
    const formattedPhone = Validation.formatPhoneNumber(phoneNumber, 'MY');
    if (!phoneNumber.trim()) {
      newErrors.phoneNumber = t('auth.phoneRequired', 'Phone number is required');
      isValid = false;
    } else if (!Validation.hasCountryCode(formattedPhone)) {
      newErrors.phoneNumber = t('auth.phoneCountryCodeRequired', 'Please enter a valid phone number (e.g. +60123456789 or 0123456789)');
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleRegister = async () => {
    if (!validateForm()) return;

    setLoading(true);
    setErrors(prev => ({ ...prev, general: '' }));

    if (captchaRef.current) {
        captchaRef.current.show();
    } else {
        setLoading(false);
        setErrors(prev => ({ ...prev, general: 'Captcha component not ready' }));
    }
  };

  const handleVerifyCaptcha = async (token: string) => {
    try {
      const formattedPhone = Validation.formatPhoneNumber(phoneNumber, 'MY');
      const result = await WorkspaceService.registerWorkspace({
        fullName,
        email,
        password,
        companyName,
        companyCode: companyCode.trim().toUpperCase(),
        phone_number: formattedPhone,
        employeeId: email.split('@')[0],
        region: 'MY',
        captchaToken: token,
      });

      setLoading(false);

      if (result.success) {
        // Navigate directly to SMS OTP verification screen
        navigation.navigate('OtpVerification', {
          phone: formattedPhone,
          userId: result.user?.id,
          email,
          companyName,
        });
      } else {
        const errorMsg = result.error || t('common.unexpectedErrorOccurred');
        setErrors(prev => ({ ...prev, general: errorMsg }));
      }
    } catch (error: any) {
      setLoading(false);
      const errorMsg = error.message || t('common.unexpectedErrorOccurred');
      setErrors(prev => ({ ...prev, general: errorMsg }));
    }
  };

  const handleCaptchaError = (errorMsg: string) => {
    setLoading(false);
    setErrors(prev => ({ ...prev, general: 'Captcha verification failed. Please try again.' }));
  };

  const handleCaptchaCancel = () => {
    setLoading(false);
  };

  // ==========================================
  // REGISTRATION FORM
  // ==========================================
  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <KeyboardAvoidingView 
          style={{ flex: 1 }}
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        >
          <ScrollView contentContainerStyle={styles.content}>
            <TouchableOpacity 
              style={styles.backButton} 
              onPress={() => navigation.goBack()}
            >
              <ArrowLeft size={24} color={colors.text.primary} />
            </TouchableOpacity>

            <View style={styles.header}>
              <Text style={styles.title}>{t('auth.registerWorkspace', 'Register Workspace')}</Text>
              <Text style={styles.subtitle}>{t('auth.registerSubtitle', 'Create your company account to start managing your fleet')}</Text>
            </View>

            <GlassCard style={styles.formCard}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label={t('auth.companyName', 'Company Name')}
                  placeholder={t('company.namePlaceholder', 'ACME Logistics')}
                  value={companyName}
                  onChangeText={setCompanyName}
                  error={errors.companyName}
                  leftIcon={<Building size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.companyCode', 'Company Code (for Driver Logins)')}
                  placeholder="e.g. PRO, HAYAT, CNG"
                  value={companyCode}
                  onChangeText={(val) => setCompanyCode(Validation.cleanCompanyCode(val))}
                  autoCapitalize="characters"
                  error={errors.companyCode}
                  leftIcon={<Building size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.fullName', 'Your Full Name')}
                  placeholder={t('auth.fullNamePlaceholder', 'John Doe')}
                  value={fullName}
                  onChangeText={setFullName}
                  error={errors.fullName}
                  leftIcon={<User size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.email', 'Business Email')}
                  placeholder="john@example.com"
                  value={email}
                  onChangeText={(text) => setEmail(Validation.cleanEmail(text))}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  error={errors.email}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.phone', 'Phone Number')}
                  placeholder="+60123456789 or 0123456789"
                  value={phoneNumber}
                  onChangeText={(text) => setPhoneNumber(Validation.cleanPhoneNumber(text))}
                  keyboardType="phone-pad"
                  error={errors.phoneNumber}
                  leftIcon={<Phone size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.password', 'Password')}
                  placeholder="••••••••"
                  value={password}
                  onChangeText={setPassword}
                  secureTextEntry={!showPassword}
                  error={errors.password}
                  leftIcon={<Lock size={20} color={colors.text.secondary} />}
                  rightIcon={
                    <TouchableOpacity onPress={() => setShowPassword(!showPassword)}>
                      {showPassword ? (
                        <EyeOff size={20} color={colors.text.secondary} />
                      ) : (
                        <Eye size={20} color={colors.text.secondary} />
                      )}
                    </TouchableOpacity>
                  }
                />

                <GlassInput
                  label={t('auth.confirmPassword', 'Confirm Password')}
                  placeholder="••••••••"
                  value={confirmPassword}
                  onChangeText={setConfirmPassword}
                  secureTextEntry={!showConfirmPassword}
                  error={errors.confirmPassword}
                  leftIcon={<Lock size={20} color={colors.text.secondary} />}
                  rightIcon={
                    <TouchableOpacity onPress={() => setShowConfirmPassword(!showConfirmPassword)}>
                      {showConfirmPassword ? (
                        <EyeOff size={20} color={colors.text.secondary} />
                      ) : (
                        <Eye size={20} color={colors.text.secondary} />
                      )}
                    </TouchableOpacity>
                  }
                />

                <GlassButton
                  title={t('auth.createWorkspace', 'Create Workspace')}
                  onPress={handleRegister}
                  loading={loading}
                  style={[styles.registerButton]}
                />
              </View>
            </GlassCard>
          </ScrollView>

          <AppCaptcha
            ref={captchaRef}
            onVerify={handleVerifyCaptcha}
            onError={handleCaptchaError}
            onCancel={handleCaptchaCancel}
          />
        </KeyboardAvoidingView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: { flex: 1 },
  content: { padding: 24, flexGrow: 1, justifyContent: 'center' },
  backButton: { position: 'absolute', top: 10, left: 10, padding: 10, zIndex: 10 },
  header: { marginBottom: 30, alignItems: 'center' },
  title: { fontSize: 28, fontFamily: typography.fonts.bold, color: colors.text.primary, marginBottom: 8 },
  subtitle: { fontSize: 16, fontFamily: typography.fonts.regular, color: colors.text.secondary, textAlign: 'center' },
  formCard: { width: '100%' },
  form: { gap: 4 },
  registerButton: { marginTop: 20 },
  errorBanner: { backgroundColor: 'rgba(255, 59, 48, 0.1)', borderWidth: 1, borderColor: colors.status.danger, borderRadius: 12, padding: 12, marginBottom: 16 },
  errorBannerText: { color: colors.status.danger, fontSize: 14, fontFamily: typography.fonts.medium, textAlign: 'center' },
});
