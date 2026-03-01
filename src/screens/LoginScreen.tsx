import React, { useState, useMemo } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, StatusBar, KeyboardAvoidingView, Platform, ScrollView, Image } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Eye, EyeOff, Mail, Lock } from 'lucide-react-native';
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

export const LoginScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme } = useTheme();
  const [employeeId, setEmployeeId] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({ employeeId: '', password: '', general: '' });
  const [activeLang, setActiveLang] = useState(i18n.language);

  const handleLangSwitch = (lang: string) => {
    i18n.changeLanguage(lang);
    setActiveLang(lang);
  };
  
  const [companyName, setCompanyName] = useState('CNG Model Driver 360');
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
      navigation.replace('MainTabs');
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
                source={companyLogo ? { uri: companyLogo } : require('../../assets/logo.png')} 
                style={styles.logo}
                resizeMode="contain"
              />
              <Text style={styles.subtitle}>{t('auth.welcomeTo')} {companyName}</Text>
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
                  placeholder="jane@example.com or MY-001"
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

                <TouchableOpacity 
                  style={styles.forgotPasswordButton}
                  onPress={() => navigation.navigate('ForgotPassword')}
                  disabled={loading}
                >
                  <Text style={styles.forgotPasswordText}>{t('auth.forgotPassword', 'Forgot Password?')}</Text>
                </TouchableOpacity>

                <View style={styles.linkButton}>
                  <Text style={styles.linkText}>
                    {t('auth.doNotHaveAccount', "Don't have an account?")}{' '}
                    <Text 
                      style={styles.linkTextBold}
                      onPress={() => navigation.navigate('RegisterWorkspace')}
                    >
                      {t('auth.registerWorkspace', 'Register Your Company')}
                    </Text>
                  </Text>
                </View>



                {/* Language Selector */}
                <View style={styles.langToggleRow}>
                  <Text style={styles.langToggleLabel}>Language / Bahasa:</Text>
                  <View style={styles.langToggleButtons}>
                    <TouchableOpacity
                      activeOpacity={0.8}
                      onPress={() => handleLangSwitch('en')}
                    >
                      <LinearGradient
                        colors={activeLang === 'en' ? colors.gradients.primary as any : ['#000', '#000']}
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
                        colors={activeLang === 'ms' ? colors.gradients.primary as any : ['#000', '#000']}
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
    marginBottom: 40,
    alignItems: 'center',
  },
  logo: {
    width: 280,
    height: 100,
    marginBottom: 16,
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
    backgroundColor: '#FFFFFF',
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
    backgroundColor: '#FFFFFF',
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    gap: 6,
  },
  langButtonText: {
    fontSize: 15,
    fontFamily: typography.fonts.medium,
    color: '#666666',
  },
  langButtonTextActive: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
  },
});

