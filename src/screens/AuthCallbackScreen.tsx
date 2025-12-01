import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ActivityIndicator } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { supabase } from '../lib/supabase';

export const AuthCallbackScreen = ({ navigation }: any) => {
  const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading');
  const [message, setMessage] = useState('Verifying your email...');

  useEffect(() => {
    handleAuthCallback();
  }, []);

  const handleAuthCallback = async () => {
    try {
      // Get the current session after email verification
      const { data: { session }, error } = await supabase.auth.getSession();

      if (error) throw error;

      if (session) {
        setStatus('success');
        setMessage('✅ Email verified successfully!');
        
        // Navigate to home after a short delay
        setTimeout(() => {
          navigation.replace('Home');
        }, 2000);
      } else {
        setStatus('success');
        setMessage('✅ Email verified! Please log in to continue.');
        
        // Navigate to login after a short delay
        setTimeout(() => {
          navigation.replace('Login');
        }, 2000);
      }
    } catch (error: any) {
      console.error('Auth callback error:', error);
      setStatus('error');
      setMessage('❌ Verification failed. Please try again.');
      
      // Navigate to login after a short delay
      setTimeout(() => {
        navigation.replace('Login');
      }, 3000);
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        {status === 'loading' && (
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
        )}
        
        <Text style={[
          styles.message,
          status === 'success' && styles.successMessage,
          status === 'error' && styles.errorMessage,
        ]}>
          {message}
        </Text>

        {status === 'loading' && (
          <Text style={styles.subMessage}>
            Please wait while we verify your email...
          </Text>
        )}
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 24,
  },
  message: {
    fontSize: typography.sizes['2xl'],
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'center',
    marginTop: 24,
  },
  successMessage: {
    color: colors.status.success,
  },
  errorMessage: {
    color: colors.status.danger,
  },
  subMessage: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
    marginTop: 12,
  },
});
