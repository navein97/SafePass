import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator, Alert, Linking, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { ChevronLeft, Check, CreditCard, Zap, Crown, AlertCircle } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { GlassInput } from '../components/ui/GlassInput';
import { SubscriptionService, PACKAGES, calculateAnnualCost, calculateFreeManagers } from '../services/subscriptionService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';
import { LinearGradient } from 'expo-linear-gradient';

export const BillingScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [currentSubscription, setCurrentSubscription] = useState<any>(null);
  const [userProfile, setUserProfile] = useState<any>(null);
  const [driverCountInput, setDriverCountInput] = useState('10'); // Default to 10 for better UX

  const styles = useMemo(() => createStyles(colors), [colors]);

  const isOnTrial = !currentSubscription?.subscription_tier || currentSubscription?.subscription_tier === 'trial';

  useEffect(() => {
    loadData();
  }, []);

  // Try to create and link a company for the user if they don't have one
  const tryCreateCompany = async (profile: any): Promise<string | null> => {
    try {
      if (profile.role !== 'manager' || profile.manager_level !== 1) {
        return null;
      }

      const { data: { user } } = await supabase.auth.getUser();
      const companyName = user?.user_metadata?.company_name;
      if (!companyName) return null;

      const { data: companyId, error: companyError } = await supabase
        .rpc('register_workspace', { p_company_name: companyName });

      if (companyError) return null;

      const { error: linkError } = await supabase.rpc('link_user_to_company', {
        p_user_id: profile.id,
        p_company_id: companyId
      });

      if (linkError) return null;
      return companyId;
    } catch (err) {
      console.error('[BillingScreen] tryCreateCompany error:', err);
      return null;
    }
  };

  const loadData = async () => {
    setLoading(true);
    try {
      let { profile } = await AuthService.getUserProfile();
      
      if (profile && !profile.company_id) {
        const newCompanyId = await tryCreateCompany(profile);
        if (newCompanyId) {
          profile.company_id = newCompanyId;
        }
      }

      setUserProfile(profile);
      
      if (profile?.company_id) {
        const sub = await SubscriptionService.getSubscriptionDetails(profile.company_id);
        setCurrentSubscription(sub);
      }
    } catch (error) {
      console.error('Error loading billing data:', error);
    } finally {
      setLoading(false);
    }
  };

  const doCheckout = async (packageId: string, companyId: string) => {
    try {
      const driverCount = parseInt(driverCountInput) || 1;
      const { url, error } = await SubscriptionService.createCheckoutSession(packageId, companyId, driverCount);
      if (error) {
        if (Platform.OS === 'web') {
          window.alert(error);
        } else {
          Alert.alert(t('common.error'), error);
        }
        return;
      }
      if (url) {
        Linking.openURL(url);
      } else {
        const msg = t('billing.checkoutFailed');
        if (Platform.OS === 'web') {
          window.alert(msg);
        } else {
          Alert.alert(t('common.error'), msg);
        }
      }
    } catch (err: any) {
      console.error('Checkout error:', err);
      const msg = err?.message || t('common.unexpectedErrorOccurred');
      if (Platform.OS === 'web') {
        window.alert(msg);
      } else {
        Alert.alert(t('common.error'), msg);
      }
    }
  };

  const proceedToCheckout = (packageId: string, companyId: string) => {
    if (Platform.OS === 'web') {
      const confirmed = window.confirm(t('billing.upgradePrompt'));
      if (confirmed) {
        doCheckout(packageId, companyId);
      }
    } else {
      Alert.alert(
        t('billing.confirmUpgrade'),
        t('billing.upgradePrompt'),
        [
          { text: t('common.cancel'), style: 'cancel' },
          { 
            text: t('billing.proceed'),
            onPress: () => doCheckout(packageId, companyId)
          }
        ]
      );
    }
  };

  const handleUpgrade = async (packageId: string) => {
    if (!userProfile?.company_id) {
      const newCompanyId = await tryCreateCompany(userProfile);
      if (newCompanyId) {
        const updatedProfile = { ...userProfile, company_id: newCompanyId };
        setUserProfile(updatedProfile);
        proceedToCheckout(packageId, newCompanyId);
        return;
      }
      const msg = t('billing.noCompany');
      if (Platform.OS === 'web') {
        window.alert(msg);
      } else {
        Alert.alert(t('common.error'), msg);
      }
      return;
    }

    proceedToCheckout(packageId, userProfile.company_id);
  };

  const renderPackage = (pkg: typeof PACKAGES[0], index: number) => {
    const tier = currentSubscription?.subscription_tier?.toLowerCase();
    const isCurrent = tier === pkg.id.toLowerCase() || 
                     (pkg.id === 'standard' && tier === 'starter') ||
                     (pkg.id === 'enterprise' && (tier === 'growth' || tier === 'pro'));
    
    // Use the user's input for the calculation
    const inputCount = parseInt(driverCountInput) || 0;
    const { total, freeManagers, tier: calculatedTier } = calculateAnnualCost(inputCount);
    
    // Check if this package is the one recommended for the input count
    const isRecommended = calculatedTier.id === pkg.id && inputCount > 0;
    const isStandard = pkg.id.toLowerCase() === 'standard';
    
    // Calculate the valid number of drivers for this specific tier based on user input
    let displayCount = inputCount > 0 ? inputCount : 1;
    if (!isStandard && displayCount < 101) {
      displayCount = 101; // Enterprise requires at least 101 drivers
    } else if (isStandard && displayCount > 100) {
      displayCount = 100; // Standard is capped at 100 drivers
    }
    
    return (
      <GlassCard 
        key={pkg.id} 
        style={[
          styles.packageCard, 
          isCurrent && styles.currentPackageCard,
          isRecommended && !isCurrent && styles.recommendedCard
        ]}
        contentStyle={styles.packageCardContent}
      >
        {/* Header */}
        <View style={styles.packageHeader}>
          <View style={[styles.iconContainer, { backgroundColor: isStandard ? colors.primary.DEFAULT + '20' : '#7B2CBF20' }]}>
             {isStandard 
               ? <Zap size={24} color={colors.primary.DEFAULT} />
               : <Crown size={24} color="#7B2CBF" />
             }
          </View>
          <View style={{ flex: 1 }}>
            <Text style={styles.packageName}>{pkg.name}</Text>
            <Text style={styles.fleetRange}>{pkg.fleetRange} {t('billing.drivers')}</Text>
          </View>
          {isCurrent && (
            <View style={styles.currentBadge}>
              <Check size={14} color="#64FFDA" />
              <Text style={styles.currentBadgeText}>{t('billing.currentPlan')}</Text>
            </View>
          )}
        </View>

        {/* Price */}
        <View style={styles.priceRow}>
          <Text style={styles.priceAmount}>RM {pkg.pricePerUser}</Text>
          <Text style={styles.pricePer}>/ {t('billing.perDriverYear')}</Text>
        </View>

        {/* Features */}
        <View style={styles.featuresContainer}>
          <View style={styles.featureRow}>
            <Check size={16} color={colors.status.success} />
            <Text style={styles.featureText}>{t('billing.allBatches')}</Text>
          </View>
          <View style={styles.featureRow}>
            <Check size={16} color={colors.status.success} />
            <Text style={styles.featureText}>{t('billing.freeManagerRatio', { ratio: pkg.freeManagerRatio })}</Text>
          </View>
          <View style={styles.featureRow}>
            <Check size={16} color={colors.status.success} />
            <Text style={styles.featureText}>{t('billing.analytics')}</Text>
          </View>
          <View style={styles.featureRow}>
            <Check size={16} color={colors.status.success} />
            <Text style={styles.featureText}>{t('billing.annualBilling')}</Text>
          </View>
        </View>

        {/* Example calculation */}
        <View style={styles.exampleBox}>
          <Text style={styles.exampleTitle}>{t('billing.totalCost')}</Text>
          <Text style={styles.exampleText}>
            {displayCount} {t('billing.drivers')} × RM {pkg.pricePerUser} = <Text style={{ fontFamily: typography.fonts.bold, color: colors.primary.DEFAULT }}>RM {(displayCount * pkg.pricePerUser).toLocaleString()}</Text>{t('billing.perYear')}
          </Text>
          <Text style={styles.exampleSubtext}>
            + {calculateFreeManagers(displayCount, pkg.freeManagerRatio)} {t('billing.freeManagers')}
          </Text>
        </View>

        {/* CTA Button */}
        {!isCurrent && (
          <GlassButton 
            title={isOnTrial ? t('billing.upgradeToPlan', { plan: pkg.name }) : t('billing.switchToPlan', { plan: pkg.name })}
            onPress={() => handleUpgrade(pkg.id)}
            style={styles.selectButton}
          />
        )}
      </GlassCard>
    );
  };

  return (
    <GradientBackground>
      <SafeAreaView style={styles.safeArea}>
        <View style={styles.header}>
          <TouchableOpacity onPress={() => navigation.goBack()} style={styles.backButton}>
            <ChevronLeft color={colors.text.primary} size={24} />
          </TouchableOpacity>
          <Text style={styles.headerTitle}>{t('billing.title')}</Text>
          <View style={{ width: 40 }} />
        </View>

        {loading ? (
          <View style={styles.center}>
            <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          </View>
        ) : (
          <ScrollView contentContainerStyle={styles.content}>
            {/* Trial Banner */}
            {isOnTrial && (
              <LinearGradient
                colors={[colors.primary.DEFAULT, '#7B2CBF'] as any}
                start={{ x: 0, y: 0 }}
                end={{ x: 1, y: 0 }}
                style={styles.trialBanner}
              >
                <AlertCircle size={24} color="#FFFFFF" />
                <View style={{ flex: 1 }}>
                  <Text style={styles.trialBannerTitle}>{t('billing.trialBannerTitle')}</Text>
                  <Text style={styles.trialBannerText}>{t('billing.trialBannerText')}</Text>
                </View>
              </LinearGradient>
            )}

            {/* Current Status */}
            <GlassCard style={styles.statusCard}>
              <View style={styles.statusRow}>
                <View style={styles.statusItem}>
                  <Text style={styles.statusLabel}>{t('billing.plan')}</Text>
                  <Text style={[styles.statusValue, isOnTrial && { color: colors.status.warning }]}>
                    {isOnTrial 
                      ? t('billing.tierTrial') 
                      : (currentSubscription?.subscription_tier?.toLowerCase() === 'enterprise' 
                          ? t('billing.tierEnterprise') 
                          : t('billing.tierStandard'))}
                  </Text>
                </View>
                <View style={styles.statusDivider} />
                <View style={styles.statusItem}>
                  <Text style={styles.statusLabel}>{t('billing.driverQuota')}</Text>
                  <Text style={styles.statusValue}>
                    {isOnTrial ? '3' : (currentSubscription?.quota_drivers || '∞')}
                  </Text>
                </View>
                <View style={styles.statusDivider} />
                <View style={styles.statusItem}>
                  <Text style={styles.statusLabel}>{t('billing.batchAccess')}</Text>
                  <Text style={styles.statusValue}>{isOnTrial ? '1/4' : '4/4'}</Text>
                </View>
              </View>
            </GlassCard>

            {/* Driver Count Input */}
            <GlassCard style={styles.inputCard}>
              <Text style={styles.inputLabel}>{t('billing.howManyDrivers') || 'How many driver slots do you need?'}</Text>
              <View style={styles.inputRow}>
                <GlassInput
                  value={driverCountInput}
                  onChangeText={setDriverCountInput}
                  placeholder="e.g. 50"
                  keyboardType="numeric"
                  containerStyle={styles.driverInputContainer}
                />
                <View style={styles.inputHint}>
                  <Text style={styles.hintText}>{t('billing.priceAdjusts') || 'Price adjusts automatically'}</Text>
                </View>
              </View>
            </GlassCard>

            {/* Pricing Plans */}
            <Text style={styles.sectionTitle}>{t('billing.availablePlans')}</Text>
            {PACKAGES.map((pkg, index) => renderPackage(pkg, index))}
            
            {/* Secure payments notice */}
            <View style={styles.stripeNotice}>
               <CreditCard size={16} color={colors.text.tertiary} />
               <Text style={styles.stripeNoticeText}>{t('billing.securePayments')}</Text>
            </View>
          </ScrollView>
        )}
      </SafeAreaView>
    </GradientBackground>
  );
};

