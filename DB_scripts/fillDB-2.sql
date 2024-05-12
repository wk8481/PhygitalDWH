-- Insert projects
-- Sample projects
INSERT INTO public.project (active, avg_time_spent, total_participants, background_color_hex, font_name, logo_path, name)
VALUES
    (true, 30, 50, '#5BC0EB', 'Helvetica', '/logos/sustainable.png', 'Sustainable Development'),
    (true, 25, 45, '#FF6B6B', 'Times New Roman', '/logos/innovation.png', 'Innovation'),
    (true, 35, 60, '#F0C987', 'Verdana', '/logos/art.png', 'Art & Culture'),
    (true, 40, 55, '#B08BEB', 'Calibri', '/logos/education.png', 'Education'),
    (true, 50, 70, '#7ED321', 'Arial', '/logos/healthcare.png', 'Healthcare'),
    (true, 32, 48, '#5BC0EB', 'Helvetica', '/logos/sustainable.png', 'Sustainable Development'),
    (true, 27, 52, '#FF6B6B', 'Times New Roman', '/logos/innovation.png', 'Innovation'),
    (true, 37, 63, '#F0C987', 'Verdana', '/logos/art.png', 'Art & Culture'),
    (true, 42, 58, '#B08BEB', 'Calibri', '/logos/education.png', 'Education'),
    (true, 52, 73, '#7ED321', 'Arial', '/logos/healthcare.png', 'Healthcare'),
    (true, 31, 49, '#5BC0EB', 'Helvetica', '/logos/sustainable.png', 'Sustainable Development'),
    (true, 26, 53, '#FF6B6B', 'Times New Roman', '/logos/innovation.png', 'Innovation'),
    (true, 36, 62, '#F0C987', 'Verdana', '/logos/art.png', 'Art & Culture'),
    (true, 41, 56, '#B08BEB', 'Calibri', '/logos/education.png', 'Education'),
    (true, 51, 71, '#7ED321', 'Arial', '/logos/healthcare.png', 'Healthcare'),
    (true, 33, 47, '#5BC0EB', 'Helvetica', '/logos/sustainable.png', 'Sustainable Development'),
    (true, 28, 51, '#FF6B6B', 'Times New Roman', '/logos/innovation.png', 'Innovation'),
    (true, 38, 64, '#F0C987', 'Verdana', '/logos/art.png', 'Art & Culture'),
    (true, 43, 57, '#B08BEB', 'Calibri', '/logos/education.png', 'Education'),
    (true, 53, 74, '#7ED321', 'Arial', '/logos/healthcare.png', 'Healthcare');

-- Sample themes
-- Sample themes
INSERT INTO public.theme (project_id, information, name)
VALUES
    (1, 'Community-driven projects aimed at sustainable development.', 'Sustainable Development 1'),
    (2, 'Bringing innovation to various sectors for societal progress.', 'Innovation 2'),
    (3, 'Promoting cultural exchange and diversity through art.', 'Art & Culture 3'),
    (4, 'Enhancing educational opportunities for all ages.', 'Education 4'),
    (5, 'Improving healthcare accessibility and services.', 'Healthcare 5'),
    (6, 'Community-driven projects aimed at sustainable development.', 'Sustainable Development 6'),
    (7, 'Bringing innovation to various sectors for societal progress.', 'Innovation 7'),
    (8, 'Promoting cultural exchange and diversity through art.', 'Art & Culture 8'),
    (9, 'Enhancing educational opportunities for all ages.', 'Education 9'),
    (10, 'Improving healthcare accessibility and services.', 'Healthcare 10'),
    (11, 'Community-driven projects aimed at sustainable development.', 'Sustainable Development 11'),
    (12, 'Bringing innovation to various sectors for societal progress.', 'Innovation 12'),
    (13, 'Promoting cultural exchange and diversity through art.', 'Art & Culture 13'),
    (14, 'Enhancing educational opportunities for all ages.', 'Education 14'),
    (15, 'Improving healthcare accessibility and services.', 'Healthcare 15'),
    (16, 'Community-driven projects aimed at sustainable development.', 'Sustainable Development 16'),
    (17, 'Bringing innovation to various sectors for societal progress.', 'Innovation 17'),
    (18, 'Promoting cultural exchange and diversity through art.', 'Art & Culture 18'),
    (19, 'Enhancing educational opportunities for all ages.', 'Education 19'),
    (20, 'Improving healthcare accessibility and services.', 'Healthcare 20');

