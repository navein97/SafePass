import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import Stripe from 'npm:stripe@^14.16.0'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') || '', {
  // This is needed to use the Fetch API rather than relying on the Node http
  // module.
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
    const { packageId, companyId, returnUrl } = await req.json()

    if (!packageId || !companyId || !returnUrl) {
      return new Response(
        JSON.stringify({ error: 'Missing packageId, companyId, or returnUrl' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // You should define these in your Stripe dashboard and pass them here, 
    // or map them via environment variables. For now we use some mock logic
    // but in a real app these must be real Stripe Price IDs.
    const priceMap: Record<string, string> = {
      starter: Deno.env.get('STRIPE_PRICE_STARTER') || '',
      growth: Deno.env.get('STRIPE_PRICE_GROWTH') || '',
      enterprise: Deno.env.get('STRIPE_PRICE_ENTERPRISE') || '',
    }

    const priceId = priceMap[packageId]

    if (!priceId) {
       return new Response(
        JSON.stringify({ error: `No Stripe Price ID configured for package ${packageId}` }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )     
    }

    // Create a Checkout Session
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price: priceId,
          quantity: 1,
        },
      ],
      mode: 'subscription', // or 'payment' for one-time
      success_url: `${returnUrl}?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${returnUrl}?cancel=true`,
      client_reference_id: companyId,
      metadata: {
        package_id: packageId,
        company_id: companyId
      }
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
