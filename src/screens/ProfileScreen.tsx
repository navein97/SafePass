import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { Shield, LogOut, User, Trophy, ChevronLeft } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';

export const ProfileScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<any>(null);

  useEffect(() => {
    loadProfile();
  }, []);

  const loadProfile = async () => {
    try {
      setLoading(true);
      const { profile: userProfile, error } = await AuthService.getUserProfile();
      
      if (error) {
        Alert.alert('Error', 'Failed to load profile');
        return;
      }

      setProfile(userProfile);
    } catch (error) {
      console.error('Error loading profile:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleLogout = async () => {
    // On web, use window.confirm; on mobile, use Alert.alert
    if (Platform.OS === 'web') {
      const confirmed = window.confirm('Are you sure you want to logout?');
      if (confirmed) {
        await AuthService.signOut();
        navigation.reset({
          index: 0,
          routes: [{ name: 'Login' }],
        });
      }
    } else {
      Alert.alert(
        t('auth.logout'),
        'Are you sure you want to logout?',
        [
          { text: 'Cancel', style: 'cancel' },
          { 
            text: 'Logout', 
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
        <StatusBar barStyle="light-content" backgroundColor="transparent" translucent />
        <ScrollView contentContainerStyle={styles.content} bounces={true} showsVerticalScrollIndicator={false}>
          <View style={styles.header}>
            <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
              <ChevronLeft color={colors.text.primary} size={28} />
            </TouchableOpacity>
            <Text style={styles.title}>{t('profile.title')}</Text>
          </View>

          {/* Profile Card */}
          <GlassCard style={styles.card}>
            <View style={styles.avatarContainer}>
              <LinearGradient
                colors={colors.gradients.primary as any}
                style={styles.avatar}
              >
                <User size={40} color={colors.text.primary} />
              </LinearGradient>
              <View>
                <Text style={styles.name}>{profile?.full_name || 'Driver'}</Text>
                <Text style={styles.id}>{profile?.employee_id || 'N/A'}</Text>
              </View>
            </View>
            
            <View style={styles.divider} />
            
            <View style={styles.infoRow}>
              <Text style={styles.label}>{t('profile.region')}</Text>
              <Text style={styles.value}>
                {profile?.region === 'MY' ? 'Malaysia (MY)' : 'Portugal (PT)'}
              </Text>
            </View>
          </GlassCard>

          {/* Safety Index */}
          <GlassCard style={styles.card}>
            <Text style={styles.cardTitle}>{t('home.safetyIndex')}</Text>
            <View style={styles.scoreContainer}>
              <Shield size={48} color={colors.primary.DEFAULT} />
              <Text style={styles.score}>{profile?.safety_index || 0}</Text>
            </View>
            <Text style={styles.scoreSubtext}>90-day rolling average</Text>
          </GlassCard>

          {/* Leaderboard Button */}
          <GlassButton
            title="View Leaderboard"
            onPress={() => navigation.navigate('ManagerQuickView')}
            icon={<Trophy color={colors.text.primary} size={20} />}
            style={styles.managerButton}
          />

          {/* Logout */}
          <GlassButton
            title="Logout"
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

const styles = StyleSheet.create({
  safeArea: {
    flex: 1,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  content: {
    padding: 24,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 24,
    marginTop: 10,
  },
  backButton: {
    marginRight: 12,
  },
  title: {
    fontSize: 32,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  card: {
    marginBottom: 24,
  },
  avatarContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 24,
  },
  avatar: {
    width: 64,
    height: 64,
    borderRadius: 32,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  name: {
    fontSize: typography.sizes.xl,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
  },
  id: {
    fontSize: typography.sizes.sm,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  divider: {
    height: 1,
    backgroundColor: 'rgba(255, 255, 255, 0.1)',
    marginBottom: 16,
  },
  infoRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  label: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  value: {
    color: colors.text.primary,
    fontFamily: typography.fonts.bold,
  },
  cardTitle: {
    fontSize: typography.sizes.base,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    marginBottom: 16,
  },
  scoreContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 16,
    marginBottom: 8,
  },
  score: {
    fontSize: 48,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textShadowColor: 'rgba(0, 122, 255, 0.5)',
    textShadowOffset: { width: 0, height: 0 },
    textShadowRadius: 10,
  },
  scoreSubtext: {
    color: colors.status.success,
    fontFamily: typography.fonts.medium,
  },
  managerButton: {
    marginBottom: 16,
  },
  logoutButton: {
    marginBottom: 24,
  },
});

