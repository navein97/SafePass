-- Fix old/outdated vehicle_type data in the profiles table

-- 1. Standardize known variations for Box Van
UPDATE public.profiles
SET vehicle_type = 'Box Van'
WHERE vehicle_type ILIKE '%box%' 
   OR vehicle_type ILIKE '%van%';

-- 2. Standardize known variations for Container Haulage
UPDATE public.profiles
SET vehicle_type = 'Container Haulage'
WHERE vehicle_type ILIKE '%container%' 
   OR vehicle_type ILIKE '%haulage%'
   OR vehicle_type ILIKE '%trailer%';

-- 3. Standardize known variations for General Cargo
UPDATE public.profiles
SET vehicle_type = 'General Cargo'
WHERE vehicle_type ILIKE '%cargo%' 
   OR vehicle_type ILIKE '%general%';

-- 4. Catch-all: Any driver who STILL doesn't have one of the 3 exact categories
-- will be defaulted to 'General Cargo' so their app doesn't break.
-- (You can change 'General Cargo' below to whichever default makes the most sense)
UPDATE public.profiles
SET vehicle_type = 'General Cargo'
WHERE vehicle_type NOT IN ('Box Van', 'Container Haulage', 'General Cargo')
   OR vehicle_type IS NULL;
