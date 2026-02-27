CREATE OR REPLACE FUNCTION test_trigger_logic() RETURNS text AS $$
DECLARE
  v_err text;
  v_meta jsonb := '{"full_name":"Test User","employee_id":"TEST01","region":"MY","role":"driver","manager_level":null,"company_id":null,"age":null,"vehicle_type":"Sedan","phone_number":"123","designation":null,"address":null}'::jsonb;
BEGIN
  INSERT INTO public.profiles (
    id, email, full_name, employee_id, region, role, manager_level, company_id, age, vehicle_type, phone_number, designation, address
  ) VALUES (
    '00000000-0000-0000-0000-000000000000'::uuid,
    'test@safepass.internal',
    COALESCE(v_meta->>'full_name', 'New User'),
    COALESCE(v_meta->>'employee_id', split_part('test@safepass.internal', '@', 1)),
    COALESCE(v_meta->>'region', 'MY'),
    COALESCE(v_meta->>'role', 'driver'),
    CASE WHEN v_meta->>'manager_level' IS NOT NULL AND v_meta->>'manager_level' ~ '^\d+$' THEN (v_meta->>'manager_level')::int ELSE NULL END,
    CASE WHEN v_meta->>'company_id' IS NOT NULL AND v_meta->>'company_id' != '' AND v_meta->>'company_id' != 'undefined' THEN (v_meta->>'company_id')::uuid ELSE NULL END,
    CASE WHEN v_meta->>'age' IS NOT NULL AND v_meta->>'age' ~ '^\d+$' THEN (v_meta->>'age')::int ELSE NULL END,
    v_meta->>'vehicle_type',
    v_meta->>'phone_number',
    v_meta->>'designation',
    v_meta->>'address'
  );
  RETURN 'Success';
EXCEPTION WHEN OTHERS THEN
  RETURN SQLERRM;
END;
$$ LANGUAGE plpgsql;
