import React, { useState } from 'react';
import { View, Text, StyleSheet, StatusBar, TouchableOpacity, ScrollView, Alert, KeyboardAvoidingView, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { Lock, Eye, EyeOff } from 'lucide-react-native';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { AuthService } from '../services/authService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassInput } from '../components/ui/GlassInput';
import { GlassButton } from '../components/ui/GlassButton';
import { Toast } from '../components/Toast';

export const ResetPasswordScreen = ({ navigation }: any) => {
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');

  // Toast state
  const [toastVisible, setToastVisible] = useState(false);
  const [toastMessage, setToastMessage] = useState('');
  const [toastType, setToastType] = useState<'success' | 'error' | 'info'>('success');

  const handleUpdatePassword = async () => {
    if (!password) {
      setError('Please enter a new password');
      return;
    }

    if (password.length < 6) {
      setError('Password must be at least 6 characters');
      return;
    }

    if (password !== confirmPassword) {
      setError('Passwords do not match');
      return;
    }

    setLoading(true);
    setError('');

    const { error: updateError } = await AuthService.updatePassword(password);

    setLoading(false);

    if (updateError) {
      setError(updateError);
    } else {
        setToastType('success');
        setToastMessage('✅ Your password has been updated successfully.');
        setToastVisible(true);

        setTimeout(() => {
          navigation.replace('Login');
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
        >
          <ScrollView contentContainerStyle={styles.content}>
            <View style={styles.header}>
              <Text style={styles.title}>Reset Password</Text>
              <Text style={styles.subtitle}>Enter your new password below</Text>
            </View>

            <GlassCard style={styles.card}>
              <View style={styles.form}>
                {error ? (
                  <View style={styles.errorBanner}>
                    <Text style={styles.errorText}>{error}</Text>
                  </View>
                ) : null}

                <GlassInput
                  label="New Password"
                  placeholder="••••••••"
                  value={password}
                  onChangeText={(text) => {
                    setPassword(text);
                    setError('');
                  }}
                  secureTextEntry={!showPassword}
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
                  label="Confirm Password"
                  placeholder="••••••••"
                  value={confirmPassword}
                  onChangeText={(text) => {
                    setConfirmPassword(text);
                    setError('');
                  }}
                  secureTextEntry={!showPassword}
                  leftIcon={<Lock size={20} color={colors.text.secondary} />}
                />

                <GlassButton
                  title="Update Password"
                  onPress={handleUpdatePassword}
                  loading={loading}
                  style={styles.button}
                />
                
                <TouchableOpacity 
                   style={styles.cancelButton}
                   onPress={() => navigation.navigate('Login')}
                 >
                   <Text style={styles.cancelText}>Cancel</Text>
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
    marginBottom: 32,
    alignItems: 'center',
  },
  title: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
  },
  card: {
    width: '100%',
  },
  form: {
    gap: 16,
  },
  button: {
    marginTop: 8,
  },
  errorBanner: {
    backgroundColor: 'rgba(255, 59, 48, 0.1)',
    borderWidth: 1,
    borderColor: colors.status.danger,
    borderRadius: 8,
    padding: 12,
  },
  errorText: {
    color: colors.status.danger,
    fontSize: typography.sizes.sm,
    textAlign: 'center',
  },
  cancelButton: {
    alignItems: 'center',
    marginTop: 8,
    padding: 8,
  },
  cancelText: {
    color: colors.text.secondary,
    fontSize: typography.sizes.sm,
  },
});
