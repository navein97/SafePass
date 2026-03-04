# Stripe Setup Guide (Updated for Annual Per-Driver Pricing)

## 1. Update Products in Stripe Dashboard

You have 3 existing products. Update them as follows:

### Option A: Edit existing products
1. Go to [Stripe Dashboard](https://dashboard.stripe.com) → **Products**
2. **Rename** "Starter" → "Standard (1-100 drivers)"
3. **Rename** "Growth" → "Enterprise (101+ drivers)"  
4. **Archive or delete** the 3rd product (old Enterprise)
5. On each renamed product, click **Add another price**:
   - **Standard**: RM 300.00 MYR, Recurring / Yearly, **Per unit** pricing
   - **Enterprise**: RM 250.00 MYR, Recurring / Yearly, **Per unit** pricing
6. **Archive** the old monthly prices on each product (do NOT delete, in case you have existing subscribers)

### Option B: Create fresh products
1. Create 2 new products from scratch with the prices above
2. Archive the old 3 products

## 2. Save New Price IDs to Supabase

Copy the **Price ID** (starts with `price_...`) for each new annual price, then run:

```bash
npx supabase secrets set STRIPE_PRICE_STANDARD=price_YOUR_STANDARD_PRICE_ID
npx supabase secrets set STRIPE_PRICE_ENTERPRISE=price_YOUR_ENTERPRISE_PRICE_ID
```

Remove old secrets:
```bash
npx supabase secrets unset STRIPE_PRICE_STARTER STRIPE_PRICE_GROWTH STRIPE_PRICE_ENTERPRISE
```

## 3. Run Supabase SQL Migration

Go to **Supabase Dashboard** → **SQL Editor** and run the contents of:
`supabase/migrations/update_subscription_model.sql`

This will:
- Change all existing companies from `basic` → `trial`
- Update the `handle_stripe_success` function for new pricing
- Update `register_workspace` to default to `trial`

## 4. Deploy Edge Functions

Deploy the updated edge functions:

```bash
npx supabase functions deploy create-checkout-session
npx supabase functions deploy stripe-webhook
```

## 5. Verify Webhook is Still Active

Go to Stripe Dashboard → **Developers** → **Webhooks** and verify your endpoint is still active:
- URL: `https://qhnnyrpcnlddqoyewwkb.supabase.co/functions/v1/stripe-webhook`
- Events: `checkout.session.completed`, `customer.subscription.deleted`

No changes needed here unless the URL changed.

## Summary of Changes

| What | Old | New |
|---|---|---|
| Tiers | Starter / Growth / Enterprise | Trial (free) / Standard / Enterprise |
| Billing | Monthly | Annual |
| Pricing | Fixed per tier | Per driver (RM 300 or RM 250) |
| Managers | Fixed quota per tier | 1 free per 25 drivers |
| Default | `basic` | `trial` |
