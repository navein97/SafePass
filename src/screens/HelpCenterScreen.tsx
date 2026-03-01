import React, { useMemo, useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, ActivityIndicator } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ArrowLeft, Crown, UserCheck, Car, HelpCircle, ChevronRight } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { AuthService } from '../services/authService';

export const HelpCenterScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);
  const [profile, setProfile] = useState<any>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadProfile();
  }, []);

  const loadProfile = async () => {
    try {
      const { profile: userProfile } = await AuthService.getUserProfile();
      setProfile(userProfile);
    } catch (error) {
      console.error('Failed to load profile for help center:', error);
    } finally {
      setLoading(false);
    }
  };

  const allGuides = [
    {
      id: 'master',
      title: t('help.masterUser', 'Master User Guide'),
      icon: <Crown size={24} color={colors.primary.DEFAULT} />,
      content: [
        { title: t('help.masterStep1', 'How to Manage Workspaces'), description: t('help.masterStep1Desc', 'Go to "Company Settings" to update your logo and company details.') },
        { title: t('help.masterStep2', 'How to Create & Delete Managers/Drivers'), description: t('help.masterStep2Desc', 'Go to "Team Management" -> tap "Add User" to create a Manager/Driver. To delete, tap the red trash can icon next to their name.') },
        { title: t('help.masterStep3', 'How to Reset User Passwords'), description: t('help.masterStep3Desc', 'Go to "Team Management" -> tap the Key icon next to a user\'s name -> type a new password and save.') },
        { title: t('help.masterStep4', 'How to Send Broadcast Notifications'), description: t('help.masterStep4Desc', 'Go to "Team Management" -> tap the Loudspeaker icon at the top -> enter your message and select "All Users".') },
        { title: t('help.masterStep5', 'How to Monitor Performance'), description: t('help.masterStep5Desc', 'Go to either Team or Leaderboard page to see a summary of your driver\'s Scores and who needs a Tune-Up.') },
        { title: t('help.masterStep6', 'How to Export Reports'), description: t('help.masterStep6Desc', 'Go to the Leaderboard -> click "Export" to download a full Excel report of all scores.') },
      ]
    },
    {
      id: 'manager',
      title: t('help.manager', 'Manager Guide'),
      icon: <UserCheck size={24} color={colors.status.info} />,
      content: [
        { title: t('help.managerStep1', 'How to Onboard Drivers'), description: t('help.managerStep1Desc', 'Go to "Team Management" -> tap "Add User" -> select "Driver" role and their vehicle type -> share the password with them.') },
        { title: t('help.managerStep2', 'How to Monitor Performance'), description: t('help.managerStep2Desc', 'Go to either Team or Leaderboard page to see a summary of your driver\'s Scores and who needs a Tune-Up.') },
        { title: t('help.managerStep3', 'How to Send a Normal Notification'), description: t('help.managerStep3Desc', 'Go to "Team Management" -> tap the Bell icon next to a specific driver\'s name -> send them a direct message.') },
        { title: t('help.managerStep4', 'How to Export Reports'), description: t('help.managerStep4Desc', 'Go to the Leaderboard -> click "Export" to download a full Excel report of your team\'s scores.') },
      ]
    },
    {
      id: 'driver',
      title: t('help.driver', 'Driver Guide'),
      icon: <Car size={24} color={colors.status.success} />,
      content: [
        { title: t('help.driverStep1', 'How to Take Assessments'), description: t('help.driverStep1Desc', 'Go to "Quiz" -> click "Start Quiz (Live)" to answer questions that affect your safety score.') },
        { title: t('help.driverStep2', 'How to Practice Safely'), description: t('help.driverStep2Desc', 'Go to "Quiz" -> click "Practice Mode" to practice questions without affecting your score.') },
        { title: t('help.driverStep3', 'How to Check the Leaderboard'), description: t('help.driverStep3Desc', 'Go to "Leaderboard" -> look at "All Time" views to see your rank among peers.') },
        { title: t('help.driverStep4', 'How to Read Notifications'), description: t('help.driverStep4Desc', 'Go to "Notifications" (Bell icon at the bottom tab) -> click on unread alerts to view assigned tasks or broadcast messages.') },
        { title: t('help.driverStep5', 'How to Update Your Profile'), description: t('help.driverStep5Desc', 'Go to "Profile" -> click on your Profile Details card to update your region or vehicle type.') },
      ]
    }
  ];

  const filteredGuides = useMemo(() => {
    if (!profile) return [];
    if (profile.role === 'manager') {
      return profile.manager_level === 1 
        ? allGuides.filter(g => g.id === 'master')
        : allGuides.filter(g => g.id === 'manager');
    }
    return allGuides.filter(g => g.id === 'driver');
  }, [profile, allGuides]);

  if (loading) {
    return (
      <GradientBackground>
        <SafeAreaView style={[styles.safeArea, { justifyContent: 'center', alignItems: 'center' }]}>
          <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
        </SafeAreaView>
      </GradientBackground>
    );
  }

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <View style={styles.header}>
          <TouchableOpacity 
            style={styles.backButton}
            onPress={() => navigation.goBack()}
          >
            <ArrowLeft size={24} color={colors.text.primary} />
          </TouchableOpacity>
          <Text style={styles.title}>{t('help.centerTitle', 'Help Center')}</Text>
          <View style={{ width: 44 }} />
        </View>

        <ScrollView 
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
        >
          <View style={styles.introCard}>
            <HelpCircle size={40} color={colors.primary.DEFAULT} style={{ marginBottom: 12 }} />
            <Text style={styles.introTitle}>{t('help.welcome', 'User Guide & FAQ')}</Text>
            <Text style={styles.introSubtitle}>
              {t('help.intro', 'Learn how to maximize your safety performance and manage your workspace effectively.')}
            </Text>
          </View>

          {filteredGuides.map((guide: any) => (
            <GlassCard key={guide.id} style={styles.guideCard}>
              <View style={styles.guideHeader}>
                <View style={[styles.iconContainer, { backgroundColor: guide.id === 'master' ? colors.primary.DEFAULT + '20' : guide.id === 'manager' ? colors.status.info + '20' : colors.status.success + '20' }]}>
                  {guide.icon}
                </View>
                <Text style={styles.guideTitle}>{guide.title}</Text>
              </View>

              <View style={styles.contentList}>
                {guide.content.map((item: any, index: number) => (
                  <View key={index} style={[styles.stepItem, index === guide.content.length - 1 && { borderBottomWidth: 0 }]}>
                    <View style={styles.stepHeader}>
                      <View style={styles.stepDot} />
                      <Text style={styles.stepTitle}>{item.title}</Text>
                    </View>
                    <Text style={styles.stepDescription}>{item.description}</Text>
                  </View>
                ))}
              </View>
            </GlassCard>
          ))}

          <View style={styles.footer}>
            <Text style={styles.footerText}>
              {t('help.footer', 'Need more help? Contact your administrator or support.')}
            </Text>
          </View>
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  container: { flex: 1 },
  safeArea: { flex: 1 },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 16,
    paddingVertical: 12,
  },
  backButton: {
    padding: 10,
    borderRadius: 12,
    backgroundColor: 'rgba(255, 255, 255, 0.05)',
  },
  title: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  scrollContent: {
    padding: 20,
    paddingBottom: 40,
  },
  introCard: {
    alignItems: 'center',
    marginBottom: 24,
    paddingHorizontal: 20,
  },
  introTitle: {
    fontSize: 24,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 8,
    textAlign: 'center',
  },
  introSubtitle: {
    fontSize: 15,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    textAlign: 'center',
    lineHeight: 22,
  },
  guideCard: {
    marginBottom: 20,
    padding: 16,
  },
  guideHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
    marginBottom: 16,
    paddingBottom: 12,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255, 255, 255, 0.05)',
  },
  iconContainer: {
    width: 44,
    height: 44,
    borderRadius: 12,
    justifyContent: 'center',
    alignItems: 'center',
  },
  guideTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  contentList: {
    gap: 16,
  },
  stepItem: {
    paddingVertical: 4,
  },
  stepHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
    marginBottom: 4,
  },
  stepDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: colors.primary.DEFAULT,
  },
  stepTitle: {
    fontSize: 15,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  stepDescription: {
    fontSize: 13,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 18,
    paddingLeft: 16,
  },
  footer: {
    marginTop: 10,
    alignItems: 'center',
  },
  footerText: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.tertiary,
    textAlign: 'center',
  },
});
