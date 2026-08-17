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

  const faqData: FAQ[] = [
    {
      id: 'q1',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I register a new Company Workspace?',
      roles: ['master'],
      answer: [
        'This feature is strictly for business owners or fleet managers.',
        '1. On the main Login screen, tap on **Request Trial**.',
        '2. This will open WhatsApp. Send the pre-filled message with your company details.',
        '3. Our support team will create your Master Account and reply with your temporary login credentials.',
        '4. You can then log in and start adding your drivers in the Profile tab.'
      ]
    },
    {
      id: 'q2',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I log in for the first time as a Driver?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Drivers cannot create their own accounts. Your manager must create it for you.',
        '1. Ask your manager for your **Employee ID** and **Temporary Password**.',
        '2. Enter these details on the main Login screen.',
        '3. If you want to change your password later, ask your manager to change it for you.'
      ]
    },
    {
      id: 'q_password_reset',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I change my password?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Password changes depend on your role:',
        '• **Drivers and Managers:** You may ask the person who created your account for you to change your password from their Profile screen > Team Management > Click the key icon.',
        '• **Master Users:** Tap **Forgot Password** on the Login screen to receive a secure reset link via your email.'
      ]
    },
    {
      id: 'q3',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I edit my Profile details (Age, Vehicle)?',
      roles: ['driver'],
      answer: [
        '1. Tap the **Profile** tab at the bottom of the screen.',
        '2. Tap **Profile Details** to update your **Age** and **Vehicle Type**.',
        '3. Keeping this accurate helps the system tailor your training data.',
        '4. Tap **Save** when you are done.'
      ]
    },
    {
      id: 'q_master_profile',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I edit my Company Name and Address?',
      roles: ['master'],
      answer: [
        '1. Go to the **Profile** tab.',
        '2. Expand the **Profile Details** section.',
        '3. Here you can edit your Designation, Company Name, Address, and Contact Number.',
        '4. Tap **Save** to apply the changes.'
      ]
    },
    {
      id: 'q4',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'I forgot my password. How do I reset it?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'If you added an email address to your profile:',
        '1. Tap **Forgot Password** on the Login screen.',
        '2. Enter your email to receive a reset link.',
        '',
        'If you do NOT have an email address linked (common for Drivers):',
        '1. You must contact your Manager.',
        '2. Your Manager can go to **Profile > Team Management**, find your name, and reset your password instantly.'
      ]
    },
    {
      id: 'q5',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How do I take my daily quizzes (Live Mode)?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Live Mode is your official safety training and certification path.',
        '1. Tap the **Mission** tab at the bottom of the screen.',
        '2. Select an unlocked **Batch** (each batch has exactly 30 questions).',
        '3. Tap **Live Mode**. By system default, you can answer up to **3 questions per day**.',
        '4. The limit resets at **12 midnight** server time each day so you can continue your batch.',
        '5. Once you answer your daily questions, your status changes to "Compliant".'
      ]
    },
    {
      id: 'q_live_scoring',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How is my Live Mode score calculated?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Each question in Live Mode allows a maximum of **two attempts**:',
        '- Correct on **1st attempt** = **1.0 mark**.',
        '- Correct on **2nd attempt** = **0.5 marks**.',
        '- Both attempts wrong = **0 marks**.',
        'Once correct or after 2 failed attempts, the question is completed.',
        'Your batch is passing if your overall score is **60%** (minimum 18.0 marks out of 30).'
      ]
    },
    {
      id: 'q6',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'What is Practice Mode?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Practice Mode lets you study without safety score consequences.',
        '1. Select any batch and tap **Practice Mode**.',
        '2. You will be given **30 questions** in a row.',
        '3. You get immediate explanations for wrong answers.',
        '4. Your progress does NOT count towards Safety Shield or compliance metrics.'
      ]
    },
    {
      id: 'q7',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How do I unlock the next batch?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'To prevent rushing, the system locks advanced batches.',
        '1. You must complete the previous batch (e.g., Batch 1).',
        '2. Your **average score** for that batch must be **60% or higher** (minimum 18.0 marks).',
        '3. Once met, the next batch unlocks automatically.'
      ]
    },
    {
      id: 'q_daily_streaks',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'What is the Weekly Streak?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        '1. The weekly streak tracks consecutive days you log in and complete your daily training.',
        '2. Maintaining a streak boosts your profile visibility on the team leaderboard.'
      ]
    },
    {
      id: 'q_safety_shield',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'What is the Safety Shield?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'The Safety Shield is a visual compliance status shown on your profile.',
        '- **Strong (Green):** You are fully compliant and keep up with daily training.',
        '- **Needs Attention (Yellow):** You have missed a few days of daily training.',
        '- **Critically Low (Red):** You have not completed training for an extended period. Log in and do your missions to restore it!'
      ]
    },
    {
      id: 'q8',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I add a new Driver to my team?',
      roles: ['manager', 'master'],
      answer: [
        '1. Tap the **Team** tab at the bottom of the screen.',
        '2. Tap the **+ Add User** button at the top right.',
        '3. Fill in their Full Name, Employee ID, Department, Area, and select their Vehicle Type.',
        '4. The system automatically sets a default password: **123456**.',
        '5. Share the Employee ID and password with your driver.'
      ]
    },
    {
      id: 'q9',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I reset a Driver password?',
      roles: ['manager', 'master'],
      answer: [
        'If a driver forgets their password, you can reset it instantly:',
        '1. Go to the **Team** tab.',
        '2. Tap on the driver name to open their profile details.',
        '3. Tap the **Reset Password** button (key icon).',
        '4. Enter the new password and tap **Save**.'
      ]
    },
    {
      id: 'q10',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I send notifications or messages to Drivers?',
      roles: ['manager', 'master'],
      answer: [
        'You can send custom messages to individual drivers or the whole team:',
        '• **Direct Message:** Go to the **Team** tab -> Tap the Bell icon next to a driver name -> Type your message and send.',
        '• **Broadcast:** Tap the Loudspeaker icon at the top of the Team tab -> Compose your message and select the target group (Everyone, Managers, Drivers).'
      ]
    },
    {
      id: 'q_performance_dashboard',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I view team safety reports?',
      roles: ['manager', 'master'],
      answer: [
        '1. Tap the **Team** tab.',
        '2. The main dashboard shows average compliance, total active drivers, and a performance chart.',
        '3. You can click on any driver to see their individual batch progress and incorrect answers.'
      ]
    },
    {
      id: 'q_export_reports',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I export data to Excel?',
      roles: ['manager', 'master'],
      answer: [
        '1. Tap the **Leaderboard** tab.',
        '2. Tap **Export** at the top right.',
        '3. The system will compile safety scores, attempts, and compliance status into an `.xlsx` file and download it.'
      ]
    },
    {
      id: 'q11',
      category: 'Billing & Plans',
      icon: getCategoryIcon('Billing & Plans'),
      question: 'How do I upgrade my driver quota?',
      roles: ['master'],
      answer: [
        '1. Go to the **Profile** tab and tap **Billing & Plans**.',
        '2. Choose between **Standard** or **Enterprise** plans.',
        '3. Use the slider to select the exact number of driver slots you need.',
        '4. Tap **Upgrade** and complete your payment securely via Stripe.',
        '5. Your driver quota will update immediately.'
      ]
    },
    {
      id: 'q12',
      category: 'Billing & Plans',
      icon: getCategoryIcon('Billing & Plans'),
      question: 'How are subscription costs calculated?',
      roles: ['master'],
      answer: [
        'Subscriptions are billed annually per driver slot:',
        '- Standard: **RM 99 / driver / year**.',
        '- Enterprise: **RM 149 / driver / year**.',
        'You also get complimentary Manager accounts based on your driver count (e.g. 1 manager per 5 drivers).'
      ]
    },
    {
      id: 'q_free_trial',
      category: 'Billing & Plans',
      icon: getCategoryIcon('Billing & Plans'),
      question: 'Is there a free trial?',
      roles: ['master'],
      answer: [
        'Yes! All new workspaces start with a **3-Month Free Trial**.',
        '- Access is limited to Batch 1 (30 questions) and a maximum of 5 drivers.',
        '- You can upgrade to a paid plan at any time to unlock all 8 batches and expand your team.'
      ]
    },
    {
      id: 'q13',
      category: 'Notifications',
      icon: getCategoryIcon('Notifications'),
      question: 'Where do I view my notifications?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        '1. Tap the **Notifications** tab (Bell icon) at the bottom navigation bar.',
        '2. You will see direct messages from your manager, system announcements, and automated weekly reminders.'
      ]
    },
    {
      id: 'q_performance_chart',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How do I see my performance chart?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        '1. Open the **Profile** tab.',
        '2. Scroll down to the **Performance Chart** section to see a visual representation of your daily XP and performance trends over the past weeks.'
      ]
    },
    {
      id: 'q_milestone_tracker',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How do I see my milestone tracker?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        '1. Open the **Profile** tab.',
        '2. Scroll down to the **Milestone Tracker** section to view your earned milestones (e.g., number of quizzes completed, streak days).'
      ]
    }
  ];

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
              onPress={() => Linking.openURL('https://wa.me/601120616323?text=Hi,%20I%20need%20help%20with%20Driver%20360.')}
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

