import React, { useMemo, useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, ActivityIndicator, Linking } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ArrowLeft, Crown, UserCheck, Car, HelpCircle, ChevronRight, MessageCircle } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
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
      title: t('help.masterUser'),
      icon: <Crown size={24} color={colors.primary.DEFAULT} />,
      content: [
        { title: t('help.masterStep1'), description: t('help.masterStep1Desc') },
        { title: t('help.masterStep2'), description: t('help.masterStep2Desc') },
        { title: t('help.masterStep3'), description: t('help.masterStep3Desc') },
        { title: t('help.masterStep4'), description: t('help.masterStep4Desc') },
        { title: t('help.masterStep5'), description: t('help.masterStep5Desc') },
        { title: t('help.masterStep6'), description: t('help.masterStep6Desc') },
      ]
    },
    {
      id: 'manager',
      title: t('help.manager'),
      icon: <UserCheck size={24} color={colors.status.info} />,
      content: [
        { title: t('help.managerStep1'), description: t('help.managerStep1Desc') },
        { title: t('help.managerStep2'), description: t('help.managerStep2Desc') },
        { title: t('help.managerStep3'), description: t('help.managerStep3Desc') },
        { title: t('help.managerStep4'), description: t('help.managerStep4Desc') },
      ]
    },
    {
      id: 'driver',
      title: t('help.driver'),
      icon: <Car size={24} color={colors.status.success} />,
      content: [
        { title: t('help.driverStep1'), description: t('help.driverStep1Desc') },
        { title: t('help.driverStep2'), description: t('help.driverStep2Desc') },
        { title: t('help.driverStep3'), description: t('help.driverStep3Desc') },
        { title: t('help.driverStep4'), description: t('help.driverStep4Desc') },
        { title: t('help.driverStep5'), description: t('help.driverStep5Desc') },
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
          <Text style={styles.title}>{t('help.centerTitle')}</Text>
          <View style={{ width: 44 }} />
        </View>

        <ScrollView 
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
        >
          <View style={styles.introCard}>
            <HelpCircle size={40} color={colors.primary.DEFAULT} style={{ marginBottom: 12 }} />
            <Text style={styles.introTitle}>{t('help.welcome')}</Text>
            <Text style={styles.introSubtitle}>
              {t('help.intro')}
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
            <GlassButton
              title="Contact Support on WhatsApp"
              onPress={() => Linking.openURL('https://wa.me/601120616323?text=Hi,%20I%20am%20from%20Driver%20360%20and%20need%20help.')}
              icon={<MessageCircle size={20} color="#FFF" />}
              style={{ width: '100%', marginBottom: 16 }}
            />
            <Text style={styles.footerText}>
              {t('help.footer')}
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
