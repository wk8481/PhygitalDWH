-- Sample projects
INSERT INTO public.project (active, avg_time_spent, total_participants, background_color_hex, font_name, logo_path, name) VALUES
(true, 4.5, 150, '#58B368', 'Arial', '/logos/sustainable.png', 'Green Energy Initiative'),
(true, 5.2, 120, '#5BC0EB', 'Helvetica', '/logos/innovation.png', 'Tech for Society'),
(true, 3.8, 180, '#FF6B6B', 'Times New Roman', '/logos/art.png', 'Cultural Exchange Program'),
(true, 6.0, 200, '#F0C987', 'Verdana', '/logos/education.png', 'Learning Together'),
(true, 4.7, 170, '#B08BEB', 'Calibri', '/logos/healthcare.png', 'Healthcare Access Initiative');

-- Sample themes
INSERT INTO public.theme (project_id, information, name) VALUES
(1, 'Community-driven projects aimed at sustainable development.', 'Sustainable Development'),
(2, 'Bringing innovation to various sectors for societal progress.', 'Innovation'),
(3, 'Promoting cultural exchange and diversity through art.', 'Art & Culture'),
(4, 'Enhancing educational opportunities for all ages.', 'Education'),
(5, 'Improving healthcare accessibility and services.', 'Healthcare');

INSERT INTO public.location (street_number, city, province, street) VALUES
(10, 'Brussels', 'Brussels-Capital Region', 'Rue de la Loi 10'),
(20, 'Antwerp', 'Flanders', 'Grote Markt 20'),
(15, 'Ghent', 'Flanders', 'Veldstraat 15'),
(30, 'Liege', 'Wallonia', 'Place Saint-Lambert 30'),
(25, 'Bruges', 'Flanders', 'Markt 25');

INSERT INTO public.installation (is_running, location_id, name) VALUES
(true, 1, 'Brussels Workshop Center'),
(true, 2, 'Antwerp Innovation Hub'),
(true, 3, 'Ghent Cultural Center'),
(true, 4, 'Liege Education Hub'),
(true, 5, 'Bruges Healthcare Center');

INSERT INTO public.flow (installation_id, is_circular, project_id, end_time, start_time, name) VALUES
(1, true, 1, '2024-05-09 12:00:00', '2024-05-09 09:00:00', 'Renewable Energy Workshop'),
(2, false, 2, '2024-05-10 14:00:00', '2024-05-10 10:00:00', 'Innovation Summit'),
(3, true, 3, '2024-05-11 18:00:00', '2024-05-11 14:00:00', 'Cultural Exchange Exhibition'),
(4, false, 4, '2024-05-12 16:00:00', '2024-05-12 13:00:00', 'Educational Access Seminar'),
(5, true, 5, '2024-05-13 15:00:00', '2024-05-13 11:00:00', 'Healthcare Access Conference');

INSERT INTO public.sub_theme (current_index, flow_id, is_visible, information, name) VALUES
(1, 1, true, 'Promotion of renewable energy sources', 'Renewable Energy'),
(2, 2, true, 'Development of innovative solutions for societal challenges', 'Innovative Solutions'),
(3, 3, true, 'Exploration of different cultures through art', 'Cultural Exchange'),
(4, 4, true, 'Improvement of educational accessibility and quality', 'Educational Access'),
(5, 5, true, 'Enhancement of healthcare services and accessibility', 'Healthcare Access');

