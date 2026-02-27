# Stripe Verification Setup Guide

To get Stripe fully working, you will need to complete these steps in your Stripe dashboard and run a few secure commands.

## 1. Create a Stripe Account
1. Go to [stripe.com](https://stripe.com) and create an account.
2. Once logged in, switch to **Test mode** (toggle in the top right).

## 2. Get your Secret Key
1. Go to **Developers** > **API keys**.
2. Find your **Secret key** (starts with `sk_test_...`).
3. Run this command in your terminal to securely save it to your Supabase project:
   ```bash
   npx supabase secrets set STRIPE_SECRET_KEY=sk_test_YOUR_SECRET_KEY
   ```

## 3. Set up your Products and Prices
1. In the Stripe Dashboard, go to **Products**.
2. Create 3 products:
   - Name: **Starter**, Price: RM 199/month
   - Name: **Growth**, Price: RM 499/month
   - Name: **Enterprise**, Price: RM 999/month
3. Once created, copy the **API ID** for each price (they start with `price_...`).
4. Run these commands using the API IDs you copied:
   ```bash
   npx supabase secrets set STRIPE_PRICE_STARTER=price_YOUR_STARTER_ID
   npx supabase secrets set STRIPE_PRICE_GROWTH=price_YOUR_GROWTH_ID
   npx supabase secrets set STRIPE_PRICE_ENTERPRISE=price_YOUR_ENTERPRISE_ID
   ```

## 4. Set up the Webhook
1. Go to **Developers** > **Webhooks** in the Stripe Dashboard.
2. Click **Add an endpoint**.
3. Set the Endpoint URL to your newly deployed function:
   `https://qhnnyrpcnlddqoyewwkb.supabase.co/functions/v1/stripe-webhook`
4. Select the following events to listen to:
   - `checkout.session.completed`
   - `customer.subscription.deleted`
5. Click **Add endpoint**.
6. Once created, click **Reveal** under "Signing secret" to get the webhook secret (starts with `whsec_...`).
7. Run this command with your webhook secret:
   ```bash
   npx supabase secrets set STRIPE_WEBHOOK_SECRET=whsec_YOUR_WEBHOOK_SECRET
   ```

## You're all set!
The Edge Functions are already deployed. Once these commands are executed, the checkout will work correctly in your app!
