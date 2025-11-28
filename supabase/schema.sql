-- SafePass Database Schema for Supabase
-- Run this in Supabase SQL Editor after project creation

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ============================================
-- 1. USERS TABLE (extends Supabase auth.users)
-- ============================================
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT NOT NULL,
  employee_id TEXT UNIQUE NOT NULL,
  region TEXT NOT NULL CHECK (region IN ('MY', 'PT')),
  role TEXT NOT NULL DEFAULT 'driver' CHECK (role IN ('driver', 'manager', 'admin')),
  safety_index INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- 2. QUESTIONS TABLE
-- ============================================
CREATE TABLE public.questions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  text TEXT NOT NULL,
  options JSONB NOT NULL, -- Array of answer options
  correct_option_index INTEGER NOT NULL,
  explanation TEXT NOT NULL,
  regions TEXT[] NOT NULL, -- Array of applicable regions ['MY', 'PT']
  category TEXT NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- 3. QUIZ ATTEMPTS TABLE
-- ============================================
CREATE TABLE public.quiz_attempts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  score INTEGER NOT NULL CHECK (score >= 0 AND score <= 100),
  answers JSONB NOT NULL, -- Array of {questionId, selectedIndex, isCorrect}
  week_number INTEGER NOT NULL,
  year INTEGER NOT NULL,
  completed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================
-- 4. COMPLIANCE LOGS TABLE (Tamper-Proof)
-- ============================================
CREATE TABLE public.compliance_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE NOT NULL,
  week_number INTEGER NOT NULL,
  year INTEGER NOT NULL,
  status TEXT NOT NULL CHECK (status IN ('COMPLIANT', 'OVERDUE')),
  score INTEGER,
  signature TEXT NOT NULL, -- HMAC signature for tamper detection
  completed_at TIMESTAMP WITH TIME ZONE,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(user_id, week_number, year)
);

-- ============================================
-- 5. INDEXES for Performance
-- ============================================
CREATE INDEX idx_profiles_employee_id ON public.profiles(employee_id);
CREATE INDEX idx_profiles_region ON public.profiles(region);
CREATE INDEX idx_questions_regions ON public.questions USING GIN(regions);
CREATE INDEX idx_quiz_attempts_user_id ON public.quiz_attempts(user_id);
CREATE INDEX idx_quiz_attempts_date ON public.quiz_attempts(week_number, year);
CREATE INDEX idx_compliance_logs_user_id ON public.compliance_logs(user_id);
CREATE INDEX idx_compliance_logs_date ON public.compliance_logs(week_number, year);

-- ============================================
-- 6. ROW LEVEL SECURITY (RLS) POLICIES
-- ============================================

-- Enable RLS on all tables
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quiz_attempts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.compliance_logs ENABLE ROW LEVEL SECURITY;

-- Profiles: Users can read their own profile
CREATE POLICY "Users can view own profile" 
  ON public.profiles FOR SELECT 
  USING (auth.uid() = id);

-- Profiles: Users can update their own profile
CREATE POLICY "Users can update own profile" 
  ON public.profiles FOR UPDATE 
  USING (auth.uid() = id);

-- Profiles: Managers and admins can view all profiles
CREATE POLICY "Managers can view all profiles" 
  ON public.profiles FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role IN ('manager', 'admin')
    )
  );

-- Questions: Everyone can read questions for their region
CREATE POLICY "Users can view questions for their region" 
  ON public.questions FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() 
      AND region = ANY(questions.regions)
    )
  );

-- Questions: Only admins can insert/update/delete questions
CREATE POLICY "Admins can manage questions" 
  ON public.questions FOR ALL 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role = 'admin'
    )
  );

-- Quiz Attempts: Users can insert their own attempts
CREATE POLICY "Users can create own quiz attempts" 
  ON public.quiz_attempts FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Quiz Attempts: Users can view their own attempts
CREATE POLICY "Users can view own quiz attempts" 
  ON public.quiz_attempts FOR SELECT 
  USING (auth.uid() = user_id);

-- Quiz Attempts: Managers can view all attempts
CREATE POLICY "Managers can view all quiz attempts" 
  ON public.quiz_attempts FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role IN ('manager', 'admin')
    )
  );

-- Compliance Logs: Users can insert their own logs
CREATE POLICY "Users can create own compliance logs" 
  ON public.compliance_logs FOR INSERT 
  WITH CHECK (auth.uid() = user_id);

-- Compliance Logs: Users can view their own logs
CREATE POLICY "Users can view own compliance logs" 
  ON public.compliance_logs FOR SELECT 
  USING (auth.uid() = user_id);

-- Compliance Logs: Managers can view all logs
CREATE POLICY "Managers can view all compliance logs" 
  ON public.compliance_logs FOR SELECT 
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles 
      WHERE id = auth.uid() AND role IN ('manager', 'admin')
    )
  );

