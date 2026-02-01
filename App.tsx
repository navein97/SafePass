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

// Auth Screens
import { LoginScreen } from './src/screens/LoginScreen';
import { AuthCallbackScreen } from './src/screens/AuthCallbackScreen';
import { ForgotPasswordScreen } from './src/screens/ForgotPasswordScreen';
import { ResetPasswordScreen } from './src/screens/ResetPasswordScreen';

// Other Screens
import { QuizScreen } from './src/screens/QuizScreen';
import { ReviewScreen } from './src/screens/ReviewScreen';
import { ManagerQuickViewScreen } from './src/screens/ManagerQuickViewScreen';
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
import { View, StyleSheet } from 'react-native';

import * as Linking from 'expo-linking';

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync();

const Stack = createNativeStackNavigator();

const linking = {
  prefixes: [Linking.createURL('/'), 'https://safepass-kappa.vercel.app', 'safepass://'],
  config: {
    screens: {
      Login: 'login',
      AuthCallback: 'auth/callback',
      MainTabs: 'home',
      Quiz: 'quiz',
      Review: 'review',
      ManagerQuickView: 'manager',
      ResetPassword: 'reset-password',
    },
  },
};

import { ThemeProvider, useTheme } from './src/context/ThemeContext';

function AppContent() {
  const { colors, theme } = useTheme();

  return (
    <GestureHandlerRootView style={styles.container}>
      <SafeAreaProvider>
        <StatusBar style={theme === 'dark' ? 'light' : 'dark'} backgroundColor={colors.background.default} />
        <NavigationContainer linking={linking} theme={{
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
            <Stack.Screen name="AuthCallback" component={AuthCallbackScreen} />
            <Stack.Screen name="ForgotPassword" component={ForgotPasswordScreen} />
            <Stack.Screen name="ResetPassword" component={ResetPasswordScreen} />
            
            {/* Main App - Tab Navigator */}
            <Stack.Screen name="MainTabs" component={MainTabNavigator} />
            
            {/* Modal/Detail Screens */}
            <Stack.Screen name="Quiz" component={QuizScreen} />
            <Stack.Screen name="Review" component={ReviewScreen} />
            <Stack.Screen name="ManagerQuickView" component={ManagerQuickViewScreen} />
          </Stack.Navigator>
        </NavigationContainer>
      </SafeAreaProvider>
    </GestureHandlerRootView>
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
  container: {
    flex: 1,
  },
});

