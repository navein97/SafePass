# Question Database Update Rule

When updating questions in the Supabase `questions` table (e.g. from an Excel sheet provided by the user):

## NEVER delete + insert. Always UPDATE existing rows.

- If a question already exists (has an ID), use `UPDATE` to modify its text, options, correct answer, etc. **Keep the same ID.**
- Only use `INSERT` for brand new questions that don't replace any existing ones.
- This preserves historical references in `user_question_progress` and `user_batch_progress.answers`, preventing orphaned question IDs that cause "question no longer available" fallback messages in the driver review screen.

## SQL pattern to follow:
```sql
-- For existing questions (UPDATE, keep same ID):
UPDATE questions
SET text = '...', text_bm = '...', correct_answer = '...', options = '...'
WHERE id = 'existing-uuid';

-- For brand new questions only (INSERT):
INSERT INTO questions (batch_number, text, text_bm, correct_answer, options, ...)
VALUES (...);
```

## When the user provides an Excel file:
1. Check which questions already exist in the DB for that batch.
2. Match by ID or by batch_number + question position.
3. Generate UPDATE statements for existing questions.
4. Generate INSERT statements only for net-new questions.
5. Do NOT generate any DELETE statements for questions.
