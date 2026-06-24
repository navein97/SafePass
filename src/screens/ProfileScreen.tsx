import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar, Dimensions, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Slider from '@react-native-community/slider';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { LogOut, User, Flame, Globe, Moon, Sun, Settings, Car, ChevronDown, ChevronUp, CreditCard, HelpCircle } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { QuizService } from '../services/quizService';
import { BatchService } from '../services/batchService';
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
import { MilestoneTracker } from '../components/MilestoneTracker';
import { Building, BookOpen, UserPlus } from 'lucide-react-native';
import { QuizAttempt } from '../types/models';
import { SubscriptionService } from '../services/subscriptionService';

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
  designation?: string;
  companyName?: string;
  address?: string;
  contactNumber?: string;
  managerLevel?: 1 | 2;
  operationalEffectiveness?: number;
  operationalDiscipline?: number;
  professionalConduct?: number;
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

  
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  
  // Master Profile State
  const [showMasterDetails, setShowMasterDetails] = useState(false);
  const [showTeamSettings, setShowTeamSettings] = useState(false);
  const [fullName, setFullName] = useState('');
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

  const showToast = (message: string, type: 'success' | 'error' | 'info' = 'success') => {
    setToastMessage(message);
    setToastType(type);
    setToastVisible(true);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  const isManager = profile?.role === 'manager';
  const streakWeeks = profile?.streak || 0;


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
    setLoading(true);
    
    // Set a safety timeout as a secondary defense
    const timeoutId = setTimeout(() => {
      setLoading(false);
    }, 10000);

    try {
      const { profile: userProfile, error } = await AuthService.getUserProfile();
      
      if (error) {
        console.error('Profile fetch error:', error);
        Alert.alert('Error', t('common.errorLoading', 'Failed to load profile'));
        return;
      }

      if (!userProfile) {
        Alert.alert(t('common.error'), t('profile.userNotFound'));
        return;
      }

      setProfile({
        ...userProfile,
        streak: userProfile.streak || 0,

        managerLevel: userProfile.manager_level,
        operationalEffectiveness: userProfile.component_scores?.operation || 0,
        operationalDiscipline: userProfile.component_scores?.discipline || 0,
        professionalConduct: userProfile.component_scores?.professionalism || 0,
        totalScore: userProfile.total_score || 0,
        current_batch: userProfile.current_batch || 1,
        total_batches_completed: userProfile.total_batches_completed || 0,
        designation: userProfile.designation || '',
        companyName: userProfile.company_name || '',
        address: userProfile.address || '',
        contactNumber: userProfile.phone_number || '', // Mapped from phone_number
      });

      // SYNC CHECK: Use userProfile.role directly (not the stale `isManager` state var)
      if (userProfile.role !== 'manager' && (userProfile.safety_index === 0 || !userProfile.component_scores) && userProfile.id) {
          console.log('[ProfileScreen] Scores are zero, syncing from batch history...');
          await BatchService.syncProfileStats(userProfile.id);
          // Re-fetch the profile to pick up the newly synced component_scores
          const { profile: refreshedProfile } = await AuthService.getUserProfile();
          if (refreshedProfile?.component_scores) {
              setProfile(prev => prev ? {
                  ...prev,
                  operationalEffectiveness: refreshedProfile.component_scores?.operation || 0,
                  operationalDiscipline: refreshedProfile.component_scores?.discipline || 0,
                  professionalConduct: refreshedProfile.component_scores?.professionalism || 0,
                  safety_index: refreshedProfile.safety_index || 0,
              } : prev);
          }
      }

      // Load Form State
      setFullName(userProfile.full_name || '');
      setDesignation(userProfile.designation || '');
      setCompanyName(userProfile.company_name || '');
      setAddress(userProfile.address || '');
      setContactNumber(userProfile.phone_number || '');

      // Load Daily Trends for Chart
      if (userProfile.id && userProfile.role !== 'manager') {
          const [trends, xp, answeredQs] = await Promise.all([
              QuizService.getDailyTrends(userProfile.id),
              BatchService.getTotalXP(userProfile.id),
              BatchService.getTotalAnsweredQuestions(userProfile.id)
          ]);
          setQuizHistory(trends);
          setTotalXP(xp);
          setTotalQuestionsAnswered(answeredQs);
      }

      // Check if Master User needs a plan
      console.log('[ProfileScreen] DEBUG profile:', {
        role: userProfile.role,
        manager_level: userProfile.manager_level,
        company_id: userProfile.company_id,
      });
      if (userProfile.role === 'manager' && userProfile.company_id) {
        const [stats, subDetails] = await Promise.all([
            CompanySettingsService.getCompanyStats(userProfile.company_id),
            SubscriptionService.getSubscriptionDetails(userProfile.company_id)
        ]);

        console.log('[ProfileScreen] Master User Stats:', stats);
        console.log('[ProfileScreen] Subscription Details:', subDetails);

        if (subDetails?.subscription_tier === 'trial') {
          setHasNoPlan(true);
        } else {
          setHasNoPlan(false);
        }

        if (subDetails) {
            setProfile(prev => prev ? ({
                ...prev,
                subscription_tier: subDetails.subscription_tier as any
            }) : prev);
        }
      }


      // Load local settings/data
      if (userProfile.role === 'manager') {
        const savedCount = await AsyncStorage.getItem('QUIZ_QUESTION_COUNT');
        const savedTimer = await AsyncStorage.getItem('QUIZ_TIMER_DURATION');
        const savedDiff = await AsyncStorage.getItem('QUIZ_DIFFICULTY_PARAMS');
        
        if (savedCount) setQuestionCount(parseInt(savedCount, 10));
        if (savedTimer) setTimerDuration(parseInt(savedTimer, 10));
        if (savedDiff) {
            try { setDifficultyParams(JSON.parse(savedDiff)); } catch (e) {}
        }
      } else {
        let initialAge = userProfile.age ? userProfile.age.toString() : '';
        let initialVehicle = userProfile.vehicle_type || '';

        if (!initialAge && userProfile.id) {
             const savedAge = await AsyncStorage.getItem(`USER_AGE_${userProfile.id}`);
             if (savedAge) initialAge = savedAge;
        }
        
        if (!initialVehicle && userProfile.id) {
             const savedVehicle = await AsyncStorage.getItem(`USER_VEHICLE_${userProfile.id}`);
             if (savedVehicle) initialVehicle = savedVehicle;
        }
        
        setAge(initialAge);
        setVehicleType(initialVehicle);
      }
    } catch (error) {
      console.error('Fatal loadProfile error:', error);
      Alert.alert(t('common.systemError'), t('common.unexpectedErrorOccurred'));
    } finally {
      clearTimeout(timeoutId);
      setLoading(false);
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
    try {
        const { error } = await AuthService.updateProfile(profile.id, {
            full_name: fullName.trim(),
            age: parseInt(age) || null,
            vehicle_type: vehicleType,
            designation: designation.trim(),
            company_name: companyName,
            address: address,
            phone_number: contactNumber
        });
        
        if (error) throw error;
        
        // Refresh local state and persistent profile
        await loadProfile();
        showToast(t('profile.detailsSaved'), 'success');
    } catch (error) {
        console.error('Save details error:', error);
        showToast(t('profile.detailsSaveError'), 'error');
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
        <Toast 
            visible={toastVisible} 
            message={toastMessage} 
            type={toastType} 
            onHide={() => setToastVisible(false)} 
        />
        <StatusBar barStyle={theme === 'dark' ? "light-content" : "dark-content"} backgroundColor="transparent" translucent />
        <ScrollView contentContainerStyle={styles.content} bounces={true} showsVerticalScrollIndicator={false}>
          
          {/* Header */}
          <View style={styles.header}>
            <Text style={styles.title}>{t('profile.title')}</Text>
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

          {/* Master Profile Details - For ALL Users */}
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
                            placeholder="Full Address"
                            placeholderTextColor={colors.text.tertiary}
                            value={address}
                            onChangeText={setAddress}
                        />

                        <Text style={styles.inputLabel}>{t('profile.contactNumber')}</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="+60..."
                            placeholderTextColor={colors.text.tertiary}
                            value={contactNumber}
                            onChangeText={setContactNumber}
                        />

                        {/* Age and Vehicle Type - shown for all users inside Profile Details */}
                        {!isManager && (
                          <>
                            <Text style={styles.inputLabel}>{t('profile.age')}</Text>
                            <TextInput 
                               style={styles.textInput}
                               placeholder={t('profile.agePlaceholder')}
                               placeholderTextColor={colors.text.tertiary}
                               keyboardType="numeric"
                               value={age}
                               onChangeText={handleAgeChange}
                            />

                            <Text style={styles.inputLabel}>{t('profile.vehicleType')}</Text>
                            <View style={styles.vehicleOptions}>
                               {[
                                 { key: 'Container Haulage', label: t('profile.vehicles.containerHaulage') },
                                 { key: 'Curtain Side', label: t('profile.vehicles.curtainSide') },
                                 { key: 'Open Cargo', label: t('profile.vehicles.openCargo') },
                                 { key: 'Small Truck', label: t('profile.vehicles.smallTruck') }
                               ].map((v) => (
                                 <TouchableOpacity
                                   key={v.key}
                                   style={[
                                     styles.vehicleOption,
                                     vehicleType === v.key && styles.vehicleOptionSelected
                                   ]}
                                   onPress={() => handleVehicleSelect(v.key)}
                                 >
                                    <Text style={[
                                      styles.vehicleText,
                                      vehicleType === v.key && styles.vehicleTextSelected
                                    ]}>{v.label}</Text>
                                 </TouchableOpacity>
                               ))}
                            </View>
                          </>
                        )}
                    </View>
                 )}

                 <GlassButton
                   title={t('common.save')}
                   onPress={handleSavePersonalDetails}
                   style={{ marginTop: 8 }}
                 />
          </GlassCard>

          {/* Manager Settings */}
          {isManager ? (
            <GlassCard style={styles.inputCard}>
            
               {/* Level 1 Specific: Company Settings */}
               {profile?.managerLevel === 1 && (
                  <TouchableOpacity style={styles.companySettingsButton} onPress={() => setShowCompanySettings(true)}>
                     <Building size={24} color={colors.text.primary} />
                     <Text style={styles.companySettingsText}>{t('profile.companySettings')}</Text>
                  </TouchableOpacity>
               )}

                 {/* Manage Users Button - For all Managers */}
                 <TouchableOpacity style={styles.manageUsersButton} onPress={() => navigation.navigate('UserManagement')}>
                    <UserPlus size={24} color={colors.mode === 'light' ? '#FFFFFF' : '#000000'} />
                    <Text style={styles.manageUsersText}>{t('profile.teamManagement')}</Text>
                 </TouchableOpacity>

                 {/* Billing & Subscription - For Level 1 Master Users */}
                 {profile?.managerLevel === 1 && (
                    <TouchableOpacity 
                      style={[styles.manageUsersButton, { marginTop: 12, backgroundColor: 'rgba(100, 149, 237, 0.2)', borderWidth: 1, borderColor: 'rgba(100, 149, 237, 0.5)' }]} 
                      onPress={() => navigation.navigate('Billing')}
                    >
                       <CreditCard size={24} color="#6495ED" />
                       <Text style={[styles.manageUsersText, { color: '#6495ED' }]}>{t('profile.billing', 'Billing & Plans')}</Text>
                    </TouchableOpacity>
                 )}

            </GlassCard>
          ) : (
            <View>

             {/* Driver Performance Dashboard */}
             <GlassCard style={styles.dashboardCard}>
                  {/* Dashboard Header */}
                  <View style={styles.dashboardHeader}>
                    <View style={styles.dashboardIconCircle}>
                      <Text style={{ fontSize: 18 }}>📊</Text>
                    </View>
                    <Text style={styles.dashboardTitle}>{t('profile.performanceDashboard')}</Text>
                  </View>

                  {/* Score Bars */}
                  <View style={styles.scoreSection}>
                    {/* Professionalism */}
                    <View style={styles.scoreRow}>
                      <View style={styles.scoreLabelRow}>
                        <View style={[styles.scoreDot, { backgroundColor: colors.primary.DEFAULT }]} />
                        <Text style={styles.scoreLabelText}>{t('profile.profConduct')}</Text>
                        <Text style={[styles.scoreValueText, { color: colors.primary.DEFAULT }]}>{profile?.professionalConduct || 0}%</Text>
                      </View>
                      <View style={styles.scoreBarTrack}>
                        <LinearGradient
                          colors={colors.gradients.primary as any}
                          start={{ x: 0, y: 0 }}
                          end={{ x: 1, y: 0 }}
                          style={[
                            styles.scoreBarFill,
                            { width: `${profile?.professionalConduct || 0}%` }
                          ]}
                        />
                      </View>
                    </View>

                    {/* Discipline */}
                    <View style={styles.scoreRow}>
                      <View style={styles.scoreLabelRow}>
                        <View style={[styles.scoreDot, { backgroundColor: '#E64A19' }]} />
                        <Text style={styles.scoreLabelText}>{t('profile.opDiscipline')}</Text>
                        <Text style={[styles.scoreValueText, { color: '#E64A19' }]}>{profile?.operationalDiscipline || 0}%</Text>
                      </View>
                      <View style={styles.scoreBarTrack}>
                        <LinearGradient
                          colors={['#FF8A65', '#E64A19'] as any}
                          start={{ x: 0, y: 0 }}
                          end={{ x: 1, y: 0 }}
                          style={[
                            styles.scoreBarFill,
                            { width: `${profile?.operationalDiscipline || 0}%` }
                          ]}
                        />
                      </View>
                    </View>

                    {/* Operation */}
                    <View style={styles.scoreRow}>
                      <View style={styles.scoreLabelRow}>
                        <View style={[styles.scoreDot, { backgroundColor: '#2E7D32' }]} />
                        <Text style={styles.scoreLabelText}>{t('profile.opEffectiveness')}</Text>
                        <Text style={[styles.scoreValueText, { color: '#2E7D32' }]}>{profile?.operationalEffectiveness || 0}%</Text>
                      </View>
                      <View style={styles.scoreBarTrack}>
                        <LinearGradient
                          colors={['#66BB6A', '#2E7D32'] as any}
                          start={{ x: 0, y: 0 }}
                          end={{ x: 1, y: 0 }}
                          style={[
                            styles.scoreBarFill,
                            { width: `${profile?.operationalEffectiveness || 0}%` }
                          ]}
                        />
                      </View>
                    </View>
                  </View>

                  {/* MCQ Progress Summary */}
                  <View style={styles.mcqProgressSection}>
                    <Text style={styles.mcqProgressLabel}>
                      TOTAL MCQs COMPLETED
                    </Text>
                    <View style={styles.mcqProgressRow}>
                      <Text style={styles.mcqProgressValue}>
                        {totalQuestionsAnswered}
                      </Text>
                      <Text style={styles.mcqProgressTotal}>
                        / 120
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
                          { width: `${Math.min((totalQuestionsAnswered / 120) * 100, 100)}%` }
                        ]}
                      />
                    </View>
                  </View>

             </GlassCard>

             {/* Milestone Tracker */}
             <MilestoneTracker currentPoints={totalXP} />

             {/* Performance Chart */}
             <GlassCard style={{marginTop: 16}}>
                <PerformanceChart 
                    data={
                        quizHistory.some(d => d.value > 0)
                        ? quizHistory
                        : [{ value: 0, label: '-' }]
                    } 
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
                 {profile?.total_batches_completed === 8 ? 'Complete' : `Batch ${profile?.current_batch || 1}`}
               </Text>
               <Text style={styles.statLabel}>Current Progress</Text>
               <Text style={[styles.statLabel, { marginTop: 8, color: colors.status.success }]}>
                 {profile?.total_batches_completed || 0} / 8 Batches Completed
               </Text>
             </GlassCard>
             
             </View>
          )}

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
    marginTop: 16,
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
    marginTop: 8,
  },
  inputCard: {
    marginBottom: 20,
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
    marginBottom: 20,
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
});
