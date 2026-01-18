import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar, Dimensions } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { Shield, LogOut, User, Flame, Globe, Moon, Sun } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';
import Svg, { Circle } from 'react-native-svg';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const SHIELD_SIZE = 120;
const SHIELD_STROKE_WIDTH = 10;
const SHIELD_RADIUS = (SHIELD_SIZE - SHIELD_STROKE_WIDTH) / 2;
const SHIELD_CIRCUMFERENCE = 2 * Math.PI * SHIELD_RADIUS;

interface ProfileData {
  full_name?: string;
  employee_id?: string;
  region?: string;
  safety_index?: number;
  streak?: number;
  multiplier?: number;
  shieldHealth?: number;
  role?: 'staff' | 'manager';
}

export const ProfileScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme, toggleTheme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<ProfileData | null>(null);

  const styles = useMemo(() => createStyles(colors), [colors]);

  const isManager = profile?.role === 'manager';
  const streakWeeks = profile?.streak || 0;
  const shieldHealth = profile?.shieldHealth || 100; // Percentage

  useEffect(() => {
    loadProfile();
  }, []);

  const loadProfile = async () => {
    try {
      setLoading(true);
      const { profile: userProfile, error } = await AuthService.getUserProfile();
      
      if (error) {
        Alert.alert('Error', t('common.errorLoading', 'Failed to load profile'));
        return;
      }

      setProfile({
        ...userProfile,
        streak: userProfile.streak || 0,
        shieldHealth: userProfile.shield_health || 100,
      });
    } catch (error) {
      console.error('Error loading profile:', error);
    } finally {
      setLoading(false);
    }
  };

  const toggleLanguage = () => {
    const nextLang = i18n.language === 'en' ? 'ms' : 'en';
    i18n.changeLanguage(nextLang);
  };

  const handleLogout = async () => {
    if (Platform.OS === 'web') {
      const confirmed = window.confirm(t('auth.logoutConfirm', 'Are you sure you want to logout?'));
      if (confirmed) {
        await AuthService.signOut();
        navigation.reset({
          index: 0,
          routes: [{ name: 'Login' }],
        });
      }
    } else {
      Alert.alert(
        t('auth.logout', 'Logout'),
        t('auth.logoutConfirm', 'Are you sure you want to logout?'),
        [
          { text: t('common.cancel', 'Cancel'), style: 'cancel' },
          { 
            text: t('auth.logout', 'Logout'), 
            style: 'destructive',
            onPress: async () => {
              await AuthService.signOut();
              navigation.reset({
                index: 0,
                routes: [{ name: 'Login' }],
              });
            }
          }
        ]
      );
    }
  };

  const shieldProgress = (shieldHealth / 100) * SHIELD_CIRCUMFERENCE;

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <ScrollView contentContainerStyle={styles.content} bounces={true} showsVerticalScrollIndicator={false}>
          
          {/* Header */}
          <View style={styles.header}>
            <Text style={styles.title}>{t('profile.title', 'Profile')}</Text>
            <View style={styles.headerActions}>
               <TouchableOpacity 
                style={styles.settingsButton}
                onPress={toggleTheme}
              >
                {theme === 'dark' ? (
                  <Sun color={colors.text.accent} size={24} />
                ) : (
                  <Moon color={colors.text.accent} size={24} />
                )}
              </TouchableOpacity>
              <TouchableOpacity 
                style={styles.languageButton}
                onPress={toggleLanguage}
              >
                 <Text style={styles.languageText}>{i18n.language === 'en' ? 'EN' : 'BM'}</Text>
              </TouchableOpacity>
            </View>
          </View>

          {/* Profile Card */}
          <GlassCard style={styles.profileCard}>
            <View style={styles.avatarContainer}>
              <LinearGradient
                colors={colors.gradients.gold as any}
                style={styles.avatar}
              >
                <User size={36} color={colors.text.inverse} />
              </LinearGradient>
              <View style={styles.profileInfo}>
                <Text style={styles.name}>{profile?.full_name || 'Driver'}</Text>
                <Text style={styles.id}>{profile?.employee_id || 'EMP-001'}</Text>
                <View style={styles.regionBadge}>
                  <Text style={styles.regionText}>
                    {profile?.region === 'MY' ? `🇲🇾 ${t('common.malaysia', 'Malaysia')}` : `🇵🇹 ${t('common.portugal', 'Portugal')}`}
                  </Text>
                </View>
              </View>
            </View>
          </GlassCard>

          {/* Gamification Stats Row - Only for Staff */}
          {!isManager && (
          <>
          {/* Weekly Streak Card */}
          <GlassCard style={styles.streakCard}>
            <View style={styles.flameContainer}>
              <LinearGradient
                colors={[colors.streak.flame, colors.streak.flameGlow]}
                style={styles.flameGlow}
              >
                <Flame size={32} color="#FFF" fill="#FFF" />
              </LinearGradient>
            </View>
            <Text style={styles.statValue}>{streakWeeks}</Text>
            <Text style={styles.statLabel}>{t('profile.weeklyStreak', 'Weekly Streak')}</Text>
          </GlassCard>

          {/* Safety Shield - Only for Staff */}
          <GlassCard style={styles.shieldCard}>
            <Text style={styles.shieldTitle}>{t('profile.safetyShield', 'Safety Shield')}</Text>
            <View style={styles.shieldContainer}>
              <Svg width={SHIELD_SIZE} height={SHIELD_SIZE} style={styles.shieldSvg}>
                {/* Background Circle */}
                <Circle
                  cx={SHIELD_SIZE / 2}
                  cy={SHIELD_SIZE / 2}
                  r={SHIELD_RADIUS}
                  stroke={colors.background.subtle}
                  strokeWidth={SHIELD_STROKE_WIDTH}
                  fill="transparent"
                />
                {/* Progress Circle */}
                <Circle
                  cx={SHIELD_SIZE / 2}
                  cy={SHIELD_SIZE / 2}
                  r={SHIELD_RADIUS}
                  stroke={shieldHealth > 50 ? colors.status.success : shieldHealth > 25 ? colors.status.warning : colors.status.danger}
                  strokeWidth={SHIELD_STROKE_WIDTH}
                  fill="transparent"
                  strokeDasharray={`${SHIELD_CIRCUMFERENCE * (shieldHealth / 100)} ${SHIELD_CIRCUMFERENCE}`}
                  strokeLinecap="round"
                  rotation={-90}
                  origin={`${SHIELD_SIZE / 2}, ${SHIELD_SIZE / 2}`}
                />
              </Svg>
              <View style={styles.shieldCenter}>
                <Shield 
                  size={36} 
                  color={shieldHealth > 50 ? colors.status.success : shieldHealth > 25 ? colors.status.warning : colors.status.danger} 
                />
                <Text style={styles.shieldPercent}>{shieldHealth}%</Text>
              </View>
            </View>
            <Text style={styles.shieldDescription}>
              {shieldHealth > 75 
                ? t('profile.shieldStrong', '🛡️ Shield is strong! Keep it up!')
                : shieldHealth > 50 
                  ? t('profile.shieldWarn', '⚠️ Shield needs attention')
                  : t('profile.shieldCritical', '🚨 Shield critically low! Complete missions!')}
            </Text>
          </GlassCard>
          </>
          )}

          {/* Logout */}
          <GlassButton
            title={t('auth.logout', 'Logout')}
            onPress={handleLogout}
            variant="danger"
            icon={<LogOut color={colors.text.primary} size={20} />}
            style={styles.logoutButton}
          />
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  content: {
    padding: 20,
    paddingBottom: 120,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 24,
    marginTop: 10,
  },
  headerActions: {
    flexDirection: 'row',
    gap: 12,
  },
  title: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  settingsButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: colors.background.card,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: colors.border,
  },
  languageButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: colors.background.card,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: colors.border,
  },
  languageText: {
    fontFamily: typography.fonts.bold,
    fontSize: 14,
    color: colors.text.primary,
  },
  profileCard: {
    marginBottom: 20,
  },
  avatarContainer: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    width: 72,
    height: 72,
    borderRadius: 36,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  profileInfo: {
    flex: 1,
  },
  name: {
    fontSize: 22,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
  },
  id: {
    fontSize: 14,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
  },
  regionBadge: {
    backgroundColor: colors.background.subtle,
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 12,
    alignSelf: 'flex-start',
  },
  regionText: {
    fontSize: 13,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    textAlign: 'center',
  },
  statValue: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'center',
  },
  statLabel: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    marginTop: 4,
    textAlign: 'center',
  },
  streakCard: {
    alignItems: 'center',
    paddingVertical: 20,
    marginBottom: 16,
  },
  flameContainer: {
    marginBottom: 8,
    alignItems: 'center',
    justifyContent: 'center',
  },
  flameGlow: {
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: 'center',
    alignItems: 'center',
  },
  shieldCard: {
    alignItems: 'center',
    paddingVertical: 24,
    marginBottom: 20,
  },
  shieldTitle: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 20,
    textAlign: 'center',
  },
  shieldContainer: {
    position: 'relative',
    width: SHIELD_SIZE,
    height: SHIELD_SIZE,
    justifyContent: 'center',
    alignItems: 'center',
    alignSelf: 'center',
  },
  shieldSvg: {
    position: 'absolute',
  },
  shieldCenter: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  shieldPercent: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginTop: 4,
  },
  shieldDescription: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    textAlign: 'center',
    marginTop: 16,
  },
  logoutButton: {
    marginTop: 8,
  },
});

