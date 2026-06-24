import re

with open('supabase_update.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# The INSERT blocks insert one question at a time with ON CONFLICT DO UPDATE
# Column order includes batch_number as a column
# Let's find the actual VALUES and extract batch_number position

# Each INSERT looks like:
# INSERT INTO public.questions (id, question_en, ..., batch_number, component_weights)
# VALUES ('uuid', '...', ..., 1, '{...}')
# ON CONFLICT ...

# Find all batch_number values in VALUES clauses
# We'll look at each INSERT block
insert_blocks = re.split(r'INSERT INTO public\.questions', content)
batch_counts = {}

for block in insert_blocks[1:]:  # skip first empty
    # Find the VALUES line
    val_match = re.search(r'VALUES\s*\((.+?)\)\s*ON CONFLICT', block, re.DOTALL)
    if val_match:
        vals = val_match.group(1)
        # Find columns line to get position of batch_number
        col_match = re.search(r'\(([^)]+batch_number[^)]+)\)', block)
        if col_match:
            cols = [c.strip() for c in col_match.group(1).split(',')]
            if 'batch_number' in cols:
                idx = cols.index('batch_number')
                # Parse values - this is complex due to nested strings/JSON
                # Simple approach: split by comma but respect quoted strings
                # Better: find batch_number value directly
                # Since it's near end: ..., difficulty, batch_number, component_weights
                # Just look for the pattern: , <digit(s)>, '{"
                bn_match = re.search(r",\s*'[^']+',\s*(\d+),\s*'\{", vals)
                if bn_match:
                    bn = bn_match.group(1)
                    batch_counts[bn] = batch_counts.get(bn, 0) + 1

print('Batch number counts in supabase_update.sql:')
if batch_counts:
    for k in sorted(batch_counts.keys(), key=lambda x: int(x)):
        print(f'  Batch {k}: {batch_counts[k]} questions')
else:
    print('  Could not parse - trying alternate method')
    # Count occurrences of batch_number values differently
    # Look for lines that have just a number followed by a JSON-like string
    matches = re.findall(r',\s*(\d+),\s*\'{"', content)
    from collections import Counter
    c = Counter(matches)
    for k in sorted(c.keys(), key=lambda x: int(x)):
        print(f'  Batch {k}: {c[k]} questions')
