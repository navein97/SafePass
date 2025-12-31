-- Verify questions were inserted
SELECT 
  id,
  text,
  regions,
  category,
  image_url,
  created_at
FROM public.questions
ORDER BY created_at DESC;

-- Count total questions
SELECT COUNT(*) as total_questions FROM public.questions;

-- Count questions by region
SELECT 
  UNNEST(regions) as region,
  COUNT(*) as count
FROM public.questions
GROUP BY region;
