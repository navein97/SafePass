import { serve } from 'https://deno.land/std@0.168.0/http/server.ts'
import Stripe from 'npm:stripe@^14.16.0'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2.39.8'

const stripe = new Stripe(Deno.env.get('STRIPE_SECRET_KEY') || '', {
  httpClient: Stripe.createFetchHttpClient(),
  apiVersion: '2023-10-16',
})
const endpointSecret = Deno.env.get('STRIPE_WEBHOOK_SECRET') || ''

serve(async (req) => {
  const signature = req.headers.get('stripe-signature')

  if (!signature) {
    return new Response('No stripe-signature header provided', { status: 400 })
  }

  const body = await req.text()
  let event

  try {
    event = await stripe.webhooks.constructEventAsync(
      body,
      signature,
      endpointSecret
    )
  } catch (err: any) {
    console.error(`Webhook signature verification failed: ${err.message}`)
    return new Response(`Webhook Error: ${err.message}`, { status: 400 })
  }

  // Initialize Supabase Client with service role to bypass RLS and perform admin updates
  const supabaseUrl = Deno.env.get('SUPABASE_URL') || ''
  const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') || ''
  
  const supabase = createClient(supabaseUrl, supabaseServiceKey)

  switch (event.type) {
    case 'checkout.session.completed': {
      const session = event.data.object
      const companyId = session.metadata?.company_id 
                         || session.client_reference_id
      const packageId = session.metadata?.package_id
      const driverCount = parseInt(session.metadata?.driver_count || '1', 10)

      if (companyId && packageId) {
        console.log(`Updating company ${companyId} to package ${packageId} with ${driverCount} drivers`)
        // Call our postgres function to handle quota assignment
        const { error } = await supabase.rpc('handle_stripe_success', {
          p_company_id: companyId,
          p_package_id: packageId,
          p_driver_count: driverCount
        })
        if (error) {
           console.error('Error invoking handle_stripe_success RPC', error)
           return new Response(`Supabase Error: ${error.message}`, { status: 500 })
        }
      } else {
        console.log(`Missing metadata in session ${session.id}`, session.metadata)
      }
      break
    }
    case 'customer.subscription.deleted': {
      // Handle cancellation -> downgrade to trial
      const subscription = event.data.object
      const companyId = subscription.metadata?.company_id
      if (companyId) {
         console.log(`Downgrading company ${companyId} to trial`)
         await supabase.rpc('handle_stripe_success', {
          p_company_id: companyId,
          p_package_id: 'trial',
          p_driver_count: 0
         })
      }
      break
    }
  }

  return new Response(JSON.stringify({ received: true }), { status: 200 })
})
