# 🚀 SafePass - Production Setup Guide

## ✅ What's Been Implemented

### 1. **Backend Infrastructure**
- ✅ Supabase database schema (`supabase/schema.sql`)
- ✅ User authentication system
- ✅ Row-level security policies
- ✅ Database triggers and functions
- ✅ Sample question seed data (MY & PT)

### 2. **Authentication System**
- ✅ User registration with email verification
- ✅ Secure login with JWT tokens
- ✅ Session management
- ✅ Profile creation on signup
- ✅ Region assignment (Malaysia/Portugal)

### 3. **Mobile App Updates**
- ✅ Supabase client integration
- ✅ Real authentication service
- ✅ Registration screen
- ✅ Updated login screen
- ✅ Environment variable configuration

---

## 📝 Setup Instructions

### Step 1: Create Supabase Project

1. Go to https://supabase.com
2. Sign up and create a new project named "SafePass"
3. Wait for project initialization (2-3 minutes)

### Step 2: Run Database Setup

1. In Supabase Dashboard, go to **SQL Editor**
2. Click **"New Query"**
3. Copy the entire contents of `supabase/schema.sql`
4. Paste into the SQL editor
5. Click **"Run"** to execute

This will create:
- `profiles` table (user data)
- `questions` table (quiz questions)
- `quiz_attempts` table (quiz history)
- `compliance_logs` table (audit trail)
- Security policies
- Sample questions for MY and PT

### Step 3: Get API Credentials

1. Go to **Project Settings** → **API**
2. Copy these values:
   - **Project URL**: `https://xxxxx.supabase.co`
   - **anon public key**: `eyJhbGc...` (long string)

### Step 4: Configure App

1. Open `.env` file in SafePass folder
2. Add your credentials:

```env
EXPO_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=your_anon_key_here
```

3. Save the file

### Step 5: Test the App

1. Restart the Expo server:
   ```bash
   npx expo start --web
   ```

2. Open http://localhost:8081

3. Click **"Register"** to create a test account:
   - Full Name: Test Driver
   - Employee ID: DRV-001
   - Email: test@company.com
   - Password: test123
   - Region: Malaysia

4. Check your email for verification link (optional in dev mode)

5. Login with your credentials

---

## 🎯 What Works Now

### ✅ Real User Registration
- Drivers can create accounts
- Email verification (optional)
- Profile auto-creation
- Region assignment

### ✅ Secure Authentication
- JWT token-based auth
- Session persistence
- Auto-refresh tokens
- Secure password hashing

### ✅ Database Integration
- All user data stored in Supabase
- Row-level security enforced
- Real-time data sync ready

---

## 🚧 Next Steps (To Complete Production App)

### Phase 1: Connect Quiz System to Database

**File to update:** `src/services/quizService.ts`

```typescript
// Replace mock data with Supabase queries
async generateWeeklyQuiz(region: Region): Promise<Question[]> {
  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .contains('regions', [region])
    .limit(30);
  
  // Shuffle and return
  return shuffleArray(data || []);
}
```

### Phase 2: Save Quiz Attempts to Database

```typescript
async submitQuiz(userId: string, answers: Answer[]) {
  // Save to quiz_attempts table
  const { data, error } = await supabase
    .from('quiz_attempts')
    .insert({
      user_id: userId,
      score: calculateScore(answers),
      answers: JSON.stringify(answers),
      week_number: getWeek(new Date()),
      year: getYear(new Date()),
    });
  
  // Also save to compliance_logs
  await saveComplianceLog(userId, score);
}
```

### Phase 3: Update Profile Screen

**File:** `src/screens/ProfileScreen.tsx`

```typescript
// Fetch real user profile from Supabase
const { profile } = await AuthService.getUserProfile();
```

### Phase 4: Manager Quick View with Real Data

**File:** `src/screens/ManagerQuickViewScreen.tsx`

```typescript
// Fetch compliance logs from database
const { data: logs } = await supabase
  .from('compliance_logs')
  .select('*')
  .eq('user_id', userId)
  .order('created_at', { ascending: false });
```

### Phase 5: Build Admin Web Portal

Create a separate Next.js app for:
- Uploading questions (CSV/JSON)
- Viewing all drivers
- Compliance dashboard
- Analytics & reports

---

## 🔒 Security Features

✅ **Row-Level Security (RLS)**
- Drivers can only see their own data
- Managers can view all drivers
- Admins have full access

✅ **Password Security**
- Bcrypt hashing
- Minimum 6 characters
- Stored securely in Supabase

✅ **API Security**
- JWT tokens for authentication
- Anon key for public access
- Service key for admin operations (never expose!)

---

## 📊 Database Schema Overview

```
profiles
├── id (UUID, primary key)
├── email (unique)
├── full_name
├── employee_id (unique)
├── region (MY/PT)
├── role (driver/manager/admin)
└── safety_index

questions
├── id (UUID)
├── text
├── options (JSON array)
├── correct_option_index
├── explanation
├── regions (array)
└── category

quiz_attempts
├── id (UUID)
├── user_id (foreign key)
├── score
├── answers (JSON)
├── week_number
├── year
└── completed_at

compliance_logs
├── id (UUID)
├── user_id (foreign key)
├── week_number
├── year
├── status (COMPLIANT/OVERDUE)
├── score
├── signature (HMAC)
└── completed_at
```

---

## 🎉 You're Ready!

Once you complete Steps 1-4 above, you'll have:

✅ A production-ready backend
✅ Real user authentication
✅ Secure database with RLS
✅ Sample questions loaded
✅ Foundation for full app

**Next:** I'll help you connect the quiz system and build the admin portal!

---

## 📞 Need Help?

If you encounter any issues:
1. Check Supabase logs in Dashboard → Logs
2. Check browser console for errors
3. Verify `.env` file has correct credentials
4. Ensure SQL schema ran successfully

Let me know when you're ready to continue! 🚀
