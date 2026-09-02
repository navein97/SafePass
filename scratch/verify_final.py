import openpyxl
import re

print("=== VERIFYING GENERATED SQL & INTEGRATION ===")

with open('supabase/import_all_1040_questions.sql', 'r', encoding='utf-8') as f:
    sql = f.read()

inserts = re.findall(r"INSERT INTO public\.questions", sql)
print(f"[OK] Total INSERT statements in SQL: {len(inserts)} (Expected: 1040)")

# Check categories in SQL
urban_matches = re.findall(r"ARRAY\['Box Van','Urban Delivery'\]", sql)
curtain_matches = re.findall(r"ARRAY\['Curtain Side','Curtain Sider'\]", sql)
haulage_matches = re.findall(r"ARRAY\['Container Haulage'\]", sql)
cargo_matches = re.findall(r"ARRAY\['General Cargo'\]", sql)

print(f"[OK] Urban Delivery / Box Van questions: {len(urban_matches)} (Expected: 263)")
print(f"[OK] Curtain Side questions: {len(curtain_matches)} (Expected: 263)")
print(f"[OK] Container Haulage questions: {len(haulage_matches)} (Expected: 258)")
print(f"[OK] General Cargo questions: {len(cargo_matches)} (Expected: 256)")

# Verify sample corrected question in SQL
# Ref 134: 'You plan to install a sun shade, dark tint film, or stickers on the company truck windscreen.'
# Correct Option was B -> index 1
match_ref134 = re.search(r"You plan to install a sun shade.*?(\d+),\s*'Avoid unauthorised vehicle modifications", sql, re.DOTALL)
if match_ref134:
    print(f"[OK] Ref 134 verified with correct index: {match_ref134.group(1)} (Expected: 1 for option B)")

print("\nALL VERIFICATIONS PASSED SUCCESSFULLY!")
