import 'react-native-gesture-handler';
import React, { useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import './src/i18n'; // Initialize i18n

// Navigation
import { MainTabNavigator } from './src/navigation/MainTabNavigator';
import { navigationRef } from './src/navigation/navigationRef';
import { supabase } from './src/lib/supabase';

// Auth Screens
import { LoginScreen } from './src/screens/LoginScreen';
import { RegisterWorkspaceScreen } from './src/screens/RegisterWorkspaceScreen';
import { AuthCallbackScreen } from './src/screens/AuthCallbackScreen';
import { ForgotPasswordScreen } from './src/screens/ForgotPasswordScreen';
import { ResetPasswordScreen } from './src/screens/ResetPasswordScreen';
import { BillingScreen } from './src/screens/BillingScreen';

// Other Screens
import { QuizScreen } from './src/screens/QuizScreen';
import { ReviewScreen } from './src/screens/ReviewScreen';
import { ManagerQuickViewScreen } from './src/screens/ManagerQuickViewScreen';
import { UserManagementScreen } from './src/screens/UserManagementScreen';
import { HelpCenterScreen } from './src/screens/HelpCenterScreen';
import { TermsScreen } from './src/screens/TermsScreen';
import { DriverDetailScreen } from './src/screens/DriverDetailScreen';
import { SuperAdminScreen } from './src/screens/SuperAdminScreen';
import { colors } from './src/theme/colors';

import { NotificationService } from './src/services/notificationService';
import { 
  useFonts, 
  Inter_400Regular, 
  Inter_500Medium, 
  Inter_700Bold 
} from '@expo-google-fonts/inter';
import * as SplashScreen from 'expo-splash-screen';
import { useCallback } from 'react';
import { View, StyleSheet, Platform } from 'react-native';

import * as Linking from 'expo-linking';

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync();

const Stack = createNativeStackNavigator();

const linking = {
  prefixes: [Linking.createURL('/'), 'https://driver360-kappa.vercel.app', 'https://safepass-kappa.vercel.app', 'driver360://'],
  config: {
    screens: {
      Login: 'login',
      RegisterWorkspace: 'salsa',
      SuperAdmin: 'woof',
      AuthCallback: 'auth/callback',
      MainTabs: 'home',
      Quiz: 'quiz',
      Review: 'review',
      ManagerQuickView: 'manager',
      ResetPassword: 'reset-password',
      Billing: 'billing',
      HelpCenter: 'help',
      Terms: 'terms',
      DriverDetail: 'driver-detail',
    },
  },
};

import { ThemeProvider, useTheme } from './src/context/ThemeContext';

function AppContent() {
  const { colors, theme } = useTheme();

  useEffect(() => {
    // Listen for auth state changes globally
    const { data: authListener } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('🔔 Auth Event:', event);
      if (event === 'SIGNED_IN' && session) {
        // Re-register push token for the newly signed-in user
        // This ensures the device's push token is always associated with the current user
        console.log('📱 Registering push token for user:', session.user.id);
        await NotificationService.registerForPushNotificationsAsync();
      }
      if (event === 'PASSWORD_RECOVERY') {
        console.log('✅ PASSWORD_RECOVERY detected - navigating to ResetPassword');
        // Wait a small bit for navigation to be ready
        setTimeout(() => {
          if (navigationRef.isReady()) {
            navigationRef.navigate('ResetPassword');
          }
        }, 500);
      }
    });

    return () => {
      authListener.subscription.unsubscribe();
    };
  }, []);

  return (
    <View style={[styles.rootWrapper, { backgroundColor: colors.background.default }]}>
      <GestureHandlerRootView style={[styles.container, { backgroundColor: colors.background.default }]}>
        <SafeAreaProvider>
          <StatusBar style={theme === 'dark' ? 'light' : 'dark'} backgroundColor={colors.background.default} />
          <NavigationContainer 
            ref={navigationRef}
            linking={linking} 
            theme={{
            dark: theme === 'dark',
            colors: {
              primary: colors.primary.DEFAULT,
              background: colors.background.default,
              card: colors.background.card,
              text: colors.text.primary,
              border: colors.border,
              notification: colors.status.info,
            },
            fonts: {
               regular: { fontFamily: 'Inter-Regular', fontWeight: '400' },
               medium: { fontFamily: 'Inter-Medium', fontWeight: '500' },
               bold: { fontFamily: 'Inter-Bold', fontWeight: '700' },
               heavy: { fontFamily: 'Inter-Bold', fontWeight: '900' },
            }
          }}>
            <Stack.Navigator
              initialRouteName="Login"
              screenOptions={{
                headerShown: false,
                contentStyle: { backgroundColor: colors.background.default },
                animation: 'slide_from_right',
              }}
            >
              {/* Auth Stack */}
              <Stack.Screen name="Login" component={LoginScreen} />
              <Stack.Screen name="RegisterWorkspace" component={RegisterWorkspaceScreen} />
              <Stack.Screen name="AuthCallback" component={AuthCallbackScreen} />
              <Stack.Screen name="ForgotPassword" component={ForgotPasswordScreen} />
              <Stack.Screen name="ResetPassword" component={ResetPasswordScreen} />
              
              {/* Main App - Tab Navigator */}
              <Stack.Screen name="MainTabs" component={MainTabNavigator} />
              
              {/* Modal/Detail Screens */}
              <Stack.Screen name="Quiz" component={QuizScreen} />
              <Stack.Screen name="Review" component={ReviewScreen} />
              <Stack.Screen name="ManagerQuickView" component={ManagerQuickViewScreen} />
              <Stack.Screen name="UserManagement" component={UserManagementScreen} />
              <Stack.Screen name="Billing" component={BillingScreen} />
              <Stack.Screen name="HelpCenter" component={HelpCenterScreen} />
              <Stack.Screen name="Terms" component={TermsScreen} />
              <Stack.Screen name="DriverDetail" component={DriverDetailScreen} />
              <Stack.Screen name="SuperAdmin" component={SuperAdminScreen} />
            </Stack.Navigator>
          </NavigationContainer>
        </SafeAreaProvider>
      </GestureHandlerRootView>
    </View>
  );
}

export default function App() {
  const [fontsLoaded] = useFonts({
    'Inter-Regular': Inter_400Regular,
    'Inter-Medium': Inter_500Medium,
    'Inter-Bold': Inter_700Bold,
  });

  useEffect(() => {
    async function setupNotifications() {
      await NotificationService.registerForPushNotificationsAsync();
      await NotificationService.scheduleWeeklyReminder();
    }
    setupNotifications();
  }, []);

  const onLayoutRootView = useCallback(async () => {
    if (fontsLoaded) {
      await SplashScreen.hideAsync();
    }
  }, [fontsLoaded]);

  if (!fontsLoaded) {
    return null;
  }

  return (
    <ThemeProvider>
      <View style={{ flex: 1 }} onLayout={onLayoutRootView}>
        <AppContent />
      </View>
    </ThemeProvider>
  );
}

const styles = StyleSheet.create({
  rootWrapper: {
    flex: 1,
    alignItems: 'center',
  },
  container: {
    flex: 1,
    width: '100%',
    maxWidth: Platform.OS === 'web' ? 1000 : undefined,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 10 },
    shadowOpacity: 0.15,
    shadowRadius: 20,
    elevation: 8,
    overflow: 'hidden',
  },
});

