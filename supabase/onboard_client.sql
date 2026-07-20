-- =========================================================================
-- CNG Driver 360 / SafePass - Standard Client Onboarding Script
-- =========================================================================
-- How to use:
-- 1. Open your Supabase Dashboard.
-- 2. Go to the SQL Editor.
-- 3. Copy/paste this entire script.
-- 4. Fill in the STEP 1 fields below with the client's details.
-- 5. Run the script!
-- =========================================================================

DO $$
DECLARE
  -- =======================================================================
  -- STEP 1: CONFIGURATION (Fill in these details for each new client)
  -- =======================================================================

  -- Company Info
  v_company_name TEXT        := 'Example Logistics Sdn Bhd';
  v_manager_email TEXT       := 'manager@examplelogistics.com';
  v_manager_password TEXT    := 'SecureTemporaryPassword123!'; -- Send this to the client securely
  v_manager_full_name TEXT   := 'John Doe';
  v_manager_employee_id TEXT := 'MGR-001';     -- This is what they type to log in
  v_manager_region TEXT      := 'MY';          -- 'MY' for Malaysia
  v_manager_phone TEXT       := '+60123456789';
  v_manager_designation TEXT := 'Operations Manager';

  -- =======================================================================
  -- INTERNAL DEFAULTS (No need to change these)
  -- =======================================================================
  v_quota_managers INT       := 2;             -- Standard: 2 managers
  v_quota_drivers INT        := 50;            -- Standard: 50 drivers
  v_subscription_tier TEXT   := 'standard';
  v_company_id UUID          := gen_random_uuid();
  v_user_id UUID             := gen_random_uuid();
BEGIN
  -- 2. Validate input parameters
  IF v_manager_region NOT IN ('MY') THEN
    RAISE EXCEPTION 'Invalid region "%". Must be either "MY".', v_manager_region;
  END IF;

  IF EXISTS (SELECT 1 FROM auth.users WHERE email = v_manager_email) THEN
    RAISE EXCEPTION 'A user with email "%" already exists in auth.users.', v_manager_email;
  END IF;
  
  IF EXISTS (SELECT 1 FROM public.profiles WHERE employee_id = v_manager_employee_id) THEN
    RAISE EXCEPTION 'A profile with employee ID "%" already exists in public.profiles.', v_manager_employee_id;
  END IF;

  -- 3. Create the Company
  INSERT INTO public.companies (
    id,
    name,
    quota_managers,
    quota_drivers,
    subscription_tier,
    created_at,
    updated_at
  ) VALUES (
    v_company_id,
    v_company_name,
    v_quota_managers,
    v_quota_drivers,
    v_subscription_tier,
    now(),
    now()
  );

  RAISE NOTICE 'SUCCESS: Created company "%" with ID %', v_company_name, v_company_id;

  -- 4. Create the Level 1 Master User (Manager) in auth.users
  -- This will fire the trigger public.handle_new_user() automatically to create the public.profiles record
  INSERT INTO auth.users (
      id,
      instance_id,
      email,
      encrypted_password,
      email_confirmed_at,
      raw_app_meta_data,
      raw_user_meta_data,
      created_at,
      updated_at,
      confirmation_token,
      email_change,
      email_change_token_new,
      recovery_token
  ) VALUES (
      v_user_id,
      '00000000-0000-0000-0000-000000000000',
      v_manager_email,
      crypt(v_manager_password, gen_salt('bf')),
      now(), -- Confirmed immediately so they can log in straight away
      '{"provider":"email","providers":["email"]}',
      jsonb_build_object(
        'full_name', v_manager_full_name,
        'employee_id', v_manager_employee_id,
        'region', v_manager_region,
        'role', 'manager',
        'manager_level', 1,
        'company_id', v_company_id,
        'phone_number', v_manager_phone,
        'designation', v_manager_designation
      ),
      now(),
      now(),
      '',
      '',
      '',
      ''
  );

  RAISE NOTICE 'SUCCESS: Created Master User "%" (%) with ID %', v_manager_full_name, v_manager_email, v_user_id;
  RAISE NOTICE '=========================================================';
  RAISE NOTICE 'Onboarding completed successfully!';
  RAISE NOTICE 'Company ID: %', v_company_id;
  RAISE NOTICE 'Manager ID: %', v_user_id;
  RAISE NOTICE 'Login Employee ID: %', v_manager_employee_id;
  RAISE NOTICE 'Temporary Password: %', v_manager_password;
  RAISE NOTICE '=========================================================';
END $$;
