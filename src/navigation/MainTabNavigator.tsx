import React from 'react';
import { View, StyleSheet } from 'react-native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { 
  User, 
  Users, 
  Bell, 
  Trophy 
} from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { supabase } from '../lib/supabase';

// Screens
// Screens
import { ProfileScreen } from '../screens/ProfileScreen';
import { MissionScreen } from '../screens/MissionScreen';
import { NotificationsScreen } from '../screens/NotificationsScreen';
import { BatchLeaderboardScreen } from '../screens/BatchLeaderboardScreen';
import { ManagerQuickViewScreen } from '../screens/ManagerQuickViewScreen';
import { UserManagementScreen } from '../screens/UserManagementScreen';

const Tab = createBottomTabNavigator();

interface TabIconProps {
  focused: boolean;
  color: string;
  size: number;
}

import { AuthService } from '../services/authService';
import { useState, useEffect } from 'react';

import { useTranslation } from 'react-i18next'; // Add import

export function MainTabNavigator() {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [role, setRole] = useState<'staff' | 'manager' | null>(null);
  const [isLoading, setIsLoading] = useState(true);
  const [hasUnread, setHasUnread] = useState(false);

  useEffect(() => {
    checkRole();
    checkUnreadNotifications();
  }, []);

  const checkUnreadNotifications = async () => {
    try {
      const { data: { user } } = await supabase.auth.getUser();
      if (user) {
        const { count } = await supabase
          .from('notifications')
          .select('*', { count: 'exact', head: true })
          .eq('user_id', user.id)
          .eq('is_read', false);
        setHasUnread(Number(count) > 0);
      }
    } catch (error) {
      console.error('Failed to check unread notifications', error);
    }
  };

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
          shadowColor: '#000',
          shadowOffset: { width: 0, height: -4 },
          shadowOpacity: 0.1,
          shadowRadius: 10,
          elevation: 10,
        },
        tabBarActiveTintColor: colors.primary.DEFAULT, // Theme primary tint
        tabBarInactiveTintColor: colors.text.tertiary,
        tabBarShowLabel: true,
        tabBarLabelStyle: styles.tabLabel,
      }}
    >
      <Tab.Screen
        name="Profile"
        component={ProfileScreen}
        options={{
          tabBarLabel: t('navigation.profile'), // Translate label
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <User color={color} size={size} />
          ),
        }}
      />

      <Tab.Screen
        name="Mission"
        component={role === 'manager' ? UserManagementScreen : MissionScreen}
        options={{
          tabBarLabel: role === 'manager' ? t('navigation.team') : t('navigation.quiz'), // Translate label
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <Users color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Notifications"
        component={NotificationsScreen}
        listeners={{
          focus: () => {
            checkUnreadNotifications();
          },
        }}
        options={{
          tabBarLabel: t('navigation.notifications'), // Translate label
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <View>
              <Bell color={color} size={size} />
              {hasUnread && (
                <View
                  style={{
                    position: 'absolute',
                    top: -2,
                    right: -2,
                    width: 10,
                    height: 10,
                    borderRadius: 5,
                    backgroundColor: '#ef4444',
                    borderWidth: 1.5,
                    borderColor: colors.background.subtle,
                  }}
                />
              )}
            </View>
          ),
        }}
      />
      <Tab.Screen
        name="Leaderboard"
        component={role === 'manager' ? ManagerQuickViewScreen : BatchLeaderboardScreen}
        options={{
          tabBarLabel: t('navigation.leaderboard'), // Translate label
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

