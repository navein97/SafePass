import React, { useEffect } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import './src/i18n'; // Initialize i18n

// Screens
import { LoginScreen } from './src/screens/LoginScreen';
import { RegisterScreen } from './src/screens/RegisterScreen';
import { AuthCallbackScreen } from './src/screens/AuthCallbackScreen';
import { HomeScreen } from './src/screens/HomeScreen';
import { QuizScreen } from './src/screens/QuizScreen';
import { ReviewScreen } from './src/screens/ReviewScreen';
import { ProfileScreen } from './src/screens/ProfileScreen';
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
import { View } from 'react-native';

import * as Linking from 'expo-linking';

// Keep the splash screen visible while we fetch resources
SplashScreen.preventAutoHideAsync();

const Stack = createNativeStackNavigator();

const linking = {
  prefixes: [Linking.createURL('/'), 'https://safepass-kappa.vercel.app', 'safepass://'],
  config: {
    screens: {
      Login: 'login',
      Register: 'register',
      AuthCallback: 'auth/callback',
      Main: 'home',
      Quiz: 'quiz',
      Review: 'review',
      Profile: 'profile',
      ManagerQuickView: 'manager',
    },
  },
};

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
    <SafeAreaProvider onLayout={onLayoutRootView}>
      <StatusBar style="light" backgroundColor={colors.background.default} />
      <NavigationContainer linking={linking}>
        <Stack.Navigator
          initialRouteName="Login"
          screenOptions={{
            headerShown: false,
            contentStyle: { backgroundColor: colors.background.default },
            animation: 'slide_from_right',
          }}
        >
          <Stack.Screen name="Login" component={LoginScreen} />
          <Stack.Screen name="Register" component={RegisterScreen} />
          <Stack.Screen name="AuthCallback" component={AuthCallbackScreen} />
          <Stack.Screen name="Main" component={HomeScreen} />
          <Stack.Screen name="Quiz" component={QuizScreen} />
          <Stack.Screen name="Review" component={ReviewScreen} />
          <Stack.Screen name="Profile" component={ProfileScreen} />
          <Stack.Screen name="ManagerQuickView" component={ManagerQuickViewScreen} />
        </Stack.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
