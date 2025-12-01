# 🚀 Quick Setup Guide - Email Verification Fix

## ⚡ CRITICAL: Configure Supabase First!

### Step 1: Add Redirect URLs to Supabase
1. Go to https://app.supabase.com
2. Select your project
3. Go to **Authentication** → **URL Configuration**
4. Add these to **Redirect URLs**:
   ```
   https://safepass-kappa.vercel.app/auth/callback
   safepass://auth/callback
   exp://localhost:8081/--/auth/callback
   ```
5. **SAVE** ✅

### Step 2: Test It!

#### On Web (https://safepass-kappa.vercel.app):
1. Register a new account
2. You'll see: "✅ Check your email for verification link!" (toast notification)
3. Check your email
4. Click the verification link
5. You'll be redirected to the web app (not localhost!)
6. See success message
7. Auto-redirect to Login

#### On Mobile App:
1. Register a new account
2. You'll see: "✅ Check your email for verification link!" (toast notification)
3. Check your email
4. Click the verification link
5. In production: App opens directly
6. In development: May still show localhost (this is normal)

## ✨ What Changed

### Before:
- ❌ Alert dialog blocks the screen
- ❌ Email links go to localhost:3000
- ❌ Confusing user experience

### After:
- ✅ Smooth toast notification
- ✅ Web users → Vercel URL
- ✅ Mobile users → Deep link
- ✅ Professional UX

## 📱 How It Works

The app detects the platform and uses the correct redirect:

```typescript
Platform.OS === 'web' 
  ? 'https://safepass-kappa.vercel.app/auth/callback'  // Web
  : 'safepass://auth/callback'                          // Mobile
```

## 🎯 Key Files

- `src/components/Toast.tsx` - Toast notification component
- `src/screens/AuthCallbackScreen.tsx` - Handles web verification
- `src/services/authService.ts` - Platform detection logic
- `EMAIL_REDIRECT_SETUP.md` - Full documentation

## ⚠️ Troubleshooting

**Still seeing localhost?**
- Did you add the URLs to Supabase? (Step 1 above)
- Did you click SAVE in Supabase?
- Try clearing browser cache

**Deep link not working on mobile?**
- Are you testing on a production build?
- Expo Go may not support deep links fully
- Build with `eas build` for full testing

## 📞 Need Help?

See `EMAIL_REDIRECT_SETUP.md` for detailed troubleshooting and advanced configuration.
