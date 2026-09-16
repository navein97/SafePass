const { createClient } = require('@supabase/supabase-js');

const SUPABASE_URL = 'https://qhnnyrpcnlddqoyewwkb.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFobm55cnBjbmxkZHFveWV3d2tiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQzMTQ5MTAsImV4cCI6MjA3OTg5MDkxMH0.HXmJ_jEX-hloMDAGOf7CMrb8PJFuJ_rKgMv7Cjoj_-M';

const supabase = createClient(SUPABASE_URL, SUPABASE_KEY);

async function checkSettings() {
    const { data, error } = await supabase
        .from('app_settings')
        .select('*');

    console.log('app_settings:', data, error);
}

checkSettings().catch(console.error);
