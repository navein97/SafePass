# Email Verification Redirect Configuration

## Problem
After clicking the email verification link, users are being redirected to `localhost:3000` instead of the mobile app.

## Solution
The email verification links need to redirect to your mobile app using a deep link scheme.

## Steps to Configure Supabase

### 1. Update Supabase Redirect URLs

1. Go to your Supabase Dashboard: https://app.supabase.com
2. Select your project: `qhnnyrpcnlddqoyewwkb`
3. Navigate to **Authentication** → **URL Configuration**
4. Add the following URLs to **Redirect URLs**:

   ```
   https://safepass-kappa.vercel.app/auth/callback
   safepass://auth/callback
   exp://localhost:8081/--/auth/callback
   ```

   - `https://safepass-kappa.vercel.app/auth/callback` - For web users (Vercel deployment)
   - `safepass://auth/callback` - For mobile app (production builds)
   - `exp://localhost:8081/--/auth/callback` - For Expo development

5. Click **Save**

### 2. What We Changed in the Code

#### app.json
- Added `"scheme": "safepass"` to enable deep linking for mobile
- Added `"bundleIdentifier": "com.safepass.app"` for iOS

#### authService.ts
- Added platform detection using `Platform.OS`
- For **web**: Uses `https://safepass-kappa.vercel.app/auth/callback`
- For **mobile**: Uses `safepass://auth/callback`
- This ensures users are redirected to the correct platform

#### AuthCallbackScreen.tsx (NEW)
- Created a new screen to handle email verification callbacks on web
- Shows verification status with loading, success, or error states
- Automatically redirects to Login or Home after verification

#### RegisterScreen.tsx
- Replaced Alert dialog with Toast notification
- Shows "✅ Check your email for verification link!" message
- Automatically navigates to Login screen after 2 seconds

#### Toast.tsx (NEW)
- Created a reusable toast notification component
- Supports success, error, and info message types
- Smooth slide-in and fade-out animations

### 3. Testing

1. **Web (Vercel):**
   - Visit https://safepass-kappa.vercel.app
   - Register a new account
   - Check your email for the verification link
   - Click the link - it should redirect to `https://safepass-kappa.vercel.app/auth/callback`
   - You'll see a verification success message
   - You'll be automatically redirected to the Login screen

2. **Mobile - Development Mode:**
   - When testing in Expo Go, the redirect might still show localhost
   - This is expected behavior in development
   - The deep link will work properly in production builds

3. **Mobile - Production Build:**
   - Build your app using `eas build`
   - Install on a device
   - Register a new account
   - Click the verification link in your email
   - The link should now open your app directly

### 4. Additional Configuration (Optional)

If you want to handle the email verification callback in your app:

1. Create a new screen to handle the auth callback
2. Update your navigation to include this route
3. Parse the URL parameters to confirm the email verification

Example:
```typescript
// In your navigation setup
import * as Linking from 'expo-linking';

// Handle deep links
Linking.addEventListener('url', (event) => {
  const { url } = event;
  if (url.includes('auth/callback')) {
    // Handle email verification
    // Show success message
    // Navigate to login
  }
});
```

## Notes

- The deep link scheme `safepass://` is now configured in your app
- Email verification links will redirect to `safepass://auth/callback`
- In development with Expo Go, you might see different behavior
- For production, the deep link will work as expected

## Troubleshooting

**Issue:** Still redirecting to localhost
- **Solution:** Make sure you saved the redirect URLs in Supabase Dashboard
- **Solution:** Clear your browser cache and try again
- **Solution:** Check that the scheme matches exactly: `safepass://`

**Issue:** Deep link not opening the app
- **Solution:** Make sure you're testing on a production build, not Expo Go
- **Solution:** Verify the scheme in app.json matches the redirect URL
- **Solution:** Reinstall the app after making changes to app.json
