import React, { useState, useMemo } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, StatusBar, KeyboardAvoidingView, Platform, ScrollView, Image, Linking } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Eye, EyeOff, Mail, Lock, HelpCircle, Car, Building } from 'lucide-react-native';
import { LinearGradient } from 'expo-linear-gradient';
import CountryFlag from 'react-native-country-flag';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';
import { CompanySettingsService } from '../services/companySettingsService';
import { WorkspaceService } from '../services/workspaceService';
import { supabase } from '../lib/supabase';

export const LoginScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme } = useTheme();
  const [employeeId, setEmployeeId] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({ employeeId: '', password: '', general: '' });
  const [activeLang, setActiveLang] = useState(i18n.language);
  const [showPolicyModal, setShowPolicyModal] = useState(false);

  const handleLangSwitch = (lang: string) => {
    i18n.changeLanguage(lang);
    setActiveLang(lang);
  };

  const [companyName, setCompanyName] = useState('ProDrive 180');
  const [companyLogo, setCompanyLogo] = useState<string | null>(null);

  React.useEffect(() => {
    loadCompanyInfo();
  }, []);

  const loadCompanyInfo = async () => {
    const info = await CompanySettingsService.getCompanyInfo();
    if (info.name) setCompanyName(info.name);
    if (info.logo_url) setCompanyLogo(info.logo_url);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  const validateForm = () => {
    let isValid = true;
    const newErrors = { employeeId: '', password: '', general: '' };

    if (!employeeId.trim()) {
      newErrors.employeeId = t('auth.employeeIdRequired', 'Employee ID is required');
      isValid = false;
    }

    if (!password) {
      newErrors.password = t('auth.passwordRequired');
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleContactSupport = () => {
    const whatsappUrl = 'https://wa.me/601120616323?text=Hi%20Driver%20360%20Support,%20I%20need%20help%20with%20logging%20in.';
    Linking.openURL(whatsappUrl);
  };

  const handleWhatsAppRegistration = () => {
    const message = `Hi there, I would like to register my company:
Company Name: 
Manager Email: 
Name: 
Region: 
Phone: +60
Designation: `;
    const encodedMessage = encodeURIComponent(message);
    const whatsappUrl = `https://wa.me/601120616323?text=${encodedMessage}`;
    Linking.openURL(whatsappUrl);
  };

  const handleLogin = async () => {
    if (!validateForm()) return;

    setLoading(true);
    setErrors(prev => ({ ...prev, general: '' }));

    const { session, error } = await AuthService.signIn({
      employeeId,
      password,
    });

    setLoading(false);

    if (error) {
      const friendlyMsg = Validation.getFriendlyErrorMessage(error);
      setErrors(prev => ({ ...prev, general: friendlyMsg }));
      Alert.alert(t('auth.loginFailed'), friendlyMsg);
    } else if (session) {
      // If this is a new Master User's first login, create their company
      await WorkspaceService.setupWorkspaceIfNeeded();
      
      const userMeta = session.user?.user_metadata;
      if (userMeta?.role === 'manager' && !userMeta?.data_retention_agreed) {
        setShowPolicyModal(true);
      } else {
        navigation.replace('MainTabs');
      }
    }
  };

  const handleAgreePolicy = async () => {
    setLoading(true);
    const { error } = await supabase.auth.updateUser({
      data: { data_retention_agreed: true }
    });
    setLoading(false);
    if (!error) {
      setShowPolicyModal(false);
      navigation.replace('MainTabs');
    } else {
      Alert.alert("Error", "Could not save agreement.");
    }
  };

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
            <View style={styles.header}>
              <Image
                source={require('../../assets/logo.png')}
                style={styles.logo}
                resizeMode="contain"
              />
            </View>

            <View style={[styles.formCard, styles.solidCard]}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label={t('auth.employeeIdOrEmail', 'Email / Employee ID')}
                  placeholder={t('auth.employeeIdPlaceholder')}
                  value={employeeId}
                  onChangeText={(text) => {
                    setEmployeeId(text);
                    if (errors.employeeId) setErrors(prev => ({ ...prev, employeeId: '' }));
                  }}
                  autoCapitalize="none"
                  autoCorrect={false}
                  autoComplete="off"
                  spellCheck={false}
                  textContentType="none"
                  importantForAutofill="no"
                  editable={!loading}
                  error={errors.employeeId}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label={t('auth.password')}
                  placeholder="••••••••"
                  value={password}
                  onChangeText={(text) => {
                    setPassword(text);
                    if (errors.password) setErrors(prev => ({ ...prev, password: '' }));
                  }}
                  secureTextEntry={!showPassword}
                  editable={!loading}
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

                <GlassButton
                  title={t('auth.login')}
                  onPress={handleLogin}
                  loading={loading}
                  style={styles.loginButton}
                />

                <Text style={[styles.linkText, { marginTop: 12, fontSize: 11, paddingHorizontal: 10, lineHeight: 16 }]}>
                  By logging in, you agree to the{' '}
                  <Text style={styles.linkTextBold} onPress={() => navigation.navigate('Terms')}>
                    Terms of Service & Intellectual Property Policies
                  </Text>
                  {' '}of CNG Synergy (KT0512750V).
                </Text>

                <TouchableOpacity
                  style={styles.forgotPasswordButton}
                  onPress={() => navigation.navigate('ForgotPassword')}
                  disabled={loading}
                >
                  <Text style={styles.forgotPasswordText}>{t('auth.forgotPassword', 'Forgot Password?')}</Text>
                </TouchableOpacity>

                <View style={[styles.linkButton, { marginTop: 24, alignItems: 'center' }]}>
                  <TouchableOpacity
                    style={styles.guideButton}
                    onPress={() => navigation.navigate('HelpCenter')}
                  >
                    <HelpCircle size={18} color={colors.primary.DEFAULT} style={{ marginRight: 8 }} />
                    <Text style={styles.guideButtonText}>New User? View App Guide</Text>
                  </TouchableOpacity>

                  {Platform.OS === 'web' && (
                    <TouchableOpacity
                      style={[styles.guideButton, { marginTop: 12, backgroundColor: colors.primary.DEFAULT + '15', borderColor: colors.primary.DEFAULT, borderWidth: 1 }]}
                      onPress={() => navigation.navigate('RegisterWorkspace')}
                    >
                      <Building size={18} color={colors.primary.DEFAULT} style={{ marginRight: 8 }} />
                      <Text style={[styles.guideButtonText, { color: colors.primary.DEFAULT, fontFamily: typography.fonts.bold }]}>
                        {t('auth.registerWorkspace', 'Register Workspace')}
                      </Text>
                    </TouchableOpacity>
                  )}

                  {Platform.OS !== 'web' && (
                    <TouchableOpacity
                      style={[styles.guideButton, { marginTop: 12, backgroundColor: '#25D36615', borderColor: '#25D366', borderWidth: 1 }]}
                      onPress={handleWhatsAppRegistration}
                    >
                      <Mail size={18} color="#25D366" style={{ marginRight: 8 }} />
                      <Text style={[styles.guideButtonText, { color: '#25D366', fontFamily: typography.fonts.bold }]}>
                        {t('auth.registerCompany', 'Request Trial')}
                      </Text>
                    </TouchableOpacity>
                  )}

                  <View style={styles.divider} />

                  <Text style={styles.linkText}>
                    {t('auth.needHelp', 'Need help?')} {' '}
                    <Text
                      style={styles.linkTextBold}
                      onPress={handleContactSupport}
                    >
                      {t('auth.contactSupport', 'Contact Support')}
                    </Text>
                  </Text>
                </View>

                {/* Language Selector */}
                <View style={styles.langToggleRow}>
                  <Text style={styles.langToggleLabel}>{t('auth.languageLabel')}</Text>
                  <View style={styles.langToggleButtons}>
                    <TouchableOpacity
                      activeOpacity={0.8}
                      onPress={() => handleLangSwitch('en')}
                    >
                      <LinearGradient
                        colors={activeLang === 'en' ? colors.gradients.primary as any : [colors.border, colors.border]}
                        start={{ x: 0, y: 0 }}
                        end={{ x: 1, y: 0 }}
                        style={styles.langButtonGradientWrapper}
                      >
                        <View style={styles.langButtonInner}>
                          <CountryFlag isoCode="GB" size={14} style={{ borderRadius: 2 }} />
                          <Text style={[
                            styles.langButtonText,
                            activeLang === 'en' && styles.langButtonTextActive,
                          ]}>EN</Text>
                        </View>
                      </LinearGradient>
                    </TouchableOpacity>

                    <TouchableOpacity
                      activeOpacity={0.8}
                      onPress={() => handleLangSwitch('ms')}
                    >
                      <LinearGradient
                        colors={activeLang === 'ms' ? colors.gradients.primary as any : [colors.border, colors.border]}
                        start={{ x: 0, y: 0 }}
                        end={{ x: 1, y: 0 }}
                        style={styles.langButtonGradientWrapper}
                      >
                        <View style={styles.langButtonInner}>
                          <CountryFlag isoCode="MY" size={14} style={{ borderRadius: 2 }} />
                          <Text style={[
                            styles.langButtonText,
                            activeLang === 'ms' && styles.langButtonTextActive,
                          ]}>BM</Text>
                        </View>
                      </LinearGradient>
                    </TouchableOpacity>
                  </View>
                </View>
              </View>
            </View>
          </ScrollView>

          {/* Data Retention Policy Modal */}
          {showPolicyModal && (
            <View style={StyleSheet.absoluteFill}>
              <View style={styles.modalOverlay}>
                <View style={styles.modalContent}>
                  <Text style={styles.modalTitle}>{t('auth.policyTitle', 'Data Retention Policy')}</Text>
                  <ScrollView style={styles.modalScrollView}>
                    <Text style={styles.modalText}>
                      {t('auth.policyFullContent', 'Before continuing, you must agree that this App will securely archive users data even after a user is removed from your active team. This ensures a permanent safety audit trail for your company\'s insurance and compliance requirements. Archived data will not be accessible in your daily management view but remains in our secure database for legal and reporting purposes.')}
                    </Text>
                  </ScrollView>
                  <GlassButton 
                    title={t('auth.iAgreeTo', 'I Agree')} 
                    onPress={handleAgreePolicy}
                    loading={loading}
                  />
                </View>
              </View>
            </View>
          )}

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
  header: {
    marginTop: 20,
    alignItems: 'center',
    gap: 8,
  },
  logo: {
    width: 280,
    height: 100,
    marginBottom: 16,
  },
  divider: {
    height: 1,
    backgroundColor: colors.border,
    width: '40%',
    marginVertical: 12,
    opacity: 0.5,
  },
  guideButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: colors.primary.DEFAULT + '15',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 20,
    marginTop: 4,
  },
  guideButtonText: {
    fontFamily: typography.fonts.bold,
    fontSize: 14,
    color: colors.primary.DEFAULT,
  },
  subtitle: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
  },
  formCard: {
    width: '100%',
  },
  form: {
    gap: 8,
  },
  loginButton: {
    marginTop: 16,
  },
  forgotPasswordButton: {
    alignItems: 'center',
    marginTop: 16,
  },
  forgotPasswordText: {
    color: colors.mode === 'light' ? colors.primary.dark : colors.primary.light,
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.medium,
  },
  linkButton: {
    alignItems: 'center',
    marginTop: 24,
  },
  linkText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
    textAlign: 'center',
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
  solidCard: {
    backgroundColor: colors.background.card,
    borderRadius: 24,
    padding: 24,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 16,
    elevation: 8,
  },
  langToggleRow: {
    alignItems: 'center',
    marginTop: 20,
    gap: 10,
  },
  langToggleLabel: {
    fontSize: 13,
    fontFamily: typography.fonts.regular,
    color: colors.text.tertiary,
  },
  langToggleButtons: {
    flexDirection: 'row',
    gap: 10,
  },
  langButtonGradientWrapper: {
    padding: 2, // Border width
    borderRadius: 24,
  },
  langButtonInner: {
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 22,
    backgroundColor: colors.background.card,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    gap: 6,
  },
  langButtonText: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  langButtonTextActive: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
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
});

