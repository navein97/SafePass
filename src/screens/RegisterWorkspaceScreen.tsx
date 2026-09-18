import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TouchableOpacity,
  KeyboardAvoidingView,
  ScrollView,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { User, Mail, Lock, Building, ArrowLeft, Phone } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { GradientBackground } from '../components/ui/GradientBackground';
import { WorkspaceService } from '../services/workspaceService';
import { Validation } from '../utils/validation';

export const RegisterWorkspaceScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors } = useTheme();

  const [companyName, setCompanyName] = useState('');
  const [companyCode, setCompanyCode] = useState('');
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [phoneNumber, setPhoneNumber] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState<{ [key: string]: string }>({});

  const styles = createStyles(colors);

  const validateForm = () => {
    let isValid = true;
    const newErrors: { [key: string]: string } = {};

    if (!companyName.trim()) {
      newErrors.companyName = t('auth.companyNameRequired', 'Company name is required');
      isValid = false;
    }

    if (!companyCode.trim()) {
      newErrors.companyCode = t('auth.companyCodeRequired', 'Company code is required');
      isValid = false;
    } else if (!/^[A-Z0-9]{2,10}$/i.test(companyCode.trim())) {
      newErrors.companyCode = t('auth.companyCodeInvalid', 'Code must be 2-10 uppercase alphanumeric characters');
      isValid = false;
    }

    if (!fullName.trim()) {
      newErrors.fullName = t('auth.fullNameRequired', 'Full name is required');
      isValid = false;
    }

    if (!email.trim()) {
      newErrors.email = t('auth.emailRequired', 'Email address is required');
      isValid = false;
    } else if (!Validation.isValidEmail(email)) {
      newErrors.email = t('auth.emailInvalid', 'Please enter a valid email address');
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

    if (!password) {
      newErrors.password = t('auth.passwordRequired', 'Password is required');
      isValid = false;
    } else if (password.length < 6) {
      newErrors.password = t('auth.passwordMinLength', 'Password must be at least 6 characters');
      isValid = false;
    }

    if (password !== confirmPassword) {
      newErrors.confirmPassword = t('auth.passwordsDoNotMatch', 'Passwords do not match');
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const checkCompanyCodeAvailability = async (codeToCheck?: string) => {
    const code = (codeToCheck !== undefined ? codeToCheck : companyCode).trim().toUpperCase();
    if (code.length < 2) return;
    try {
      const availability = await WorkspaceService.checkRegistrationAvailability({ companyCode: code });
      if (availability.errors.companyCode) {
        setErrors(prev => ({
          ...prev,
          companyCode: (t('auth.companyCodeTaken', 'Company code is already taken. Please choose another code.') as string),
        }));
      }
    } catch (e) {
      // Non-blocking
    }
  };

  const checkEmailAvailability = async (emailToCheck?: string) => {
    const targetEmail = (emailToCheck !== undefined ? emailToCheck : email).trim().toLowerCase();
    if (!Validation.isValidEmail(targetEmail)) return;
    try {
      const availability = await WorkspaceService.checkRegistrationAvailability({ email: targetEmail });
      if (availability.errors.email) {
        setErrors(prev => ({
          ...prev,
          email: (t('auth.emailAlreadyRegistered', 'This email address is already registered. Please log in instead.') as string),
        }));
      }
    } catch (e) {
      // Non-blocking
    }
  };

  const checkPhoneAvailability = async (phoneToCheck?: string) => {
    const targetPhone = (phoneToCheck !== undefined ? phoneToCheck : phoneNumber).trim();
    if (targetPhone.replace(/[^0-9]/g, '').length < 8) return;
    try {
      const availability = await WorkspaceService.checkRegistrationAvailability({ phoneNumber: targetPhone, region: 'MY' });
      if (availability.errors.phoneNumber) {
        setErrors(prev => ({
          ...prev,
          phoneNumber: (t('auth.phoneAlreadyRegistered', 'This phone number is already registered. Please use a different phone number.') as string),
        }));
      }
    } catch (e) {
      // Non-blocking
    }
  };

  const handleRegister = async () => {
    if (!validateForm()) return;

    setLoading(true);
    setErrors(prev => ({ ...prev, general: '' }));

    try {
      const formattedPhone = Validation.formatPhoneNumber(phoneNumber, 'MY');
      const cleanCompanyCode = companyCode.trim().toUpperCase();
      const cleanEmail = email.trim().toLowerCase();

      // Check availability across all critical unique fields upfront
      const availability = await WorkspaceService.checkRegistrationAvailability({
        companyCode: cleanCompanyCode,
        email: cleanEmail,
        phoneNumber: formattedPhone,
        region: 'MY',
      });

      if (!availability.isValid) {
        setLoading(false);
        const newFieldErrors: { [key: string]: string } = {};
        if (availability.errors.companyCode) {
          newFieldErrors.companyCode = t('auth.companyCodeTaken', 'Company code is already taken. Please choose another code.') as string;
        }
        if (availability.errors.email) {
          newFieldErrors.email = t('auth.emailAlreadyRegistered', 'This email address is already registered. Please log in instead.') as string;
        }
        if (availability.errors.phoneNumber) {
          newFieldErrors.phoneNumber = t('auth.phoneAlreadyRegistered', 'This phone number is already registered. Please use a different phone number.') as string;
        }
        newFieldErrors.general = t('auth.duplicateDetailsFound', 'Some details provided already exist. Please check the highlighted fields.') as string;
        setErrors(prev => ({ ...prev, ...newFieldErrors }));
        return;
      }

      const result = await WorkspaceService.registerWorkspace({
        fullName,
        email: cleanEmail,
        password,
        companyName,
        companyCode: cleanCompanyCode,
        phone_number: formattedPhone,
        employeeId: cleanEmail.split('@')[0],
        region: 'MY',
      });

      setLoading(false);

      if (result.success) {
        // Navigate directly to SMS OTP verification screen
        navigation.navigate('OtpVerification', {
          phone: formattedPhone,
          userId: result.user?.id,
          email: cleanEmail,
          companyName,
        });
      } else {
        if ((result as any).fieldErrors) {
          const fieldErrors = (result as any).fieldErrors;
          const newFieldErrors: { [key: string]: string } = {};
          if (fieldErrors.companyCode) {
            newFieldErrors.companyCode = t('auth.companyCodeTaken', 'Company code is already taken. Please choose another code.') as string;
          }
          if (fieldErrors.email) {
            newFieldErrors.email = t('auth.emailAlreadyRegistered', 'This email address is already registered. Please log in instead.') as string;
          }
          if (fieldErrors.phoneNumber) {
            newFieldErrors.phoneNumber = t('auth.phoneAlreadyRegistered', 'This phone number is already registered. Please use a different phone number.') as string;
          }
          newFieldErrors.general = t('auth.duplicateDetailsFound', 'Some details provided already exist. Please check the highlighted fields.') as string;
          setErrors(prev => ({ ...prev, ...newFieldErrors }));
        } else {
          const friendlyMsg = Validation.getFriendlyErrorMessage(result.error || '');
          setErrors(prev => ({ ...prev, general: friendlyMsg || (t('common.unexpectedErrorOccurred') as string) }));
        }
      }
    } catch (error: any) {
      setLoading(false);
      const friendlyMsg = Validation.getFriendlyErrorMessage(error.message || '');
      setErrors(prev => ({ ...prev, general: friendlyMsg || (t('common.unexpectedErrorOccurred') as string) }));
    }
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <KeyboardAvoidingView
          style={{ flex: 1 }}
          behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        >
          <ScrollView contentContainerStyle={styles.content} keyboardShouldPersistTaps="handled">
            <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
              <ArrowLeft size={24} color={colors.text.primary} />
            </TouchableOpacity>

            <View style={styles.header}>
              <Text style={styles.title}>{t('auth.createWorkspace', 'Create Workspace')}</Text>
              <Text style={styles.subtitle}>{t('auth.workspaceSubtitle', 'Register your company account')}</Text>
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
                  placeholder="e.g. Acme Corporation"
                  value={companyName}
                  onChangeText={(text) => {
                    setCompanyName(text);
                    if (errors.companyName || errors.general) setErrors(prev => ({ ...prev, companyName: '', general: '' }));
                  }}
                  autoCapitalize="words"
                  editable={!loading}
                  error={errors.companyName}
                  leftIcon={<Building size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.companyCode', 'Company Code')}
                  placeholder="e.g. ACME (2-10 chars)"
                  value={companyCode}
                  onChangeText={(text) => {
                    setCompanyCode(Validation.cleanCompanyCode(text));
                    if (errors.companyCode || errors.general) setErrors(prev => ({ ...prev, companyCode: '', general: '' }));
                  }}
                  onBlur={() => checkCompanyCodeAvailability()}
                  autoCapitalize="characters"
                  maxLength={10}
                  editable={!loading}
                  error={errors.companyCode}
                  leftIcon={<Building size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.fullName', 'Full Name')}
                  placeholder="e.g. John Doe"
                  value={fullName}
                  onChangeText={(text) => {
                    setFullName(text);
                    if (errors.fullName || errors.general) setErrors(prev => ({ ...prev, fullName: '', general: '' }));
                  }}
                  autoCapitalize="words"
                  editable={!loading}
                  error={errors.fullName}
                  leftIcon={<User size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.emailAddress', 'Email Address')}
                  placeholder="e.g. john@acme.com"
                  value={email}
                  onChangeText={(text) => {
                    setEmail(text);
                    if (errors.email || errors.general) setErrors(prev => ({ ...prev, email: '', general: '' }));
                  }}
                  onBlur={() => checkEmailAvailability()}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  editable={!loading}
                  error={errors.email}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.phoneNumber', 'Phone Number')}
                  placeholder="e.g. 0123456789 or +60123456789"
                  value={phoneNumber}
                  onChangeText={(text) => {
                    setPhoneNumber(text);
                    if (errors.phoneNumber || errors.general) setErrors(prev => ({ ...prev, phoneNumber: '', general: '' }));
                  }}
                  onBlur={() => checkPhoneAvailability()}
                  keyboardType="phone-pad"
                  editable={!loading}
                  error={errors.phoneNumber}
                  leftIcon={<Phone size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.password', 'Password')}
                  placeholder="••••••••"
                  value={password}
                  onChangeText={(text) => {
                    setPassword(text);
                    if (errors.password) setErrors(prev => ({ ...prev, password: '' }));
                  }}
                  secureTextEntry
                  editable={!loading}
                  error={errors.password}
                  leftIcon={<Lock size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.confirmPassword', 'Confirm Password')}
                  placeholder="••••••••"
                  value={confirmPassword}
                  onChangeText={(text) => {
                    setConfirmPassword(text);
                    if (errors.confirmPassword) setErrors(prev => ({ ...prev, confirmPassword: '' }));
                  }}
                  secureTextEntry
                  editable={!loading}
                  error={errors.confirmPassword}
                  leftIcon={<Lock size={20} color={colors.text.secondary} />}
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