-- ============================================
-- 7. FUNCTIONS & TRIGGERS
-- ============================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for profiles
CREATE TRIGGER update_profiles_updated_at 
  BEFORE UPDATE ON public.profiles 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Trigger for questions
CREATE TRIGGER update_questions_updated_at 
  BEFORE UPDATE ON public.questions 
  FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Function to create profile on user signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, employee_id, region)
  VALUES (
    NEW.id,
    NEW.email,
    COALESCE(NEW.raw_user_meta_data->>'full_name', 'New User'),
    COALESCE(NEW.raw_user_meta_data->>'employee_id', 'PENDING'),
    COALESCE(NEW.raw_user_meta_data->>'region', 'MY')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger to auto-create profile on signup
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ============================================
-- 8. SEED DATA - Sample Questions
-- ============================================

-- Malaysian Questions
INSERT INTO public.questions (text, options, correct_option_index, explanation, regions, category) VALUES
('What is the maximum speed limit for heavy vehicles on Malaysian expressways?', 
 '["80 km/h", "90 km/h", "110 km/h", "70 km/h"]', 
 1, 
 'Heavy vehicles exceeding 10,000kg BDM are limited to 90 km/h on expressways (Lebuhraya) and 80 km/h on federal roads.', 
 ARRAY['MY'], 
 'Speed Limits'),

('According to JPJ regulations, how often must a commercial vehicle undergo PUSPAKOM inspection?', 
 '["Every 3 months", "Every 6 months", "Every 12 months", "Every 24 months"]', 
 1, 
 'Commercial vehicles are required to undergo routine inspection at PUSPAKOM every 6 months to ensure roadworthiness.', 
 ARRAY['MY'], 
 'Compliance'),

('What does a solid double white line on the road indicate?', 
 '["Overtaking allowed if safe", "Overtaking strictly prohibited", "Parking allowed", "U-turn allowed"]', 
 1, 
 'A double white line indicates that overtaking is strictly prohibited in both directions.', 
 ARRAY['MY'], 
 'Road Rules'),

('When is it legal to use the emergency lane?', 
 '["To avoid traffic jams", "When your vehicle breaks down", "To answer a phone call", "When rushing for delivery"]', 
 1, 
 'The emergency lane is strictly for emergencies such as vehicle breakdown or medical emergencies. Misuse is an offense.', 
 ARRAY['MY'], 
 'Road Rules'),

('What is the legal blood alcohol concentration (BAC) limit for drivers in Malaysia?', 
 '["0.08%", "0.05%", "0.02%", "0.00%"]', 
 1, 
 'The legal BAC limit in Malaysia was reduced to 0.05% (50mg/100ml blood) in 2020.', 
 ARRAY['MY'], 
 'Safety');

-- Portuguese Questions
INSERT INTO public.questions (text, options, correct_option_index, explanation, regions, category) VALUES
('Qual é o limite máximo de horas de condução diária permitido na UE?', 
 '["8 horas", "9 horas", "10 horas", "11 horas"]', 
 1, 
 'O limite diário de condução é de 9 horas, podendo ser estendido para 10 horas no máximo duas vezes por semana.', 
 ARRAY['PT'], 
 'Regulamentação UE'),

('Após 4,5 horas de condução, qual a pausa obrigatória mínima?', 
 '["15 minutos", "30 minutos", "45 minutos", "60 minutos"]', 
 2, 
 'Após um período de condução de 4,5 horas, o condutor deve fazer uma pausa ininterrupta de pelo menos 45 minutos.', 
 ARRAY['PT'], 
 'Tempos de Condução'),

('Qual é o limite de velocidade para veículos pesados de mercadorias em autoestradas em Portugal?', 
 '["80 km/h", "90 km/h", "100 km/h", "110 km/h"]', 
 1, 
 'O limite máximo de velocidade para veículos pesados de mercadorias em autoestradas é de 90 km/h.', 
 ARRAY['PT'], 
 'Limites de Velocidade'),

('O que indica o sinal de tacógrafo "Cama"?', 
 '["Condução", "Trabalho", "Disponibilidade", "Repouso"]', 
 3, 
 'O símbolo da cama no tacógrafo indica que o condutor está em período de repouso ou pausa.', 
 ARRAY['PT'], 
 'Tacógrafo'),

('É obrigatório o uso de colete refletor ao sair do veículo na autoestrada?', 
 '["Apenas à noite", "Sim, sempre", "Não é obrigatório", "Apenas se estiver a chover"]', 
 1, 
 'É obrigatório usar o colete refletor sempre que sair do veículo na autoestrada ou vias equiparadas, de dia ou de noite.', 
 ARRAY['PT'], 
 'Segurança');

-- ============================================
-- SETUP COMPLETE!
-- ============================================
-- Next: Configure your app with Supabase URL and Anon Key
