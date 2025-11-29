import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, Alert, StatusBar, ScrollView, KeyboardAvoidingView, Platform } from 'react-native';
import { Eye, EyeOff } from 'lucide-react-native';
import { useTranslation } from 'react-i18next';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { AuthService } from '../services/authService';
import { Region } from '../types/models';

import { Validation } from '../utils/validation';

export const RegisterScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [fullName, setFullName] = useState('');
  const [employeeId, setEmployeeId] = useState('');
  const [region, setRegion] = useState<Region>('MY');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  
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
      Alert.alert('Registration Failed', friendlyMsg);
    } else {
      Alert.alert(
        'Verify Your Email',
        'We have sent a verification link to ' + email + '.\n\nPlease check your inbox (and spam folder) and click the link to activate your account.',
        [{ text: 'OK, I will check', onPress: () => navigation.navigate('Login') }]
      );
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor={colors.background.default} />
      <KeyboardAvoidingView 
        style={{ flex: 1 }}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
        keyboardVerticalOffset={Platform.OS === 'ios' ? 0 : 20}
      >
        <ScrollView 
          contentContainerStyle={styles.content}
          keyboardShouldPersistTaps="handled"
          bounces={true}
        >
        <Text style={styles.title}>SafePass</Text>
        <Text style={styles.subtitle}>Create Driver Account</Text>

        <View style={styles.form}>
          {errors.general ? (
            <View style={styles.errorBanner}>
              <Text style={styles.errorBannerText}>{errors.general}</Text>
            </View>
          ) : null}

          <View>
            <Text style={styles.label}>Full Name</Text>
            <TextInput
              style={[styles.input, errors.fullName ? styles.inputError : null]}
              placeholderTextColor={colors.text.secondary}
              value={fullName}
              onChangeText={(text) => {
                setFullName(text);
                if (errors.fullName) setErrors(prev => ({ ...prev, fullName: '' }));
              }}
              autoCapitalize="words"
            />
            {errors.fullName ? <Text style={styles.errorText}>{errors.fullName}</Text> : null}
          </View>

          <View>
            <Text style={styles.label}>Employee ID</Text>
            <TextInput
              style={[styles.input, errors.employeeId ? styles.inputError : null]}
              placeholderTextColor={colors.text.secondary}
              value={employeeId}
              onChangeText={(text) => {
                setEmployeeId(text);
                if (errors.employeeId) setErrors(prev => ({ ...prev, employeeId: '' }));
              }}
              autoCapitalize="characters"
            />
            {errors.employeeId ? <Text style={styles.errorText}>{errors.employeeId}</Text> : null}
          </View>

          <View>
            <Text style={styles.label}>Email</Text>
            <TextInput
              style={[styles.input, errors.email ? styles.inputError : null]}
              placeholderTextColor={colors.text.secondary}
              value={email}
              onChangeText={(text) => {
                setEmail(text);
                if (errors.email) setErrors(prev => ({ ...prev, email: '' }));
              }}
              autoCapitalize="none"
              keyboardType="email-address"
            />
            {errors.email ? <Text style={styles.errorText}>{errors.email}</Text> : null}
          </View>

          <View>
            <Text style={styles.label}>Password</Text>
            <View style={styles.passwordContainer}>
              <TextInput
                style={[styles.passwordInput, errors.password ? styles.inputError : null]}
                placeholderTextColor={colors.text.secondary}
                value={password}
                onChangeText={(text) => {
                  setPassword(text);
                  if (errors.password) setErrors(prev => ({ ...prev, password: '' }));
                }}
                secureTextEntry={!showPassword}
              />
              <TouchableOpacity 
                style={styles.eyeIcon}
                onPress={() => setShowPassword(!showPassword)}
              >
                {showPassword ? (
                  <EyeOff size={20} color={colors.text.secondary} />
                ) : (
                  <Eye size={20} color={colors.text.secondary} />
                )}
              </TouchableOpacity>
            </View>
            {errors.password ? <Text style={styles.errorText}>{errors.password}</Text> : null}
          </View>

          <Text style={styles.label}>Region</Text>
          <View style={styles.regionContainer}>
            <TouchableOpacity
              style={[styles.regionButton, region === 'MY' && styles.regionButtonActive]}
              onPress={() => setRegion('MY')}
            >
              <Text style={[styles.regionText, region === 'MY' && styles.regionTextActive]}>
                Malaysia
              </Text>
            </TouchableOpacity>
            <TouchableOpacity
              style={[styles.regionButton, region === 'PT' && styles.regionButtonActive]}
              onPress={() => setRegion('PT')}
            >
              <Text style={[styles.regionText, region === 'PT' && styles.regionTextActive]}>
                Portugal
              </Text>
            </TouchableOpacity>
          </View>

          <TouchableOpacity 
            style={[styles.button, loading && styles.buttonDisabled]} 
            onPress={handleRegister}
            disabled={loading}
          >
            <Text style={styles.buttonText}>
              {loading ? 'Creating Account...' : 'Register'}
            </Text>
          </TouchableOpacity>

          <TouchableOpacity 
            style={styles.linkButton}
            onPress={() => navigation.navigate('Login')}
          >
            <Text style={styles.linkText}>
              Already have an account? <Text style={styles.linkTextBold}>Sign In</Text>
            </Text>
          </TouchableOpacity>
        </View>
        </ScrollView>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  content: {
    flexGrow: 1,
    padding: 24,
  },
  title: {
    fontSize: typography.sizes['4xl'],
    fontFamily: typography.fonts.bold,
    color: colors.primary.light,
    marginBottom: 8,
    textAlign: 'center',
    marginTop: 20,
  },
  subtitle: {
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    marginBottom: 32,
    textAlign: 'center',
  },
  form: {
    gap: 16,
  },
  label: {
    fontSize: typography.sizes.sm,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
    marginBottom: 4,
  },
  input: {
    backgroundColor: colors.background.paper,
    borderWidth: 1,
    borderColor: colors.border,
    borderRadius: 8,
    padding: 16,
    color: colors.text.primary,
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
  },
  passwordContainer: {
    position: 'relative',
  },
  passwordInput: {
    backgroundColor: colors.background.paper,
    borderWidth: 1,
    borderColor: colors.border,
    borderRadius: 8,
    padding: 16,
    paddingRight: 50,
    color: colors.text.primary,
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
  },
  eyeIcon: {
    position: 'absolute',
    right: 16,
    top: 16,
    padding: 4,
  },
  regionContainer: {
    flexDirection: 'row',
    gap: 12,
  },
  regionButton: {
    flex: 1,
    padding: 16,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: colors.border,
    backgroundColor: colors.background.paper,
    alignItems: 'center',
  },
  regionButtonActive: {
    borderColor: colors.primary.light,
    backgroundColor: 'rgba(59, 130, 246, 0.1)',
  },
  regionText: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  regionTextActive: {
    color: colors.primary.light,
    fontFamily: typography.fonts.bold,
  },
  button: {
    backgroundColor: colors.primary.DEFAULT,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
    marginTop: 16,
  },
  buttonDisabled: {
    opacity: 0.5,
  },
  buttonText: {
    color: colors.text.primary,
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.bold,
  },
  linkButton: {
    alignItems: 'center',
    marginTop: 16,
  },
  linkText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
  },
  linkTextBold: {
    color: colors.primary.light,
    fontFamily: typography.fonts.bold,
  },
  inputError: {
    borderColor: colors.status.danger,
  },
  errorText: {
    color: colors.status.danger,
    fontSize: typography.sizes.xs,
    marginTop: 4,
    fontFamily: typography.fonts.regular,
  },
  errorBanner: {
    backgroundColor: 'rgba(239, 68, 68, 0.1)',
    borderWidth: 1,
    borderColor: colors.status.danger,
    borderRadius: 8,
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