INSERT INTO public.flow_sub_themes (flow_id, sub_themes_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


-- Sample questions for Sustainable Development project
INSERT INTO public.question (is_visible, sub_theme_id, text, type) VALUES
(true, 1, 'What is your opinion on renewable energy sources?', 'OPEN'),
(true, 1, 'Which renewable energy source do you think is most promising for our community?', 'SINGLE_CHOICE'),
(true, 1, 'How important do you think sustainability is for our future?', 'RANGE'),
(true, 1, 'Do you actively participate in eco-friendly practices?', 'MULTIPLE_CHOICE');

-- Sample questions for Tech for Society project
INSERT INTO public.question (is_visible, sub_theme_id, text, type) VALUES
(true, 2, 'What technology do you believe can have the biggest impact on society?', 'OPEN'),
(true, 2, 'Which industry do you think needs technological innovation the most?', 'SINGLE_CHOICE'),
(true, 2, 'How comfortable are you with using new technologies?', 'RANGE'),
(true, 2, 'Have you ever participated in a hackathon or similar event?', 'MULTIPLE_CHOICE');

-- Sample questions for Cultural Exchange Program project
INSERT INTO public.question (is_visible, sub_theme_id, text, type) VALUES
(true, 3, 'What cultural aspect do you believe is most important to preserve?', 'OPEN'),
(true, 3, 'Which form of art do you find most expressive?', 'SINGLE_CHOICE'),
(true, 3, 'How often do you engage with different cultures?', 'RANGE'),
(true, 3, 'Have you ever participated in an international exchange program?', 'MULTIPLE_CHOICE');

-- Sample questions for Learning Together project
INSERT INTO public.question (is_visible, sub_theme_id, text, type) VALUES
(true, 4, 'What do you think is the biggest challenge in education today?', 'OPEN'),
(true, 4, 'Which educational method do you find most effective?', 'SINGLE_CHOICE'),
(true, 4, 'How satisfied are you with the current education system?', 'RANGE'),
(true, 4, 'Have you ever volunteered as a tutor or mentor?', 'MULTIPLE_CHOICE');

-- Sample questions for Healthcare Access Initiative project
INSERT INTO public.question (is_visible, sub_theme_id, text, type) VALUES
(true, 5, 'What improvements would you like to see in healthcare services?', 'OPEN'),
(true, 5, 'Which aspect of healthcare accessibility concerns you the most?', 'SINGLE_CHOICE'),
(true, 5, 'How satisfied are you with your current healthcare coverage?', 'RANGE'),
(true, 5, 'Have you ever participated in a medical mission or volunteer work?', 'MULTIPLE_CHOICE');

-- Possible answers for Sustainable Development project
INSERT INTO public.possible_answers (question_id, answer) VALUES
(1, 'I believe renewable energy sources are essential for a sustainable future.'),
(1, 'Renewable energy sources are the key to reducing carbon emissions.'),
(2, 'Solar energy'),
(2, 'Wind energy'),
(2, 'Hydropower'),
(2, 'Geothermal energy'),
(3, 'Extremely important'),
(3, 'Very important'),
(3, 'Moderately important'),
(3, 'Slightly important'),
(3, 'Not important at all'),
(4, 'Using public transportation'),
(4, 'Reducing plastic usage'),
(4, 'Conserving water'),
(4, 'Recycling waste materials');

-- Possible answers for Tech for Society project
INSERT INTO public.possible_answers (question_id, answer) VALUES
(5, 'Artificial Intelligence'),
(5, 'Internet of Things (IoT)'),
(5, 'Blockchain'),
(5, 'Augmented Reality/Virtual Reality (AR/VR)'),
(6, 'Healthcare'),
(6, 'Education'),
(6, 'Finance'),
(6, 'Transportation'),
(7, 'Very comfortable'),
(7, 'Comfortable'),
(7, 'Neutral'),
(7, 'Uncomfortable'),
(7, 'Very uncomfortable'),
(8, 'Yes'),
(8, 'No');

-- Possible answers for Cultural Exchange Program project
INSERT INTO public.possible_answers (question_id, answer) VALUES
(9, 'Language preservation'),
(9, 'Traditional festivals and celebrations'),
(9, 'Cuisine'),
(9, 'Music and dance'),
(10, 'Painting'),
(10, 'Sculpture'),
(10, 'Literature'),
(10, 'Music'),
(11, 'Regularly'),
(11, 'Occasionally'),
(11, 'Rarely'),
(11, 'Never'),
(12, 'Yes'),
(12, 'No');

-- Possible answers for Learning Together project
INSERT INTO public.possible_answers (question_id, answer) VALUES
(13, 'Access to quality education for all'),
(13, 'Inadequate funding for schools'),
(13, 'Lack of access to technology'),
(13, 'Educational inequality'),
(14, 'Traditional classroom teaching'),
(14, 'Hands-on learning experiences'),
(14, 'Online learning platforms'),
(14, 'Group discussions and collaboration'),
(15, 'Very satisfied'),
(15, 'Satisfied'),
(15, 'Neutral'),
(15, 'Dissatisfied'),
(15, 'Very dissatisfied'),
(16, 'Yes'),
(16, 'No');

-- Possible answers for Healthcare Access Initiative project
INSERT INTO public.possible_answers (question_id, answer) VALUES
(17, 'Better access to primary care services'),
(17, 'Reducing waiting times for appointments'),
(17, 'Improving access to specialist care'),
(17, 'Enhancing telemedicine services'),
(18, 'Affordability of healthcare services'),
(18, 'Geographical accessibility to healthcare facilities'),
(18, 'Quality of healthcare services'),
(18, 'Cultural and language barriers'),
(19, 'Very satisfied'),
(19, 'Satisfied'),
(19, 'Neutral'),
(19, 'Dissatisfied'),
(19, 'Very dissatisfied'),
(20, 'Yes'),
(20, 'No');

INSERT INTO public.answer (subtheme_id, timestamp, answers, questions) VALUES
(1, '2024-05-09 10:00:00', 'I believe renewable energy sources are essential for a sustainable future.', 'What is your opinion on renewable energy sources?'),
(2, '2024-05-10 11:00:00', 'Artificial Intelligence', 'What technology do you believe can have the biggest impact on society?'),
(3, '2024-05-11 15:00:00', 'Language preservation', 'What cultural aspect do you believe is most important to preserve?'),
(4, '2024-05-12 14:00:00', 'Access to quality education for all', 'What do you think is the biggest challenge in education today?'),
(5, '2024-05-13 12:00:00', 'Better access to primary care services', 'What improvements would you like to see in healthcare services?');

