const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://qhnnyrpcnlddqoyewwkb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFobm55cnBjbmxkZHFveWV3d2tiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzMTQ5MTAsImV4cCI6MjA3OTg5MDkxMH0.HXmJ_jEX-hloMDAGOf7CMrb8PJFuJ_rKgMv7Cjoj_-M';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function check() {
    const bipinId = '0a4a8448-924c-4e67-9237-d4af81328816';

    const { data: comp, error: cErr } = await supabase
        .from('compliance_logs')
        .select('*')
        .eq('user_id', bipinId);

    console.log('compliance_logs:', comp, cErr);

    const { data: login, error: lErr } = await supabase
        .from('login_logs')
        .select('*')
        .eq('user_id', bipinId);

    console.log('login_logs:', login, lErr);
}

check().catch(console.error);
