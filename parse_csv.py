import csv
import json
import os
import uuid

# Input file
csv_file = 'c:\\Users\\ACER\\SafePass\\quiz_question_template V1006.2026_NAV.csv'

# Output files
output_dir = 'c:\\Users\\ACER\\SafePass\\src\\data'
batches_dir = os.path.join(output_dir, 'batches')
sql_output_file = 'c:\\Users\\ACER\\SafePass\\supabase_update.sql'

os.makedirs(batches_dir, exist_ok=True)

# Data structures
master_questions = []
batch_questions = {1: [], 2: [], 3: [], 4: []}

# Supabase SQL commands
sql_statements = [
    "-- 1. Update questions table schema to support new columns",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS text_ms TEXT;",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS options_ms JSONB;",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS explanation_ms TEXT;",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS difficulty TEXT;",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS batch_number INTEGER;",
    "ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS component_weights JSONB;",
    "",
    "-- 2. Clear existing questions (optional, but ensures clean slate based on CSV)",
    "-- DELETE FROM public.questions;",
    "",
    "-- 3. Insert new questions",
]

answer_map = {'A': 0, 'B': 1, 'C': 2, 'D': 3}

# Parse CSV
with open(csv_file, 'r', encoding='utf-8') as f:
    reader = csv.reader(f)
    header = next(reader)
    
    question_counter = 1
    
    for row in reader:
        if not row or not row[0].strip():
            continue
            
        # Extract columns based on index
        text_en = row[0].strip()
        opt_en_a = row[1].strip()
        opt_en_b = row[2].strip()
        opt_en_c = row[3].strip()
        opt_en_d = row[4].strip()
        
        correct_ans_letter = row[5].strip().upper()
        if not correct_ans_letter or correct_ans_letter not in answer_map:
            continue
            
        correct_index = answer_map[correct_ans_letter]
        explanation_en = row[6].strip()
        
        def parse_float(val):
            try:
                return float(val) if val.strip() else 0.0
            except ValueError:
                return 0.0
                
        weight_op = parse_float(row[7])
        weight_disc = parse_float(row[8])
        weight_prof = parse_float(row[9])
        
        text_ms = row[10].strip()
        opt_ms_a = row[11].strip()
        opt_ms_b = row[12].strip()
        opt_ms_c = row[13].strip()
        opt_ms_d = row[14].strip()
        explanation_ms = row[15].strip()
        
        try:
            batch = int(row[16].strip())
        except ValueError:
            batch = 1
            
        # Construct Question Object
        q_id = f"my_int_{question_counter:03d}"
        
        question_obj = {
            "id": q_id,
            "text": text_en,
            "text_ms": text_ms,
            "options": [opt_en_a, opt_en_b, opt_en_c, opt_en_d],
            "options_ms": [opt_ms_a, opt_ms_b, opt_ms_c, opt_ms_d],
            "correctOptionIndex": correct_index,
            "explanation": explanation_en,
            "explanation_ms": explanation_ms,
            "category": "Situational Awareness",
            "region": ["MY"],
            "difficulty": "intermediate",
            "componentWeights": {
                "operation": weight_op,
                "discipline": weight_disc,
                "professionalism": weight_prof
            }
        }
        
        master_questions.append(question_obj)
        if batch in batch_questions:
            batch_questions[batch].append(question_obj)
            
        # Construct SQL Insert
        db_id = str(uuid.uuid4())
        
        options_json = json.dumps([opt_en_a, opt_en_b, opt_en_c, opt_en_d]).replace("'", "''")
        options_ms_json = json.dumps([opt_ms_a, opt_ms_b, opt_ms_c, opt_ms_d]).replace("'", "''")
        weights_json = json.dumps({"operation": weight_op, "discipline": weight_disc, "professionalism": weight_prof}).replace("'", "''")
        
        sql = f"""INSERT INTO public.questions (
    id, text, text_ms, options, options_ms, correct_option_index, 
    explanation, explanation_ms, regions, category, difficulty, batch_number, component_weights
) VALUES (
    '{db_id}', 
    '{text_en.replace("'", "''")}', 
    '{text_ms.replace("'", "''")}', 
    '{options_json}', 
    '{options_ms_json}', 
    {correct_index}, 
    '{explanation_en.replace("'", "''")}', 
    '{explanation_ms.replace("'", "''")}', 
    ARRAY['MY'], 
    'Situational Awareness', 
    'intermediate', 
    {batch}, 
    '{weights_json}'
);"""
        sql_statements.append(sql)
        
        question_counter += 1

# Write JSON Files
with open(os.path.join(output_dir, 'questionsMY.json'), 'w', encoding='utf-8') as f:
    json.dump(master_questions, f, indent=4, ensure_ascii=False)

for batch, q_list in batch_questions.items():
    if q_list:
        with open(os.path.join(batches_dir, f'batch{batch}.json'), 'w', encoding='utf-8') as f:
            json.dump(q_list, f, indent=4, ensure_ascii=False)

# Write SQL File
with open(sql_output_file, 'w', encoding='utf-8') as f:
    f.write("\n".join(sql_statements))

print(f"Successfully parsed {question_counter - 1} questions.")
print(f"Generated questionsMY.json and batch1-4.json in {output_dir}")
print(f"Generated SQL script at {sql_output_file}")
