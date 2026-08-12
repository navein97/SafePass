import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ActivityIndicator, StatusBar, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { supabase } from '../lib/supabase';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';

import * as Linking from 'expo-linking';

export const AuthCallbackScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading');
  const [message, setMessage] = useState(t('auth.verifyingEmail'));

  useEffect(() => {
    // Check initial URL
    Linking.getInitialURL().then(url => {
      if (url) checkUrlForRecovery(url);
    });

    // Listen to incoming URLs
    const subscription = Linking.addEventListener('url', ({ url }) => {
      checkUrlForRecovery(url);
    });

    handleAuthCallback();

    return () => {
      subscription.remove();
    };
  }, []);

  const checkUrlForRecovery = (url: string) => {
    // Check if the URL contains type=recovery
    // Supabase usually sends it in the hash fragment: #access_token=...&type=recovery...
    // Or sometimes query params.
    if (url && url.includes('type=recovery')) {
       navigation.replace('ResetPassword');
       return true;
    }
    return false;
  };

  const handleAuthCallback = async () => {
    try {
      let isRecovery = false;
      if (Platform.OS === 'web' && typeof window !== 'undefined') {
        isRecovery = checkUrlForRecovery(window.location.href);
      }

      // Check for recovery flow first
      // Supabase handles the session exchange automatically when the link is clicked.
      // We just need to check if we are logged in.
      
      const { data: { session }, error } = await supabase.auth.getSession();

      if (error) throw error;

      if (session) {
        setStatus('success');
        setMessage(t('auth.successfullyVerified'));
        
        // If it wasn't a recovery, and we have a session, go home
        if (!isRecovery) {
          setTimeout(() => {
            navigation.replace('MainTabs');
          }, 1500);
        }
      } else {
        setStatus('success');
        setMessage(t('auth.emailVerifiedLogin'));
        
        setTimeout(() => {
          navigation.replace('Login');
        }, 2000);
      }
    } catch (error: any) {
      console.error('Auth callback error:', error);
      setStatus('error');
      setMessage(t('auth.verificationFailed'));
      
      setTimeout(() => {
        navigation.replace('Login');
      }, 3000);
    }
  };

  useEffect(() => {
    // Listen for auth state changes specifically for password recovery
    const { data: subscription } = supabase.auth.onAuthStateChange(async (event, session) => {
      if (event === 'PASSWORD_RECOVERY') {
         // This event is fired when the user clicks a password recovery link
         navigation.replace('ResetPassword');
      } else if (event === 'SIGNED_IN') {
         // Standard sign in (could be signup confirmation or recovery)
         // If recovery, PASSWORD_RECOVERY usually fires too?
         // Documentation says: PASSWORD_RECOVERY event is emitted when the user clicks a recovery link.
         // It also signs the user in.
         
         // We can check the URL for 'type=recovery' if on web/linking
         // But for safetfy, we can redirect to Home, and if they meant to reset pass, they can do it from profile?
         // No, they forgot it.
         
         // Let's assume if we are on this screen, and we get signed in, we go to Home
         // UNLESS we caught the recovery event.
      }
    });

    return () => {
      subscription.subscription.unsubscribe();
    };
  }, []);

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <View style={styles.content}>
          <GlassCard style={styles.card}>
            {status === 'loading' && (
              <ActivityIndicator size="large" color={colors.primary.DEFAULT} style={styles.spinner} />
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
                {t('auth.waitVerifying')}
              </Text>
            )}
          </GlassCard>
        </View>
      </SafeAreaView>
    </GradientBackground>
  );
};

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 24,
  },
  card: {
    width: '100%',
    alignItems: 'center',
    paddingVertical: 40,
  },
  spinner: {
    marginBottom: 24,
  },
  message: {
    fontSize: typography.sizes['2xl'],
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'center',
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

