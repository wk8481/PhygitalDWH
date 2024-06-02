-- Sample projects
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
    series_id, -- project_id
    CASE ((series_id - 1) % 5)
        WHEN 0 THEN 'Community-driven projects aimed at sustainable development.'
        WHEN 1 THEN 'Bringing innovation to various sectors for societal progress.'
        WHEN 2 THEN 'Promoting cultural exchange and diversity through art.'
        WHEN 3 THEN 'Enhancing educational opportunities for all ages.'
        ELSE 'Improving healthcare accessibility and services.'
        END, -- information
    CASE ((series_id - 1) % 5)
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

-- Insert flows with corrected timestamp ranges to satisfy constraints
-- Reset the sequence for the flow table to start from 1
ALTER SEQUENCE public.flow_id_seq RESTART WITH 1;

-- Now you can insert flows with corrected timestamp ranges
INSERT INTO public.flow (installation_id, is_circular, project_id, end_time, start_time, name)
SELECT
    series_id, -- installation_id
    series_id % 2 = 0, -- is_circular
    series_id, -- project_id
    CURRENT_TIMESTAMP - INTERVAL '1 minute' * (1 + FLOOR(RANDOM() * 30)), -- end_time (up to 30 minutes before the current timestamp)
    CURRENT_TIMESTAMP - INTERVAL '1 year' - RANDOM() * INTERVAL '365 days' + RANDOM() * INTERVAL '12 hours', -- start_time within the past year, before end_time
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



truncate question cascade
-- Insert questions with a maximum of 10 questions per subtheme
-- Insert questions with a random distribution across subthemes, up to a total of 1000 questions
-- Insert questions with a maximum of 10 questions per subtheme
Alter sequence question_id_seq restart with 1;

INSERT INTO public.question (is_visible, sub_theme_id, text, type)
SELECT
    true AS is_visible,
    sub_theme_id,
    'Question ' || row_number() OVER (PARTITION BY sub_theme_id) || ' for Subtheme ' || sub_theme_id AS text,
    CASE (series_id % 4)
        WHEN 0 THEN 'SINGLE_CHOICE'
        WHEN 1 THEN 'MULTIPLE_CHOICE'
        WHEN 2 THEN 'RANGE'
        ELSE 'OPEN'
        END AS type
FROM (
         SELECT
             generate_series(1, 500) AS series_id,
             (random() * 40)::int + 1 AS sub_theme_id -- Randomly distribute questions across subthemes
     ) AS random_data;


truncate possible_answers cascade
-- Insert multiple possible answers for each question with a maximum of 20 possible answers per question

alter sequence possible_answers_id_seq restart with 1;

-- Generate possible answers
-- Generate possible answers
CREATE TEMPORARY TABLE temp_possible_answers AS
SELECT
    'Answer ' || generate_series AS answer
FROM
    generate_series(1, 200);

-- Assign possible answers to questions randomly, limiting to 50 questions
INSERT INTO public.possible_answers (question_id, answer)
SELECT
    q.id AS question_id,
    pa.answer
FROM
    public.question q
        CROSS JOIN LATERAL (
        SELECT answer FROM temp_possible_answers ORDER BY random() LIMIT 5 -- Adjust the limit as needed
        ) pa
LIMIT 200; -- Limit the number of questions

-- Drop temporary table
DROP TABLE IF EXISTS temp_possible_answers;









-- Insert multiple answered questions for each subtheme with a limit
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
-- Inserting into public.answer with a maximum of 5 answered questions per subtheme
truncate answer cascade

-- Update the existing record with subtheme_id = 1
-- Update the existing record with subtheme_id = 1
-- Update the existing record with subtheme_id = 1
-- Inserting into public.answer for existing subtheme_id = 1
-- Inserting into public.answer for a different subtheme_id
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_idsINSERT INTO public.answer (subtheme_id, timestamp, answers, questions)
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a smaller dataset of subtheme_ids
-- Inserting into public.answer with a larger dataset of subtheme_ids and diverse dummy answers

alter sequence answer_id_seq restart with 1;


INSERT INTO public.answer (subtheme_id, timestamp, answers, questions)
SELECT
    series_id AS subtheme_id, -- Subtheme_id ranges from 1 to 500
    CURRENT_TIMESTAMP - INTERVAL '1' YEAR - (RANDOM() * INTERVAL '365 days'), -- Random timestamp within the past year
    (SELECT
         CASE
             WHEN q.type = 'RANGE' THEN 'Range answer for Question ' || q.id || ', Range: ' || (random() * 100)::int
             WHEN q.type = 'OPEN' THEN 'Open answer for Question ' || q.id || ', Length: ' || (random() * 50)::int
             WHEN q.type = 'MULTIPLE_CHOICE' THEN 'Option ' || num || ' for Question ' || q.id
             WHEN q.type = 'SINGLE_CHOICE' THEN 'Option ' || series_id || ' for Question ' || q.id
             ELSE 'No answer for Question ' || q.id
             END
     FROM (
              SELECT generate_series(1, 5) AS num
          ) AS dummy,
          LATERAL (
              SELECT id, type
              FROM public.question
              WHERE sub_theme_id = series_id % 500 + 1
              ORDER BY RANDOM() -- Randomly select a question for each type
              LIMIT 1
              ) AS q
     LIMIT 1) AS answers,
    (SELECT text
     FROM public.question
     WHERE sub_theme_id = series_id % 500 + 1
     ORDER BY RANDOM() -- Randomly select a question
     LIMIT 1) AS questions
FROM generate_series(1, 500) AS series_id
LIMIT 40; -- Limit the number of rows inserted to 50

