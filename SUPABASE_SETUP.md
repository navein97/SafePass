# Supabase Setup Guide for SafePass

## Step 1: Create Supabase Account

1. Go to https://supabase.com
2. Click "Start your project" or "Sign in"
3. Sign up with GitHub or email
4. Verify your email

## Step 2: Create New Project

1. Click "New Project"
2. Fill in:
   - **Name:** SafePass
   - **Database Password:** (choose a strong password - SAVE THIS!)
   - **Region:** Choose closest to your users (e.g., Southeast Asia)
   - **Pricing Plan:** Free (sufficient for development and small deployments)
3. Click "Create new project"
4. Wait 2-3 minutes for project to initialize

## Step 3: Get Your API Keys

Once the project is ready:

1. Go to **Project Settings** (gear icon in sidebar)
2. Click **API** in the left menu
3. You'll see:
   - **Project URL:** `https://xxxxx.supabase.co`
   - **anon public key:** `eyJhbGc...` (long string)
   - **service_role key:** `eyJhbGc...` (long string - KEEP SECRET!)

## Step 4: Copy Your Credentials

**IMPORTANT:** Copy these values - you'll need them in the next step:

```
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
```

## Step 5: Run Database Setup

After you provide me with these credentials, I will:
1. Create the database schema (tables for users, questions, quizzes, etc.)
2. Set up Row Level Security (RLS) policies
3. Populate sample questions for Malaysia and Portugal
4. Configure authentication

## What You'll Get

✅ User registration and login
✅ Secure password hashing
✅ Quiz attempt tracking
✅ Compliance audit logs
✅ Question bank management
✅ Admin web portal
✅ Real-time data sync

---

## Next Steps

**Please complete Steps 1-4 above, then provide me with:**
1. Your Supabase Project URL
2. Your Supabase Anon Key

I'll handle all the database setup and code integration automatically!
