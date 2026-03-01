import React, { useState, useMemo } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Platform, StatusBar, KeyboardAvoidingView, ScrollView, Modal } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Mail, Lock, User, Building, ArrowLeft, CheckCircle, Eye, EyeOff } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { WorkspaceService } from '../services/workspaceService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { LinearGradient } from 'expo-linear-gradient';

export const RegisterWorkspaceScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [companyName, setCompanyName] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [showConfirmPassword, setShowConfirmPassword] = useState(false);
  
  const [agreedToRetention, setAgreedToRetention] = useState(false);
  const [showPolicyModal, setShowPolicyModal] = useState(false);
  
  const [loading, setLoading] = useState(false);
  const [registered, setRegistered] = useState(false); // SUCCESS state
  const [errors, setErrors] = useState({ fullName: '', email: '', password: '', confirmPassword: '', companyName: '', general: '' });

  const styles = useMemo(() => createStyles(colors), [colors]);

  const validateForm = () => {
    let isValid = true;
    const newErrors = { fullName: '', email: '', password: '', confirmPassword: '', companyName: '', general: '' };

    if (!fullName.trim()) {
      newErrors.fullName = t('auth.fullNameRequired', 'Full Name is required');
      isValid = false;
    }
    if (!email.trim() || !email.includes('@')) {
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

    if (!agreedToRetention) {
      newErrors.general = t('auth.agreementRequired', 'You must agree to the Data Retention Policy to continue');
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleRegister = async () => {
    if (!validateForm()) return;

    setLoading(true);
    try {
      const result = await WorkspaceService.registerWorkspace({
        fullName,
        email,
        password,
        companyName,
        employeeId: email.split('@')[0],
        region: 'MY',
        data_retention_agreed: agreedToRetention,
      });

      setLoading(false);

      if (result.success) {
        setRegistered(true); // Show success screen
      } else {
        const errorMsg = result.error || 'Something went wrong. Please try again.';
        setErrors(prev => ({ ...prev, general: errorMsg }));
      }
    } catch (error: any) {
      setLoading(false);
      const errorMsg = error.message || 'An unexpected error occurred.';
      setErrors(prev => ({ ...prev, general: errorMsg }));
    }
  };

  // ==========================================
  // SUCCESS SCREEN - shown after registration
  // ==========================================
  if (registered) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.safeArea}>
          <ScrollView contentContainerStyle={styles.successContent}>
            <LinearGradient
              colors={['rgba(76, 175, 80, 0.15)', 'rgba(76, 175, 80, 0.05)'] as any}
              style={styles.successCard}
            >
              <View style={styles.successIconCircle}>
                <CheckCircle size={48} color="#4CAF50" />
              </View>

              <Text style={styles.successTitle}>Registration Successful! 🎉</Text>

              <Text style={styles.successMessage}>
                Your account has been created with the email:
              </Text>
              <Text style={styles.successEmail}>{email}</Text>

              <Text style={styles.successNote}>
                Log in now to activate your company workspace "{companyName}" and start managing your team.
              </Text>

              <GlassButton
                title="Go to Login"
                onPress={() => navigation.navigate('Login')}
                style={styles.goToLoginButton}
              />
            </LinearGradient>
          </ScrollView>
        </SafeAreaView>
      </GradientBackground>
    );
  }

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
                  placeholder="ACME Logistics"
                  value={companyName}
                  onChangeText={setCompanyName}
                  error={errors.companyName}
                  leftIcon={<Building size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.fullName', 'Your Full Name')}
                  placeholder="John Doe"
                  value={fullName}
                  onChangeText={setFullName}
                  error={errors.fullName}
                  leftIcon={<User size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.email', 'Business Email')}
                  placeholder="john@example.com"
                  value={email}
                  onChangeText={setEmail}
                  autoCapitalize="none"
                  keyboardType="email-address"
                  error={errors.email}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
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

                <View style={styles.agreementContainer}>
                  <TouchableOpacity 
                    style={styles.checkboxRow} 
                    onPress={() => setAgreedToRetention(!agreedToRetention)}
                    activeOpacity={0.7}
                  >
                    <View style={[
                      styles.checkbox,
                      agreedToRetention && { backgroundColor: colors.primary.DEFAULT, borderColor: colors.primary.DEFAULT }
                    ]}>
                      {agreedToRetention && <CheckCircle size={14} color="#FFF" />}
                    </View>
                    <Text style={styles.agreementLabel}>
                      {t('auth.iAgreeTo', 'I agree to the')} <Text onPress={() => setShowPolicyModal(true)} style={styles.linkText}>{t('auth.dataRetentionPolicy', 'Data Retention Policy')}</Text>
                    </Text>
                  </TouchableOpacity>
                  
                  <View style={styles.policyCard}>
                    <Text style={styles.policyText}>
                      {t('auth.retentionNoticeShort', 'Users data will be securely archived for compliance even after removal.')}
                    </Text>
                  </View>
                </View>

                {/* Data Retention Policy Modal */}
                <Modal
                  visible={showPolicyModal}
                  transparent={true}
                  animationType="fade"
                  onRequestClose={() => setShowPolicyModal(false)}
                >
                  <View style={styles.modalOverlay}>
                    <View style={styles.modalContent}>
                      <Text style={styles.modalTitle}>{t('auth.policyTitle', 'Data Retention Policy')}</Text>
                      <ScrollView style={styles.modalScrollView}>
                        <Text style={styles.modalText}>
                          {t('auth.policyFullContent', 'By checking this box, you agree that this App will securely archive users data even after a user is removed from your active team. This ensures a permanent safety audit trail for your company\'s insurance and compliance requirements. Archived data will not be accessible in your daily management view but remains in our secure database for legal and reporting purposes.')}
                        </Text>
                      </ScrollView>
                      <GlassButton 
                        title={t('common.close', 'Close')} 
                        onPress={() => setShowPolicyModal(false)}
                        style={styles.closeModalButton}
                      />
                    </View>
                  </View>
                </Modal>

                <GlassButton
                  title={t('auth.createWorkspace', 'Create Workspace')}
                  onPress={handleRegister}
                  loading={loading}
                  disabled={!agreedToRetention}
                  style={[styles.registerButton, !agreedToRetention && { opacity: 0.6 }]}
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
  agreementContainer: {
    marginVertical: 16,
    gap: 8,
  },
  checkboxRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  checkbox: {
    width: 20,
    height: 20,
    borderRadius: 6,
    borderWidth: 1,
    borderColor: colors.text.tertiary,
    justifyContent: 'center',
    alignItems: 'center',
  },
  agreementLabel: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
  },
  linkText: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
  },
  policyCard: {
    backgroundColor: colors.background.subtle + '50',
    padding: 12,
    borderRadius: 12,
    borderLeftWidth: 3,
    borderLeftColor: colors.primary.DEFAULT,
  },
  policyText: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 18,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.6)',
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  modalContent: {
    width: '100%',
    backgroundColor: colors.background.card,
    borderRadius: 20,
    padding: 24,
    borderWidth: 1,
    borderColor: `${colors.primary.DEFAULT}30`,
    maxHeight: '70%',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 10 },
    shadowOpacity: 0.3,
    shadowRadius: 20,
    elevation: 10,
  },
  modalTitle: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
    textAlign: 'center',
  },
  modalScrollView: {
    marginBottom: 20,
  },
  modalText: {
    fontSize: 15,
    lineHeight: 24,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
  },
  closeModalButton: {
    marginTop: 0,
  },
  errorBanner: { backgroundColor: 'rgba(255, 59, 48, 0.1)', borderWidth: 1, borderColor: colors.status.danger, borderRadius: 12, padding: 12, marginBottom: 16 },
  errorBannerText: { color: colors.status.danger, fontSize: 14, fontFamily: typography.fonts.medium, textAlign: 'center' },

  // Success Screen Styles
  successContent: { padding: 24, flexGrow: 1, justifyContent: 'center' },
  successCard: { borderRadius: 24, padding: 32, alignItems: 'center' as const, borderWidth: 1, borderColor: 'rgba(76, 175, 80, 0.3)' },
  successIconCircle: { width: 80, height: 80, borderRadius: 40, backgroundColor: 'rgba(76, 175, 80, 0.15)', justifyContent: 'center', alignItems: 'center', marginBottom: 24 },
  successTitle: { fontSize: 24, fontFamily: typography.fonts.bold, color: colors.text.primary, marginBottom: 16, textAlign: 'center' as const },
  successMessage: { fontSize: 16, fontFamily: typography.fonts.regular, color: colors.text.secondary, textAlign: 'center' as const },
  successEmail: { fontSize: 16, fontFamily: typography.fonts.bold, color: colors.text.primary, marginTop: 4, marginBottom: 24 },
  successSteps: { width: '100%' as any, gap: 16, marginBottom: 24 },
  stepRow: { flexDirection: 'row' as const, alignItems: 'center' as const, gap: 14 },
  stepDot: { width: 28, height: 28, borderRadius: 14, justifyContent: 'center' as const, alignItems: 'center' as const },
  stepNumber: { color: '#FFF', fontSize: 14, fontFamily: typography.fonts.bold },
  stepText: { fontSize: 15, fontFamily: typography.fonts.medium, color: colors.text.primary },
  successNote: { fontSize: 13, fontFamily: typography.fonts.regular, color: colors.text.tertiary, textAlign: 'center' as const, marginBottom: 24, lineHeight: 20 },
  goToLoginButton: { width: '100%' as any },
});
