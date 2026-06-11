"""
import_questions.py
===================
Reads quiz_question_template_V1106.2026_NAV_no_yellow_rows.xlsx and
uploads all questions to Supabase with correct driver_categories tagging.

Each sheet in the Excel file maps to a driver category:
  - 'Box_Van'           -> 'Box Van'
  - 'Container haulage' -> 'Container Haulage'
  - 'general cargo'     -> 'General Cargo'

Usage:
    python import_questions.py

Requirements:
    pip install pandas openpyxl supabase
"""

import pandas as pd
import uuid
import json
import sys
import os

# ── CONFIG ──────────────────────────────────────────────────────────────────
EXCEL_FILE = r'c:\Users\ACER\SafePass\quiz_question_template_V1106.2026_NAV_no_yellow_rows.xlsx'
SUPABASE_URL = 'https://qhnnyrpcnlddqoyewwkb.supabase.co'
# Use the SERVICE ROLE key (not anon) so we can bypass RLS for import.
# Get it from: Supabase Dashboard -> Project Settings -> API -> service_role secret
SUPABASE_SERVICE_KEY = os.environ.get('SUPABASE_SERVICE_KEY', '')

# Sheet name → vehicle_type label (must match exactly what's stored in profiles.vehicle_type)
SHEET_TO_CATEGORY = {
    'Box_Van':           'Box Van',
    'Container haulage': 'Container Haulage',
    'general cargo':     'General Cargo',
}

REGION = 'MY'          # All questions are MY for now
DIFFICULTY = 'intermediate'
# ────────────────────────────────────────────────────────────────────────────

def esc(s: str) -> str:
    """Escape single quotes for SQL."""
    return str(s).replace("'", "''")

def parse_float(val) -> float:
    try:
        v = float(val)
        return 0.0 if pd.isna(v) else v
    except (ValueError, TypeError):
        return 0.0

def parse_int(val, default=1) -> int:
    try:
        v = int(val)
        return v if not pd.isna(float(val)) else default
    except (ValueError, TypeError):
        return default

def read_sheet(xl: pd.ExcelFile, sheet_name: str) -> list[dict]:
    """Parse one sheet and return a list of question dicts ready for Supabase."""
    df = pd.read_excel(xl, sheet_name=sheet_name)
    category = SHEET_TO_CATEGORY[sheet_name]
    questions = []

    for _, row in df.iterrows():
        text_en = str(row.get('Question Text (English)', '')).strip()
        if not text_en or text_en.lower() == 'nan':
            continue

        opt_a = str(row.get('Option A', '')).strip()
        opt_b = str(row.get('Option B', '')).strip()
        opt_c = str(row.get('Option C', '')).strip()
        opt_d = str(row.get('Option D', '')).strip()

        # Column 'Unnamed: 5' is the correct answer letter (A/B/C/D)
        correct_letter = str(row.get('Unnamed: 5', '')).strip().upper()
        answer_map = {'A': 0, 'B': 1, 'C': 2, 'D': 3}
        if correct_letter not in answer_map:
            print(f"  ⚠️  Skipping question (bad answer letter '{correct_letter}'): {text_en[:60]}...")
            continue
        correct_index = answer_map[correct_letter]

        explanation_en = str(row.get('Explanation (English)', '')).strip()

        weight_op   = parse_float(row.get('DOPD Operation Weight (%)', 0))
        weight_disc = parse_float(row.get('DOPD Discipline Weight (%)', 0))
        weight_prof = parse_float(row.get('DOPD Professionalism Weight (%)', 0))

        text_ms         = str(row.get('Malay Question Text', '')).strip()
        opt_ms_a        = str(row.get('Malay Option A', '')).strip()
        opt_ms_b        = str(row.get('Malay Option B', '')).strip()
        opt_ms_c        = str(row.get('Malay Option C', '')).strip()
        opt_ms_d        = str(row.get('Malay Option D', '')).strip()
        explanation_ms  = str(row.get('Malay Explanation', '')).strip()

        batch = parse_int(row.get('Batch', 1))

        # Clean up 'nan' strings from Malay fields
        def clean(s): return '' if s.lower() == 'nan' else s
        text_ms        = clean(text_ms)
        opt_ms_a       = clean(opt_ms_a)
        opt_ms_b       = clean(opt_ms_b)
        opt_ms_c       = clean(opt_ms_c)
        opt_ms_d       = clean(opt_ms_d)
        explanation_ms = clean(explanation_ms)

        questions.append({
            'id':                   str(uuid.uuid4()),
            'text':                 text_en,
            'text_ms':              text_ms or None,
            'options':              [opt_a, opt_b, opt_c, opt_d],
            'options_ms':           [opt_ms_a, opt_ms_b, opt_ms_c, opt_ms_d] if text_ms else None,
            'correct_option_index': correct_index,
            'explanation':          explanation_en,
            'explanation_ms':       explanation_ms or None,
            'regions':              [REGION],
            'category':             category,          # e.g. "Container Haulage"
            'driver_categories':    [category],        # same — used for filtering
            'difficulty':           DIFFICULTY,
            'batch_number':         batch,
            'component_weights': {
                'operation':       weight_op,
                'discipline':      weight_disc,
                'professionalism': weight_prof,
            },
        })

    return questions


