with open('supabase_update.sql', 'r', encoding='utf-8') as f:
    content = f.read()

import re
from collections import Counter

# The INSERT blocks in this file have VALUES with batch_number as second-to-last field
# Format: ..., 'difficulty_text', batch_num, '{"operation":...}'
# batch_num is an integer between the difficulty text string and the JSON

batch_counter = Counter()

# Match: , 'some_difficulty', 5, '{"operation' or similar
# More specifically - the batch_number comes right before the component_weights JSON
# Pattern: ', NUMBER, '{"' 
pattern = re.compile(r",\s*(\d+),\s*'\{\"")
for m in pattern.finditer(content):
    bn = m.group(1)
    batch_counter[bn] += 1

print('Batch counts using pattern ,NUM,\'{"":')
for k in sorted(batch_counter.keys(), key=lambda x: int(x)):
    print(f'  Batch {k}: {batch_counter[k]} questions')

if not batch_counter:
    print('\nTrying alternate pattern...')
    # Look at actual VALUES lines - print a few
    lines = content.split('\n')
    for i, line in enumerate(lines):
        if 'VALUES' in line and i < 50:
            print(f'Line {i+1}: {line[:200]}')
