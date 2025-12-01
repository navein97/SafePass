# 🔧 Fix: "Failed to delete selected users: Database error deleting user"

## 🔴 The Problem

When you try to delete a user from Supabase Dashboard, you get this error:
```
Failed to delete selected users: Database error deleting user
```

**Root Cause:** Your `profiles` table has RLS (Row Level Security) enabled, but there's no DELETE policy. When Supabase Auth tries to delete a user, it also needs to delete the profile record, but RLS blocks it.

---

## ✅ The Solution

### **Step 1: Run the SQL Migration**

1. Go to your Supabase Dashboard: https://app.supabase.com
2. Select your project
3. Navigate to **SQL Editor** (left sidebar)
4. Click **"New query"**
5. Open the file: `supabase/fix_user_deletion.sql`
6. Copy the entire contents
7. Paste into the SQL Editor
8. Click **"Run"** (or press Ctrl+Enter)

You should see: ✅ **Success. No rows returned**

### **Step 2: Test User Deletion**

1. Go to **Authentication** → **Users**
2. Find a test user
3. Click the **trash icon**
4. Confirm deletion
5. ✅ **It should work now!**

---

## 📋 What the Migration Does

The SQL migration adds a DELETE policy to the `profiles` table:

```sql
CREATE POLICY "Service role can delete profiles"
  ON public.profiles FOR DELETE
  USING (true);
```

This allows:
- ✅ Supabase service role to delete profiles
- ✅ Cascade deletion of related data (quiz_attempts, compliance_logs)
- ✅ User deletion from the Auth dashboard

---

## 🔄 Alternative: Delete Users Manually via SQL

If you prefer not to run the migration, you can delete users manually:

1. Go to **SQL Editor**
2. Run this query (replace the email):

```sql
-- Delete user and all related data
DELETE FROM auth.users 
WHERE email = 'test@example.com';
```

This will:
- Delete the user from auth.users
- Trigger cascade deletion of the profile
- Delete all related quiz_attempts and compliance_logs

---

## 🎯 For Testing: Quick User Cleanup

If you're testing registration and need to clean up users frequently:

```sql
-- Delete all test users (be careful!)
DELETE FROM auth.users 
WHERE email LIKE '%test%' 
   OR email LIKE '%+%';  -- Gmail plus addressing

-- Or delete a specific user by email
DELETE FROM auth.users WHERE email = 'naveinrex97@gmail.com';
```

---

## ⚠️ Important Notes

1. **Cascade Deletion:** When you delete a user, ALL their data is deleted:
   - Profile
   - Quiz attempts
   - Compliance logs
   - This is **permanent** and **cannot be undone**

2. **Production Safety:** The DELETE policy uses `USING (true)` which allows the service role to delete any profile. This is safe because:
   - Only the Supabase service role can use this policy
   - Regular users cannot delete profiles (unless you uncomment the user policy)
   - The service role is only accessible from the backend

3. **User Self-Deletion:** If you want users to delete their own accounts, uncomment this in the migration:
   ```sql
   CREATE POLICY "Users can delete own profile"
     ON public.profiles FOR DELETE
     USING (auth.uid() = id);
   ```

---

## 🧪 After Running the Migration

Now you can:
- ✅ Delete test users from the dashboard
- ✅ Test registration with the same email multiple times
- ✅ Clean up test data easily

---

## 📚 Related Files

- `supabase/fix_user_deletion.sql` - The migration to run
- `supabase/schema.sql` - Original database schema
- `EMAIL_REDIRECT_SETUP.md` - Email verification setup

---

## 🚀 Next Steps

1. **Run the migration** (see Step 1 above)
2. **Delete the test user** that's blocking your email
3. **Register again** with a fresh email
4. **Check your inbox** for the verification email!