-- sample data for location
INSERT INTO public.location (street_number, city, province, street)
SELECT
    FLOOR(RANDOM() * 100) + 1, -- random street_number between 1 and 100
    CASE FLOOR(RANDOM() * 5)
        WHEN 0 THEN 'Brussels'
        WHEN 1 THEN 'Antwerp'
        WHEN 2 THEN 'Ghent'
        WHEN 3 THEN 'Liege'
        ELSE 'Bruges'
        END, -- random city
    CASE FLOOR(RANDOM() * 3)
        WHEN 0 THEN 'Brussels-Capital Region'
        WHEN 1 THEN 'Flanders'
        ELSE 'Wallonia'
        END, -- random province
    CASE FLOOR(RANDOM() * 10)
        WHEN 0 THEN 'Rue de la Loi'
        WHEN 1 THEN 'Grote Markt'
        WHEN 2 THEN 'Veldstraat'
        WHEN 3 THEN 'Place Saint-Lambert'
        WHEN 4 THEN 'Markt'
        WHEN 5 THEN 'Grand Place'
        WHEN 6 THEN 'Meir'
        WHEN 7 THEN 'Rue Neuve'
        WHEN 8 THEN 'Avenue Louise'
        ELSE 'Chaussee de Wavre'
        END || ' ' || (series_id % 1000) + 1 -- random street name with series_id appended
FROM generate_series(1, 50) AS series_id;

--installation

--installation
INSERT INTO public.installation (is_running, location_id, name)
SELECT
    series_id % 2 = 0, -- is_running
    (series_id % 50) + 1 as location_id, -- location_id
    CASE (series_id % 5)
        WHEN 0 THEN 'Brussels Workshop Center'
        WHEN 1 THEN 'Antwerp Innovation Hub'
        WHEN 2 THEN 'Ghent Cultural Center'
        WHEN 3 THEN 'Liege Education Hub'
        ELSE 'Bruges Healthcare Center'
        END || ' ' || series_id -- Appending series_id to ensure uniqueness
FROM generate_series(1, 400) AS series_id;



--installation
INSERT INTO public.installation (is_running, location_id, name)
SELECT
    series_id % 2 = 0, -- is_running
    (series_id % 50) + 1 as location_id, -- location_id
    CASE (series_id % 5)
        WHEN 0 THEN 'Brussels Workshop Center'
        WHEN 1 THEN 'Antwerp Innovation Hub'
        WHEN 2 THEN 'Ghent Cultural Center'
        WHEN 3 THEN 'Liege Education Hub'
        ELSE 'Bruges Healthcare Center'
        END || ' ' || series_id -- Appending series_id to ensure uniqueness
FROM generate_series(1, 400) AS series_id;

INSERT INTO public.flow (installation_id, is_circular, project_id, end_time, start_time, name)
SELECT
    installation.id, -- installation_id
    series_id % 2 = 0, -- is_circular
    series_id, -- project_id
    CASE
        WHEN CURRENT_TIMESTAMP + INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30)) > CURRENT_TIMESTAMP THEN CURRENT_TIMESTAMP + INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30))
        ELSE CURRENT_TIMESTAMP - INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30))
    END, -- end_time (plus or minus 1-30 minutes from current_timestamp)
    CURRENT_TIMESTAMP - INTERVAL '1 year' - RANDOM() * INTERVAL '365 days' - RANDOM() * INTERVAL '12 hours' + RANDOM() * INTERVAL '12 hours', -- Start time within the past year, randomly distributed throughout the day
    CASE (series_id % 5)
        WHEN 0 THEN 'Renewable Energy Workshop ' || series_id
        WHEN 1 THEN 'Innovation Summit ' || series_id
        WHEN 2 THEN 'Cultural Exchange Exhibition ' || series_id
        WHEN 3 THEN 'Educational Access Seminar ' || series_id
        ELSE 'Healthcare Access Conference ' || series_id
    END -- name
FROM generate_series(1, 1000) AS series_id
JOIN public.installation ON series_id = public.installation.id; -- Join with installation table to ensure valid installation_id

