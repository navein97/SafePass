-- ============================================
-- MULTI-TENANT MIGRATION: Companies & Quotas
-- ============================================

-- Step 1: Create Companies Table (without policies that reference profiles.company_id yet)
CREATE TABLE IF NOT EXISTS public.companies (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  quota_managers INTEGER DEFAULT 1,
  quota_drivers INTEGER DEFAULT 3,
  subscription_tier TEXT DEFAULT 'trial', -- 'trial', 'standard', 'enterprise'
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS for Companies
ALTER TABLE public.companies ENABLE ROW LEVEL SECURITY;

-- Step 2: Add company_id to profiles table
DO $$ 
BEGIN 
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'profiles' AND column_name = 'company_id') THEN
        ALTER TABLE public.profiles ADD COLUMN company_id UUID REFERENCES public.companies(id);
        CREATE INDEX idx_profiles_company_id ON public.profiles(company_id);
    END IF;
END $$;

-- Step 3: NOW create policies that reference profiles.company_id
DROP POLICY IF EXISTS "Users can view own company" ON public.companies;
CREATE POLICY "Users can view own company" 
  ON public.companies FOR SELECT 
  USING (
    id IN (
      SELECT company_id FROM public.profiles WHERE id = auth.uid()
    )
  );

DROP POLICY IF EXISTS "Level 1 Managers can update own company" ON public.companies;
CREATE POLICY "Level 1 Managers can update own company" 
  ON public.companies FOR UPDATE
  USING (
    EXISTS (
        SELECT 1 FROM public.profiles
        WHERE profiles.id = auth.uid()
        AND profiles.company_id = companies.id
        AND profiles.role = 'manager'
        AND profiles.manager_level = 1
    )
  );

-- Step 4: Update profiles policies to support multi-tenancy
DROP POLICY IF EXISTS "Managers can view all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Managers can view all profiles in company" ON public.profiles;
CREATE POLICY "Managers can view all profiles in company" 
  ON public.profiles FOR SELECT 
  USING (
    (auth.uid() = id) OR -- View self
    (
        EXISTS ( -- View others in same company if manager
            SELECT 1 FROM public.profiles as viewer
            WHERE viewer.id = auth.uid() 
            AND viewer.role IN ('manager', 'admin')
            AND viewer.company_id = profiles.company_id
        )
    )
  );

-- Step 5: Quota Enforcement Trigger
CREATE OR REPLACE FUNCTION check_company_quotas()
RETURNS TRIGGER AS $$
DECLARE
    v_company_id UUID;
    v_quota_limit INTEGER;
    v_current_count INTEGER;
BEGIN
    -- Determine company_id
    v_company_id := NEW.company_id;
    
    -- If no company_id, skip quota check (for super-admins or unlinked users)
    IF v_company_id IS NULL THEN
        RETURN NEW;
    END IF;

    -- Check Quota based on Role
    IF NEW.role = 'driver' THEN
        SELECT quota_drivers INTO v_quota_limit FROM public.companies WHERE id = v_company_id;
        SELECT COUNT(*) INTO v_current_count FROM public.profiles 
        WHERE company_id = v_company_id AND role = 'driver' AND id != NEW.id AND (status IS NULL OR status != 'inactive');
        
        IF v_current_count >= v_quota_limit THEN
            RAISE EXCEPTION 'Driver quota exceeded for this company. Limit: %', v_quota_limit;
        END IF;

    ELSIF NEW.role = 'manager' THEN
        SELECT quota_managers INTO v_quota_limit FROM public.companies WHERE id = v_company_id;
        SELECT COUNT(*) INTO v_current_count FROM public.profiles 
        WHERE company_id = v_company_id AND role = 'manager' AND id != NEW.id AND (status IS NULL OR status != 'inactive');
        
        IF v_current_count >= v_quota_limit THEN
            RAISE EXCEPTION 'Manager quota exceeded for this company. Limit: %', v_quota_limit;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop trigger if exists to recreate
DROP TRIGGER IF EXISTS check_quotas_before_insert ON public.profiles;

CREATE TRIGGER check_quotas_before_insert
  BEFORE INSERT OR UPDATE OF role, company_id ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION check_company_quotas();

-- Step 6: Function to Get Company Stats
CREATE OR REPLACE FUNCTION get_company_stats(p_company_id UUID)
RETURNS JSONB AS $$
DECLARE
    v_driver_count INTEGER;
    v_manager_count INTEGER;
    v_driver_quota INTEGER;
    v_manager_quota INTEGER;
BEGIN
    -- Get Counts (exclude deactivated/inactive users)
    SELECT COUNT(*) INTO v_driver_count FROM public.profiles 
    WHERE company_id = p_company_id AND role = 'driver'
    AND (status IS NULL OR status != 'inactive');
    
    SELECT COUNT(*) INTO v_manager_count FROM public.profiles 
    WHERE company_id = p_company_id AND role = 'manager'
    AND (status IS NULL OR status != 'inactive');

    -- Get Quotas
    SELECT quota_drivers, quota_managers INTO v_driver_quota, v_manager_quota 
    FROM public.companies WHERE id = p_company_id;

    RETURN jsonb_build_object(
        'drivers', v_driver_count,
        'managers', v_manager_count,
        'quota_drivers', COALESCE(v_driver_quota, 0),
        'quota_managers', COALESCE(v_manager_quota, 0)
    );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
