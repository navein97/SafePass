import React, { useState } from 'react';
import { View, Text, TouchableOpacity, StyleSheet, StatusBar, ScrollView, KeyboardAvoidingView, Platform } from 'react-native';
import { Eye, EyeOff, User, Mail, Lock, Briefcase, MapPin } from 'lucide-react-native';
import { useTranslation } from 'react-i18next';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Region } from '../types/models';
import { Toast } from '../components/Toast';
import { Validation } from '../utils/validation';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassCard } from '../components/ui/GlassCard';

export const RegisterScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [fullName, setFullName] = useState('');
  const [employeeId, setEmployeeId] = useState('');
  const [region, setRegion] = useState<Region>('MY');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  
  // Toast state
  const [toastVisible, setToastVisible] = useState(false);
  const [toastMessage, setToastMessage] = useState('');
  const [toastType, setToastType] = useState<'success' | 'error' | 'info'>('success');
  
  // Validation state
  const [errors, setErrors] = useState({
    email: '',
    password: '',
    fullName: '',
    employeeId: '',
    general: ''
  });

  const validateForm = () => {
    let isValid = true;
    const newErrors = { email: '', password: '', fullName: '', employeeId: '', general: '' };

    if (!fullName.trim()) {
      newErrors.fullName = 'Full Name is required';
      isValid = false;
    }

    if (!employeeId.trim()) {
      newErrors.employeeId = 'Employee ID is required';
      isValid = false;
    }

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
    } else if (!Validation.isValidPassword(password)) {
      newErrors.password = 'Password must be at least 6 characters';
      isValid = false;
    }

    setErrors(newErrors);
    return isValid;
  };

  const handleRegister = async () => {
    if (!validateForm()) return;

    setLoading(true);
    setErrors(prev => ({ ...prev, general: '' }));

    const { user, error } = await AuthService.signUp({
      email,
      password,
      fullName,
      employeeId,
      region,
    });

    setLoading(false);

    if (error) {
      const friendlyMsg = Validation.getFriendlyErrorMessage(error);
      setErrors(prev => ({ ...prev, general: friendlyMsg }));
      setToastType('error');
      setToastMessage(friendlyMsg);
      setToastVisible(true);
    } else {
      // Show success toast
      setToastType('success');
      setToastMessage('✅ Check your email for verification link!');
      setToastVisible(true);
      
      // Navigate to login after a short delay
      setTimeout(() => {
        navigation.navigate('Login');
      }, 2000);
    }
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <Toast
          visible={toastVisible}
          message={toastMessage}
          type={toastType}
          onHide={() => setToastVisible(false)}
        />
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
              <Text style={styles.subtitle}>Create Driver Account</Text>
            </View>

            <GlassCard style={styles.formCard}>
              <View style={styles.form}>
                {errors.general ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorBannerText}>{errors.general}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label="Full Name"
                  placeholder="John Doe"
                  value={fullName}
                  onChangeText={(text) => {
                    setFullName(text);
                    if (errors.fullName) setErrors(prev => ({ ...prev, fullName: '' }));
                  }}
                  autoCapitalize="words"
                  error={errors.fullName}
                  leftIcon={<User size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label="Employee ID"
                  placeholder="EMP12345"
                  value={employeeId}
                  onChangeText={(text) => {
                    setEmployeeId(text);
                    if (errors.employeeId) setErrors(prev => ({ ...prev, employeeId: '' }));
                  }}
                  autoCapitalize="characters"
                  error={errors.employeeId}
                  leftIcon={<Briefcase size={20} color={colors.text.secondary} />}
                />

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
                  error={errors.email}
                  leftIcon={<Mail size={20} color={colors.text.secondary} />}
                />

                <GlassInput
                  label="Password"
                  placeholder="••••••••"
                  value={password}
                  onChangeText={(text) => {
                    setPassword(text);
                    if (errors.password) setErrors(prev => ({ ...prev, password: '' }));
                  }}
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

                <Text style={styles.label}>Region</Text>
                <View style={styles.regionContainer}>
                  <GlassButton
                    title="Malaysia"
                    onPress={() => setRegion('MY')}
                    variant={region === 'MY' ? 'primary' : 'outline'}
                    style={styles.regionButton}
                    icon={<MapPin size={16} color={region === 'MY' ? colors.text.primary : colors.primary.DEFAULT} />}
                  />
                  <GlassButton
                    title="Portugal"
                    onPress={() => setRegion('PT')}
                    variant={region === 'PT' ? 'primary' : 'outline'}
                    style={styles.regionButton}
                    icon={<MapPin size={16} color={region === 'PT' ? colors.text.primary : colors.primary.DEFAULT} />}
                  />
                </View>

                <GlassButton
                  title={loading ? 'Creating Account...' : 'Register'}
                  onPress={handleRegister}
                  loading={loading}
                  style={styles.registerButton}
                />

                <TouchableOpacity 
                  style={styles.linkButton}
                  onPress={() => navigation.navigate('Login')}
                >
                  <Text style={styles.linkText}>
                    Already have an account? <Text style={styles.linkTextBold}>Sign In</Text>
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
  },
  header: {
    marginBottom: 32,
    alignItems: 'center',
    marginTop: 20,
  },
  title: {
    fontSize: 36,
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
  label: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
    marginBottom: 8,
    marginLeft: 4,
  },
  regionContainer: {
    flexDirection: 'row',
    gap: 12,
    marginBottom: 16,
  },
  regionButton: {
    flex: 1,
    height: 44,
  },
  registerButton: {
    marginTop: 8,
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

