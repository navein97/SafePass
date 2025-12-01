# 🔧 Fix: 404 Error on Email Confirmation

## 🔴 The Problem

When you click the email confirmation link, you get a **404: NOT_FOUND** error on Vercel.

**Root Cause:**
1.  **Server-Side Routing:** Vercel tries to find a file named `auth/callback` on the server, but it doesn't exist. Since this is a Single Page Application (SPA), we need to redirect all requests to `index.html`.
2.  **Client-Side Routing:** The app didn't know how to handle the `/auth/callback` URL because deep linking wasn't configured.

---

## ✅ The Solution

I have applied the following fixes:

### 1. Updated `vercel.json`
Added a rewrite rule to redirect all routes to `index.html`. This ensures that Vercel hands over control to your React app instead of showing a 404.

```json
"rewrites": [
  {
    "source": "/(.*)",
    "destination": "/index.html"
  }
]
```

### 2. Configured Deep Linking in `App.tsx`
Told React Navigation how to handle the URLs.

```typescript
const linking = {
  prefixes: [Linking.createURL('/'), 'https://safepass-kappa.vercel.app', 'safepass://'],
  config: {
    screens: {
      // ...
      AuthCallback: 'auth/callback', // Maps /auth/callback to AuthCallbackScreen
      // ...
    },
  },
};
```

### 3. Installed `expo-linking`
Run `npx expo install expo-linking` to support the deep linking configuration.

---

## 🚀 Next Steps

1.  **Re-deploy to Vercel:**
    You need to push these changes to your GitHub repository so Vercel can rebuild the app with the new configuration.

    ```bash
    git add .
    git commit -m "Fix 404 error on email redirect"
    git push
    ```

2.  **Test Again:**
    -   Register a new user (or use the "Resend Confirmation" feature if you implemented it).
    -   Click the link in the email.
    -   It should now open the app and show the "Verifying..." screen instead of a 404.

---

## 📱 Mobile App Note

For the mobile app (Android/iOS), the deep link `safepass://auth/callback` should already work if you build the app (`eas build`). In Expo Go, it might still be tricky, but the web flow is now fixed!
