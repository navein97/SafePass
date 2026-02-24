import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar, Dimensions, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Slider from '@react-native-community/slider';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { Shield, LogOut, User, Flame, Globe, Moon, Sun, Settings, Car, ChevronDown, ChevronUp } from 'lucide-react-native';
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
import { PerformanceChart } from '../components/PerformanceChart';
import { MilestoneTracker } from '../components/MilestoneTracker';
import { Building, BookOpen, UserPlus } from 'lucide-react-native';
import { QuizAttempt } from '../types/models';

const { width: SCREEN_WIDTH } = Dimensions.get('window');
const SHIELD_SIZE = 120;
const SHIELD_STROKE_WIDTH = 10;
const SHIELD_RADIUS = (SHIELD_SIZE - SHIELD_STROKE_WIDTH) / 2;
const SHIELD_CIRCUMFERENCE = 2 * Math.PI * SHIELD_RADIUS;

interface ProfileData {
  id: string;
  full_name?: string;
  employee_id?: string;
  region?: string;
  safety_index?: number;
  streak?: number;
  multiplier?: number;
  shieldHealth?: number;
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

  const showToast = (message: string, type: 'success' | 'error' | 'info' = 'success') => {
    setToastMessage(message);
    setToastType(type);
    setToastVisible(true);
  };

  const styles = useMemo(() => createStyles(colors), [colors]);

