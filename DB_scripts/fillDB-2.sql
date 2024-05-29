INSERT INTO public.project (active, avg_time_spent, total_participants, background_color_hex, font_name, logo_path, name)
SELECT
    (series_id % 2) = 0, -- active
    ROUND(RANDOM() * 40 + 20), -- avg_time_spent (random value between 20 and 60)
    FLOOR(RANDOM() * 100) + 1, -- total_participants (random value between 1 and 100)
    CASE (series_id % 5)
        WHEN 0 THEN '#5BC0EB'
        WHEN 1 THEN '#FF6B6B'
        WHEN 2 THEN '#F0C987'
        WHEN 3 THEN '#B08BEB'
        ELSE '#7ED321' -- A default color if more examples are added
        END, -- background_color_hex
    CASE (series_id % 5)
        WHEN 0 THEN 'Helvetica'
        WHEN 1 THEN 'Times New Roman'
        WHEN 2 THEN 'Verdana'
        WHEN 3 THEN 'Calibri'
        ELSE 'Arial' -- A default font name if more examples are added
        END, -- font_name
    CASE (series_id % 5)
        WHEN 0 THEN '/logos/sustainable.png'
        WHEN 1 THEN '/logos/innovation.png'
        WHEN 2 THEN '/logos/art.png'
        WHEN 3 THEN '/logos/education.png'
        ELSE '/logos/healthcare.png' -- A default logo path if more examples are added
        END, -- logo_path
    'Project ' || series_id || ' ' ||
    (SELECT array_to_string(array_agg(words ORDER BY random()), ' ')
     FROM (VALUES ('Green'), ('Technology'), ('Innovation'), ('Community'), ('Education'), ('Healthcare'), ('Art'), ('Culture')) AS t(words)
     LIMIT 3) -- random project name
FROM generate_series(1, 1000) AS series_id;



-- Sample themes
INSERT INTO public.theme (project_id, information, name)
SELECT
    (series_id % 1000) + 1, -- project_id
    CASE (series_id % 5)
        WHEN 0 THEN 'Community-driven projects aimed at sustainable development.'
        WHEN 1 THEN 'Bringing innovation to various sectors for societal progress.'
        WHEN 2 THEN 'Promoting cultural exchange and diversity through art.'
        WHEN 3 THEN 'Enhancing educational opportunities for all ages.'
        ELSE 'Improving healthcare accessibility and services.'
        END, -- information
    CASE (series_id % 5)
        WHEN 0 THEN 'Sustainable Development ' || series_id
        WHEN 1 THEN 'Innovation ' || series_id
        WHEN 2 THEN 'Art & Culture ' || series_id
        WHEN 3 THEN 'Education ' || series_id
        ELSE 'Healthcare ' || series_id
        END -- name
FROM generate_series(1, 1000) AS series_id;

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
FROM generate_series(1, 1000) AS series_id;

--installation

INSERT INTO public.installation (is_running, location_id, name)
SELECT
    series_id % 2 = 0, -- is_running
    series_id, -- location_id
    CASE (series_id % 5)
        WHEN 0 THEN 'Brussels Workshop Center'
        WHEN 1 THEN 'Antwerp Innovation Hub'
        WHEN 2 THEN 'Ghent Cultural Center'
        WHEN 3 THEN 'Liege Education Hub'
        ELSE 'Bruges Healthcare Center'
        END || ' ' || series_id -- Appending series_id to ensure uniqueness
FROM generate_series(1, 1000) AS series_id;

INSERT INTO public.flow (installation_id, is_circular, project_id, end_time, start_time, name)
SELECT
    series_id, -- installation_id
    series_id % 2 = 0, -- is_circular
    series_id, -- project_id
    CASE
        WHEN CURRENT_TIMESTAMP + INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30)) > CURRENT_TIMESTAMP THEN CURRENT_TIMESTAMP + INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30))
        ELSE CURRENT_TIMESTAMP + INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30)) END, -- end_time (plus or minus 1-30 minutes from current_timestamp)
    CURRENT_TIMESTAMP - INTERVAL '1 year' - RANDOM() * INTERVAL '365 days' - RANDOM() * INTERVAL '12 hours' + RANDOM() * INTERVAL '12 hours', -- Start time within the past year, randomly distributed throughout the day
    CASE (series_id % 5)
        WHEN 0 THEN 'Renewable Energy Workshop ' || series_id
        WHEN 1 THEN 'Innovation Summit ' || series_id
        WHEN 2 THEN 'Cultural Exchange Exhibition ' || series_id
        WHEN 3 THEN 'Educational Access Seminar ' || series_id
        ELSE 'Healthcare Access Conference ' || series_id
    END -- name
FROM generate_series(1, 1000) AS series_id;


--subtheme
INSERT INTO public.sub_theme (current_index, flow_id, is_visible, information, name)
SELECT
    series_id % 10, -- current_index
    series_id, -- flow_id
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



-- Insert questions with random number of possible answers for each subtheme
INSERT INTO public.question (is_visible, sub_theme_id, text, type)
SELECT
    true AS is_visible,
    sub_theme_id,
    'Question ' || sub_theme_id || ' for Subtheme ' || series_id AS text,
    CASE (series_id % 4)
        WHEN 0 THEN 'SINGLE_CHOICE'
        WHEN 1 THEN 'MULTIPLE_CHOICE'
        WHEN 2 THEN 'RANGE'
        ELSE 'OPEN'
        END AS type
FROM (
    SELECT
        generate_series(1, 1000) AS series_id,
        (generate_series % 1000) + 1 AS sub_theme_id,
        (random() * 5)::int + 1 AS num_questions -- Random number of questions per subtheme
    FROM generate_series(1, 1000)
) AS random_data
CROSS JOIN LATERAL generate_series(1, num_questions);

-- Insert multiple possible answers for each question with random number of answers
INSERT INTO public.possible_answers (question_id, answer)
SELECT
    series_id AS question_id,
    'Answer ' || series_id AS answer
FROM generate_series(1, 10000) AS series_id;

-- Insert multiple answered questions for each subtheme
-- Inserting into public.answer with reasonable timestamp ranges
INSERT INTO public.answer (subtheme_id, timestamp, answers, questions)
SELECT
    sub_theme_id AS subtheme_id,
    CURRENT_TIMESTAMP - INTERVAL '1' YEAR - (RANDOM() * INTERVAL '365 days'), -- Random timestamp within the past year
    (SELECT array_to_string(array_agg(answer ORDER BY random()), ', ')
     FROM (SELECT answer
           FROM public.possible_answers
           WHERE question_id = question_id
           ORDER BY RANDOM()
           LIMIT (RANDOM() * 5)::int + 1) AS t) AS answers,
    text AS questions
FROM public.question
