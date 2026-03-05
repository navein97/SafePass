-- Create app_settings table
CREATE TABLE IF NOT EXISTS public.app_settings (
    key TEXT PRIMARY KEY,
    value JSONB NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_by UUID REFERENCES public.profiles(id)
);

-- Enable RLS
ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;

-- Policy: Everyone can read company settings
DROP POLICY IF EXISTS "Everyone can read app_settings" ON public.app_settings;
CREATE POLICY "Everyone can read app_settings" ON public.app_settings
    FOR SELECT
    USING (true);

-- Policy: Only Level 1 Managers can update
DROP POLICY IF EXISTS "Level 1 Managers can update app_settings" ON public.app_settings;
CREATE POLICY "Level 1 Managers can update app_settings" ON public.app_settings
    FOR ALL
    USING (
        EXISTS (
            SELECT 1 FROM public.profiles
            WHERE profiles.id = auth.uid()
            AND profiles.role = 'manager'
            AND profiles.manager_level = 1
        )
    );

-- Insert default values (Update name safely if it already exists)
INSERT INTO public.app_settings (key, value)
VALUES 
    ('company_info', '{"name": "Driver 360", "logo_url": null}'::jsonb)
ON CONFLICT (key) DO UPDATE SET value = jsonb_set(app_settings.value, '{name}', '"Driver 360"');

-- === STORAGE CONFIGURATION ===

-- Create company-assets bucket
INSERT INTO storage.buckets (id, name, public)
VALUES ('company-assets', 'company-assets', true)
ON CONFLICT (id) DO NOTHING;

-- Allow public access to company-assets
DROP POLICY IF EXISTS "Anyone can view company assets" ON storage.objects;
CREATE POLICY "Anyone can view company assets"
ON storage.objects FOR SELECT
USING ( bucket_id = 'company-assets' );

-- Allow Level 1 Managers to upload/update/delete company assets
DROP POLICY IF EXISTS "Level 1 Managers can manage company assets" ON storage.objects;
CREATE POLICY "Level 1 Managers can manage company assets"
ON storage.objects FOR ALL
USING (
    bucket_id = 'company-assets' AND
    EXISTS (
        SELECT 1 FROM public.profiles
        WHERE profiles.id = auth.uid()
        AND profiles.role = 'manager'
        AND profiles.manager_level = 1
    )
)
WITH CHECK (
    bucket_id = 'company-assets' AND
    EXISTS (
        SELECT 1 FROM public.profiles
        WHERE profiles.id = auth.uid()
        AND profiles.role = 'manager'
        AND profiles.manager_level = 1
    )
);
