const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://qhnnyrpcnlddqoyewwkb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFobm55cnBjbmxkZHFveWV3d2tiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzMTQ5MTAsImV4cCI6MjA3OTg5MDkxMH0.HXmJ_jEX-hloMDAGOf7CMrb8PJFuJ_rKgMv7Cjoj_-M';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function run() {
    // Find P0004
    const { data: profiles, error: err1 } = await supabase.from('profiles').select('*').ilike('employee_id', '%P0004%');
    if (err1) { console.error('Profiles err:', err1); return; }
    
    console.log('Found profiles for P0004:', profiles);

    if (profiles.length === 0) {
        console.log('No user P0004 found.');
        return;
    }

    const p0004 = profiles[0];
    
    // Check questions for this user's vehicle type
    const { data: qtys, error: err2 } = await supabase.from('questions').select('id, batch_number, driver_categories');
    
    console.log('Total questions:', qtys ? qtys.length : 0, 'Error:', err2);
    
    if (qtys) {
        const batch1 = qtys.filter(q => q.batch_number === 1);
        console.log('Total questions in batch 1:', batch1.length);
        
        if (p0004.vehicle_type) {
            const match = batch1.filter(q => (q.driver_categories || []).includes(p0004.vehicle_type));
            console.log('Batch 1 questions matching', p0004.vehicle_type, ':', match.length);
        }
    }
}

run();
