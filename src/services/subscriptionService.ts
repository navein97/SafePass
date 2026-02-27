import { supabase } from '../lib/supabase';
import { Platform } from 'react-native';

export type SubscriptionTier = 'starter' | 'growth' | 'enterprise';

export interface PackageDetails {
    id: SubscriptionTier;
    name: string;
    driverQuota: number;
    managerQuota: number;
    price: string;
    priceId: string; // Stripe Price ID
}

export const PACKAGES: PackageDetails[] = [
    {
        id: 'starter',
        name: 'Starter',
        driverQuota: 5,
        managerQuota: 1,
        price: 'RM 199/mo',
        priceId: 'price_starter_mock'
    },
    {
        id: 'growth',
        name: 'Growth',
        driverQuota: 25,
        managerQuota: 3,
        price: 'RM 499/mo',
        priceId: 'price_growth_mock'
    },
    {
        id: 'enterprise',
        name: 'Enterprise',
        driverQuota: 100,
        managerQuota: 10,
        price: 'RM 999/mo',
        priceId: 'price_enterprise_mock'
    }
];

export const SubscriptionService = {
    /**
     * Get current company subscription details
     */
    async getSubscriptionDetails(companyId: string) {
        const { data, error } = await supabase
            .from('companies')
            .select('subscription_tier, quota_drivers, quota_managers')
            .eq('id', companyId)
            .single();

        if (error) throw error;
        return data;
    },

    async createCheckoutSession(packageId: string, companyId: string) {
        // Use window.location.origin on web to support local dev, preview domains, and prod correctly.
        // For native apps, use the production HTTPS universal link to ensure Stripe redirects reliably.
        const returnUrl = Platform.OS === 'web'
            ? `${window.location.origin}/billing`
            : 'https://safepass.app/billing';

        const { data, error } = await supabase.functions.invoke('create-checkout-session', {
            body: { packageId, companyId, returnUrl }
        });

        if (error || !data) {
            console.error('Error creating checkout session', error);
            return { url: null, error: error?.message || 'Failed to create session' };
        }

        return { url: data.url, error: null };
    }
};
