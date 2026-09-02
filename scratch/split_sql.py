import os
import re

print("=== SPLITTING SQL INTO 4 CATEGORY FILES ===")

with open('supabase/import_all_1040_questions.sql', 'r', encoding='utf-8') as f:
    full_sql = f.read()

# Header to include in part 1
header_part1 = """-- ==========================================================================
-- SafePass Questions Part 1 of 4: Setup & Urban Delivery / Box Van (263 MCQs)
-- ==========================================================================
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS driver_categories TEXT[];
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS reference_number INTEGER;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS explanation_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS text_ms TEXT;
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS options_ms JSONB;

-- Clear existing questions table
TRUNCATE TABLE public.questions;

"""

# Separate inserts by category
lines = full_sql.split('\n')
urban_blocks = []
curtain_blocks = []
haulage_blocks = []
cargo_blocks = []

current_block = []
for line in lines:
    if line.startswith("INSERT INTO public.questions"):
        if current_block:
            block_str = "\n".join(current_block)
            if "ARRAY['Box Van','Urban Delivery']" in block_str:
                urban_blocks.append(block_str)
            elif "ARRAY['Curtain Side','Curtain Sider']" in block_str:
                curtain_blocks.append(block_str)
            elif "ARRAY['Container Haulage']" in block_str:
                haulage_blocks.append(block_str)
            elif "ARRAY['General Cargo']" in block_str:
                cargo_blocks.append(block_str)
        current_block = [line]
    elif current_block:
        current_block.append(line)

# Flush last block
if current_block:
    block_str = "\n".join(current_block)
    if "ARRAY['Box Van','Urban Delivery']" in block_str:
        urban_blocks.append(block_str)
    elif "ARRAY['Curtain Side','Curtain Sider']" in block_str:
        curtain_blocks.append(block_str)
    elif "ARRAY['Container Haulage']" in block_str:
        haulage_blocks.append(block_str)
    elif "ARRAY['General Cargo']" in block_str:
        cargo_blocks.append(block_str)

print(f"Urban blocks: {len(urban_blocks)}")
print(f"Curtain blocks: {len(curtain_blocks)}")
print(f"Haulage blocks: {len(haulage_blocks)}")
print(f"Cargo blocks: {len(cargo_blocks)}")

# 1. Write Part 1
p1_path = 'supabase/part1_urban_263.sql'
with open(p1_path, 'w', encoding='utf-8') as f:
    f.write(header_part1 + "\n\n".join(urban_blocks))
print(f"[OK] Wrote {p1_path} ({os.path.getsize(p1_path)} bytes)")

# 2. Write Part 2
p2_path = 'supabase/part2_curtain_263.sql'
header_part2 = """-- ==========================================================================
-- SafePass Questions Part 2 of 4: Curtain Side (263 MCQs)
-- ==========================================================================
"""
with open(p2_path, 'w', encoding='utf-8') as f:
    f.write(header_part2 + "\n\n".join(curtain_blocks))
print(f"[OK] Wrote {p2_path} ({os.path.getsize(p2_path)} bytes)")

# 3. Write Part 3
p3_path = 'supabase/part3_haulage_258.sql'
header_part3 = """-- ==========================================================================
-- SafePass Questions Part 3 of 4: Container Haulage (258 MCQs)
-- ==========================================================================
"""
with open(p3_path, 'w', encoding='utf-8') as f:
    f.write(header_part3 + "\n\n".join(haulage_blocks))
print(f"[OK] Wrote {p3_path} ({os.path.getsize(p3_path)} bytes)")

# 4. Write Part 4
p4_path = 'supabase/part4_cargo_256.sql'
header_part4 = """-- ==========================================================================
-- SafePass Questions Part 4 of 4: General Cargo (256 MCQs)
-- ==========================================================================
"""
with open(p4_path, 'w', encoding='utf-8') as f:
    f.write(header_part4 + "\n\n".join(cargo_blocks))
print(f"[OK] Wrote {p4_path} ({os.path.getsize(p4_path)} bytes)")