  const isManager = profile?.role === 'manager';
  const streakWeeks = profile?.streak || 0;
  const shieldHealth = profile?.shieldHealth || 100; // Percentage

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
        Alert.alert('Error', 'User profile not found');
        return;
      }

      setProfile({
        ...userProfile,
        streak: userProfile.streak || 0,
        shieldHealth: userProfile.shield_health || 100,
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
      Alert.alert('System Error', 'An unexpected error occurred while loading your profile.');
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
                    {profile?.region === 'MY' ? `🇲🇾 ${t('common.malaysia')}` : profile?.region}
                  </Text>
                </View>
                {/* Role Badge - only shown for managers */}
                {isManager && (
                  <View style={[
                    styles.regionBadge,
                    { 
                      marginTop: 6,
                      backgroundColor: profile?.managerLevel === 1
                        ? 'rgba(255, 180, 0, 0.2)'
                        : 'rgba(100, 149, 237, 0.2)',
                      borderColor: profile?.managerLevel === 1
                        ? 'rgba(255, 180, 0, 0.5)'
                        : 'rgba(100, 149, 237, 0.5)',
                    }
                  ]}>
                    <Text style={[
                      styles.regionText,
                      { color: profile?.managerLevel === 1 ? '#FFB400' : '#6495ED' }
                    ]}>
                      {profile?.managerLevel === 1 ? '⭐ Master User' : '👔 Manager'}
                    </Text>
                  </View>
                )}
              </View>
            </View>
          </GlassCard>

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
                            Profile Details
                        </Text>
                    </View>
                    {showMasterDetails ? <ChevronUp size={20} color={colors.text.secondary} /> : <ChevronDown size={20} color={colors.text.secondary} />}
                 </TouchableOpacity>

                 {showMasterDetails && (
                    <View style={{ marginBottom: 16 }}>
                        <Text style={styles.inputLabel}>Full Name</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. John Doe"
                            placeholderTextColor={colors.text.tertiary}
                            value={fullName}
                            onChangeText={setFullName}
                        />
                        
                        <Text style={styles.inputLabel}>Designation</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. Senior Driver"
                            placeholderTextColor={colors.text.tertiary}
                            value={designation}
                            onChangeText={setDesignation}
                        />
                        
                        <Text style={styles.inputLabel}>Company Name</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="e.g. Transport Co."
                            placeholderTextColor={colors.text.tertiary}
                            value={companyName}
                            onChangeText={setCompanyName}
                        />

                        <Text style={styles.inputLabel}>Address</Text>
                        <TextInput 
                            style={styles.textInput}
                            placeholder="Full Address"
                            placeholderTextColor={colors.text.tertiary}
                            value={address}
                            onChangeText={setAddress}
                        />

                        <Text style={styles.inputLabel}>Contact Number</Text>
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
                     <Building size={24} color={colors.primary.DEFAULT} />
                     <Text style={styles.companySettingsText}>{t('profile.companySettings')}</Text>
                  </TouchableOpacity>
               )}

                 {/* Manage Users Button - For all Managers */}
                 <TouchableOpacity style={styles.manageUsersButton} onPress={() => navigation.navigate('UserManagement')}>
                    <UserPlus size={24} color={colors.text.inverse} />
                    <Text style={styles.manageUsersText}>{t('profile.manageUsers')}</Text>
                 </TouchableOpacity>



               {/* Team Quiz Settings - HIDDEN per user request */}
               {/* <TouchableOpacity 
                    style={{ 
                        flexDirection: 'row', 
                        alignItems: 'center', 
                        justifyContent: 'space-between', 
                        marginTop: 24,
                        marginBottom: showTeamSettings ? 16 : 0, 
                        padding: 16, 
                        backgroundColor: colors.background.subtle, 
                        borderRadius: 12,
                    }}
                    onPress={() => setShowTeamSettings(!showTeamSettings)}
                 >
                     <View style={{ flexDirection: 'row', alignItems: 'center', gap: 12 }}>
                        <Settings size={20} color={colors.primary.DEFAULT} />
                        <Text style={{ fontSize: 16, fontFamily: typography.fonts.bold, color: colors.text.primary }}>
                            {t('profile.settings')}
                        </Text>
                     </View>
                     {showTeamSettings ? <ChevronUp size={20} color={colors.text.secondary} /> : <ChevronDown size={20} color={colors.text.secondary} />}
                 </TouchableOpacity>

                 {showTeamSettings && (
                    <View>
                        <View style={styles.sliderContainer}>
                            <View style={styles.sliderLabelContainer}>
                            <Text style={[styles.inputLabel, {color: colors.text.secondary}]}>{t('profile.questionsCount')} (Fixed)</Text>
                            <Text style={[styles.sliderValue, {color: colors.text.secondary}]}>30</Text>
                            </View>
                            <Slider
                                style={styles.slider}
                                minimumValue={30}
                                maximumValue={30} 
                                step={1}
                                value={30}
                                disabled={true}
                                minimumTrackTintColor={colors.border}
                                maximumTrackTintColor={colors.border}
                                thumbTintColor={colors.text.tertiary}
                            />
                            <Text style={[styles.statLabel, {textAlign: 'left', marginTop: 4}]}>
                                Standardized to 30 questions per batch for fair leaderboard ranking
                            </Text>
                        </View>

                        <View style={{ marginTop: 24, marginBottom: 16 }}>
                            <Text style={[styles.inputLabel, {color: colors.text.secondary}]}>Question Distribution (Pre-set per Batch)</Text>
                            
                            {['Easy', 'Intermediate', 'Hard'].map((level, idx) => (
                                <View key={level} style={styles.sliderContainer}>
                                <View style={styles.sliderLabelContainer}>
                                    <Text style={[styles.inputLabel, { fontSize: 12, color: colors.text.secondary }]}>{level}</Text>
                                    <Text style={[styles.sliderValue, { color: colors.text.secondary }]}>Mixed</Text>
                                </View>
                                <Slider
                                    style={styles.slider}
                                    value={50}
                                    disabled={true}
                                    minimumTrackTintColor={colors.border}
                                    maximumTrackTintColor={colors.border}
                                    thumbTintColor={colors.text.tertiary}
                                />
                                </View>
                            ))}
                        </View>
                    </View>
                 )} */}

{/* Save Button - Hidden as settings are hidden */}
               {/* <GlassButton
                 title={t('common.save')}
                 onPress={handleSaveSettings}
                 style={{ marginTop: 8 }}
               /> */}
            </GlassCard>
          ) : (
            <View>

             {/* Driver Performance Dashboard */}
             <GlassCard style={styles.inputCard}>
                  <Text style={[styles.sectionTitle, { textAlign: 'center' }]}>{t('profile.performanceDashboard')}</Text>
                  
                  {/* Legend */}
                  <View style={styles.legendContainer}>
                    <View style={styles.legendItem}>
                        <View style={[styles.legendColor, { backgroundColor: '#FFD600' }]} />
                        <Text style={styles.legendLabel}>{t('leaderboard.professionalism')}</Text>
                    </View>
                    <View style={styles.legendItem}>
                        <View style={[styles.legendColor, { backgroundColor: '#BF360C' }]} />
                        <Text style={styles.legendLabel}>{t('leaderboard.discipline')}</Text>
                    </View>
                    <View style={styles.legendItem}>
                        <View style={[styles.legendColor, { backgroundColor: '#2E7D32' }]} />
                        <Text style={styles.legendLabel}>{t('leaderboard.operation')}</Text>
                    </View>
                  </View>

                  <View style={styles.chartArea}>
                    {[0, 20, 40, 60, 80, 100].map(tick => (
                      <View key={tick} style={[styles.gridLine, { left: `${tick}%` }]} />
                    ))}

                    <View style={styles.barRow}>
                      <View style={styles.dashboardLabelContainer}>
                        <Text style={styles.dashboardLabel}>{t('leaderboard.professionalism')}</Text>
                      </View>
                      <View style={styles.dashboardBarContainer}>
                        <View style={styles.barTrack}>
                          <View 
                            style={[
                              styles.barFill, 
                              { width: `${profile?.professionalConduct || 0}%`, backgroundColor: '#FFD600' }
                            ]} 
                          />
                        </View>
                        <Text style={styles.barValue}>{profile?.professionalConduct || 0}%</Text>
                      </View>
                    </View>

                    <View style={styles.barRow}>
                      <View style={styles.dashboardLabelContainer}>
                        <Text style={styles.dashboardLabel}>{t('leaderboard.discipline')}</Text>
                      </View>
                      <View style={styles.dashboardBarContainer}>
                        <View style={styles.barTrack}>
                          <View 
                            style={[
                              styles.barFill, 
                              { width: `${profile?.operationalDiscipline || 0}%`, backgroundColor: '#BF360C' }
                            ]} 
                          />
                        </View>
                        <Text style={styles.barValue}>{profile?.operationalDiscipline || 0}%</Text>
                      </View>
                    </View>

                    <View style={styles.barRow}>
                      <View style={styles.dashboardLabelContainer}>
                        <Text style={styles.dashboardLabel}>{t('leaderboard.operation')}</Text>
                      </View>
                      <View style={styles.dashboardBarContainer}>
                        <View style={styles.barTrack}>
                          <View 
                            style={[
                              styles.barFill, 
                              { width: `${profile?.operationalEffectiveness || 0}%`, backgroundColor: '#2E7D32' }
                            ]} 
                          />
                        </View>
                        <Text style={styles.barValue}>{profile?.operationalEffectiveness || 0}%</Text>
                      </View>
                    </View>
                  </View>

                  {/* MCQ Progress Summary */}
                  <View style={{ 
                    marginTop: 16, 
                    paddingTop: 16, 
                    borderTopWidth: 1, 
                    borderTopColor: colors.border,
                    alignItems: 'center'
                  }}>
                    <Text style={{ fontSize: 13, fontFamily: typography.fonts.medium, color: colors.text.secondary, textTransform: 'uppercase', letterSpacing: 0.5 }}>
                      Total MCQs Completed
                    </Text>
                    <View style={{ flexDirection: 'row', alignItems: 'baseline', marginTop: 4, gap: 4 }}>
                      <Text style={{ fontSize: 24, fontFamily: typography.fonts.bold, color: colors.primary.DEFAULT }}>
                        {totalQuestionsAnswered}
                      </Text>
                      <Text style={{ fontSize: 16, fontFamily: typography.fonts.regular, color: colors.text.tertiary }}>
                        / 120
                      </Text>
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
                 {profile?.total_batches_completed === 4 ? 'Complete' : `Batch ${profile?.current_batch || 1}`}
               </Text>
               <Text style={styles.statLabel}>Current Progress</Text>
               <Text style={[styles.statLabel, { marginTop: 8, color: colors.status.success }]}>
                 {profile?.total_batches_completed || 0} / 4 Batches Completed
               </Text>
             </GlassCard>
             
             </View>
          )}

          {/* Logout */}
          <GlassButton
            title={t('auth.logout')}
            onPress={handleLogout}
            variant="danger"
            icon={<LogOut color={colors.text.primary} size={20} />}
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
    backgroundColor: colors.primary.light + '20',
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
    backgroundColor: colors.text.primary, // Black background
    borderRadius: 12,
  },
  manageUsersText: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.inverse, // White text
    marginLeft: 8,
  },
  companySettingsButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    marginBottom: 12,
    backgroundColor: colors.background.subtle,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: colors.primary.DEFAULT,
    borderStyle: 'dashed',
  },
  companySettingsText: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
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
    backgroundColor: colors.background.subtle || 'rgba(0,0,0,0.1)',
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
});
