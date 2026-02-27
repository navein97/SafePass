import { supabase } from '../lib/supabase';

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

    /**
     * Create a Stripe Checkout Session
     * In a real app, this would be a Supabase Edge Function or Backend API call
     */
    async createCheckoutSession(packageId: string, companyId: string) {
        // For now, we mock the checkout URL. 
        // In production, this would return a real Stripe URL.
        return {
            url: `https://checkout.stripe.com/pay/${packageId}?client_reference_id=${companyId}`,
            error: null
        };
    }
};
