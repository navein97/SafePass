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

  const getCategoryIcon = (category: string, size = 20) => {
    switch(category) {
      case 'Account & Setup': return <BookOpen size={size} color={colors.primary.DEFAULT} />;
      case 'Driver Training': return <TrendingUp size={size} color={colors.status.success} />;
      case 'Manager Tools': return <Users size={size} color={colors.status.info} />;
      case 'Billing & Plans': return <CreditCard size={size} color={colors.leaderboard.gold} />;
      case 'Notifications': return <Bell size={size} color={colors.status.warning} />;
      default: return <BookOpen size={size} color={colors.primary.DEFAULT} />;
    }
  };

  const faqData: FAQ[] = [
    // --- ACCOUNT & SETUP ---
    {
      id: 'q1',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I register a new Company Workspace?',
      roles: ['master'],
      answer: [
        'This feature is strictly for business owners or fleet managers.',
        '1. On the main Login screen, tap on **Register Your Company**.',
        '2. Enter your Company Name, your Admin Name, Email, and create a Password.',
        '3. Once successful, you will become the "Master User" for your organization.',
        '4. You can now log in and start adding your drivers in the Profile tab.'
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
        '3. If you want to change your password later, ask your manager to reset it for you.'
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
        '2. Under "Personal Details", you can update your **Age** and **Vehicle Type**.',
        '3. Keeping this accurate helps the system tailor your training data.',
        '4. Tap **Save Details** when you are done.'
      ]
    },
    {
      id: 'q_master_profile',
      category: 'Account & Setup',
      icon: getCategoryIcon('Account & Setup'),
      question: 'How do I edit my Company Name and Address?',
      roles: ['master'],
      answer: [
        '1. Tap the **Profile** tab at the bottom of the screen.',
        '2. Tap to expand the **Master User Details** section.',
        '3. You can edit your Designation, Company Name, Address, and Contact Number here.',
        '4. Tap **Save Details** when you are done.'
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

    // --- DRIVER TRAINING ---
    {
      id: 'q5',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How do I take my daily quizzes (Live Mode)?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Live Mode is your official daily training.',
        '1. Tap the **Mission** tab at the bottom of the screen.',
        '2. Select an unlocked **Batch**.',
        '3. Tap **Live Mode**. You will receive 3 questions for the day.',
        '4. Answer carefully! Your first attempt is recorded and affects your Performance Scores.',
        '5. Once completed, your status for the day will change to "Compliant".'
      ]
    },
    {
      id: 'q6',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'What is Practice Mode?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Practice Mode allows you to study without affecting your score.',
        '1. In the **Mission** tab, select a Batch and tap **Practice Mode**.',
        '2. You can take Practice quizzes as many times as you want.',
        '3. Use this to learn the material before taking the official Live Mode quiz.'
      ]
    },
    {
      id: 'q_review',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'Can I review my past mistakes?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'Yes! After completing a quiz, the system will show you your final score.',
        'You can scroll through the results to see exactly which questions you got right and wrong, along with the correct answers.'
      ]
    },

    {
      id: 'q8',
      category: 'Driver Training',
      icon: getCategoryIcon('Driver Training'),
      question: 'How does the Leaderboard work?',
      roles: ['driver', 'manager', 'master'],
      answer: [
        'The Leaderboard ranks everyone in your company based on their Total Score.',
        '1. Tap the **Leaderboard** tab.',
        '2. You can filter the rankings by specific **Batches** using the dropdown at the top.',
        '3. Top performers earn medals (Gold, Silver, Bronze) and the title of Safety Champion.'
      ]
    },

    // --- MANAGER TOOLS ---
    {
      id: 'q9',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I create a new Driver or Manager account?',
      roles: ['manager', 'master'],
      answer: [
        '1. Go to the **Profile** tab and tap **Team Management**.',
        '2. Tap the **Add User** button at the bottom of the screen.',
        '3. Enter the new user\'s Full Name, assign an Employee ID, and set a starting Password.',
        '4. Ensure you select the correct Role (Driver or Manager).',
        '5. Give the Employee ID and Password to the user so they can log in.'
      ]
    },
    {
      id: 'q_delete_user',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I delete or remove a user?',
      roles: ['manager', 'master'],
      answer: [
        '1. Go to the **Profile** tab and tap **Team Management**.',
        '2. Find the user you want to remove in the list.',
        '3. Tap the red **Trash Can** icon next to their name.',
        '4. Confirm the deletion. Note: This action is permanent and frees up space in your Driver Quota.'
      ]
    },
    {
      id: 'q10',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I track if my drivers completed their training?',
      roles: ['manager', 'master'],
      answer: [
        '1. Go to the **Profile** tab and tap **Manager Quick View**.',
        '2. This dashboard shows a weekly overview of your entire team.',
        '3. You can instantly see who is **COMPLIANT** (finished their quizzes) and who is **OVERDUE**.',
        '4. You can also view their current scores for the week.'
      ]
    },
    {
      id: 'q11',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I export training reports to Excel?',
      roles: ['manager', 'master'],
      answer: [
        'You can export data for HR or insurance compliance purposes.',
        '1. Go to the **Manager Quick View** screen via your Profile.',
        '2. Tap the **Download Icon** in the top right corner.',
        '3. The app will securely generate an Excel (.xlsx) file containing all current rankings, scores, and compliance statuses.'
      ]
    },
    {
      id: 'q12',
      category: 'Manager Tools',
      icon: getCategoryIcon('Manager Tools'),
      question: 'How do I send notifications to my team?',
      roles: ['manager', 'master'],
      answer: [
        '1. Go to **Profile > Team Management**.',
        '2. To message everyone, tap the **Megaphone icon** at the top right.',
        '3. To message a specific driver, tap the **Bell icon** next to their name.',
        '4. Type your message (e.g., "Please complete your training today") and send. They will receive it in their Notifications tab.'
      ]
    },

    // --- BILLING & ACCOUNT ---
    {
      id: 'q13',
      category: 'Billing & Plans',
      icon: getCategoryIcon('Billing & Plans'),
      question: 'How do I upgrade my company\'s subscription?',
      roles: ['master'],
      answer: [
        'Only the Master User can manage billing.',
        '1. Go to the **Profile** tab and tap **Billing & Plans**.',
        '2. Here you will see your current plan and driver quota.',
        '3. Select a new plan (e.g., Standard or Enterprise) to unlock more drivers and all training batches.',
        '4. You will be securely redirected to Stripe to complete the payment.'
      ]
    },
    {
      id: 'q14',
      category: 'Billing & Plans',
      icon: getCategoryIcon('Billing & Plans'),
      question: 'What happens if I reach my Driver Quota limit?',
      roles: ['manager', 'master'],
      answer: [
        'Your subscription determines how many active drivers you can have.',
        'If you reach the limit, you will not be able to add new users in Team Management.',
        'You must either delete inactive users to free up space, or the Master User must upgrade the plan in the Billing section.'
      ]
    },

    // --- NOTIFICATIONS ---
    {

        id: 'q15',
        category: 'Notifications',
        icon: getCategoryIcon('Notifications'),
        question: 'Where can I find my alerts and messages?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Tap the **Notifications** tab (the Bell icon at the bottom of the main screen).',
          '2. Here you will see system alerts and direct messages from your managers.',
          '3. Unread messages will have a highlight. Tap a message to mark it as read.'
        ]
      },
      // --- ADDITIONAL TOPICS ---
      {
        id: 'q_theme',
        category: 'Account & Setup',
        icon: getCategoryIcon('Account & Setup'),
        question: 'How do I toggle Dark/Light mode?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Open the **Profile** tab.',
          '2. Tap the **Theme** toggle button (Sun/Moon icon) at the top right.',
          '3. The app will instantly switch between Light and Dark themes.'
        ]
      },
      {
        id: 'q_language',
        category: 'Account & Setup',
        icon: getCategoryIcon('Account & Setup'),
        question: 'How do I change the app language?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Open the **Profile** tab.',
          '2. Tap the **Language** button.',
          '3. Select **English** or **Malay**. The interface will update immediately.'
        ]
      },
      {
        id: 'q_logout',
        category: 'Account & Setup',
        icon: getCategoryIcon('Account & Setup'),
        question: 'How do I log out of Driver 360?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Open the **Profile** tab.',
          '2. Scroll down and tap the **Logout** button.',
          '3. Confirm the logout prompt. You will be returned to the Login screen.'
        ]
      },

      {
        id: 'q_performance_chart',
        category: 'Driver Training',
        icon: getCategoryIcon('Driver Training'),
        question: 'How do I view my performance chart?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Open the **Profile** tab.',
          '2. Tap **Performance Chart** to see a visual representation of your daily XP and performance trends over the past weeks.'
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
          '2. Tap **Milestone Tracker** to view your earned milestones (e.g., number of quizzes completed, streak days).'
        ]
      },
      {
        id: 'q_quiz_history',
        category: 'Driver Training',
        icon: getCategoryIcon('Driver Training'),
        question: 'How can I see my past quiz history?',
        roles: ['driver', 'manager', 'master'],
        answer: [
          '1. Open the **Profile** tab.',
          '2. Tap **Quiz History** (or **Daily Trends**) to view scores and dates of your completed quizzes.'
        ]
      }
    ];


  // Formatting helper: Make text between ** ** bold
  const renderFormattedText = (text: string, index: number) => {
    if (text === '') return <View key={index} style={{ height: 8 }} />; // Empty line spacer

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

  // Filter logic
  const filteredFAQs = useMemo(() => {
    let result = faqData;

    // Filter by role if logged in
    if (profile) {
      const userRole = profile.manager_level === 1 ? 'master' : profile.role;
      result = result.filter(faq => faq.roles.includes(userRole));
    }

    // Filter by search query
    if (searchQuery.trim() !== '') {
      const query = searchQuery.toLowerCase();
      result = result.filter(faq => 
        faq.question.toLowerCase().includes(query) || 
        faq.answer.some(a => a.toLowerCase().includes(query))
      );
    } 
    // Filter by selected category (only if not searching)
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
          <Text style={styles.title}>Help & Support</Text>
          <View style={{ width: 44 }} />
        </View>

        {/* Search Bar */}
        <View style={styles.searchContainer}>
          <GlassCard contentStyle={styles.searchBar}>
            <Search size={20} color={colors.text.tertiary} />
            <TextInput 
              style={styles.searchInput}
              placeholder="Search for help (e.g., password, batches)"
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

        {/* Category Pills (Only show if not searching) */}
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
                <Text style={[styles.categoryPillText, !selectedCategory && styles.categoryPillTextActive]}>All Topics</Text>
              </TouchableOpacity>
              
              {categories.map(cat => {
                // Hide billing category if user is not master
                if (cat === 'Billing & Plans' && profile?.manager_level !== 1) return null;
                // Hide manager tools if user is driver
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
                    <Text style={[styles.categoryPillText, isActive && styles.categoryPillTextActive]}>{cat}</Text>
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
              <Text style={styles.emptyTitle}>No results found</Text>
              <Text style={styles.emptyText}>Try adjusting your search terms.</Text>
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
                      <Text style={styles.faqCategory}>{faq.category}</Text>
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
            <Text style={styles.footerTitle}>Can't find what you're looking for?</Text>
            <Text style={styles.footerSubtitle}>Our support team is ready to assist you.</Text>
            
            <GlassButton
              title="Chat with Support"
              onPress={() => Linking.openURL('https://wa.me/601120616323?text=Hi,%20I%20need%20help%20with%20Driver%20360.')}
              icon={<MessageCircle size={20} color="#FFF" />}
              style={styles.supportButton}
            />
            
            <Text style={styles.footerHours}>
              Available Mon-Fri, 9am - 6pm (MYT)
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

