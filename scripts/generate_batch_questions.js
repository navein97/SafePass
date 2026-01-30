const fs = require('fs');
const path = require('path');

// Load existing questions
const questionsMY = require('../src/data/questionsMY.json');

// Select 10 diverse base questions
// Strategy: Pick questions with different category weights and scenarios
const selectedBaseQuestions = [
  questionsMY[0],  // my_int_001 - Loading area
  questionsMY[1],  // my_int_002 - Traffic speed management
  questionsMY[2],  // my_int_003 - Forklift operations
  questionsMY[3],  // my_int_004 - Customer entrance
  questionsMY[4],  // my_int_005 - Terminal operations
  questionsMY[5],  // my_int_006 - Multi-lane positioning
  questionsMY[6],  // my_int_007 - Following distance
  questionsMY[7],  // my_int_008 - Lane changes
  questionsMY[8],  // my_int_009 - Highway merging
  questionsMY[9],  // my_int_010 - Junction approach
];

console.log('✅ Selected 10 base questions');

// Generate 120 questions (10 base × 12 duplicates)
const allQuestions = [];

selectedBaseQuestions.forEach((baseQ, baseIndex) => {
  for (let dupIndex = 0; dupIndex < 12; dupIndex++) {
    const duplicatedQuestion = {
      ...baseQ,
      id: `${baseQ.id}_dup${String(dupIndex + 1).padStart(2, '0')}`,
      // Keep all other properties identical
    };
    allQuestions.push(duplicatedQuestion);
  }
});

console.log(`✅ Generated ${allQuestions.length} total questions`);

// Shuffle the 120 questions using Fisher-Yates algorithm
function shuffle(array) {
  const result = [...array];
  for (let i = result.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}

const shuffledQuestions = shuffle(allQuestions);

// Organize into 4 batches of 30 questions each
const batches = {
  batch1: shuffledQuestions.slice(0, 30),
  batch2: shuffledQuestions.slice(30, 60),
  batch3: shuffledQuestions.slice(60, 90),
  batch4: shuffledQuestions.slice(90, 120),
};

console.log('✅ Organized into 4 batches of 30 questions each');

// Save batch questions to individual files
const dataDir = path.join(__dirname, '../src/data/batches');
if (!fs.existsSync(dataDir)) {
  fs.mkdirSync(dataDir, { recursive: true });
}

Object.keys(batches).forEach((batchName, index) => {
  const batchNumber = index + 1;
  const filePath = path.join(dataDir, `${batchName}.json`);
  fs.writeFileSync(filePath, JSON.stringify(batches[batchName], null, 2));
  console.log(`✅ Saved ${batchName}.json (${batches[batchName].length} questions)`);
});

// Generate SQL migration file
const questionIds = {
  batch1: batches.batch1.map(q => q.id),
  batch2: batches.batch2.map(q => q.id),
  batch3: batches.batch3.map(q => q.id),
  batch4: batches.batch4.map(q => q.id),
};

const sqlMigration = `-- Migration: Create Batch-Based Quiz System
-- Generated: ${new Date().toISOString()}

-- Create quiz_batches table
CREATE TABLE IF NOT EXISTS quiz_batches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  batch_number INTEGER NOT NULL UNIQUE CHECK (batch_number BETWEEN 1 AND 4),
  question_ids TEXT[] NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Create user_batch_progress table
CREATE TABLE IF NOT EXISTS user_batch_progress (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
  batch_number INTEGER NOT NULL CHECK (batch_number BETWEEN 1 AND 4),
  attempt_number INTEGER NOT NULL DEFAULT 1,
  score DECIMAL(5,2) NOT NULL,
  accuracy_percentage DECIMAL(5,2),
  completion_percentage DECIMAL(5,2),
  component_scores JSONB,
  answers JSONB NOT NULL,
  time_spent_seconds INTEGER DEFAULT 0,
  completed_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(user_id, batch_number, attempt_number)
);

-- Add batch tracking columns to profiles
ALTER TABLE profiles 
  ADD COLUMN IF NOT EXISTS current_batch INTEGER DEFAULT 1 CHECK (current_batch BETWEEN 1 AND 4),
  ADD COLUMN IF NOT EXISTS total_batches_completed INTEGER DEFAULT 0;

-- Insert batch question mappings
INSERT INTO quiz_batches (batch_number, question_ids) VALUES
  (1, ARRAY[${questionIds.batch1.map(id => `'${id}'`).join(', ')}]),
  (2, ARRAY[${questionIds.batch2.map(id => `'${id}'`).join(', ')}]),
  (3, ARRAY[${questionIds.batch3.map(id => `'${id}'`).join(', ')}]),
  (4, ARRAY[${questionIds.batch4.map(id => `'${id}'`).join(', ')}])
ON CONFLICT (batch_number) DO UPDATE SET question_ids = EXCLUDED.question_ids;

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_user_batch_progress_user ON user_batch_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_batch_progress_batch ON user_batch_progress(batch_number);
CREATE INDEX IF NOT EXISTS idx_profiles_current_batch ON profiles(current_batch);

COMMENT ON TABLE quiz_batches IS 'Fixed question sets for each batch (1-4)';
COMMENT ON TABLE user_batch_progress IS 'User progress tracking for batch-based quizzes with unlimited attempts';
COMMENT ON COLUMN user_batch_progress.score IS 'Weighted score based on attempt numbers (1st=1.0, 2nd=0.5, 3rd=0.25, 4th+=0)';
COMMENT ON COLUMN user_batch_progress.accuracy_percentage IS 'Percentage of attempted questions answered correctly';
COMMENT ON COLUMN user_batch_progress.completion_percentage IS 'Percentage of total batch questions attempted';
`;

const migrationPath = path.join(__dirname, '../supabase/migrations');
if (!fs.existsSync(migrationPath)) {
  fs.mkdirSync(migrationPath, { recursive: true });
}

const timestamp = new Date().toISOString().replace(/[-:]/g, '').split('.')[0];
const migrationFile = path.join(migrationPath, `${timestamp}_batch_system.sql`);
fs.writeFileSync(migrationFile, sqlMigration);

console.log(`✅ Generated SQL migration: ${path.basename(migrationFile)}`);
console.log('\n📊 Summary:');
console.log(`   - Base questions: 10`);
console.log(`   - Total questions: 120`);
console.log(`   - Batches: 4`);
console.log(`   - Questions per batch: 30`);
console.log('\n✅ Batch generation complete!');
