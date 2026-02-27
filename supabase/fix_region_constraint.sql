-- Add new regions to the CHECK constraint
ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_region_check;
ALTER TABLE public.profiles ADD CONSTRAINT profiles_region_check CHECK (region IN ('MY', 'PT', 'TH', 'SG', 'ID', 'VN', 'PH'));
