-- Migration to add image_url to questions and seed 20 new questions (5 with images)

-- 1. Add image_url column to questions table
ALTER TABLE public.questions 
ADD COLUMN IF NOT EXISTS image_url TEXT;

-- 2. Clear existing questions to ensure clean state
DELETE FROM public.questions;

-- 3. Insert 20 new questions
-- 5 Image Questions (Traffic Signs)
INSERT INTO public.questions (text, options, correct_option_index, explanation, regions, category, image_url) VALUES
('What does this traffic sign indicate?', 
 '["Yield", "Stop", "No Entry", "Slow Down"]', 
 1, 
 'The octagonal red sign with white text always indicates that you must come to a complete stop.', 
 ARRAY['MY', 'PT'], 
 'Traffic Signs',
 'stop_sign'),

('What is the meaning of this warning sign?', 
 '["School Zone", "Construction", "Pedestrian Crossing", "Children Crossing"]', 
 2, 
 'This sign warns drivers that there is a pedestrian crossing ahead. Slow down and be prepared to stop.', 
 ARRAY['MY', 'PT'], 
 'Traffic Signs',
 'pedestrian_crossing'),

('What are you prohibited from doing when you see this sign?', 
 '["Turning Left", "Turning Right", "Entering", "Stopping"]', 
 2, 
 'The red circle with a white horizontal bar means "No Entry" for all vehicles.', 
 ARRAY['MY', 'PT'], 
 'Traffic Signs',
 'no_entry'),

('What action is mandatory according to this sign?', 
 '["Turn Left", "Turn Right", "Go Straight", "U-Turn"]', 
 1, 
 'The blue backing with a white arrow is a mandatory sign. You must turn right.', 
 ARRAY['MY', 'PT'], 
 'Traffic Signs',
 'turn_right'),

('What does this general warning sign indicate?', 
 '["Stop Ahead", "Danger/Caution", "Speed Limit", "Traffic Light"]', 
 1, 
 'The exclamation mark inside a red triangle is a general warning sign indicating unspecified danger or caution ahead.', 
 ARRAY['MY', 'PT'], 
 'Traffic Signs',
 'warning');

-- 15 Text-Based Questions
INSERT INTO public.questions (text, options, correct_option_index, explanation, regions, category) VALUES
('When driving in heavy rain, what should you do to improve visibility?', 
 '["Turn on high beams", "Turn on hazard lights", "Turn on low beam headlights", "Drive faster to get out of rain"]', 
 2, 
 'High beams reflect off rain/fog, and hazard lights are for stationary vehicles. Low beams are best for visibility.', 
 ARRAY['MY', 'PT'], 
 'Safety'),

('What is the recommended following distance under normal driving conditions?', 
 '["1 second", "2 seconds", "4 seconds", "5 seconds"]', 
 1, 
 'The "2-second rule" is the standard recommendation for safe following distance in good conditions.', 
 ARRAY['MY', 'PT'], 
 'Safety'),

('If your vehicle begins to skid, what should you do?', 
 '["Brake hard immediately", "Accelerate", "Steer in the direction of the skid", "Steer opposite to the skid"]', 
 2, 
 'Steer gently into the direction of the skid. Do not brake hard as it may lock the wheels.', 
 ARRAY['MY', 'PT'], 
 'Emergency Handling'),

('What is the main cause of tire blowouts on highways?', 
 '["Over-inflation", "Under-inflation", "Old tires", "High speed"]', 
 1, 
 'Under-inflation causes excessive heat buildup in the tire sidewalls, leading to blowouts.', 
 ARRAY['MY', 'PT'], 
 'Maintenance'),

('When are you allowed to use a mobile phone while driving?', 
 '["When creating a map route", "When at a red light", "Only with a hands-free device", "Never"]', 
 2, 
 'Using a mobile phone is generally prohibited unless firmly mounted and used hands-free.', 
 ARRAY['MY', 'PT'], 
 'Regulations'),

('Which lane should you normally use on a three-lane highway?', 
 '["Left lane", "Middle lane", "Right lane", "Any lane"]', 
 0, 
 'In left-hand traffic countries (MY), keep left. In right-hand traffic (PT), keep right. Generally, the outer lane is for overtaking.', 
 ARRAY['MY', 'PT'], 
 'Road Rules'),

('What should you do if an ambulance approaches with sirens on?', 
 '["Speed up", "Stop immediately where you are", "Pull over to the side and stop safely", "Ignore it"]', 
 2, 
 'Always give way to emergency vehicles by pulling over safely to the side to clear a path.', 
 ARRAY['MY', 'PT'], 
 'Road Rules'),

('How often should you check your tire pressure?', 
 '["Once a year", "Every month", "Before every long trip", "Only when they look flat"]', 
 1, 
 'Tires lose pressure naturally. Check them at least once a month and before long trips.', 
 ARRAY['MY', 'PT'], 
 'Maintenance'),

('What is the effect of alcohol on driving ability?', 
 '["Increases reaction time", "Decreases reaction time", "Improves concentration", "Sharpen vision"]', 
 0, 
 'Alcohol slows down the nervous system, increasing the time it takes to react to hazards.', 
 ARRAY['MY', 'PT'], 
 'Safety'),

('When approaching a flashing yellow traffic light, what should you do?', 
 '["Stop and wait for green", "Proceed with caution", "Speed up to cross quickly", "Treat it as a red light"]', 
 1, 
 'A flashing yellow light means proceed with caution/slow down, checking for cross traffic.', 
 ARRAY['MY', 'PT'], 
 'Road Rules'),

('What is the purpose of ABS (Anti-lock Braking System)?', 
 '["To stop faster", "To prevent wheels from locking during braking", "To auto-brake", "To prevent skidding while turning"]', 
 1, 
 'ABS prevents wheels from locking up during hard braking, allowing the driver to maintain steering control.', 
 ARRAY['MY', 'PT'], 
 'Vehicle Technology'),

('When parked downhill with a curb, which way should you turn your wheels?', 
 '["Towards the curb", "Away from the curb", "Straight", "Doesn''t matter"]', 
 0, 
 'Turn wheels towards the curb so if the brakes fail, the car rolls into the curb, not traffic.', 
 ARRAY['MY', 'PT'], 
 'Parking'),

('What is "blind spot" in driving?', 
 '["The area directly in front of the car", "The area you cannot see in your mirrors", "The area behind the car", "Night driving"]', 
 1, 
 'Blind spots are areas around the vehicle that cannot be seen in the rear or side mirrors.', 
 ARRAY['MY', 'PT'], 
 'Safety'),

('Why is it dangerous to drive fast on a wet road?', 
 '["The engine might overheat", "Tires lose grip (hydroplaning)", "Visibility is better", "Brakes work better"]', 
 1, 
 'Water creates a layer between tires and road, leading to loss of traction (hydroplaning/aquaplaning).', 
 ARRAY['MY', 'PT'], 
 'Safety'),

('Which lights should you use in dense fog?', 
 '["High beams", "Low beams and fog lights", "Parking lights", "No lights"]', 
 1, 
 'Use low beams and fog lights. High beams reflect off the fog and reduce visibility.', 
 ARRAY['MY', 'PT'], 
 'Safety');
