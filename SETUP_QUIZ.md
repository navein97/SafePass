# SafePass Quiz Setup Instructions

To fix the quiz blank screen issue and add the new questions (including 5 with images), please follow these steps:

## 1. Run the Database Migration

You need to update your Supabase database schema and insert the new questions.

1.  Go to your **Supabase Dashboard**.
2.  Navigate to the **SQL Editor**.
3.  Click **New Query**.
4.  Copy the contents of the file `supabase/update_questions.sql` (located in your project).
5.  Paste it into the SQL Editor.
6.  Click **Run**.

## 2. Verify Images (Optional)

We have added 5 traffic sign images to `assets/quiz`. The app is configured to use these local assets when the matching question is loaded.

## 3. Restart the App

After running the SQL, restart your Expo app to ensure the new questions are loaded correctly.

```bash
npx expo start -c
```

The quiz should now contain 20 questions, and the first 5 will be visual questions with traffic signs.
