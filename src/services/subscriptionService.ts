import { supabase } from '../lib/supabase';
import { Platform } from 'react-native';

export type SubscriptionTier = 'trial' | 'standard' | 'enterprise' | 'test' | string;

export interface PackageDetails {
    id: SubscriptionTier;
    name: string;
    fleetRange: string;
    pricePerUser: number;
    freeManagerRatio: number;
    price: string;
    priceId: string;
    maxBatches: number;
    minDrivers: number;
    maxDrivers: number | null;
}

// Helper to calculate free managers from driver count
export const calculateFreeManagers = (driverCount: number, ratio: number = 25): number => {
    return Math.max(1, Math.ceil(driverCount / ratio));
};

// Helper to calculate total annual cost dynamically
export const calculateAnnualCost = (driverCount: number, packages: PackageDetails[]): { tier: PackageDetails | null; total: number; freeManagers: number } => {
    if (!packages || packages.length === 0) return { tier: null, total: 0, freeManagers: 0 };
    
    // Find matching tier based on min and max drivers
    let tier = packages.find(p => driverCount >= p.minDrivers && (p.maxDrivers === null || driverCount <= p.maxDrivers));
    
    // Fallback: if no tier matches, use the highest tier (last one assuming sorted)
    if (!tier) {
        tier = packages[packages.length - 1];
    }

    const total = driverCount * tier.pricePerUser;
    const freeManagers = calculateFreeManagers(driverCount, tier.freeManagerRatio);
    return { tier, total, freeManagers };
};

export const SubscriptionService = {
    /**
     * Get active packages from Supabase
     */
    async getPackages(): Promise<PackageDetails[]> {
        const { data, error } = await supabase
            .from('subscription_packages')
            .select('*')
            .eq('is_active', true)
            .order('sort_order', { ascending: true });

        if (error || !data) {
            console.error('Error fetching packages', error);
            return [];
        }

        return data.map(d => ({
            id: d.id,
            name: d.name,
            fleetRange: d.fleet_range,
            pricePerUser: d.price_per_user,
            freeManagerRatio: d.free_manager_ratio,
            price: d.price_display,
            priceId: d.stripe_price_id,
            maxBatches: d.max_batches,
            minDrivers: d.min_drivers,
            maxDrivers: d.max_drivers
        }));
    },

    /**
     * Get current company subscription details
     */
    async getSubscriptionDetails(companyId: string) {
        const { data, error } = await supabase
            .from('companies')
            .select('subscription_tier, quota_drivers, quota_managers, trial_end_date')
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

    async createCheckoutSession(packageId: string, companyId: string, driverCount: number = 1, billingYears: 1 | 2 = 1) {
        const returnUrl = Platform.OS === 'web'
            ? `${window.location.origin}/billing`
            : 'https://qhnnyrpcnlddqoyewwkb.supabase.co/storage/v1/object/public/assets/success.html';

        const { data, error } = await supabase.functions.invoke('create-checkout-session', {
            body: { packageId, companyId, driverCount, returnUrl, billingYears }
        });

        if (error || !data) {
            console.error('Error creating checkout session', error);
            return { url: null, error: error?.message || 'Failed to create session' };
        }

        return { url: data.url, error: null };
    },

    async createPortalSession(companyId: string) {
        const returnUrl = Platform.OS === 'web'
            ? `${window.location.origin}/billing`
            : 'https://qhnnyrpcnlddqoyewwkb.supabase.co/storage/v1/object/public/assets/success.html';

        const { data, error } = await supabase.functions.invoke('create-portal-session', {
            body: { companyId, returnUrl }
        });

        if (error || !data) {
            console.error('Error creating portal session', error);
            return { url: null, error: error?.message || 'Failed to open portal' };
        }

        return { url: data.url, error: null };
    }
};
