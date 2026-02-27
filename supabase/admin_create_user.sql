-- Safely create a user directly bypassing the public signUp method
CREATE OR REPLACE FUNCTION public.create_company_user(
  p_email TEXT,
  p_password TEXT,
  p_full_name TEXT,
  p_employee_id TEXT,
  p_region TEXT,
  p_role TEXT,
  p_manager_level INT,
  p_company_id UUID,
  p_age INT,
  p_vehicle_type TEXT,
  p_phone_number TEXT
)
RETURNS JSONB AS $$
DECLARE
  v_user_id UUID := gen_random_uuid();
  v_result JSONB;
BEGIN

  -- 1. Check if the current user is a manager (Basic Security)
  IF (SELECT role FROM public.profiles WHERE id = auth.uid()) != 'manager' THEN
    RETURN jsonb_build_object('success', false, 'error', 'Only managers can create users');
  END IF;

  -- 2. Insert into auth.users directly. This avoids hitting rate limits for the 
  -- frontend signUp endpoint. We set the email as already confirmed since it's created by a manager.
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
      p_email,
      crypt(p_password, gen_salt('bf')),
      now(), -- Confirmed immediately!
      '{"provider":"email","providers":["email"]}',
      json_build_object(
        'full_name', p_full_name,
        'employee_id', p_employee_id,
        'region', p_region,
        'role', p_role,
        'manager_level', p_manager_level,
        'company_id', p_company_id,
        'age', p_age,
        'vehicle_type', p_vehicle_type,
        'phone_number', p_phone_number
      )::jsonb,
      now(),
      now(),
      '',
      '',
      '',
      ''
  );

  -- 3. The handle_new_user trigger will automatically fire here and create the profile!

  RETURN jsonb_build_object('success', true, 'user_id', v_user_id);

EXCEPTION WHEN OTHERS THEN
  RETURN jsonb_build_object('success', false, 'error', SQLERRM);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
