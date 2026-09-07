import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar, Dimensions, TextInput, RefreshControl } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Slider from '@react-native-community/slider';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { LogOut, User, Flame, Globe, Moon, Sun, Settings, Car, ChevronDown, ChevronUp, CreditCard, HelpCircle, Trophy, Award, Zap, CheckCircle2, Lock, X } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { BatchService } from '../services/batchService';
import { ScoringService } from '../services/scoringService';
import { PracticeService } from '../services/practiceService';
import { MilestoneService } from '../services/milestoneService';
import { CacheService, formatTimeAgo, isDataEqual } from '../services/cacheService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';
import { Toast } from '../components/Toast';
import Svg, { Circle } from 'react-native-svg';
import { CreateUserModal } from '../components/CreateUserModal';
import { CompanySettingsModal } from '../components/CompanySettingsModal';
import { CompanySettingsService } from '../services/companySettingsService';
import { PerformanceChart } from '../components/PerformanceChart';
import { Building, BookOpen } from 'lucide-react-native';
import { QuizAttempt } from '../types/models';
import { SubscriptionService } from '../services/subscriptionService';
import { supabase } from '../lib/supabase';
import { Validation } from '../utils/validation';
import { Modal } from 'react-native';

const { width: SCREEN_WIDTH } = Dimensions.get('window');


interface ProfileData {
  id: string;
  full_name?: string;
  employee_id?: string;
  region?: string;
  safety_index?: number;
  streak?: number;
  multiplier?: number;

  role?: 'staff' | 'manager';
  age?: string;
  vehicleType?: string;
  // Master User Fields
  email?: string;
  designation?: string;
  companyName?: string;
  address?: string;
  contactNumber?: string;
  managerLevel?: 1 | 2;
  operationalEffectiveness?: number | null;
  operationalDiscipline?: number | null;
  professionalConduct?: number | null;
  department?: string;
  division?: string;
  area?: string;
  totalScore?: number;
  current_batch?: number;
  total_batches_completed?: number;
  subscription_tier?: 'trial' | 'standard' | 'enterprise';
}


