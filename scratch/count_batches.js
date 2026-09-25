const fs = require('fs');
const files = ['part1_urban_263.sql','part2_curtain_263.sql','part3_haulage_258.sql','part4_cargo_256.sql'];

files.forEach(f => {
    const content = fs.readFileSync('supabase/' + f, 'utf8');
    const batches = {};
    // Each question is a separate INSERT statement, batch_number is on a line by itself like:
    //     1,
    // after the line containing 'intermediate' or 'beginner' or 'advanced' (difficulty)
    // OR we can look for the pattern: a line that just has a number 1-8 followed by comma
    // Better: find all occurrences of batch_number value in the INSERT
    // The format is: difficulty, batch_number, component_weights
    // So batch_number is on its own line, just a digit 1-8 followed by comma
    
    // Count INSERT statements
    const insertCount = (content.match(/INSERT INTO public\.questions/g) || []).length;
    
    // Find batch_number values - they appear on lines like "    1," or "    2," after difficulty lines
    const lines = content.split('\n');
    let afterDifficulty = false;
    lines.forEach((line, i) => {
        const trimmed = line.trim();
        if (trimmed.match(/^'(intermediate|beginner|advanced|expert)',$/)) {
            afterDifficulty = true;
        } else if (afterDifficulty) {
            const batchMatch = trimmed.match(/^(\d),$/);
            if (batchMatch) {
                const b = batchMatch[1];
                batches[b] = (batches[b] || 0) + 1;
            }
            afterDifficulty = false;
        }
    });
    
    console.log(f + ': INSERTs=' + insertCount + ', Batches=' + JSON.stringify(batches));
    
    // Total
    let total = 0;
    Object.values(batches).forEach(v => total += v);
    console.log('  Total from batches: ' + total);
});
