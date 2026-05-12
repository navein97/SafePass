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
    const { packageId, companyId, returnUrl, driverCount = 1, billingYears = 1 } = await req.json()

    if (!packageId || !companyId || !returnUrl) {
      return new Response(
        JSON.stringify({ error: 'Missing packageId, companyId, or returnUrl' }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )
    }

    // Price map: for each package we check for a 2-year variant first, then fall back to 1-year.
    // To use 2-year billing, create a separate Stripe Price with interval=year, interval_count=2
    // and set STRIPE_PRICE_STANDARD_2YEAR / STRIPE_PRICE_ENTERPRISE_2YEAR / STRIPE_PRICE_TEST_2YEAR.
    const priceMap: Record<string, { oneYear: string; twoYear: string }> = {
      standard:   { oneYear: Deno.env.get('STRIPE_PRICE_STANDARD')      || '', twoYear: Deno.env.get('STRIPE_PRICE_STANDARD_2YEAR')   || '' },
      enterprise: { oneYear: Deno.env.get('STRIPE_PRICE_ENTERPRISE')    || '', twoYear: Deno.env.get('STRIPE_PRICE_ENTERPRISE_2YEAR') || '' },
      test:       { oneYear: Deno.env.get('STRIPE_PRICE_TEST')          || '', twoYear: Deno.env.get('STRIPE_PRICE_TEST_2YEAR')       || '' },
    }

    const priceVariants = priceMap[packageId]

    if (!priceVariants) {
       return new Response(
        JSON.stringify({ error: `No Stripe Price ID configured for package ${packageId}` }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )     
    }

    // Prefer 2-year price ID if billingYears=2 and a dedicated 2-year price is configured
    const priceId = (billingYears === 2 && priceVariants.twoYear)
      ? priceVariants.twoYear
      : priceVariants.oneYear

    if (!priceId) {
       return new Response(
        JSON.stringify({ error: `No Stripe Price ID configured for package ${packageId} (${billingYears}-year)` }),
        { status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' } }
      )     
    }

    // Create a Checkout Session
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ['card'],
      line_items: [
        {
          price: priceId,
          quantity: driverCount, // Number of licenses (drivers)
        },
      ],
      mode: 'subscription',
      success_url: `${returnUrl}?session_id={CHECKOUT_SESSION_ID}`,
      cancel_url: `${returnUrl}?cancel=true`,
      client_reference_id: companyId,
      metadata: {
        package_id: packageId,
        company_id: companyId,
        driver_count: driverCount.toString(),
        billing_years: billingYears.toString(),
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