--subtheme
INSERT INTO public.sub_theme (current_index, flow_id, is_visible, information, name)
SELECT
    series_id % 10, -- current_index
    FLOOR((series_id - 1) / 20) + 1, -- flow_id (assuming each flow contains 20 subthemes)
    series_id % 2 = 0, -- is_visible
    CASE (series_id % 5)
        WHEN 0 THEN 'Promotion of renewable energy sources'
        WHEN 1 THEN 'Development of innovative solutions for societal challenges'
        WHEN 2 THEN 'Exploration of different cultures through art'
        WHEN 3 THEN 'Improvement of educational accessibility and quality'
        ELSE 'Enhancement of healthcare services and accessibility'
        END || ' ' || series_id, -- information
    CASE (series_id % 5)
        WHEN 0 THEN 'Renewable Energy ' || series_id
        WHEN 1 THEN 'Innovative Solutions ' || series_id
        WHEN 2 THEN 'Cultural Exchange ' || series_id
        WHEN 3 THEN 'Educational Access ' || series_id
        ELSE 'Healthcare Access ' || series_id
        END -- name
FROM generate_series(1, 1000) AS series_id;

--flow_sub_themes
-- Inserting into public.flow with reasonable timestamp ranges
INSERT INTO public.flow_sub_themes (flow_id, sub_themes_id)
SELECT 
    series_id, -- flow_id
    series_id -- sub_themes_id
FROM generate_series(1, 1000) AS series_id;



--increase amount of questions and answers:
-- Insert multiple questions for each theme
INSERT INTO public.question (is_visible, sub_theme_id, text, type)
SELECT
    true AS is_visible,
    series_id AS sub_theme_id,
    CASE
        WHEN (series_id % 5) = 0 THEN 'Question 1 for Subtheme ' || series_id
        WHEN (series_id % 5) = 1 THEN 'Question 2 for Subtheme ' || series_id
        WHEN (series_id % 5) = 2 THEN 'Question 3 for Subtheme ' || series_id
        WHEN (series_id % 5) = 3 THEN 'Question 4 for Subtheme ' || series_id
        ELSE 'Question 5 for Subtheme ' || series_id
        END AS text,
    CASE (series_id % 4)
        WHEN 0 THEN 'SINGLE_CHOICE'
        WHEN 1 THEN 'MULTIPLE_CHOICE'
        WHEN 2 THEN 'RANGE'
        ELSE 'OPEN'
        END AS type
FROM generate_series(1, 1000) AS series_id;

-- Insert multiple possible answers for each question
INSERT INTO public.possible_answers (question_id, answer)
SELECT
    series_id AS question_id,
    CASE
        WHEN (series_id % 20) = 0 THEN 'Answer 1 for Question ' || series_id
        WHEN (series_id % 20) = 1 THEN 'Answer 2 for Question ' || series_id
        WHEN (series_id % 20) = 2 THEN 'Answer 3 for Question ' || series_id
        WHEN (series_id % 20) = 3 THEN 'Answer 4 for Question ' || series_id
        ELSE 'Answer 5 for Question ' || series_id
        END AS answer
FROM generate_series(1, 1000) AS series_id;

-- Insert multiple answered questions for each subtheme
-- Inserting into public.answer with reasonable timestamp ranges
INSERT INTO public.answer (subtheme_id, timestamp, answers, questions)
SELECT
    series_id AS subtheme_id, -- Subtheme_id ranges from 1 to 1000
    CURRENT_TIMESTAMP - INTERVAL '1' YEAR - (RANDOM() * INTERVAL '365 days'), -- Random timestamp within the past year
    (SELECT array_to_string(array_agg(answer ORDER BY random()), ', ')
     FROM (SELECT answer
           FROM public.possible_answers
           WHERE question_id IN (SELECT id FROM public.question WHERE sub_theme_id = series_id % 1000 + 1)
           ORDER BY RANDOM()
           LIMIT 3) AS t) AS answers,
    (SELECT array_to_string(array_agg(text ORDER BY random()), ', ')
     FROM public.question
     WHERE sub_theme_id = series_id % 1000 + 1
     LIMIT 1) AS questions
FROM generate_series(1, 1000) AS series_id;