def generate_sql(all_questions: list[dict]) -> str:
    """Also generate a SQL file as a backup / manual option."""
    lines = [
        "-- Auto-generated by import_questions.py",
        "-- Run in Supabase SQL Editor if the Python upload fails",
        "",
        "-- Ensure driver_categories column exists",
        "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS driver_categories TEXT[];",
        "",
        "-- Clear existing questions (OPTIONAL - comment out to keep old data)",
        "-- DELETE FROM public.questions;",
        "",
    ]

    for q in all_questions:
        options_json    = json.dumps(q['options']).replace("'", "''")
        options_ms_json = json.dumps(q['options_ms']).replace("'", "''") if q['options_ms'] else 'NULL'
        weights_json    = json.dumps(q['component_weights']).replace("'", "''")
        cats_arr        = "ARRAY['" + "','".join(q['driver_categories']) + "']"
        regions_arr     = "ARRAY['" + "','".join(q['regions']) + "']"

        text_ms_val  = f"'{esc(q['text_ms'])}'"  if q['text_ms']  else 'NULL'
        expl_ms_val  = f"'{esc(q['explanation_ms'])}'" if q['explanation_ms'] else 'NULL'
        opts_ms_val  = f"'{options_ms_json}'" if q['options_ms'] else 'NULL'

        lines.append(f"""INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index,
    explanation, explanation_ms, regions, category, driver_categories,
    difficulty, batch_number, component_weights
) VALUES (
    '{q['id']}',
    '{esc(q['text'])}',
    {text_ms_val},
    '{options_json}',
    {opts_ms_val},
    {q['correct_option_index']},
    '{esc(q['explanation'])}',
    {expl_ms_val},
    {regions_arr},
    '{esc(q['category'])}',
    {cats_arr},
    '{q['difficulty']}',
    {q['batch_number']},
    '{weights_json}'
) ON CONFLICT (id) DO NOTHING;""")

    return "\n".join(lines)


def upload_via_supabase_api(all_questions: list[dict]):
    """Upload questions using the supabase-py library."""
    try:
        from supabase import create_client
    except ImportError:
        print("\n❌ supabase library not found. Run: pip install supabase")
        print("   Falling back to SQL file only.\n")
        return False

    if not SUPABASE_SERVICE_KEY:
        print("\n⚠️  SUPABASE_SERVICE_KEY not set in environment.")
        print("   Please set the SUPABASE_SERVICE_KEY environment variable.")
        print("   Get it from: Supabase Dashboard → Project Settings → API\n")
        return False

    print(f"\n📡 Connecting to Supabase: {SUPABASE_URL}")
    client = create_client(SUPABASE_URL, SUPABASE_SERVICE_KEY)

    # Ensure driver_categories column exists (via raw SQL through rpc or just try insert)
    print("📝 Uploading questions in batches of 50...")
    BATCH_SIZE = 50
    total = len(all_questions)
    success_count = 0

    for i in range(0, total, BATCH_SIZE):
        chunk = all_questions[i:i + BATCH_SIZE]
        try:
            result = client.table('questions').upsert(chunk, on_conflict='id').execute()
            success_count += len(chunk)
            print(f"   ✅ Uploaded {min(i + BATCH_SIZE, total)}/{total}")
        except Exception as e:
            print(f"   ❌ Error on batch {i//BATCH_SIZE + 1}: {e}")
            return False

    print(f"\n🎉 Successfully uploaded {success_count} questions to Supabase!\n")
    return True


def main():
    print("=" * 60)
    print("SafePass Question Import Tool")
    print("=" * 60)

    xl = pd.ExcelFile(EXCEL_FILE)
    print(f"\n📂 Reading: {EXCEL_FILE}")
    print(f"   Sheets found: {xl.sheet_names}\n")

    all_questions = []
    for sheet in xl.sheet_names:
        if sheet not in SHEET_TO_CATEGORY:
            print(f"   ⚠️  Unknown sheet '{sheet}', skipping.")
            continue
        category = SHEET_TO_CATEGORY[sheet]
        qs = read_sheet(xl, sheet)
        print(f"   📋 {sheet!r:25s} ({category}) → {len(qs)} questions")
        all_questions.extend(qs)

    print(f"\n📊 Total questions parsed: {len(all_questions)}")

    # Summary by category and batch
    print("\n   Category × Batch breakdown:")
    for sheet in SHEET_TO_CATEGORY:
        cat = SHEET_TO_CATEGORY[sheet]
        cat_qs = [q for q in all_questions if q['category'] == cat]
        batches = sorted(set(q['batch_number'] for q in cat_qs))
        for b in batches:
            count = sum(1 for q in cat_qs if q['batch_number'] == b)
            print(f"     {cat:22s} | Batch {b} → {count} questions")

    # Generate SQL backup
    sql_path = r'c:\Users\ACER\SafePass\supabase\import_questions_generated.sql'
    print(f"\n💾 Generating SQL backup → {sql_path}")
    sql_content = generate_sql(all_questions)
    with open(sql_path, 'w', encoding='utf-8') as f:
        f.write(sql_content)
    print("   SQL file written.")

    # Try direct API upload
    success = upload_via_supabase_api(all_questions)
    if not success:
        print(f"📌 To import manually, run the SQL file in Supabase SQL Editor:")
        print(f"   {sql_path}\n")

    print("Done! ✓")


if __name__ == '__main__':
    main()
