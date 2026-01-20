import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, Alert, ActivityIndicator, Platform, StatusBar, Dimensions, TextInput } from 'react-native';
import { useTranslation } from 'react-i18next';
import { SafeAreaView } from 'react-native-safe-area-context';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Slider from '@react-native-community/slider';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { Shield, LogOut, User, Flame, Globe, Moon, Sun, Settings, Car } from 'lucide-react-native';
import { AuthService } from '../services/authService';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { LinearGradient } from 'expo-linear-gradient';
import { Toast } from '../components/Toast';
import Svg, { Circle } from 'react-native-svg';
import { PerformanceRing } from '../components/PerformanceRing';
import { CreateUserModal } from '../components/CreateUserModal';
import { CompanySettingsModal } from '../components/CompanySettingsModal';
import { Building, BookOpen, UserPlus } from 'lucide-react-native';

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
  managerLevel?: 1 | 2;
  operationalEffectiveness?: number;
  operationalDiscipline?: number;
  professionalConduct?: number;
  department?: string;
  division?: string;
  area?: string;
}

export const ProfileScreen = ({ navigation }: any) => {
  const { t, i18n } = useTranslation();
  const { colors, theme, toggleTheme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [profile, setProfile] = useState<ProfileData | null>(null);
  
  // Staff State
  const [age, setAge] = useState('');
  const [vehicleType, setVehicleType] = useState('');
  
  // Manager State
  const [questionCount, setQuestionCount] = useState(5);
  const [timerDuration, setTimerDuration] = useState(2); // minutes

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
    loadProfile();
  }, []);

  const loadProfile = async () => {
    try {
      setLoading(true);
      const { profile: userProfile, error } = await AuthService.getUserProfile();
      
      if (error) {
        Alert.alert('Error', t('common.errorLoading', 'Failed to load profile'));
        return;
      }

      setProfile({
        ...userProfile,
        streak: userProfile.streak || 0,
        shieldHealth: userProfile.shield_health || 100,
        managerLevel: userProfile.manager_level,
        operationalEffectiveness: userProfile.operational_effectiveness || 0.75, // Default for demo
        operationalDiscipline: userProfile.operational_discipline || 0.25,
        professionalConduct: userProfile.professional_conduct || 0.12,
      });

      // Load local settings/data
      if (userProfile.role === 'manager') {
        const savedCount = await AsyncStorage.getItem('QUIZ_QUESTION_COUNT');
        const savedTimer = await AsyncStorage.getItem('QUIZ_TIMER_DURATION');
        if (savedCount) setQuestionCount(parseInt(savedCount, 10));
        if (savedTimer) setTimerDuration(parseInt(savedTimer, 10));
      } else {
        // Prioritize profile data from Supabase
        let initialAge = userProfile.age ? userProfile.age.toString() : '';
        let initialVehicle = userProfile.vehicle_type || '';

        // If missing in Supabase, try to fallback to AsyncStorage
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
      console.error('Error loading profile:', error);
    } finally {
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
            age: parseInt(age) || null,
            vehicle_type: vehicleType
        });
        
        if (error) throw error;
        
        // Refresh local state and persistent profile
        await loadProfile();
        showToast(t('profile.detailsSaved', 'Personal details saved!'), 'success');
    } catch (error) {
        console.error('Save details error:', error);
        showToast(t('profile.detailsSaveError', 'Failed to save details.'), 'error');
    }
  };

  const handleSettingChange = (key: string, value: number) => {
    if (key === 'count') {
        setQuestionCount(value);
    } else {
        setTimerDuration(value);
    }
  };

  const handleSaveSettings = async () => {
    try {
        await AsyncStorage.setItem('QUIZ_QUESTION_COUNT', questionCount.toString());
        await AsyncStorage.setItem('QUIZ_TIMER_DURATION', timerDuration.toString());
        showToast(t('profile.settingsSaved', 'Settings saved successfully!'), 'success');
    } catch (error) {
        console.error('Save error:', error);
        showToast(t('profile.settingsSaveError', 'Failed to save settings.'), 'error');
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
            <Text style={styles.title}>{t('profile.title', 'Profile')}</Text>
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
                    {profile?.region === 'MY' ? `🇲🇾 ${t('common.malaysia', 'Malaysia')}` : `🇵🇹 ${t('common.portugal', 'Portugal')}`}
                  </Text>
                </View>
              </View>
            </View>
          </GlassCard>

          {/* Manager Settings */}
          {isManager ? (
            <GlassCard style={styles.inputCard}>
            
               {/* Level 1 Specific: Company Settings */}
               {profile?.managerLevel === 1 && (
                  <TouchableOpacity style={styles.companySettingsButton} onPress={() => setShowCompanySettings(true)}>
                     <Building size={24} color={colors.text.inverse} />
                     <Text style={styles.companySettingsText}>{t('profile.companySettings', 'Company Settings')}</Text>
                  </TouchableOpacity>
               )}

                {/* Manage Users Button - For all Managers */}
                 <TouchableOpacity style={styles.manageUsersButton} onPress={() => setShowCreateUser(true)}>
                    <UserPlus size={24} color={colors.primary.DEFAULT} />
                    <Text style={styles.manageUsersText}>{t('profile.manageUsers', 'Manage / Create Users')}</Text>
                 </TouchableOpacity>

               {/* DOPS Dashboard - Visible to all managers */}
               <View style={styles.dopsContainer}>
                  <Text style={styles.sectionTitle}>{t('profile.dopsTitle', 'Driver Operational Performance')}</Text>
                  <Text style={styles.sectionSubtitle}>{t('profile.dopsSubtitle', 'DOPD - Final Aggregated Results')}</Text>
                  
                  <View style={styles.ringsContainer}>
                      <PerformanceRing 
                        score={profile?.operationalEffectiveness || 0} 
                        label={t('profile.opEffectiveness', 'Operational Effectiveness')} 
                        color={colors.status.success}
                        size={SCREEN_WIDTH * 0.26}
                      />
                      <PerformanceRing 
                        score={profile?.operationalDiscipline || 0} 
                        label={t('profile.opDiscipline', 'Operational Discipline')} 
                        color={colors.status.warning}
                        size={SCREEN_WIDTH * 0.26}
                      />
                      <PerformanceRing 
                        score={profile?.professionalConduct || 0} 
                        label={t('profile.profConduct', 'Professional Conduct')} 
                        color={colors.status.danger} // Red/Grey as per PDF for low score
                        size={SCREEN_WIDTH * 0.26}
                      />
                  </View>
               </View>

               <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 16, marginTop: 24 }}>
                  <Settings size={24} color={colors.primary.DEFAULT} style={{ marginRight: 8 }} />
                  <Text style={styles.sectionTitle}>{t('profile.settings', 'Team Quiz Settings')}</Text>
               </View>

               {/* Question Count Slider */}
               <View style={styles.sliderContainer}>
                 <View style={styles.sliderLabelContainer}>
                   <Text style={styles.inputLabel}>{t('profile.questionsCount', 'Questions to Answer')}</Text>
                   <Text style={styles.sliderValue}>{questionCount}</Text>
                 </View>
                 <Slider
                   style={styles.slider}
                   minimumValue={5}
                   maximumValue={20}
                   step={1}
                   value={questionCount}
                   onValueChange={(val) => handleSettingChange('count', val)}
                   minimumTrackTintColor={colors.primary.DEFAULT}
                   maximumTrackTintColor={colors.border}
                   thumbTintColor={colors.primary.DEFAULT}
                 />
               </View>

               {/* Timer Slider */}
               <View style={styles.sliderContainer}>
                 <View style={styles.sliderLabelContainer}>
                   <Text style={styles.inputLabel}>{t('profile.timerDuration', 'Timer (Minutes)')}</Text>
                   <Text style={styles.sliderValue}>{timerDuration} min</Text>
                 </View>
                 <Slider
                   style={styles.slider}
                   minimumValue={1}
                   maximumValue={10}
                   step={1}
                   value={timerDuration}
                   onValueChange={(val) => handleSettingChange('timer', val)}
                   minimumTrackTintColor={colors.primary.DEFAULT}
                   maximumTrackTintColor={colors.border}
                   thumbTintColor={colors.primary.DEFAULT}
                 />
               </View>

               {/* Save Button */}
               <GlassButton
                 title={t('common.save', 'Save Settings')}
                 onPress={handleSaveSettings}
                 style={{ marginTop: 8 }}
               />
            </GlassCard>
          ) : (
             /* Staff Inputs */
             <GlassCard style={styles.inputCard}>
                <View style={{ flexDirection: 'row', alignItems: 'center', marginBottom: 16 }}>
                   <User size={24} color={colors.primary.DEFAULT} style={{ marginRight: 8 }} />
                   <Text style={styles.sectionTitle}>{t('profile.personalDetails', 'Personal Details')}</Text>
                </View>

                {/* Age Input */}
                <Text style={styles.inputLabel}>{t('profile.age', 'Age')}</Text>
                <TextInput 
                   style={styles.textInput}
                   placeholder="Enter your age"
                   placeholderTextColor={colors.text.tertiary}
                   keyboardType="numeric"
                   value={age}
                   onChangeText={handleAgeChange}
                />

                {/* Vehicle Selection */}
                <Text style={styles.inputLabel}>{t('profile.vehicleType', 'Vehicle Type')}</Text>
                <View style={styles.vehicleOptions}>
                   {['Motorcycle', 'Car', 'Bus', 'Truck'].map((v) => (
                      <TouchableOpacity
                        key={v}
                        style={[
                          styles.vehicleOption,
                          vehicleType === v && styles.vehicleOptionSelected
                        ]}
                        onPress={() => handleVehicleSelect(v)}
                      >
                         <Text style={[
                           styles.vehicleText,
                           vehicleType === v && styles.vehicleTextSelected
                         ]}>{v}</Text>
                      </TouchableOpacity>
                   ))}
                </View>

                {/* Save Button */}
                <GlassButton
                  title={t('common.save', 'Save Details')}
                  onPress={handleSavePersonalDetails}
                  style={{ marginTop: 24 }}
                />
             </GlassCard>
          )}

          {/* Gamification Stats Row - Only for Staff and NOT Manager (redundant check but safe) */}
          {!isManager && (
          <>
          {/* Weekly Streak Card */}
          <GlassCard style={styles.streakCard}>
            <View style={styles.flameContainer}>
              <LinearGradient
                colors={[colors.streak.flame, colors.streak.flameGlow]}
                style={styles.flameGlow}
              >
                <Flame size={32} color="#FFF" fill="#FFF" />
              </LinearGradient>
            </View>
            <Text style={styles.statValue}>{streakWeeks}</Text>
            <Text style={styles.statLabel}>{t('profile.weeklyStreak', 'Weekly Streak')}</Text>
          </GlassCard>

          {/* Safety Shield - Only for Staff */}
          <GlassCard style={styles.shieldCard}>
            <Text style={styles.shieldTitle}>{t('profile.safetyShield', 'Safety Shield')}</Text>
            <View style={styles.shieldContainer}>
              <Svg width={SHIELD_SIZE} height={SHIELD_SIZE} style={styles.shieldSvg}>
                {/* Background Circle */}
                <Circle
                  cx={SHIELD_SIZE / 2}
                  cy={SHIELD_SIZE / 2}
                  r={SHIELD_RADIUS}
                  stroke={colors.background.subtle}
                  strokeWidth={SHIELD_STROKE_WIDTH}
                  fill="transparent"
                />
                {/* Progress Circle */}
                <Circle
                  cx={SHIELD_SIZE / 2}
                  cy={SHIELD_SIZE / 2}
                  r={SHIELD_RADIUS}
                  stroke={shieldHealth > 50 ? colors.status.success : shieldHealth > 25 ? colors.status.warning : colors.status.danger}
                  strokeWidth={SHIELD_STROKE_WIDTH}
                  fill="transparent"
                  strokeDasharray={`${SHIELD_CIRCUMFERENCE * (shieldHealth / 100)} ${SHIELD_CIRCUMFERENCE}`}
                  strokeLinecap="round"
                  rotation={-90}
                  origin={`${SHIELD_SIZE / 2}, ${SHIELD_SIZE / 2}`}
                />
              </Svg>
              <View style={styles.shieldCenter}>
                <Shield 
                  size={36} 
                  color={shieldHealth > 50 ? colors.status.success : shieldHealth > 25 ? colors.status.warning : colors.status.danger} 
                />
                <Text style={styles.shieldPercent}>{shieldHealth}%</Text>
              </View>
            </View>
            <Text style={styles.shieldDescription}>
              {shieldHealth > 75 
                ? t('profile.shieldStrong', '🛡️ Shield is strong! Keep it up!')
                : shieldHealth > 50 
                  ? t('profile.shieldWarn', '⚠️ Shield needs attention')
                  : t('profile.shieldCritical', '🚨 Shield critically low! Complete missions!')}
            </Text>
          </GlassCard>
          </>
          )}

          {/* Logout */}
          <GlassButton
            title={t('auth.logout', 'Logout')}
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
    fontSize: 16,
    borderWidth: 1,
    borderColor: colors.border,
    marginBottom: 16,
  },
  vehicleOptions: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 10,
  },
  vehicleOption: {
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 20,
    borderWidth: 1,
    borderColor: colors.border,
    backgroundColor: colors.background.subtle,
  },
  vehicleOptionSelected: {
    backgroundColor: colors.primary.DEFAULT,
    borderColor: colors.primary.DEFAULT,
  },
  vehicleText: {
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
  },
  vehicleTextSelected: {
    color: colors.text.inverse,
    fontFamily: typography.fonts.bold,
  },
  sectionTitle: {
    fontSize: 18,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
    marginTop: 8,
  },
  sliderContainer: {
    marginBottom: 24,
  },
  sliderLabelContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    marginBottom: 8,
  },
  sliderValue: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  slider: {
    width: '100%',
    height: 40,
  },
  dopsContainer: {
    marginBottom: 24,
    borderBottomWidth: 1,
    borderBottomColor: 'rgba(255,255,255,0.1)',
    paddingBottom: 24,
  },
  sectionSubtitle: {
    fontSize: 12,
    color: colors.text.secondary,
    fontFamily: typography.fonts.medium,
    marginBottom: 16,
    textTransform: 'uppercase',
    letterSpacing: 1,
  },
  ringsContainer: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    flexWrap: 'wrap',
  },
  companySettingsButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: colors.primary.DEFAULT,
    padding: 16,
    borderRadius: 12,
    marginBottom: 24,
    shadowColor: colors.primary.DEFAULT,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.3,
    shadowRadius: 8,
    elevation: 4,
  },
  companySettingsText: {
    color: colors.text.inverse,
    fontFamily: typography.fonts.bold,
    fontSize: 16,
    marginLeft: 8,
  },
  manageUsersButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: colors.background.subtle,
    padding: 16,
    borderRadius: 12,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: colors.primary.DEFAULT,
    borderStyle: 'dashed',
  },
  manageUsersText: {
    color: colors.primary.DEFAULT,
    fontFamily: typography.fonts.bold,
    fontSize: 16,
    marginLeft: 8,
  },
});