const createStyles = (colors: any) => StyleSheet.create({
  safeArea: { flex: 1 },
  header: { flexDirection: 'row', alignItems: 'center', justifyContent: 'space-between', paddingHorizontal: 20, paddingVertical: 12 },
  backButton: { padding: 8 },
  headerTitle: { fontSize: 20, fontFamily: typography.fonts.bold, color: colors.text.primary },
  content: { padding: 20, paddingBottom: 40 },
  center: { flex: 1, justifyContent: 'center', alignItems: 'center' },
  
  // Trial Banner
  trialBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 16,
    borderRadius: 16,
    gap: 12,
    marginBottom: 16,
  },
  trialBannerTitle: {
    fontSize: 15,
    fontFamily: typography.fonts.bold,
    color: '#FFFFFF',
  },
  trialBannerText: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    color: 'rgba(255,255,255,0.85)',
    marginTop: 2,
  },
  
  // Status Card
  statusCard: {
    marginBottom: 24,
    padding: 20,
  },
  statusRow: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    alignItems: 'center',
  },
  statusItem: {
    alignItems: 'center',
    flex: 1,
  },
  statusLabel: {
    fontSize: 11,
    fontFamily: typography.fonts.medium,
    color: colors.text.secondary,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
    marginBottom: 6,
  },
  statusValue: {
    fontSize: 20,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  statusDivider: {
    width: 1,
    height: 40,
    backgroundColor: colors.border,
  },
  
  // Section
  sectionTitle: {
    fontSize: 16,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 16,
  },
  
  // Package Cards
  packageCard: { marginBottom: 16 },
  currentPackageCard: { borderLeftWidth: 4, borderLeftColor: colors.primary.DEFAULT },
  packageCardContent: { padding: 20 },
  packageHeader: { flexDirection: 'row', alignItems: 'center', marginBottom: 16, gap: 12 },
  iconContainer: { width: 48, height: 48, borderRadius: 14, justifyContent: 'center', alignItems: 'center' },
  packageName: { fontSize: 20, fontFamily: typography.fonts.bold, color: colors.text.primary },
  fleetRange: { fontSize: 13, fontFamily: typography.fonts.medium, color: colors.text.secondary, marginTop: 2 },
  currentBadge: {
    backgroundColor: colors.primary.DEFAULT + '20',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 8,
    flexDirection: 'row',
    alignItems: 'center',
    gap: 4,
  },
  currentBadgeText: {
    fontSize: 11,
    fontFamily: typography.fonts.bold,
    color: colors.primary.DEFAULT,
  },
  
  // Price
  priceRow: { flexDirection: 'row', alignItems: 'baseline', marginBottom: 20, gap: 4 },
  priceAmount: { fontSize: 32, fontFamily: typography.fonts.bold, color: colors.text.primary },
  pricePer: { fontSize: 14, fontFamily: typography.fonts.regular, color: colors.text.secondary },
  
  // Features
  featuresContainer: { gap: 10, marginBottom: 16 },
  featureRow: { flexDirection: 'row', alignItems: 'center', gap: 10 },
  featureText: { fontSize: 14, color: colors.text.secondary, fontFamily: typography.fonts.medium },
  
  // Example Box
  exampleBox: {
    backgroundColor: colors.background.subtle,
    borderRadius: 12,
    padding: 14,
    marginBottom: 16,
  },
  exampleTitle: {
    fontSize: 11,
    fontFamily: typography.fonts.bold,
    color: colors.text.tertiary,
    textTransform: 'uppercase',
    letterSpacing: 0.5,
    marginBottom: 6,
  },
  exampleText: {
    fontSize: 14,
    fontFamily: typography.fonts.medium,
    color: colors.text.primary,
  },
  exampleSubtext: {
    fontSize: 12,
    fontFamily: typography.fonts.regular,
    color: colors.status.success,
    marginTop: 4,
  },
  
  // CTA
  selectButton: { marginTop: 4 },
  
  // Input Card
  inputCard: {
    marginBottom: 24,
    padding: 16,
  },
  inputLabel: {
    fontSize: 14,
    fontFamily: typography.fonts.bold,
    color: colors.text.primary,
    marginBottom: 12,
  },
  inputRow: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 16,
  },
  driverInputContainer: {
    flex: 1,
    marginBottom: 0,
  },
  inputHint: {
    flex: 1,
  },
  hintText: {
    fontSize: 12,
    color: colors.text.secondary,
    fontFamily: typography.fonts.regular,
  },
  recommendedCard: {
    borderColor: colors.primary.DEFAULT,
    borderWidth: 2,
    backgroundColor: colors.primary.DEFAULT + '05',
  },

  // Stripe Notice
  stripeNotice: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8, marginTop: 20, opacity: 0.6 },
  stripeNoticeText: { fontSize: 12, color: colors.text.tertiary },
});
