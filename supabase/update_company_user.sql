CREATE OR REPLACE FUNCTION public.update_company_user(
    target_user_id UUID,
    p_email TEXT,
    p_full_name TEXT,
    p_employee_id TEXT,
    p_region TEXT,
    p_age INTEGER DEFAULT NULL,
    p_vehicle_type TEXT DEFAULT NULL,
    p_phone_number TEXT DEFAULT NULL
) RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
    v_caller_role TEXT;
    v_caller_company UUID;
    v_target_company UUID;
    v_user_metadata JSONB;
BEGIN
    -- 1. Check if caller is authorized (must be a manager)
    SELECT role, company_id INTO v_caller_role, v_caller_company 
    FROM public.profiles 
    WHERE id = auth.uid();
    
    IF v_caller_role != 'manager' THEN
        RETURN jsonb_build_object('success', false, 'error', 'Only managers can update users');
    END IF;

    -- 2. Verify the target user belongs to the same company
    SELECT company_id INTO v_target_company 
    FROM public.profiles 
    WHERE id = target_user_id;

    IF v_caller_company IS NOT NULL AND v_caller_company != v_target_company THEN
        RETURN jsonb_build_object('success', false, 'error', 'Cannot update user from different company');
    END IF;

    -- 3. Update public.profiles
    UPDATE public.profiles
    SET 
        full_name = p_full_name,
        employee_id = p_employee_id,
        region = p_region,
        age = p_age,
        vehicle_type = p_vehicle_type,
        phone_number = p_phone_number,
        updated_at = NOW()
    WHERE id = target_user_id;

    -- 4. Update auth.users (email and raw_user_meta_data)
    -- We must ensure we don't overwrite other metadata keys like company_id, role, etc.
    SELECT raw_user_meta_data INTO v_user_metadata
    FROM auth.users
    WHERE id = target_user_id;

    IF v_user_metadata IS NULL THEN
        v_user_metadata := '{}'::jsonb;
    END IF;

    v_user_metadata := v_user_metadata || jsonb_build_object(
        'full_name', p_full_name,
        'employee_id', p_employee_id,
        'region', p_region,
        'age', p_age,
        'vehicle_type', p_vehicle_type,
        'phone_number', p_phone_number
    );

    UPDATE auth.users
    SET 
        email = p_email,
        raw_user_meta_data = v_user_metadata,
        updated_at = NOW()
    WHERE id = target_user_id;

    RETURN jsonb_build_object('success', true);
EXCEPTION WHEN OTHERS THEN
    RETURN jsonb_build_object('success', false, 'error', SQLERRM);
END;
$$;
