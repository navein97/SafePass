# How to Fix the APK Build Issue

## Problem
Your APK is showing only the splash screen because the environment variables (Supabase credentials) are not being bundled with the build.

## Solution

### Option 1: Using EAS Secrets (Recommended)

1. **Add your Supabase credentials to EAS:**

```bash
# Replace with your actual Supabase URL
eas env:create --name EXPO_PUBLIC_SUPABASE_URL --value "https://your-project.supabase.co" --scope project

# Replace with your actual Supabase Anon Key
eas env:create --name EXPO_PUBLIC_SUPABASE_ANON_KEY --value "your-anon-key-here" --scope project
```

2. **Rebuild the APK:**

```bash
eas build --platform android --profile production
```

### Option 2: Using .env file directly (Quick Test)

If you just want to test quickly, you can build with the preview profile:

```bash
eas build --platform android --profile preview
```

This will use your local `.env` file automatically.

## Verification

After building, install the new APK and it should:
1. Show the splash screen briefly
2. Navigate to the Login screen
3. Allow you to login and use the app normally

## Common Issues

### Issue: "Environment variable not found"
**Solution:** Make sure you've set the secrets in EAS using the commands above.

### Issue: "Still showing splash screen"
**Solution:** 
1. Check that your `.env` file has the correct Supabase credentials
2. Verify the credentials work by running `npm start` locally
3. Make sure you're installing the NEW APK, not the old one

### Issue: "App crashes immediately"
**Solution:** This usually means there's a JavaScript error. Check:
1. All dependencies are installed: `npm install`
2. The app works locally: `npm start`
3. Check the logs during build for any errors

## What Changed

I've updated `eas.json` to include:
- Environment variable configuration for production builds
- Preview and development build profiles for testing
- Proper env variable mapping for Supabase credentials

The key change is in the `production` profile:
```json
"env": {
  "EXPO_PUBLIC_SUPABASE_URL": "${EXPO_PUBLIC_SUPABASE_URL}",
  "EXPO_PUBLIC_SUPABASE_ANON_KEY": "${EXPO_PUBLIC_SUPABASE_ANON_KEY}"
}
```

This tells EAS to inject these environment variables into your APK during the build process.
