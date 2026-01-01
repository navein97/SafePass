import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, ActivityIndicator, StatusBar } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { supabase } from '../lib/supabase';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';

export const AuthCallbackScreen = ({ navigation }: any) => {
  const [status, setStatus] = useState<'loading' | 'success' | 'error'>('loading');
  const [message, setMessage] = useState('Verifying your email...');

  useEffect(() => {
    handleAuthCallback();
  }, []);

  const handleAuthCallback = async () => {
    try {
      // Check for recovery flow first
      // Supabase handles the session exchange automatically when the link is clicked.
      // We just need to check if we are logged in.
      
      const { data: { session }, error } = await supabase.auth.getSession();

      if (error) throw error;

      if (session) {
        // If we have a session, check if it was a password recovery flow
        // The URL normally contains type=recovery, but deep linking might strip it or handle it before we see it.
        // However, we can also check if the user is here and we want to redirect them.
        // A simple heuristic: if we are confirmed, but came to this screen, we *might* be resetting password.
        // But wait, SignUp confirmation also logs you in.
        
        // Strategy: We can listen to the onAuthStateChange event for 'PASSWORD_RECOVERY'
        // But since we are already here, let's look at the URL that opened the app if possible?
        // Or relying on the fact that if we are here and we have a session, we usually go home.
        // But if the user requested a password reset, they clicked a link that said "Recover Password".
        
        // Ideally, we redirect to a ResetPassword screen if the path was /auth/callback?type=recovery
        // But checking URL params inside the component might be needed if using React Navigation with linking.
        
        // For now, let's try to detect if it's a recovery from the navigation route params if passed
        // Or just redirect to Home.
        // Wait, the USER complained "Redirects to login page". 
        // This implies they were NOT logged in, or the logic below `if (session)` failed
        // OR they were logged in, and `status` became 'success' -> navigation.replace('Home');
        // If they want to reset password, going to Home is also annoying if they don't know it.
        
        // Fix: We should check if the user was put into a password recovery state.
        // Supabase fires onAuthStateChange with 'PASSWORD_RECOVERY' event.
        
        setStatus('success');
        setMessage('✅ Successfully verified!');
        
        // If we are in a recovery flow, supabase fires a signed in event.
        // We can check if we want to support reset password. 
        // A tricky part: detecting if it's sign up or reset.
        
        // Let's rely on the URL or session.
        // Actually, let's wait for a brief moment to see if we navigate to ResetPassword from App.tsx listener
        // But we are the screen handling the callback.
        
        // NOTE: For now, I will add a check using onAuthStateChange within this component
        // to see if we get a PASSWORD_RECOVERY event.
      } else {
        setStatus('success');
        setMessage('✅ Email verified! Please log in to continue.');
        
        setTimeout(() => {
          navigation.replace('Login');
        }, 2000);
      }
    } catch (error: any) {
      console.error('Auth callback error:', error);
      setStatus('error');
      setMessage('❌ Verification failed. Please try again.');
      
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
                Please wait while we verify your email...
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

