import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.8'

const EXPO_PUSH_API_URL = 'https://exp.host/--/api/v2/push/send';

serve(async (req) => {
  // CORS configuration
  if (req.method === 'OPTIONS') {
    return new Response('ok', {
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
      }
    });
  }

  try {
    const { userId, title, body, data } = await req.json();

    if (!userId) {
      return new Response(JSON.stringify({ error: 'Missing userId' }), { status: 400 });
    }

    // Initialize Supabase Client with service role to bypass RLS
    const supabaseUrl = Deno.env.get('SUPABASE_URL') || '';
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || '';
    const supabase = createClient(supabaseUrl, supabaseServiceKey);

    // Get the user's push token
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('expo_push_token')
      .eq('id', userId)
      .single();

    if (profileError || !profile?.expo_push_token) {
      console.log(`Push token not found for user ${userId}`);
      return new Response(JSON.stringify({ success: false, reason: 'Push token missing' }), { status: 200 });
    }

    const pushToken = profile.expo_push_token;

    // Send the notification via Expo Push API
    const message = {
      to: pushToken,
      sound: 'default',
      title: title || 'New Notification',
      body: body || '',
      data: data || {},
    };

    const expoResponse = await fetch(EXPO_PUSH_API_URL, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Accept-encoding': 'gzip, deflate',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(message),
    });

    const result = await expoResponse.json();
    console.log(`Expo Push Response for ${userId}:`, result);

    return new Response(JSON.stringify({ success: true, expoResult: result }), {
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
      status: 200,
    });

  } catch (error: any) {
    console.error('Push notification error:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { 'Content-Type': 'application/json', 'Access-Control-Allow-Origin': '*' },
      status: 500,
    });
  }
});
