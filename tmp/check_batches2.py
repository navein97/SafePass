with open('supabase_update.sql', 'r', encoding='utf-8') as f:
    lines = f.readlines()

total = len(lines)
print(f'Total lines: {total}')

# Find lines with actual batch numbers in VALUES (look for ", 5, '{" pattern)
import re
for i, line in enumerate(lines, 1):
    if re.search(r',\s*5,\s*\x27\{', line):
        print(f'First batch 5 value at line: {i}')
        print(f'  Content: {line.strip()[:120]}')
        break

# Also check if supabase_update.sql was already run (i.e., those questions are already in DB)
# We can only tell by looking at what's in the file
# Count questions per batch
from collections import Counter
batch_counter = Counter()
for line in lines:
    m = re.search(r',\s*(\d+),\s*\x27\{', line)
    if m:
        batch_counter[m.group(1)] += 1

print('\nBatch counts:')
for k in sorted(batch_counter.keys(), key=lambda x: int(x)):
    print(f'  Batch {k}: {batch_counter[k]} questions')
