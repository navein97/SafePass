-- Force a Schema Cache reload in PostgREST
NOTIFY pgrst, 'reload schema';
