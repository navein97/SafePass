import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import Stripe from 'npm:stripe@^14.16.0'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.8'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') || '', {
  httpClient: Stripe.createFetchHttpClient(),
  apiVersion: '2023-10-16',
})

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const { companyId, returnUrl } = await req.json()

    if (!companyId || !returnUrl) {
      return new Response(
        JSON.stringify({ error: 'Missing companyId or returnUrl' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Initialize Supabase Client with service role to bypass RLS and fetch customer ID
    const supabaseUrl = Deno.env.get('SUPABASE_URL') || ''
    const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || ''
    const supabase = createClient(supabaseUrl, supabaseServiceKey)

    // Fetch the stripe_customer_id for this company
    const { data: company, error } = await supabase
      .from('companies')
      .select('stripe_customer_id')
      .eq('id', companyId)
      .single()

    if (error || !company?.stripe_customer_id) {
       return new Response(
        JSON.stringify({ error: 'No Stripe Customer ID found for this company. Please ensure your subscription is active.' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Create a Portal Session
    const session = await stripe.billingPortal.sessions.create({
      customer: company.stripe_customer_id,
      return_url: returnUrl,
    })

    return new Response(
      JSON.stringify({ url: session.url }),
      { status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  } catch (error) {
    const err = error as Error;
    return new Response(
      JSON.stringify({ error: err.message }),
      { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
    )
  }
})
