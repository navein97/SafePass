-- ============================================
-- BACKEND INTEGRATION SUPPORT
-- Profiles Updates, Notifications, Social Feed
-- ============================================

-- 1. Add Game Stats to Profiles
ALTER TABLE public.profiles 
ADD COLUMN IF NOT EXISTS streak INTEGER DEFAULT 0,
ADD COLUMN IF NOT EXISTS last_activity_date DATE DEFAULT CURRENT_DATE,
ADD COLUMN IF NOT EXISTS shield_health INTEGER DEFAULT 100 CHECK (shield_health >= 0 AND shield_health <= 100),
ADD COLUMN IF NOT EXISTS total_score INTEGER DEFAULT 0;

-- Index for leaderboard performance
CREATE INDEX IF NOT EXISTS idx_profiles_total_score ON public.profiles(total_score DESC);

-- 2. Create Notifications Table
CREATE TABLE IF NOT EXISTS public.notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    type TEXT CHECK (type IN ('system', 'achievement', 'mission', 'alert')) DEFAULT 'system',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Users can view own notifications" 
    ON public.notifications FOR SELECT 
    USING (auth.uid() = user_id);

CREATE POLICY "Users can update own notifications" 
    ON public.notifications FOR UPDATE
    USING (auth.uid() = user_id);

-- 3. Create Posts Table (Social Feed)
CREATE TABLE IF NOT EXISTS public.posts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    content TEXT NOT NULL,
    image_url TEXT,
    likes_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE public.posts ENABLE ROW LEVEL SECURITY;

-- Policies
CREATE POLICY "Authenticated users can view posts" 
    ON public.posts FOR SELECT 
    USING (auth.role() = 'authenticated');

CREATE POLICY "Users can create posts" 
    ON public.posts FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

-- 4. Create Post Likes Table (to track who liked what)
CREATE TABLE IF NOT EXISTS public.post_likes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    post_id UUID REFERENCES public.posts(id) ON DELETE CASCADE NOT NULL,
    user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(post_id, user_id)
);

ALTER TABLE public.post_likes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view likes" 
    ON public.post_likes FOR SELECT 
    USING (auth.role() = 'authenticated');

CREATE POLICY "Users can like posts" 
    ON public.post_likes FOR INSERT 
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Users can unlike posts" 
    ON public.post_likes FOR DELETE 
    USING (auth.uid() = user_id);

-- Function to update like count
CREATE OR REPLACE FUNCTION update_post_likes_count()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE public.posts SET likes_count = likes_count + 1 WHERE id = NEW.post_id;
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        UPDATE public.posts SET likes_count = likes_count - 1 WHERE id = OLD.post_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER on_like_change
AFTER INSERT OR DELETE ON public.post_likes
FOR EACH ROW EXECUTE FUNCTION update_post_likes_count();

-- 5. Insert Dummy Social Posts (optional, if we have users, but harmless if table is empty)
-- INSERT INTO public.posts (user_id, content, likes_count) 
-- SELECT id, 'Just completed a 7-day safety streak! 🛡️', 5 FROM public.profiles LIMIT 1;
