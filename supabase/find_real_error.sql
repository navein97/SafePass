-- Diagnostic script to catch the EXACT trigger error
DO $$
DECLARE
    v_user_id uuid := gen_random_uuid();
    v_error_msg text;
    v_error_detail text;
BEGIN
    -- We use a subtransaction to catch the error
    BEGIN
        -- Insert a dummy user directly into auth.users to fire the trigger
        -- We supply the exact metadata that CreateUserModal generates
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
            'test_driver_999@driver360.internal',
            'dummy_password_hash',
            now(),
            '{"provider":"email","providers":["email"]}',
            '{"full_name": "Test Driver", "employee_id": "TEST999", "region": "MY", "role": "driver", "age": 25, "vehicle_type": "Sedan", "phone_number": "123456789"}',
            now(),
            now(),
            '',
            '',
            '',
            ''
        );
        
        -- If it succeeded, clean up immediately
        DELETE FROM auth.users WHERE id = v_user_id;
        RAISE NOTICE 'SUCCESS: The trigger works perfectly. The issue must be something else.';
        
    EXCEPTION WHEN OTHERS THEN
        -- Catch the exact error and print it clearly
        GET STACKED DIAGNOSTICS v_error_msg = MESSAGE_TEXT, v_error_detail = PG_EXCEPTION_DETAIL;
        RAISE NOTICE 'TRIGGER ERROR: %', v_error_msg;
        RAISE NOTICE 'ERROR DETAIL: %', v_error_detail;
    END;
END;
$$;
