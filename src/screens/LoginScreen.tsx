import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, Alert, StatusBar, KeyboardAvoidingView, Platform, ScrollView } from 'react-native';
import { useTranslation } from 'react-i18next';
import { Eye, EyeOff, Mail, Lock } from 'lucide-react-native';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';

export const LoginScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [errors, setErrors] = useState({ email: '', password: '', general: '' });

  const validateForm = () => {
    let isValid = true;
    const newErrors = { email: '', password: '', general: '' };

    if (!email.trim()) {
      newErrors.email = 'Email is required';
      isValid = false;
    } else if (!Validation.isValidEmail(email)) {
      newErrors.email = 'Please enter a valid email address';
      isValid = false;
    }

    if (!password) {
      newErrors.password = 'Password is required';
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
      email,
      password,
    });

    setLoading(false);

    if (error) {
      const friendlyMsg = Validation.getFriendlyErrorMessage(error);
      setErrors(prev => ({ ...prev, general: friendlyMsg }));
      Alert.alert('Login Failed', friendlyMsg);
    } else if (session) {
      navigation.replace('Main');
    }
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
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
              <Text style={styles.title}>SafePass</Text>
              <Text style={styles.subtitle}>{t('auth.welcome')}</Text>
            </View>

            <GlassCard style={styles.formCard}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label="Email"
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
                  style={styles.linkButton}
                  onPress={() => navigation.navigate('Register')}
                  disabled={loading}
                >
                  <Text style={styles.linkText}>
                    Don't have an account? <Text style={styles.linkTextBold}>Register</Text>
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

const styles = StyleSheet.create({
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
  title: {
    fontSize: 42,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
    marginBottom: 8,
    textAlign: 'center',
    textShadowColor: colors.primary.dark,
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 20,
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
  linkButton: {
    alignItems: 'center',
    marginTop: 24,
  },
  linkText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
  },
  linkTextBold: {
    color: colors.primary.light,
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
});

