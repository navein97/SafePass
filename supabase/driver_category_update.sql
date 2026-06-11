-- Add driver_categories to questions table
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS driver_categories TEXT[];

-- Update existing questions to apply to all 3 categories for backward compatibility (optional but safe)
UPDATE public.questions
SET driver_categories = ARRAY['General Cargo', 'Container Haulage', 'Box Van']
WHERE driver_categories IS NULL;
