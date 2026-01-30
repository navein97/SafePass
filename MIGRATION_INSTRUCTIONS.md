# Database Migration Instructions

## Option 1: Using Supabase Dashboard (Recommended)

1. Go to your Supabase project dashboard: https://supabase.com/dashboard
2. Navigate to **SQL Editor** in the left sidebar
3. Click **New Query**
4. Copy and paste the contents of `supabase/migrations/20260129T111649_batch_system.sql`
5. Click **Run** to execute the migration
6. Verify in the **Table Editor** that the new tables exist:
   - `quiz_batches`
   - `user_batch_progress`
   - Check `profiles` table has new columns: `current_batch`, `total_batches_completed`

## Option 2: Using Supabase CLI

If you have Supabase CLI installed:

```bash
# Login to Supabase
supabase login

# Link to your project
supabase link --project-ref YOUR_PROJECT_REF

# Run the migration
supabase db push
```

## Option 3: Using a Migration Script

Run the provided script:

```bash
node scripts/run_migration.js
```

## Verification Queries

After running the migration, verify it worked:

```sql
-- Check quiz_batches table
SELECT batch_number, array_length(question_ids, 1) as question_count 
FROM quiz_batches 
ORDER BY batch_number;

-- Should return 4 rows, each with 30 questions

-- Check profiles columns
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'profiles' 
AND column_name IN ('current_batch', 'total_batches_completed');

-- Should return 2 rows
```

## Rollback (if needed)

If something goes wrong:

```sql
DROP TABLE IF EXISTS user_batch_progress;
DROP TABLE IF EXISTS quiz_batches;
ALTER TABLE profiles DROP COLUMN IF EXISTS current_batch;
ALTER TABLE profiles DROP COLUMN IF EXISTS total_batches_completed;
```

## Next Steps

After successful migration:
1. Test batch loading in the app
2. Test quiz submission
3. Verify leaderboard data
4. Test Excel export for managers
