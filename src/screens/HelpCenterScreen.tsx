import React, { useMemo, useState, useEffect } from 'react';
import { View, Text, StyleSheet, ScrollView, TouchableOpacity, ActivityIndicator, Linking, TextInput, LayoutAnimation, UIManager, Platform } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { SafeAreaView } from 'react-native-safe-area-context';
import { ArrowLeft, MessageCircle, Search, ChevronDown, ChevronUp, BookOpen, Users, CreditCard, TrendingUp, Bell, X } from 'lucide-react-native';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { AuthService } from '../services/authService';

if (Platform.OS === 'android' && UIManager.setLayoutAnimationEnabledExperimental) {
  UIManager.setLayoutAnimationEnabledExperimental(true);
}

interface FAQ {
  id: string;
  category: string;
  icon: React.ReactNode;
  question: string;
  answer: string[];
  roles: ('driver' | 'manager' | 'master')[];
}

export const HelpCenterScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors } = useTheme();
  const styles = useMemo(() => createStyles(colors), [colors]);

  const [profile, setProfile] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

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

  const toggleExpand = (id: string) => {
    LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
    setExpandedId(expandedId === id ? null : id);
  };

  const getCategoryKey = (category: string) => {
    switch (category) {
      case 'Account & Setup': return 'help.accountSetup';
      case 'Driver Training': return 'help.driverTraining';
      case 'Manager Tools': return 'help.managerTools';
      case 'Billing & Plans': return 'help.billingPlans';
      case 'Notifications': return 'help.notifications';
      default: return category;
    }
  };

  const getCategoryIcon = (category: string, size = 20) => {
    switch (category) {
      case 'Account & Setup': return <BookOpen size={size} color={colors.primary.DEFAULT} />;
      case 'Driver Training': return <TrendingUp size={size} color={colors.status.success} />;
      case 'Manager Tools': return <Users size={size} color={colors.status.info} />;
      case 'Billing & Plans': return <CreditCard size={size} color={colors.leaderboard.gold} />;
      case 'Notifications': return <Bell size={size} color={colors.status.warning} />;
      default: return <BookOpen size={size} color={colors.primary.DEFAULT} />;
    }
  };

  const faqMeta: { id: string; category: string; roles: ('driver' | 'manager' | 'master')[] }[] = [
    { id: 'q1', category: 'Account & Setup', roles: ['master'] },
    { id: 'q2', category: 'Account & Setup', roles: ['driver', 'manager', 'master'] },
    { id: 'q_password_reset', category: 'Account & Setup', roles: ['driver', 'manager', 'master'] },
    { id: 'q3', category: 'Account & Setup', roles: ['driver'] },
    { id: 'q_master_profile', category: 'Account & Setup', roles: ['master'] },
    { id: 'q4', category: 'Account & Setup', roles: ['driver', 'manager', 'master'] },
    { id: 'q5', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q_live_scoring', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q6', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q7', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q_daily_streaks', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q_safety_shield', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q_performance_chart', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q_milestone_tracker', category: 'Driver Training', roles: ['driver', 'manager', 'master'] },
    { id: 'q8', category: 'Manager Tools', roles: ['manager', 'master'] },
    { id: 'q9', category: 'Manager Tools', roles: ['manager', 'master'] },
    { id: 'q10', category: 'Manager Tools', roles: ['manager', 'master'] },
    { id: 'q_performance_dashboard', category: 'Manager Tools', roles: ['manager', 'master'] },
    { id: 'q_export_reports', category: 'Manager Tools', roles: ['manager', 'master'] },
    { id: 'q11', category: 'Billing & Plans', roles: ['master'] },
    { id: 'q12', category: 'Billing & Plans', roles: ['master'] },
    { id: 'q_free_trial', category: 'Billing & Plans', roles: ['master'] },
    { id: 'q13', category: 'Notifications', roles: ['driver', 'manager', 'master'] },
  ];

  const faqData: FAQ[] = useMemo(() => {
    return faqMeta.map(item => {
      const question = t(`help.faq.${item.id}.q`, '');
      const answer = t(`help.faq.${item.id}.a`, { returnObjects: true }) as string[];
      return {
        id: item.id,
        category: item.category,
        icon: getCategoryIcon(item.category),
        question: typeof question === 'string' ? question : '',
        answer: Array.isArray(answer) ? answer : [],
        roles: item.roles,
      };
    });
  }, [t, colors]);

  const renderFormattedText = (text: string, index: number) => {
    if (text === '') return <View key={index} style={{ height: 8 }} />;

    const parts = text.split(/(\*\*.*?\*\*)/g);
    return (
      <Text key={index} style={styles.answerText}>
        {parts.map((part, i) => {
          if (part.startsWith('**') && part.endsWith('**')) {
            return (
              <Text key={i} style={styles.boldText}>
                {part.slice(2, -2)}
              </Text>
            );
          }
          return part;
        })}
      </Text>
    );
  };

  const filteredFAQs = useMemo(() => {
    let result = faqData;

    if (profile) {
      const userRole = profile.manager_level === 1 ? 'master' : profile.role;
      result = result.filter(faq => faq.roles.includes(userRole));
    }

    if (searchQuery.trim() !== '') {
      const query = searchQuery.toLowerCase();
      result = result.filter(faq =>
        faq.question.toLowerCase().includes(query) ||
        faq.answer.some(a => a.toLowerCase().includes(query))
      );
    }
    else if (selectedCategory) {
      result = result.filter(faq => faq.category === selectedCategory);
    }

    return result;
  }, [profile, searchQuery, selectedCategory]);

  const categories = Array.from(new Set(faqData.map(item => item.category)));

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
          <Text style={styles.title}>{t('help.helpSupport', 'Help & Support')}</Text>
          <View style={{ width: 44 }} />
        </View>

        <View style={styles.searchContainer}>
          <GlassCard contentStyle={styles.searchBar}>
            <Search size={20} color={colors.text.tertiary} />
            <TextInput
              style={styles.searchInput}
              placeholder={t('help.searchPlaceholder', 'Search for help (e.g., password, batches)')}
              placeholderTextColor={colors.text.tertiary}
              value={searchQuery}
              onChangeText={setSearchQuery}
            />
            {searchQuery.length > 0 && (
              <TouchableOpacity onPress={() => setSearchQuery('')}>
                <X size={20} color={colors.text.tertiary} />
              </TouchableOpacity>
            )}
          </GlassCard>
        </View>

        {searchQuery.length === 0 && (
          <View style={styles.categoriesContainer}>
            <ScrollView horizontal showsHorizontalScrollIndicator={false} contentContainerStyle={styles.categoriesScroll}>
              <TouchableOpacity
                style={[styles.categoryPill, !selectedCategory && styles.categoryPillActive]}
                onPress={() => {
                  LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
                  setSelectedCategory(null);
                }}
              >
                <Text style={[styles.categoryPillText, !selectedCategory && styles.categoryPillTextActive]}>{t('help.allTopics', 'All Topics')}</Text>
              </TouchableOpacity>

              {categories.map(cat => {
                if (cat === 'Billing & Plans' && profile?.manager_level !== 1) return null;
                if (cat === 'Manager Tools' && profile?.role === 'driver') return null;

                const isActive = selectedCategory === cat;
                return (
                  <TouchableOpacity
                    key={cat}
                    style={[styles.categoryPill, isActive && styles.categoryPillActive]}
                    onPress={() => {
                      LayoutAnimation.configureNext(LayoutAnimation.Presets.easeInEaseOut);
                      setSelectedCategory(cat);
                    }}
                  >
                    <Text style={[styles.categoryPillText, isActive && styles.categoryPillTextActive]}>{t(getCategoryKey(cat), cat)}</Text>
                  </TouchableOpacity>
                );
              })}
            </ScrollView>
          </View>
        )}

        <ScrollView
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
        >
          {filteredFAQs.length === 0 ? (
            <View style={styles.emptyState}>
              <Search size={48} color={colors.text.tertiary} style={{ marginBottom: 16 }} />
              <Text style={styles.emptyTitle}>{t('help.noResults', 'No results found')}</Text>
              <Text style={styles.emptyText}>{t('help.adjustSearch', 'Try adjusting your search terms.')}</Text>
            </View>
          ) : (
            filteredFAQs.map((faq) => {
              const isExpanded = expandedId === faq.id;
              return (
                <GlassCard key={faq.id} style={styles.faqCard} contentStyle={{ padding: 0 }}>
                  <TouchableOpacity
                    style={styles.faqHeader}
                    onPress={() => toggleExpand(faq.id)}
                    activeOpacity={0.7}
                  >
                    <View style={[styles.faqIconContainer, { backgroundColor: colors.background.subtle }]}>
                      {faq.icon}
                    </View>
                    <View style={styles.faqTitleContainer}>
                      <Text style={styles.faqCategory}>{t(getCategoryKey(faq.category), faq.category)}</Text>
                      <Text style={styles.faqQuestion}>{faq.question}</Text>
                    </View>
                    {isExpanded ? (
                      <ChevronUp size={20} color={colors.text.tertiary} />
                    ) : (
                      <ChevronDown size={20} color={colors.text.tertiary} />
                    )}
                  </TouchableOpacity>

                  {isExpanded && (
                    <View style={styles.faqAnswerContainer}>
                      {faq.answer.map((line, index) => renderFormattedText(line, index))}
                    </View>
                  )}
                </GlassCard>
              );
            })
          )}

          <View style={styles.footer}>
            <Text style={styles.footerTitle}>{t('help.cantFind', "Can't find what you're looking for?")}</Text>
            <Text style={styles.footerSubtitle}>{t('help.supportReady', 'Our support team is ready to assist you.')}</Text>

            <GlassButton
              title={t('help.chatWithSupport', 'Chat with Support')}
              onPress={() => Linking.openURL('https://wa.me/601120616323?text=Hi,%20I%20need%20help%20with%20[Blank].')}
              icon={<MessageCircle size={20} color="#FFF" />}
              style={styles.supportButton}
            />

            <Text style={styles.footerHours}>
              {t('help.supportHours', 'Available Mon-Fri, 9am - 6pm (MYT)')}
            </Text>
          </View>
        </ScrollView>
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
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

  // Search Bar
  searchContainer: {
    paddingHorizontal: 20,
    marginBottom: 16,
  },
  searchBar: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 12,
    borderRadius: 12,
    gap: 12,
  },
  searchInput: {
    flex: 1,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    fontSize: 15,
  },

  // Categories
  categoriesContainer: {
    marginBottom: 16,
  },
  categoriesScroll: {
    paddingHorizontal: 20,
    gap: 10,
  },
  categoryPill: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    backgroundColor: colors.background.card,
    borderWidth: 1,
    borderColor: 'transparent',
  },
  categoryPillActive: {
    backgroundColor: colors.primary.DEFAULT + '20',
    borderColor: colors.primary.DEFAULT + '50',
  },
  categoryPillText: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  categoryPillTextActive: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
  },

  // Content
  scrollContent: {
    padding: 20,
    paddingBottom: 60,
  },
  emptyState: {
    alignItems: 'center',
    paddingVertical: 60,
  },
  emptyTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 8,
  },
  emptyText: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
  },

  // FAQ Cards
  faqCard: {
    marginBottom: 12,
    overflow: 'hidden',
  },
  faqHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    gap: 12,
  },
  faqIconContainer: {
    width: 40,
    height: 40,
    borderRadius: 10,
    justifyContent: 'center',
    alignItems: 'center',
  },
  faqTitleContainer: {
    flex: 1,
  },
  faqCategory: {
    fontSize: 11,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
    marginBottom: 4,
  },
  faqQuestion: {
    fontSize: 15,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    lineHeight: 22,
  },
  faqAnswerContainer: {
    padding: 16,
    paddingTop: 0,
    paddingLeft: 68, // Aligns text with the question, past the icon
  },
  answerText: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    lineHeight: 22,
    marginBottom: 6,
  },
  boldText: {
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },

  // Footer
  footer: {
    marginTop: 32,
    alignItems: 'center',
    paddingHorizontal: 20,
    paddingVertical: 24,
    backgroundColor: colors.background.card,
    borderRadius: 16,
  },
  footerTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
    textAlign: 'center',
  },
  footerSubtitle: {
    fontSize: 14,
    fontFamily: typography.fonts.regular,
    color: colors.text.secondary,
    marginBottom: 20,
    textAlign: 'center',
  },
  supportButton: {
    width: '100%',
    marginBottom: 16,
  },
  footerHours: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.tertiary,
    textAlign: 'center',
  },
});

