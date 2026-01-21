import React from 'react';
import { View, StyleSheet } from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { 
  User, 
  Users, 
  Target, 
  Bell, 
  Trophy 
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';

// Screens
import { ProfileScreen } from '../screens/ProfileScreen';
import { SocialScreen } from '../screens/SocialScreen';
import { QuizScreen } from '../screens/QuizScreen';
import { NotificationsScreen } from '../screens/NotificationsScreen';
import { LeaderboardScreen } from '../screens/LeaderboardScreen';
import { ManagerQuickViewScreen } from '../screens/ManagerQuickViewScreen';

const Tab = createBottomTabNavigator();

interface TabIconProps {
  focused: boolean;
  color: string;
  size: number;
}

import { AuthService } from '../services/authService';
import { useState, useEffect } from 'react';

export function MainTabNavigator() {
  const { colors, theme } = useTheme();
  const [role, setRole] = useState<'staff' | 'manager' | null>(null);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    checkRole();
  }, []);

  const checkRole = async () => {
    try {
      const { profile } = await AuthService.getUserProfile();
      if (profile?.role) {
        setRole(profile.role);
      } else {
        setRole('staff');
      }
    } catch (error) {
      console.error('Failed to load role', error);
      setRole('staff'); // Fallback
    } finally {
      setIsLoading(false);
    }
  };

  if (isLoading) {
    return (
      <View style={[styles.centerIcon, { borderWidth: 0, width: '100%', height: '100%' }]}>
        {/* Placeholder or simple view while determining role */}
      </View>
    );
  }

  return (
    <Tab.Navigator
      screenOptions={{
        headerShown: false,
        tabBarStyle: {
          backgroundColor: colors.background.subtle,
          borderTopWidth: 1,
          borderTopColor: colors.border,
          height: 80,
          paddingBottom: 12,
          paddingTop: 8,
        },
        tabBarActiveTintColor: colors.primary.DEFAULT,
        tabBarInactiveTintColor: colors.text.tertiary,
        tabBarShowLabel: true,
        tabBarLabelStyle: styles.tabLabel,
      }}
    >
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <User color={color} size={size} />
          ),
        }}
      />

      <Tab.Screen
        name="Mission"
        component={role === 'manager' ? ManagerQuickViewScreen : QuizScreen}
        options={{
          tabBarLabel: role === 'manager' ? 'Team' : 'Quiz',
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <Target color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Notifications"
        component={NotificationsScreen}
        options={{
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <Bell color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Leaderboard"
        component={LeaderboardScreen}
        options={{
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <Trophy color={color} size={size} />
          ),
        }}
      />
    </Tab.Navigator>
  );
}

const styles = StyleSheet.create({
  tabLabel: {
    fontFamily: 'Inter-Medium',
    fontSize: 11,
    marginTop: 2,
    marginBottom: 4,
  },
  centerIcon: {
    width: 56,
    height: 56,
    borderRadius: 28,
    borderWidth: 2,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: 20,
  },
});

