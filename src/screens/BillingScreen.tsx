import React, { useState, useEffect, useMemo } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ScrollView, ActivityIndicator, Alert, Linking } from 'react-native';
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

  const loadData = async () => {
    setLoading(true);
    try {
      const { profile } = await AuthService.getUserProfile();
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

  const handleUpgrade = async (packageId: string) => {
    if (!userProfile?.company_id) return;
    
    Alert.alert(
      t('billing.confirmUpgrade', 'Upgrade Plan'),
      t('billing.upgradePrompt', 'You will be redirected to Stripe for payment.'),
      [
        { text: t('common.cancel'), style: 'cancel' },
        { 
          text: t('billing.proceed', 'Proceed to Payment'),
          onPress: async () => {
             const { url } = await SubscriptionService.createCheckoutSession(packageId, userProfile.company_id);
             if (url) {
               Linking.openURL(url);
             }
          }
        }
      ]
    );
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
