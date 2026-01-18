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
import { MissionScreen } from '../screens/MissionScreen';
import { NotificationsScreen } from '../screens/NotificationsScreen';
import { LeaderboardScreen } from '../screens/LeaderboardScreen';

const Tab = createBottomTabNavigator();

interface TabIconProps {
  focused: boolean;
  color: string;
  size: number;
}

export function MainTabNavigator() {
  const { colors, theme } = useTheme();

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
        name="Social"
        component={SocialScreen}
        options={{
          tabBarIcon: ({ color, size }: TabIconProps) => (
            <Users color={color} size={size} />
          ),
        }}
      />
      <Tab.Screen
        name="Mission"
        component={MissionScreen}
        options={{
          tabBarIcon: ({ focused, size }: TabIconProps) => (
            <View style={[
              styles.centerIcon, 
              { 
                backgroundColor: colors.background.card,
                borderColor: colors.primary.DEFAULT 
              },
              focused && { backgroundColor: colors.primary.DEFAULT }
            ]}>
              <Target 
                color={focused ? colors.text.inverse : colors.primary.DEFAULT} 
                size={size + 4} 
              />
            </View>
          ),
          tabBarLabel: () => null,
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

