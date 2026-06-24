-- 1. Create the subscription_packages table
CREATE TABLE IF NOT EXISTS public.subscription_packages (
    id text PRIMARY KEY,
    name text NOT NULL,
    fleet_range text NOT NULL,
    price_per_user numeric NOT NULL,
    free_manager_ratio integer NOT NULL,
    price_display text NOT NULL,
    stripe_price_id text NOT NULL,
    max_batches integer NOT NULL,
    min_drivers integer NOT NULL,
    max_drivers integer,
    is_active boolean DEFAULT true,
    sort_order integer NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.subscription_packages ENABLE ROW LEVEL SECURITY;

-- 3. Add policy to allow public read access
CREATE POLICY "Allow public read access to subscription packages"
ON public.subscription_packages
FOR SELECT
USING (true);

-- 4. Insert initial package data
INSERT INTO public.subscription_packages (
    id, name, fleet_range, price_per_user, free_manager_ratio, price_display, stripe_price_id, max_batches, min_drivers, max_drivers, is_active, sort_order
) VALUES 
('standard', 'Standard', '1–100', 120, 25, 'RM 120/driver/year', 'price_1TlrmnLzh6eCIr6DJDYkulBN', 4, 1, 100, true, 1),
('enterprise', 'Enterprise', '101+', 98, 25, 'RM 98/driver/year', 'price_1TlrnULzh6eCIr6DRkCilK3F', 4, 101, null, true, 2),
('test', 'Test (RM1/year)', '1', 1, 1, 'RM 1/year', 'price_test_annual', 4, 1, null, false, 99)
ON CONFLICT (id) DO UPDATE SET
    name = EXCLUDED.name,
    fleet_range = EXCLUDED.fleet_range,
    price_per_user = EXCLUDED.price_per_user,
    free_manager_ratio = EXCLUDED.free_manager_ratio,
    price_display = EXCLUDED.price_display,
    stripe_price_id = EXCLUDED.stripe_price_id,
    max_batches = EXCLUDED.max_batches,
    min_drivers = EXCLUDED.min_drivers,
    max_drivers = EXCLUDED.max_drivers,
    is_active = EXCLUDED.is_active,
    sort_order = EXCLUDED.sort_order,
    updated_at = now();
