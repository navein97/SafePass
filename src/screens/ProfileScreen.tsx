import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import { colors } from '../theme/colors';
import { typography } from '../theme/typography';
import { Shield, LogOut, User, MapPin, Hash, Eye, Trophy, ChevronLeft } from 'lucide-react-native';
import { AuthService } from '../services/authService';

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
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={colors.primary.light} />
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.content} bounces={true}>
        <View style={styles.header}>
          <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
            <ChevronLeft color={colors.text.primary} size={28} />
          </TouchableOpacity>
          <Text style={styles.title}>{t('profile.title')}</Text>
        </View>

        {/* Profile Card */}
        <View style={styles.card}>
          <View style={styles.avatarContainer}>
            <View style={styles.avatar}>
              <User size={40} color={colors.text.primary} />
            </View>
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
        </View>

        {/* Safety Index */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>{t('home.safetyIndex')}</Text>
          <View style={styles.scoreContainer}>
            <Shield size={48} color={colors.primary.light} />
            <Text style={styles.score}>{profile?.safety_index || 0}</Text>
          </View>
          <Text style={styles.scoreSubtext}>90-day rolling average</Text>
        </View>

        {/* Leaderboard Button */}
        <TouchableOpacity 
          style={styles.managerButton}
          onPress={() => navigation.navigate('ManagerQuickView')}
        >
          <Trophy color={colors.text.inverse} size={24} />
          <Text style={styles.managerButtonText}>View Leaderboard</Text>
        </TouchableOpacity>

        {/* Logout */}
        <TouchableOpacity 
          style={styles.logoutButton}
          onPress={handleLogout}
        >
          <LogOut color={colors.status.danger} size={20} />
          <Text style={styles.logoutText}>Logout</Text>
        </TouchableOpacity>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: colors.background.default,
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
  },
  backButton: {
    marginRight: 12,
  },
  title: {
    fontSize: typography.sizes['3xl'],
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  card: {
    backgroundColor: colors.background.paper,
    borderRadius: 16,
    padding: 24,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: colors.border,
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
    backgroundColor: colors.background.subtle,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
    borderWidth: 2,
    borderColor: colors.border,
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
    backgroundColor: colors.border,
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
  },
  scoreSubtext: {
    color: colors.status.success,
    fontFamily: typography.fonts.medium,
  },
  managerButton: {
    backgroundColor: colors.primary.light,
    padding: 20,
    borderRadius: 12,
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    gap: 12,
    marginBottom: 24,
    shadowColor: colors.primary.light,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
  },
  managerButtonText: {
    color: colors.text.inverse,
    fontSize: typography.sizes.lg,
    fontFamily: typography.fonts.bold,
  },
  logoutButton: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    gap: 8,
    padding: 16,
  },
  logoutText: {
    color: colors.status.danger,
    fontFamily: typography.fonts.medium,
  },
});
