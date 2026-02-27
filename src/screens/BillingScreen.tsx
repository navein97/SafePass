import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator, Alert, Linking, Platform } from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useTranslation } from 'react-i18next';
import { ChevronLeft, Check, CreditCard, Zap, Shield, Crown } from 'lucide-react-native';
import { useTheme } from '../context/ThemeContext';
import { typography } from '../theme/typography';
import { GradientBackground } from '../components/ui/GradientBackground';
import { GlassCard } from '../components/ui/GlassCard';
import { GlassButton } from '../components/ui/GlassButton';
import { SubscriptionService, PACKAGES } from '../services/subscriptionService';
import { AuthService } from '../services/authService';
import { supabase } from '../lib/supabase';

export const BillingScreen = ({ navigation }: any) => {
  const { t } = useTranslation();
  const { colors, theme } = useTheme();
  const [loading, setLoading] = useState(true);
  const [currentSubscription, setCurrentSubscription] = useState<any>(null);
  const [userProfile, setUserProfile] = useState<any>(null);

  const styles = useMemo(() => createStyles(colors), [colors]);

  useEffect(() => {
    loadData();
  }, []);

  // Try to create and link a company for the user if they don't have one
  const tryCreateCompany = async (profile: any): Promise<string | null> => {
    try {
      // Only manager level 1 can auto-create a company
      if (profile.role !== 'manager' || profile.manager_level !== 1) {
        console.log('[BillingScreen] Not a master manager, cannot auto-create company');
        return null;
      }

      // Get company_name from auth metadata
      const { data: { user } } = await supabase.auth.getUser();
      const companyName = user?.user_metadata?.company_name;
      if (!companyName) {
        console.log('[BillingScreen] No company_name in auth metadata');
        return null;
      }

      console.log('[BillingScreen] Creating company:', companyName);
      const { data: companyId, error: companyError } = await supabase
        .rpc('register_workspace', { p_company_name: companyName });

      if (companyError) {
        console.error('[BillingScreen] Company creation error:', companyError);
        return null;
      }

      console.log('[BillingScreen] Company created, linking user. ID:', companyId);
      const { error: linkError } = await supabase.rpc('link_user_to_company', {
        p_user_id: profile.id,
        p_company_id: companyId
      });

      if (linkError) {
        console.error('[BillingScreen] Link error:', linkError);
        return null;
      }

      console.log('[BillingScreen] ✅ Company created and linked:', companyId);
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
      
      // If no company_id, try to create the company directly
      if (profile && !profile.company_id) {
        console.log('[BillingScreen] No company_id found, attempting to create company...');
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
      const { url, error } = await SubscriptionService.createCheckoutSession(packageId, companyId);
      if (error) {
        if (Platform.OS === 'web') {
          window.alert(error);
        } else {
          Alert.alert(t('common.error', 'Error'), error);
        }
        return;
      }
      if (url) {
        Linking.openURL(url);
      } else {
        const msg = t('billing.checkoutFailed', 'Could not open checkout. Please try again.');
        if (Platform.OS === 'web') {
          window.alert(msg);
        } else {
          Alert.alert(t('common.error', 'Error'), msg);
        }
      }
    } catch (err: any) {
      console.error('Checkout error:', err);
      const msg = err?.message || 'An unexpected error occurred.';
      if (Platform.OS === 'web') {
        window.alert(msg);
      } else {
        Alert.alert(t('common.error', 'Error'), msg);
      }
    }
  };

  const proceedToCheckout = (packageId: string, companyId: string) => {
    if (Platform.OS === 'web') {
      // Alert.alert doesn't work on web
      const confirmed = window.confirm(
        t('billing.upgradePrompt', 'You will be redirected to Stripe for payment. Proceed?')
      );
      if (confirmed) {
        doCheckout(packageId, companyId);
      }
    } else {
      Alert.alert(
        t('billing.confirmUpgrade', 'Upgrade Plan'),
        t('billing.upgradePrompt', 'You will be redirected to Stripe for payment.'),
        [
          { text: t('common.cancel'), style: 'cancel' },
          { 
            text: t('billing.proceed', 'Proceed to Payment'),
            onPress: () => doCheckout(packageId, companyId)
          }
        ]
      );
    }
  };

  const handleUpgrade = async (packageId: string) => {
    // If company_id is still missing, try to create it now
    if (!userProfile?.company_id) {
      console.log('[BillingScreen] company_id missing on upgrade, trying to create company...');
      const newCompanyId = await tryCreateCompany(userProfile);
      if (newCompanyId) {
        const updatedProfile = { ...userProfile, company_id: newCompanyId };
        setUserProfile(updatedProfile);
        proceedToCheckout(packageId, newCompanyId);
        return;
      }
      const msg = t('billing.noCompany', 'No company associated with your account. Please contact support.');
      if (Platform.OS === 'web') {
        window.alert(msg);
      } else {
        Alert.alert(t('common.error', 'Error'), msg);
      }
      return;
    }

    proceedToCheckout(packageId, userProfile.company_id);
  };

  const renderPackage = (pkg: any) => {
    const isCurrent = currentSubscription?.subscription_tier === pkg.id;
    const Icon = pkg.id === 'starter' ? Zap : pkg.id === 'growth' ? Shield : Crown;
    
    return (
      <GlassCard 
        key={pkg.id} 
        style={[styles.packageCard, isCurrent && styles.currentPackageCard]}
        contentStyle={styles.packageCardContent}
      >
        <View style={styles.packageHeader}>
          <View style={[styles.iconContainer, { backgroundColor: isCurrent ? colors.primary.DEFAULT : colors.background.subtle }]}>
             <Icon size={24} color={isCurrent ? colors.text.inverse : colors.primary.DEFAULT} />
          </View>
          <View>
            <Text style={styles.packageName}>{pkg.name}</Text>
            {isCurrent && <Text style={styles.currentLabel}>{t('billing.currentPlan', 'Current Plan')}</Text>}
          </View>
        </View>

        <Text style={styles.priceText}>{pkg.price}</Text>

        <View style={styles.featuresContainer}>
           <View style={styles.featureRow}>
             <Check size={16} color={colors.status.success} />
             <Text style={styles.featureText}>{pkg.driverQuota} {t('billing.drivers', 'Drivers')}</Text>
           </View>
           <View style={styles.featureRow}>
             <Check size={16} color={colors.status.success} />
             <Text style={styles.featureText}>{pkg.managerQuota} {t('billing.managers', 'Managers')}</Text>
           </View>
           <View style={styles.featureRow}>
             <Check size={16} color={colors.status.success} />
             <Text style={styles.featureText}>{t('billing.analytics', 'Full Analytics Dashboard')}</Text>
           </View>
        </View>

        {!isCurrent && (
          <GlassButton 
            title={t('billing.choosePlan', 'Select Plan')}
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
          <Text style={styles.headerTitle}>{t('billing.title', 'Billing & Plans')}</Text>
          <View style={{ width: 40 }} />
        </View>

        {loading ? (
          <View style={styles.center}>
            <ActivityIndicator size="large" color={colors.primary.DEFAULT} />
          </View>
        ) : (
          <ScrollView contentContainerStyle={styles.content}>
            <View style={styles.currentStats}>
               <Text style={styles.sectionTitle}>{t('billing.currentUsage', 'Usage Overview')}</Text>
               <GlassCard style={styles.statsCard}>
                  <View style={styles.statItem}>
                    <Text style={styles.statVal}>{currentSubscription?.quota_drivers || 0}</Text>
                    <Text style={styles.statLab}>{t('billing.driverQuota', 'Driver Quota')}</Text>
                  </View>
                  <View style={styles.divider} />
                  <View style={styles.statItem}>
                    <Text style={styles.statVal}>{currentSubscription?.quota_managers || 0}</Text>
                    <Text style={styles.statLab}>{t('billing.managerQuota', 'Manager Quota')}</Text>
                  </View>
               </GlassCard>
            </View>

            <Text style={styles.sectionTitle}>{t('billing.availablePlans', 'Premium Tiers')}</Text>
            {PACKAGES.map(renderPackage)}
            
            <View style={styles.stripeNotice}>
               <CreditCard size={16} color={colors.text.tertiary} />
               <Text style={styles.stripeNoticeText}>Payments secured by Stripe</Text>
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
  sectionTitle: { fontSize: 16, fontFamily: typography.fonts.bold, color: colors.text.primary, marginBottom: 16, marginTop: 10 },
  currentStats: { marginBottom: 24 },
  statsCard: { flexDirection: 'row', padding: 20, justifyContent: 'space-around', alignItems: 'center' },
  statItem: { alignItems: 'center' },
  statVal: { fontSize: 24, fontFamily: typography.fonts.bold, color: colors.primary.DEFAULT },
  statLab: { fontSize: 12, color: colors.text.secondary, marginTop: 4 },
  divider: { width: 1, height: 40, backgroundColor: colors.border },
  packageCard: { marginBottom: 16, borderLeftWidth: 0 },
  currentPackageCard: { borderLeftWidth: 4, borderLeftColor: colors.primary.DEFAULT },
  packageCardContent: { padding: 20 },
  packageHeader: { flexDirection: 'row', alignItems: 'center', marginBottom: 16, gap: 12 },
  iconContainer: { width: 44, height: 44, borderRadius: 12, justifyContent: 'center', alignItems: 'center' },
  packageName: { fontSize: 18, fontFamily: typography.fonts.bold, color: colors.text.primary },
  currentLabel: { fontSize: 11, fontFamily: typography.fonts.medium, color: colors.primary.DEFAULT, marginTop: 2 },
  priceText: { fontSize: 28, fontFamily: typography.fonts.bold, color: colors.text.primary, marginBottom: 16 },
  featuresContainer: { gap: 10, marginBottom: 20 },
  featureRow: { flexDirection: 'row', alignItems: 'center', gap: 10 },
  featureText: { fontSize: 14, color: colors.text.secondary },
  selectButton: { marginTop: 10 },
  center: { flex: 1, justifyContent: 'center', alignItems: 'center' },
  stripeNotice: { flexDirection: 'row', alignItems: 'center', justifyContent: 'center', gap: 8, marginTop: 20, opacity: 0.6 },
  stripeNoticeText: { fontSize: 12, color: colors.text.tertiary }
});