export const ProfileScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme, toggleTheme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<ProfileData | null>(null);
  const [quizHistory, setQuizHistory] = useState<any[]>([]);
  const [totalXP, setTotalXP] = useState(0);
  const [totalQuestionsAnswered, setTotalQuestionsAnswered] = useState(0);
  const [totalMCQsCount, setTotalMCQsCount] = useState(263);
  const [csiData, setCsiData] = useState<any>(null);
  const [milestoneSummary, setMilestoneSummary] = useState<any>(null);
  const [showAchievementsModal, setShowAchievementsModal] = useState(false);

  
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  const [vehicleTypesList, setVehicleTypesList] = useState<string[]>([]);
  
  // Master Profile State
  const [showMasterDetails, setShowMasterDetails] = useState(false);
  const [showTeamSettings, setShowTeamSettings] = useState(false);
  const [fullName, setFullName] = useState('');
  const [email, setEmail] = useState('');
  const [initialEmail, setInitialEmail] = useState('');
  const [designation, setDesignation] = useState('');
  const [companyName, setCompanyName] = useState('');
  const [address, setAddress] = useState('');
  const [contactNumber, setContactNumber] = useState('');
  
  // Manager State
  const [questionCount, setQuestionCount] = useState(5);
  const [timerDuration, setTimerDuration] = useState(5); // Default 5 mins
  const [difficultyParams, setDifficultyParams] = useState({ easy: 0, intermediate: 100, hard: 0 });

  /* Toast State */
  const [toastVisible, setToastVisible] = useState(false);
  const [toastMessage, setToastMessage] = useState('');
  const [toastType, setToastType] = useState<'success' | 'error' | 'info'>('success');
  
  // User Management
  const [showCreateUser, setShowCreateUser] = useState(false);
  const [showCompanySettings, setShowCompanySettings] = useState(false);
  const [hasNoPlan, setHasNoPlan] = useState(false);

  // SWR Caching & Last Updated State
  const [lastUpdatedTime, setLastUpdatedTime] = useState<number | null>(null);
  const [lastUpdatedText, setLastUpdatedText] = useState<string>('');
  const [refreshing, setRefreshing] = useState(false);

  const showToast = (message: string, type: 'success' | 'error' | 'info' = 'success') => {
    setToastMessage(message);
    setToastType(type);
    setToastVisible(true);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  const isManager = profile?.role === 'manager';
  const streakWeeks = profile?.streak || 0;

  // Live timer update for "Last updated X ago"
  useEffect(() => {
    if (!lastUpdatedTime) return;
    setLastUpdatedText(formatTimeAgo(lastUpdatedTime));
    const interval = setInterval(() => {
      setLastUpdatedText(formatTimeAgo(lastUpdatedTime));
    }, 30000);
    return () => clearInterval(interval);
  }, [lastUpdatedTime]);

  const onRefresh = async () => {
    setRefreshing(true);
    try {
      await loadProfile();
    } finally {
      setRefreshing(false);
    }
  };

  useEffect(() => {
    // Load immediately on mount
    loadProfile();

    // Also reload whenever the screen comes into focus
    const unsubscribe = navigation.addListener('focus', () => {
      loadProfile();
    });

    return unsubscribe;
  }, [navigation]);

  const loadProfile = async () => {
    // 1. Instant Cache-First Read (Stale-While-Revalidate)
    const cached = await CacheService.get<any>('profile_full_data');
    if (cached && cached.data) {
      const c = cached.data;
      if (c.profile) setProfile(c.profile);
      if (c.fullName) setFullName(c.fullName);
      if (c.email) { setEmail(c.email); setInitialEmail(c.email); }
      if (c.designation) setDesignation(c.designation);
      if (c.companyName) setCompanyName(c.companyName);
      if (c.address) setAddress(c.address);
      if (c.contactNumber) setContactNumber(c.contactNumber);
      if (c.age) setAge(c.age);
      if (c.vehicleType) setVehicleType(c.vehicleType);
      if (c.quizHistory) setQuizHistory(c.quizHistory);
      if (c.totalXP !== undefined) setTotalXP(c.totalXP);
      if (c.totalQuestionsAnswered !== undefined) setTotalQuestionsAnswered(c.totalQuestionsAnswered);
      if (c.csiData) setCsiData(c.csiData);
      if (c.milestoneSummary) setMilestoneSummary(c.milestoneSummary);
      if (c.totalMCQsCount) setTotalMCQsCount(c.totalMCQsCount);
      if (c.hasNoPlan !== undefined) setHasNoPlan(c.hasNoPlan);

      setLastUpdatedTime(cached.lastUpdated);
      setLastUpdatedText(formatTimeAgo(cached.lastUpdated));
      setLoading(false); // Immediate 0-wait render
    } else {
      setLoading(true); // Show skeleton/spinner only on cold start with 0 cache
    }

    // 2. Parallel Background Fetch with 5s Timeout (Fail silently)
    try {
      await CacheService.fetchWithTimeout(async () => {
        const { profile: userProfile, error } = await AuthService.getUserProfile();
        if (error || !userProfile) return;

        const { data: { user: authUser } } = await supabase.auth.getUser();
        const userEmail = authUser?.email || '';

        const baseProfile: ProfileData = {
          ...userProfile,
          streak: userProfile.streak || 0,
          email: userEmail,
          managerLevel: userProfile.manager_level,
          operationalEffectiveness: userProfile.component_scores?.operation ?? null,
          operationalDiscipline: userProfile.component_scores?.discipline ?? null,
          professionalConduct: userProfile.component_scores?.professionalism ?? null,
          totalScore: userProfile.total_score || 0,
          current_batch: userProfile.current_batch || 1,
          total_batches_completed: userProfile.total_batches_completed || 0,
          designation: userProfile.designation || '',
          companyName: userProfile.company_name || '',
          address: userProfile.address || '',
          contactNumber: userProfile.phone_number || '',
        };

        let updatedProfile = baseProfile;
        let freshQuizHistory: { value: number; label: string }[] = [];
        let freshXP = 0;
        let freshAnsweredQs = 0;
        let freshCsiData: any = null;
        let freshMilestones: any = null;
        let freshTotalMCQs = 263;
        let freshHasNoPlan = false;

        // Sync and fetch stats for driver
        if (userProfile.role !== 'manager' && userProfile.id) {
          await BatchService.syncProfileStats(userProfile.id);
          const { profile: refreshedProfile } = await AuthService.getUserProfile();
          if (refreshedProfile) {
            updatedProfile = {
              ...updatedProfile,
              ...refreshedProfile,
              operationalEffectiveness: refreshedProfile.component_scores?.operation ?? null,
              operationalDiscipline: refreshedProfile.component_scores?.discipline ?? null,
              professionalConduct: refreshedProfile.component_scores?.professionalism ?? null,
              safety_index: refreshedProfile.safety_index || 0,
              streak: refreshedProfile.streak || 0,
              totalScore: refreshedProfile.total_score || 0,
              total_batches_completed: refreshedProfile.total_batches_completed || 0,
            };
          }


          const [trends, xp, answeredQs, categoryTotalMCQs, csi, milestones] = await Promise.all([
            QuizService.getDailyTrends(userProfile.id),
            BatchService.getTotalXP(userProfile.id),
            BatchService.getTotalAnsweredQuestions(userProfile.id),
            BatchService.getTotalCategoryQuestions(userProfile.id),
            BatchService.getCumulativeSafetyIndex(userProfile.id),
            MilestoneService.getUserMilestones(userProfile.id),
          ]);

          freshQuizHistory = trends;
          freshXP = xp;
          freshAnsweredQs = answeredQs;
          freshCsiData = csi;
          freshMilestones = milestones;
          freshTotalMCQs = categoryTotalMCQs > 0 ? categoryTotalMCQs : 263;
        }

        if (userProfile.role === 'manager' && userProfile.company_id) {
          const subDetails = await SubscriptionService.getSubscriptionDetails(userProfile.company_id);
          freshHasNoPlan = subDetails?.subscription_tier === 'trial';
          if (subDetails) {
            updatedProfile = {
              ...updatedProfile,
              subscription_tier: subDetails.subscription_tier as any,
            };
          }
        }

        const freshData = {
          profile: updatedProfile,
          fullName: userProfile.full_name || '',
          email: userEmail,
          designation: userProfile.designation || '',
          companyName: userProfile.company_name || '',
          address: userProfile.address || '',
          contactNumber: userProfile.phone_number || '',
          age: userProfile.age ? String(userProfile.age) : '',
          vehicleType: userProfile.vehicle_type || '',
          quizHistory: freshQuizHistory,
          totalXP: freshXP,
          totalQuestionsAnswered: freshAnsweredQs,
          csiData: freshCsiData,
          milestoneSummary: freshMilestones,
          totalMCQsCount: freshTotalMCQs,
          hasNoPlan: freshHasNoPlan,
        };

        // Only update UI state and cache if fresh data differs from cached data
        if (!cached || !isDataEqual(cached.data, freshData)) {
          setProfile(updatedProfile);
          setFullName(freshData.fullName);
          setEmail(freshData.email);
          setInitialEmail(freshData.email);
          setDesignation(freshData.designation);
          setCompanyName(freshData.companyName);
          setAddress(freshData.address);
          setContactNumber(freshData.contactNumber);
          setAge(freshData.age);
          setVehicleType(freshData.vehicleType);
          setQuizHistory(freshQuizHistory);
          setTotalXP(freshXP);
          setTotalQuestionsAnswered(freshAnsweredQs);
          setCsiData(freshCsiData);
          setMilestoneSummary(freshMilestones);
          setTotalMCQsCount(freshTotalMCQs);
          setHasNoPlan(freshHasNoPlan);

          await CacheService.set('profile_full_data', freshData);
          const now = Date.now();
          setLastUpdatedTime(now);
          setLastUpdatedText(formatTimeAgo(now));
        }
      }, 5000);
    } catch (err) {
      // Background fetch failed or timed out — fail silently and keep showing cached data
      console.warn('[ProfileScreen] Background fetch failed, using cached data:', err);
    } finally {
      setLoading(false);
    }

    // Load dynamic vehicle types
    try {
      const types = await PracticeService.getVehicleTypes();
      if (types && types.length > 0) {
        setVehicleTypesList(types);
      }
    } catch (err) {
      console.error('Error fetching vehicle types in ProfileScreen:', err);
    }
  };

  const handleAgeChange = (text: string) => {
    setAge(text);
  };

  const handleVehicleSelect = (vehicle: string) => {
    setVehicleType(vehicle);
  };

  const handleSavePersonalDetails = async () => {
    if (!profile?.id) return;

    const sanitizedEmail = Validation.cleanEmail(email);
    if (sanitizedEmail && !Validation.isValidEmail(sanitizedEmail)) {
      showToast(t('auth.invalidEmail', 'Please enter a valid email address'), 'error');
      return;
    }

    try {
        const emailChanged = sanitizedEmail && sanitizedEmail !== initialEmail;

        // If email changed, update Supabase Auth user email first
        if (emailChanged) {
          const { error: authErr } = await supabase.auth.updateUser({ email: sanitizedEmail });
          if (authErr) {
            showToast(authErr.message, 'error');
            return;
          }
        }

        const { error } = await AuthService.updateProfile(profile.id, {
            full_name: fullName.trim(),
            age: parseInt(age) || null,
            designation: designation.trim(),
            company_name: companyName,
            address: address,
            phone_number: contactNumber
            // NOTE: Do NOT write email here. Email in profiles is only updated
            // by Supabase Auth after the user confirms the change via their email link.
        });
        
        if (error) throw error;
        
        // Refresh local state and persistent profile
        await loadProfile();

        if (emailChanged) {
          showToast(t('profile.emailUpdatePending', 'A confirmation link has been sent to your new email. Please verify it to complete the change.'), 'info');
        } else {
          showToast(t('profile.detailsSaved'), 'success');
        }
    } catch (error: any) {
        console.error('Save details error:', error);
        showToast(error.message || t('profile.detailsSaveError'), 'error');
    }
  };

  const handleSettingChange = (key: string, value: number) => {
    if (key === 'count') {
        setQuestionCount(value);
    } else if (key === 'timer') {
        setTimerDuration(value);
    }
  };

  const handleDifficultyChange = (level: 'easy' | 'intermediate' | 'hard', value: number) => {
      setDifficultyParams(prev => ({
          ...prev,
          [level]: value
      }));
  };

  const handleSaveSettings = async () => {
    try {
        const total = difficultyParams.easy + difficultyParams.intermediate + difficultyParams.hard;
        if (Math.abs(total - 100) > 1) { // Tolerate small rounding
            Alert.alert(t('common.error'), t('profile.difficultySumError', 'Difficulty percentages must sum to 100% (Current: {total}%)', { total }));
            return;
        }

        await AsyncStorage.setItem('QUIZ_QUESTION_COUNT', questionCount.toString());
        await AsyncStorage.setItem('QUIZ_TIMER_DURATION', timerDuration.toString());
        await AsyncStorage.setItem('QUIZ_DIFFICULTY_PARAMS', JSON.stringify(difficultyParams));
        showToast(t('profile.settingsSaved'), 'success');
    } catch (error) {
        console.error('Save error:', error);
        showToast(t('profile.settingsSaveError'), 'error');
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


  const renderProfileDetails = () => (
    <GlassCard style={styles.inputCard}>
                 <TouchableOpacity 
                    style={{ 
                        flexDirection: 'row', 
                        alignItems: 'center', 
                        justifyContent: 'space-between', 
                        marginBottom: showMasterDetails ? 16 : 0, 
                        padding: 16, 
                        backgroundColor: colors.background.subtle, 
                        borderRadius: 12,
                    }}
                    onPress={() => setShowMasterDetails(!showMasterDetails)}
                 >
                    <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12 }}>
                        <User size={20} color={colors.primary.DEFAULT} />
                        <Text style={{ fontSize: 16, fontFamily: typography.fonts.bold, color: colors.text.primary }}>
                            {t('profile.profileDetails')}
                        </Text>
                    </View>
                    {showMasterDetails ? <ChevronUp size={20} color={colors.text.secondary} /> : <ChevronDown size={20} color={colors.text.secondary} />}
                 </TouchableOpacity>

                 {showMasterDetails && (
                    <View style={{ marginBottom: 16 }}>
                        <Text style={styles.inputLabel}>{t('profile.fullName')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. John Doe"
                            placeholderTextColor={colors.text.tertiary}
                            value={fullName}
                            onChangeText={setFullName}
                        />

                        {isManager && profile?.managerLevel === 1 && (
                            <>
                                <Text style={styles.inputLabel}>{t('profile.email', 'Email Address')}</Text>
                                <TextInput 
                                    style={styles.textInput}
                                    placeholder="user@example.com"
                                    placeholderTextColor={colors.text.tertiary}
                                    keyboardType="email-address"
                                    autoCapitalize="none"
                                    autoCorrect={false}
                                    value={email}
                                    onChangeText={(text) => setEmail(Validation.cleanEmail(text))}
                                />
                            </>
                        )}
                        
                        <Text style={styles.inputLabel}>{t('profile.designation')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. Senior Driver"
                            placeholderTextColor={colors.text.tertiary}
                            value={designation}
                            onChangeText={setDesignation}
                        />
                        
                        <Text style={styles.inputLabel}>{t('profile.companyName')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. Transport Co."
                            placeholderTextColor={colors.text.tertiary}
                            value={companyName}
                            onChangeText={setCompanyName}
                        />

                        <Text style={styles.inputLabel}>{t('profile.address')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder={t('profile.addressPlaceholder', 'Full Address')}
                            placeholderTextColor={colors.text.tertiary}
                            value={address}
                            onChangeText={setAddress}
                        />

                        <Text style={styles.inputLabel}>{t('profile.contactNumber')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="+60..."
                            placeholderTextColor={colors.text.tertiary}
                            keyboardType="phone-pad"
                            value={contactNumber}
                            onChangeText={(text) => setContactNumber(Validation.cleanPhoneNumber(text))}
                        />

                        {/* Age - shown for all users inside Profile Details */}
                        {!isManager && (
                          <>
                            <Text style={styles.inputLabel}>{t('profile.age')}</Text>
                            <TextInput 
                               style={styles.textInput}
                               placeholder={t('profile.agePlaceholder')}
                               placeholderTextColor={colors.text.tertiary}
                               keyboardType="numeric"
                               value={age}
                               onChangeText={(text) => setAge(Validation.cleanNumericOnly(text))}
                            />
                          </>
                        )}

                        <GlassButton
                           title={t('common.save')}
                           onPress={handleSavePersonalDetails}
                           style={{ marginTop: 14 }}
                         />
                    </View>
                 )}
          </GlassCard>
  );

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
      <SafeAreaView edges={['top', 'left', 'right']} style={styles.safeArea}>
        <Toast 
            visible={toastVisible} 
            message={toastMessage} 
            type={toastType} 
            onHide={() => setToastVisible(false)} 
        />
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <ScrollView 
          contentContainerStyle={styles.content} 
          bounces={true} 
          showsVerticalScrollIndicator={false}
          refreshControl={
            <RefreshControl
              refreshing={refreshing}
              onRefresh={onRefresh}
              tintColor={colors.primary.DEFAULT}
              colors={[colors.primary.DEFAULT]}
            />
          }
        >
          
          {/* Header */}
          <View style={styles.header}>
            <View>
              <Text style={styles.title}>{t('profile.title')}</Text>
              {lastUpdatedText ? (
                <Text style={{ fontSize: 11, color: colors.text.tertiary, marginTop: 2, fontFamily: typography.fonts.regular }}>
                  {t('common.lastUpdated', 'Last updated')} {lastUpdatedText}
                </Text>
              ) : null}
            </View>
            <View style={styles.headerActions}>
               <TouchableOpacity 
                style={styles.settingsButton}
                onPress={toggleTheme}
              >
                 {theme === 'dark' ? (
                  <Sun color={colors.text.accent} size={24} />
                ) : (
                  <Moon color={colors.primary.DEFAULT} size={24} />
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
                <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 6, marginTop: 8 }}>
                  <View style={styles.regionBadge}>
                    <Text style={styles.regionText}>
                      {profile?.region === 'MY' ? `🇲🇾 ${t('common.malaysia')}` : profile?.region}
                    </Text>
                  </View>
                  {isManager && (
                    <View style={[
                      styles.regionBadge,
                      { 
                        backgroundColor: profile?.managerLevel === 1
                          ? 'rgba(225, 37, 124, 0.2)'
                          : 'rgba(100, 149, 237, 0.2)',
                        borderColor: profile?.managerLevel === 1
                          ? 'rgba(225, 37, 124, 0.5)'
                          : 'rgba(100, 149, 237, 0.5)',
                      }
                      ]}>
                        <Text style={[
                          styles.regionText,
                          { color: profile?.managerLevel === 1 ? '#E1257C' : '#6495ED' }
                        ]}>
                          {profile?.managerLevel === 1 ? t('profile.roles.masterUser') : t('profile.roles.manager')}
                        </Text>
                      </View>
                  )}
                  {!isManager && vehicleType ? (
                    <View style={[
                      styles.regionBadge,
                      { 
                        backgroundColor: 'rgba(100, 255, 180, 0.15)',
                        borderColor: 'rgba(100, 255, 180, 0.35)',
                      }
                    ]}>
                      <Text style={[styles.regionText, { color: '#4CAF96' }]}>
                        🚛 {vehicleType}
                      </Text>
                    </View>
                  ) : null}
                  {!isManager && (
                    <View style={{ flexDirection: 'row', alignItems: 'center', flexWrap: 'wrap', gap: 8, marginTop: 4 }}>
                      <Text style={{ fontSize: 13, fontFamily: typography.fonts.bold, color: colors.text.primary }}>
                        ⭐ {t('profile.overallScore', 'Overall Score')}: {csiData?.score !== null && csiData?.score !== undefined ? `${csiData.score}%` : '-'}
                      </Text>
                      {csiData?.rank && csiData.rank !== '-' ? (
                        <View style={[
                          styles.csiProfileBadge,
                          { 
                            backgroundColor: (csiData?.bandColor || '#3B82F6') + '20',
                            borderColor: csiData?.bandColor || '#3B82F6',
                            borderWidth: 1,
                            paddingHorizontal: 8,
                            paddingVertical: 2,
                            borderRadius: 6,
                          }
                        ]}>
                          <Text style={[styles.csiProfileBadgeText, { color: csiData?.bandColor || '#3B82F6', fontSize: 11, fontWeight: '700' }]}>
                            {csiData.rank}
                          </Text>
                        </View>
                      ) : null}
                    </View>
                  )}
                  {isManager && profile?.subscription_tier && (
                    <View style={[
                      styles.regionBadge,
                      { 
                        backgroundColor: profile.subscription_tier === 'trial' ? 'rgba(158, 158, 158, 0.2)' : 'rgba(100, 255, 218, 0.15)',
                        borderColor: profile.subscription_tier === 'trial' ? 'rgba(158, 158, 158, 0.5)' : 'rgba(100, 255, 218, 0.3)',
                      }
                      ]}>
                        <Text style={[
                          styles.regionText,
                          { color: profile.subscription_tier === 'trial' ? '#9E9E9E' : '#64FFDA' }
                        ]}>
                          {profile.subscription_tier === 'trial' ? t('billing.tierTrial') :
                           profile.subscription_tier === 'standard' ? t('billing.tierStandard') :
                           t('billing.tierEnterprise')}
                        </Text>
                      </View>
                  )}
                </View>
              </View>
            </View>
          </GlassCard>

          {/* Nudge Banner - Choose a Plan */}
          {profile?.role === 'manager' && profile?.managerLevel === 1 && hasNoPlan && (
            <TouchableOpacity 
              onPress={() => navigation.navigate('Billing')}
              activeOpacity={0.8}
            >
              <LinearGradient
                colors={[colors.primary.DEFAULT, '#6C63FF'] as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={{
                  borderRadius: 16,
                  padding: 20,
                  marginTop: 10,
                  marginBottom: 4,
                  flexDirection: 'row',
                  alignItems: 'center',
                  gap: 14,
                }}
              >
                <Text style={{ fontSize: 28 }}>🚀</Text>
                <View style={{ flex: 1 }}>
                  <Text style={{ color: '#FFF', fontSize: 16, fontFamily: typography.fonts.bold }}>
                    {t('profile.choosePlanTitle')}
                  </Text>
                  <Text style={{ color: 'rgba(255,255,255,0.8)', fontSize: 13, fontFamily: typography.fonts.regular, marginTop: 4 }}>
                    {t('profile.choosePlanSubtitle')}
                  </Text>
                </View>
                <Text style={{ color: '#FFF', fontSize: 20 }}>→</Text>
              </LinearGradient>
            </TouchableOpacity>
          )}

          {/* renderProfileDetails() goes here for manager */}
          {isManager && renderProfileDetails()}

          {/* Manager Settings */}
          {isManager && profile?.managerLevel === 1 ? (
            <GlassCard style={styles.inputCard}>
               {/* Level 1 Specific: Company Settings */}
               <TouchableOpacity style={styles.companySettingsButton} onPress={() => setShowCompanySettings(true)}>
                  <Building size={24} color={colors.text.primary} />
                  <Text style={styles.companySettingsText}>{t('profile.companySettings')}</Text>
               </TouchableOpacity>

               {/* Billing & Subscription - For Level 1 Master Users */}
               <TouchableOpacity 
                 style={[
                   styles.manageUsersButton, 
                   { 
                     marginTop: 0, 
                     marginBottom: 0,
                     backgroundColor: colors.mode === 'light' ? 'rgba(37, 99, 235, 0.1)' : 'rgba(96, 165, 250, 0.15)', 
                     borderWidth: 1, 
                     borderColor: colors.mode === 'light' ? 'rgba(37, 99, 235, 0.3)' : 'rgba(96, 165, 250, 0.4)' 
                   }
                 ]} 
                 onPress={() => navigation.navigate('Billing')}
               >
                  <CreditCard size={24} color={colors.mode === 'light' ? '#2563EB' : '#60A5FA'} />
                  <Text style={[styles.manageUsersText, { color: colors.mode === 'light' ? '#2563EB' : '#60A5FA' }]}>{t('profile.billing', 'Billing & Plans')}</Text>
               </TouchableOpacity>
            </GlassCard>
          ) : !isManager ? (
            <View>

             {/* Minimalist Milestone Banner */}
             <GlassCard style={{ marginBottom: 16 }}>
               <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', padding: 14 }}>
                 <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12, flex: 1 }}>
                   <View style={{
                     width: 44,
                     height: 44,
                     borderRadius: 22,
                     backgroundColor: colors.primary.DEFAULT + '20',
                     alignItems: 'center',
                     justifyContent: 'center'
                   }}>
                     <Trophy size={22} color={colors.primary.DEFAULT} />
                   </View>
                   <View style={{ flex: 1 }}>
                     <View style={{ flexDirection: 'row', alignItems: 'center', gap: 6 }}>
                       <Text style={{ fontSize: 15, fontFamily: typography.fonts.bold, color: colors.text.primary }}>
                         {t('profile.personalMilestones', 'Personal Milestones')}
                       </Text>
                     </View>
                     <Text style={{ fontSize: 12, fontFamily: typography.fonts.regular, color: colors.text.secondary, marginTop: 2 }} numberOfLines={1}>
                       {t('profile.tapToViewBadges', 'Tap to view achievement badges')}
                     </Text>
                   </View>
                 </View>

                 <TouchableOpacity
                   onPress={() => setShowAchievementsModal(true)}
                   style={{
                     backgroundColor: colors.primary.DEFAULT,
                     paddingHorizontal: 12,
                     paddingVertical: 8,
                     borderRadius: 10,
                   }}
                 >
                   <Text style={{ color: '#FFF', fontSize: 12, fontFamily: typography.fonts.bold }}>
                     {t('profile.viewBadges', 'View Badges')}
                   </Text>
                 </TouchableOpacity>
               </View>
             </GlassCard>

             {/* Driver Performance Dashboard */}
              {(() => {
                const pcScore = profile?.professionalConduct;
                const odScore = profile?.operationalDiscipline;
                const oeScore = profile?.operationalEffectiveness;

                const pcRating = ScoringService.getPerformanceRating(pcScore);
                const odRating = ScoringService.getPerformanceRating(odScore);
                const oeRating = ScoringService.getPerformanceRating(oeScore);

                const pcRatingText = t(pcRating.ratingKey, { defaultValue: pcRating.rating });
                const odRatingText = t(odRating.ratingKey, { defaultValue: odRating.rating });
                const oeRatingText = t(oeRating.ratingKey, { defaultValue: oeRating.rating });

                return (
                  <GlassCard style={styles.dashboardCard}>
                    {/* Dashboard Header */}
                    <View style={styles.dashboardHeader}>
                      <View style={styles.dashboardIconCircle}>
                        <Text style={{ fontSize: 18 }}>📊</Text>
                      </View>
                      <Text style={styles.dashboardTitle}>{t('profile.driverPerformanceIndex', 'Driver Performance Index')}</Text>
                    </View>

                    {/* Score Bars */}
                    <View style={styles.scoreSection}>
                      {/* Professional Conduct (PC) */}
                      <View style={styles.scoreRow}>
                        <View style={styles.scoreLabelRow}>
                          <View style={[styles.scoreDot, { backgroundColor: colors.primary.DEFAULT }]} />
                          <Text style={styles.scoreLabelText}>{t('profile.profConductWithCode', 'Professional Conduct (PC)')}</Text>
                          <View style={[styles.dimensionRatingBadge, { backgroundColor: `${pcRating.color}18`, borderColor: pcRating.color }]}>
                            <Text style={[styles.dimensionRatingText, { color: pcRating.color }]}>
                              {pcRatingText}
                            </Text>
                          </View>
                          <Text style={[styles.scoreValueText, { color: colors.primary.DEFAULT }]}>
                            {pcScore !== null && pcScore !== undefined ? `${Math.round(pcScore)}%` : t('ratings.na', 'N/A')}
                          </Text>
                        </View>
                        <View style={styles.scoreBarTrack}>
                          <LinearGradient
                            colors={colors.gradients.primary as any}
                            start={{ x: 0, y: 0 }}
                            end={{ x: 1, y: 0 }}
                            style={[
                              styles.scoreBarFill,
                              { width: pcScore !== null && pcScore !== undefined ? `${Math.min(Math.round(pcScore), 100)}%` : '0%' }
                            ]}
                          />
                        </View>
                      </View>

                      {/* Operational Discipline (OD) */}
                      <View style={styles.scoreRow}>
                        <View style={styles.scoreLabelRow}>
                          <View style={[styles.scoreDot, { backgroundColor: colors.mode === 'light' ? '#E64A19' : '#FF7043' }]} />
                          <Text style={styles.scoreLabelText}>{t('profile.opDisciplineWithCode', 'Operational Discipline (OD)')}</Text>
                          <View style={[styles.dimensionRatingBadge, { backgroundColor: `${odRating.color}18`, borderColor: odRating.color }]}>
                            <Text style={[styles.dimensionRatingText, { color: odRating.color }]}>
                              {odRatingText}
                            </Text>
                          </View>
                          <Text style={[styles.scoreValueText, { color: colors.mode === 'light' ? '#E64A19' : '#FF7043' }]}>
                            {odScore !== null && odScore !== undefined ? `${Math.round(odScore)}%` : t('ratings.na', 'N/A')}
                          </Text>
                        </View>
                        <View style={styles.scoreBarTrack}>
                          <LinearGradient
                            colors={colors.mode === 'light' ? ['#FF8A65', '#E64A19'] : ['#FF8A65', '#FF7043'] as any}
                            start={{ x: 0, y: 0 }}
                            end={{ x: 1, y: 0 }}
                            style={[
                              styles.scoreBarFill,
                              { width: odScore !== null && odScore !== undefined ? `${Math.min(Math.round(odScore), 100)}%` : '0%' }
                            ]}
                          />
                        </View>
                      </View>

                      {/* Operational Effectiveness (OE) */}
                      <View style={styles.scoreRow}>
                        <View style={styles.scoreLabelRow}>
                          <View style={[styles.scoreDot, { backgroundColor: colors.mode === 'light' ? '#2E7D32' : '#81C784' }]} />
                          <Text style={styles.scoreLabelText}>{t('profile.opEffectivenessWithCode', 'Operational Effectiveness (OE)')}</Text>
                          <View style={[styles.dimensionRatingBadge, { backgroundColor: `${oeRating.color}18`, borderColor: oeRating.color }]}>
                            <Text style={[styles.dimensionRatingText, { color: oeRating.color }]}>
                              {oeRatingText}
                            </Text>
                          </View>
                          <Text style={[styles.scoreValueText, { color: colors.mode === 'light' ? '#2E7D32' : '#81C784' }]}>
                            {oeScore !== null && oeScore !== undefined ? `${Math.round(oeScore)}%` : t('ratings.na', 'N/A')}
                          </Text>
                        </View>
                        <View style={styles.scoreBarTrack}>
                          <LinearGradient
                            colors={colors.mode === 'light' ? ['#66BB6A', '#2E7D32'] : ['#81C784', '#4CAF50'] as any}
                            start={{ x: 0, y: 0 }}
                            end={{ x: 1, y: 0 }}
                            style={[
                              styles.scoreBarFill,
                              { width: oeScore !== null && oeScore !== undefined ? `${Math.min(Math.round(oeScore), 100)}%` : '0%' }
                            ]}
                          />
                        </View>
                      </View>
                    </View>


                    {/* MCQ Progress Summary */}
                    <View style={styles.mcqProgressSection}>
                      <Text style={styles.mcqProgressLabel}>
                        {t('profile.totalMcqsCompleted', 'TOTAL MCQs COMPLETED')}
                      </Text>
                      <View style={styles.mcqProgressRow}>
                        <Text style={styles.mcqProgressValue}>
                          {totalQuestionsAnswered}
                        </Text>
                        <Text style={styles.mcqProgressTotal}>
                          / {totalMCQsCount}
                        </Text>
                      </View>
                      {/* Mini progress bar */}
                      <View style={styles.mcqMiniTrack}>
                        <LinearGradient
                          colors={[colors.primary.DEFAULT, colors.gradients.gold[1] as string] as any}
                          start={{ x: 0, y: 0 }}
                          end={{ x: 1, y: 0 }}
                          style={[
                            styles.mcqMiniFill,
                            { width: `${Math.min((totalQuestionsAnswered / (totalMCQsCount || 263)) * 100, 100)}%` }
                          ]}
                        />
                      </View>
                    </View>
                  </GlassCard>
                );
              })()}

             {/* Performance Chart */}
             <GlassCard style={{ marginBottom: 16 }}>
                <PerformanceChart 
                    userId={profile?.id}
                    data={
                        quizHistory && quizHistory.length > 0
                        ? quizHistory
                        : undefined
                    } 
                    allowedRanges={['1W', '1M', 'ALL']}
                />
             </GlassCard>

             {/* Batch Progress Card */}
             <GlassCard style={styles.streakCard}>
               <View style={styles.flameContainer}>
                 <LinearGradient
                   colors={[colors.primary.DEFAULT, colors.gradients.gold[1] as string]}
                   style={styles.flameGlow}
                 >
                   <BookOpen size={32} color="#FFF" />
                 </LinearGradient>
               </View>
               <Text style={styles.statValue}>
                 {profile?.total_batches_completed === 8 ? t('profile.statusComplete', 'Complete') : t('quiz.batchTitle', { number: profile?.current_batch || 1 })}
               </Text>
               <Text style={styles.statLabel}>{t('profile.currentProgress', 'Current Progress')}</Text>
               <Text style={[styles.statLabel, { marginTop: 8, color: colors.status.success }]}>
                 {t('profile.batchesCompleted', { count: profile?.total_batches_completed || 0 })}
               </Text>
             </GlassCard>

             {/* Profile Details for Driver */}
             {renderProfileDetails()}
             
             </View>
          ) : null}

          {/* Help Center */}
          <GlassButton
            title={t('help.centerTitle', 'Help Center')}
            onPress={() => navigation.navigate('HelpCenter')}
            icon={<HelpCircle color={colors.text.inverse} size={20} />}
            style={{ marginBottom: 16 }}
          />

          {/* Logout */}
          <GlassButton
            title={t('auth.logout')}
            onPress={handleLogout}
            variant="danger"
            icon={<LogOut color={colors.text.inverse} size={20} />}
            style={styles.logoutButton}
          />
        </ScrollView>
      </SafeAreaView>

      {/* Modals */}
      <CreateUserModal 
        visible={showCreateUser} 
        onClose={() => setShowCreateUser(false)}
        currentUserLevel={(profile?.managerLevel || 2) as 1 | 2}
        currentUserDepartment={profile?.department}
      />
      
      <CompanySettingsModal
         visible={showCompanySettings}
         onClose={() => setShowCompanySettings(false)}
      />

      {/* Achievements / Badges Modal */}
      <Modal
        visible={showAchievementsModal}
        animationType="slide"
        transparent={true}
        onRequestClose={() => setShowAchievementsModal(false)}
      >
        <View style={styles.modalOverlay}>
          <View style={[styles.modalContent, { backgroundColor: colors.background.card }]}>
            <View style={styles.modalHeader}>
              <View style={{ flexDirection: 'row', alignItems: 'center', gap: 10 }}>
                <Trophy size={24} color={colors.primary.DEFAULT} />
                <Text style={[styles.modalTitle, { color: colors.text.primary }]}>{t('profile.driverAchievements', 'Driver Achievements')}</Text>
              </View>
              <TouchableOpacity onPress={() => setShowAchievementsModal(false)} style={styles.closeBtn}>
                <X size={20} color={colors.text.secondary} />
              </TouchableOpacity>
            </View>

            <Text style={{ fontSize: 13, color: colors.text.secondary, marginHorizontal: 20, marginBottom: 14 }}>
              {t('profile.achievementsSubtitle', 'Earn badges by completing questions, finishing batches, building streaks, and advancing ranks!')}
            </Text>

            <ScrollView contentContainerStyle={{ paddingHorizontal: 20, paddingBottom: 24 }} showsVerticalScrollIndicator={false}>
              {milestoneSummary?.milestones.map((m: any) => (
                <View
                  key={m.id}
                  style={{
                    flexDirection: 'row',
                    alignItems: 'center',
                    backgroundColor: colors.background.subtle,
                    borderRadius: 14,
                    padding: 14,
                    marginBottom: 10,
                    borderWidth: 1,
                    borderColor: m.isUnlocked ? (m.color + '60') : colors.border,
                    opacity: m.isUnlocked ? 1 : 0.7,
                  }}
                >
                  <View
                    style={{
                      width: 44,
                      height: 44,
                      borderRadius: 22,
                      backgroundColor: (m.isUnlocked ? m.color : '#9E9E9E') + '20',
                      alignItems: 'center',
                      justifyContent: 'center',
                      marginRight: 12,
                    }}
                  >
                    {m.isUnlocked ? (
                      <Award size={22} color={m.color} />
                    ) : (
                      <Lock size={18} color={colors.text.tertiary} />
                    )}
                  </View>

                  <View style={{ flex: 1 }}>
                    <View style={{ flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between' }}>
                      <Text style={{ fontSize: 14, fontFamily: typography.fonts.bold, color: colors.text.primary }}>
                        {String(t(`milestones.${m.id}.title`, m.title))}
                      </Text>
                      {m.isUnlocked ? (
                        <View style={{ backgroundColor: '#10B98120', paddingHorizontal: 6, paddingVertical: 2, borderRadius: 4 }}>
                          <Text style={{ fontSize: 10, fontWeight: '700', color: '#10B981' }}>{t('profile.unlocked', 'UNLOCKED ✓')}</Text>
                        </View>
                      ) : (
                        <Text style={{ fontSize: 11, fontFamily: typography.fonts.medium, color: colors.text.tertiary }}>
                          {m.currentValue} / {m.threshold}
                        </Text>
                      )}
                    </View>

                    <Text style={{ fontSize: 12, color: colors.text.secondary, marginTop: 2, marginBottom: 6 }}>
                      {String(t(`milestones.${m.id}.description`, m.description))}
                    </Text>

                    {/* Progress bar */}
                    <View style={{ height: 5, backgroundColor: 'rgba(0,0,0,0.06)', borderRadius: 3, overflow: 'hidden' }}>
                      <View
                        style={{
                          height: '100%',
                          width: `${m.progressPercentage}%`,
                          backgroundColor: m.isUnlocked ? m.color : colors.primary.DEFAULT,
                          borderRadius: 3,
                        }}
                      />
                    </View>
                  </View>
                </View>
              ))}
            </ScrollView>
          </View>
        </View>
      </Modal>
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
  csiProfileBadge: {
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 8,
    borderWidth: 1,
    marginTop: 4,
  },
  csiProfileBadgeText: {
    fontSize: 12,
    fontFamily: typography.fonts.bold,
  },
  modalOverlay: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.6)',
    justifyContent: 'flex-end',
  },
  modalContent: {
    borderTopLeftRadius: 24,
    borderTopRightRadius: 24,
    maxHeight: '85%',
    paddingTop: 16,
  },
  modalHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: 20,
    paddingVertical: 12,
  },
  modalTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
  },
  closeBtn: {
    padding: 6,
    borderRadius: 20,
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
    borderColor: 'transparent',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  languageButton: {
    width: 44,
    height: 44,
    borderRadius: 22,
    backgroundColor: colors.background.card,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 1,
    borderColor: 'transparent',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  languageText: {
    fontFamily: typography.fonts.bold,
    fontSize: 14,
    color: colors.text.primary,
  },
  profileCard: {
    marginBottom: 16,
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

  logoutButton: {
    marginBottom: 16,
  },
  inputCard: {
    marginBottom: 16,
    padding: 20,
  },
  inputLabel: {
    fontSize: 14,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    marginBottom: 8,
  },
  textInput: {
    backgroundColor: colors.background.subtle,
    borderRadius: 12,
    padding: 12,
    color: colors.text.primary,
    fontFamily: typography.fonts.medium,
    marginBottom: 16,
    borderWidth: 1,
    borderColor: colors.border,
  },
  vehicleOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  vehicleOption: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: colors.border,
    backgroundColor: colors.background.subtle,
  },
  vehicleOptionSelected: {
    borderColor: colors.primary.DEFAULT,
    backgroundColor: `${colors.primary.light}20`,
  },
  vehicleText: {
    fontSize: 14,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  vehicleTextSelected: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
  },
  dopsContainer: {
    alignItems: 'center',
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 4,
  },
  sectionSubtitle: {
    fontSize: 12,
    color: colors.text.tertiary,
    marginBottom: 16,
  },
  ringsContainer: {
    flexDirection: 'row',
    justifyContent: 'center',
    gap: 8,
    flexWrap: 'wrap',
  },
  manageUsersButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    marginBottom: 20,
    backgroundColor: colors.text.primary,
    borderRadius: 12,
  },
  manageUsersText: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.background.default,
    marginLeft: 8,
  },
  companySettingsButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    marginBottom: 12,
    backgroundColor: 'transparent',
    borderRadius: 12,
    borderWidth: 1.5,
    borderColor: colors.text.primary,
  },
  companySettingsText: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginLeft: 8,
  },
  sliderContainer: {
    marginBottom: 16,
  },
  sliderLabelContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 4,
  },
  sliderValue: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  slider: {
    width: '100%',
    height: 40,
  },
  dopChartContainer: {
    marginTop: 8,
    width: '100%',
  },
  legendContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'center',
    gap: 12,
    marginTop: 12,
    marginBottom: 20,
    paddingHorizontal: 10,
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  legendColor: {
    width: 10,
    height: 10,
    borderRadius: 2,
  },
  legendLabel: {
    fontSize: 10,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  chartArea: {
    position: 'relative',
    width: '100%',
    paddingTop: 10,
    paddingBottom: 5,
    borderLeftWidth: 1,
    borderBottomWidth: 1,
    borderColor: colors.border,
  },
  gridLine: {
    position: 'absolute',
    top: 0,
    bottom: 0,
    width: 1,
    backgroundColor: colors.border,
    opacity: 0.5,
  },
  dashboardBarRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    height: 24,
  },
  dashboardBarTrack: {
    flex: 1,
    height: '100%',
    backgroundColor: 'transparent',
  },
  dashboardBarFill: {
    height: '100%',
  },
  dashboardBarValue: {
    fontSize: 11,
    fontFamily: typography.fonts.bold,
    color: colors.text.secondary,
    width: 35,
    textAlign: 'right',
  },
  chartBarRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
    gap: 8,
  },
  dashboardLabelContainer: {
    width: 100,
  },
  dashboardLabel: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  dashboardBarContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 10,
  },
  barRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 10,
    gap: 12,
  },
  barLabel: {
    width: 100,
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  barTrack: {
    flex: 1,
    height: 10,
    backgroundColor: colors.background.subtle,
    borderRadius: 5,
    overflow: 'hidden',
  },
  barFill: {
    height: '100%',
    borderRadius: 5,
  },
  barValue: {
    width: 35,
    fontSize: 12,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    textAlign: 'right',
  },

  // ── Performance Dashboard (Redesigned) ──
  dashboardCard: {
    marginBottom: 16,
    padding: 24,
  },
  dashboardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 10,
    marginBottom: 24,
  },
  dashboardIconCircle: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: `${colors.primary.light}20`,
    justifyContent: 'center',
    alignItems: 'center',
  },
  dashboardTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
  },
  scoreSection: {
    gap: 18,
  },
  scoreRow: {
    gap: 8,
  },
  scoreLabelRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  scoreDot: {
    width: 10,
    height: 10,
    borderRadius: 5,
  },
  scoreLabelText: {
    flex: 1,
    fontSize: 13,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
  },
  scoreValueText: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
  },
  scoreBarTrack: {
    height: 12,
    borderRadius: 6,
    backgroundColor: colors.background.subtle,
    overflow: 'hidden',
  },
  scoreBarFill: {
    height: '100%',
    borderRadius: 6,
  },

  // ── MCQ Progress ──
  mcqProgressSection: {
    marginTop: 24,
    paddingTop: 20,
    borderTopWidth: 1,
    borderTopColor: colors.border,
    alignItems: 'center',
  },
  mcqProgressLabel: {
    fontSize: 12,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    textTransform: 'uppercase',
    letterSpacing: 1,
  },
  mcqProgressRow: {
    flexDirection: 'row',
    alignItems: 'baseline',
    marginTop: 6,
    gap: 4,
  },
  mcqProgressValue: {
    fontSize: 28,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  mcqProgressTotal: {
    fontSize: 16,
    fontFamily: typography.fonts.medium,
    color: colors.text.tertiary,
  },
  mcqMiniTrack: {
    width: '60%',
    height: 6,
    borderRadius: 3,
    backgroundColor: colors.background.subtle,
    overflow: 'hidden',
    marginTop: 10,
  },
  mcqMiniFill: {
    height: '100%',
    borderRadius: 3,
  },
  dimensionRatingBadge: {
    paddingHorizontal: 7,
    paddingVertical: 2,
    borderRadius: 5,
    borderWidth: 1,
  },
  dimensionRatingText: {
    fontSize: 10,
    fontFamily: typography.fonts.bold,
  },
});

