import { supabase } from '../lib/supabase';
import { Platform } from 'react-native';

export type SubscriptionTier = 'trial' | 'standard' | 'enterprise';

export interface PackageDetails {
    id: SubscriptionTier;
    name: string;
    fleetRange: string;
    pricePerUser: number;
    freeManagerRatio: number;
    price: string;
    priceId: string;
    maxBatches: number;
}

// Trial tier is not a purchasable package — it's the default state.
// Only Standard and Enterprise are shown on the billing page.
export const PACKAGES: PackageDetails[] = [
    {
        id: 'standard',
        name: 'Standard',
        fleetRange: '1–100',
        pricePerUser: 250,
        freeManagerRatio: 25,
        price: 'RM 250/driver/year',
        priceId: 'price_standard_annual',
        maxBatches: 4,
    },
    {
        id: 'enterprise',
        name: 'Enterprise',
        fleetRange: '101+',
        pricePerUser: 200,
        freeManagerRatio: 25,
        price: 'RM 200/driver/year',
        priceId: 'price_enterprise_annual',
        maxBatches: 4,
    }
];

// Helper to calculate free managers from driver count
export const calculateFreeManagers = (driverCount: number, ratio: number = 25): number => {
    return Math.max(1, Math.ceil(driverCount / ratio));
};

// Helper to calculate total annual cost
export const calculateAnnualCost = (driverCount: number): { tier: PackageDetails; total: number; freeManagers: number } => {
    const tier = driverCount > 100 ? PACKAGES[1] : PACKAGES[0];
    const total = driverCount * tier.pricePerUser;
    const freeManagers = calculateFreeManagers(driverCount, tier.freeManagerRatio);
    return { tier, total, freeManagers };
};

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

    /**
     * Check if a company has an active paid subscription (not trial)
     */
    async isSubscribed(companyId: string): Promise<boolean> {
        try {
            const details = await this.getSubscriptionDetails(companyId);
            return details?.subscription_tier === 'standard' || details?.subscription_tier === 'enterprise';
        } catch {
            return false;
        }
    },

    /**
     * Get the maximum batches a company can access
     * Trial = 1 batch, Subscribed = 4 batches
     */
    async getMaxBatches(companyId: string | null): Promise<number> {
        if (!companyId) return 1; // No company = trial
        try {
            const subscribed = await this.isSubscribed(companyId);
            return subscribed ? 4 : 1;
        } catch {
            return 1;
        }
    },

    async createCheckoutSession(packageId: string, companyId: string, driverCount: number = 1) {
        const returnUrl = Platform.OS === 'web'
            ? `${window.location.origin}/billing`
            : 'https://qhnnyrpcnlddqoyewwkb.supabase.co/storage/v1/object/public/assets/success.html';

        const { data, error } = await supabase.functions.invoke('create-checkout-session', {
            body: { packageId, companyId, driverCount, returnUrl }
        });

        if (error || !data) {
            console.error('Error creating checkout session', error);
            return { url: null, error: error?.message || 'Failed to create session' };
        }

        return { url: data.url, error: null };
    }
};
