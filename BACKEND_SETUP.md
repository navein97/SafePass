# Backend Setup Instructions for CNG Driver 360

## Step 1: Run the SQL Script in Supabase

1. Open your **Supabase Dashboard**
2. Go to **SQL Editor**
3. Click **New Query**
4. Copy and paste the entire contents of `supabase_setup.sql`
5. Click **Run** to execute the script

This will:
- Add Master Profile columns (`designation`, `company_name`, `address`) to the `profiles` table
- Create the `notifications` table with proper RLS policies
- Create `delete_user()` function for managers
- Create `change_user_password()` function for managers

## Step 2: Verify the Setup

After running the script, verify everything is set up correctly:

### Check Columns
```sql
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'profiles' 
AND column_name IN ('designation', 'company_name', 'address', 'phone_number');
```

### Check Tables
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_name = 'notifications';
```

### Check Functions
```sql
SELECT routine_name 
FROM information_schema.routines 
WHERE routine_name IN ('delete_user', 'change_user_password');
```

## Step 3: Test the Features

Once the backend is set up, test these features in your app:

### 1. User Management
- ✅ **Create User**: Add a new user with password field
- ✅ **Delete User**: Delete a user (with confirmation)
- ✅ **Change Password**: Set a new password for any user
- ✅ **View Results**: See each user's score and batch progress

### 2. Master Profile Details
- ✅ Save designation, company name, address, and contact number
- ✅ Available for all users (managers and staff)

### 3. Notifications (Optional)
- If you want to use manual notifications, the table is ready
- The UI currently shows "Not Implemented" - you can enable it later

## Troubleshooting

### If user creation fails:
1. Check Supabase logs for errors
2. Verify the `profiles` table has all required columns
3. Check that RLS policies allow user creation

### If delete/password change fails:
1. Ensure you're logged in as a manager
2. Check Supabase logs for RPC function errors
3. Verify the functions were created successfully

### If Master Profile save fails:
1. Confirm the columns exist in the `profiles` table
2. Check that the column names match exactly: `designation`, `company_name`, `address`
3. Verify RLS policies allow updates

## What's Implemented

✅ **Delete User** - Full backend implementation with confirmation
✅ **Change Password** - Managers can set custom passwords for users
✅ **Master Profile Fields** - All columns added and save function working
✅ **User Results Display** - Shows score and batch progress in User Management
✅ **Password Field** - Added to Create User form with validation
✅ **Notifications Table** - Created and ready (UI shows "Not Implemented")

## Next Steps (Optional)

1. **Enable Manual Notifications**: Update the UI to actually use the NotificationSenderModal
2. **Add Email Notifications**: Integrate with a service like SendGrid
3. **Add User Roles**: Extend the role system beyond 'driver' and 'manager'
4. **Add Audit Logs**: Track who deleted/modified users
