-- Sample projects
INSERT INTO public.project (active, avg_time_spent, total_participants, background_color_hex, font_name, logo_path, name)
SELECT
    (series_id % 2) = 0, -- active
    RANDOM() * 10, -- avg_time_spent
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

--flow
INSERT INTO public.flow (installation_id, is_circular, project_id, end_time, start_time, name)
SELECT
    series_id, -- installation_id
    series_id % 2 = 0, -- is_circular
    series_id, -- project_id
    CURRENT_TIMESTAMP - RANDOM() * INTERVAL '365 days' * RANDOM(), -- end_time
    CURRENT_TIMESTAMP - RANDOM() * INTERVAL '730 days' * RANDOM(), -- start_time (twice as far in the past as end_time)
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
INSERT INTO public.flow_sub_themes (flow_id, sub_themes_id)
SELECT
    series_id, -- flow_id
    series_id -- sub_themes_id
FROM generate_series(1, 1000) AS series_id;

--questions
INSERT INTO public.question (is_visible, sub_theme_id, text, type)
SELECT
    (series_id % 2 = 0) AS is_visible,
    (series_id % 1000) + 1 AS sub_theme_id,
    CASE
        WHEN (series_id % 5) = 0 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'What is your opinion on renewable energy sources?'
                WHEN series_id % 4 = 1 THEN 'Which renewable energy source do you think is most promising for our community?'
                WHEN series_id % 4 = 2 THEN 'How important do you think sustainability is for our future?'
                ELSE 'Do you actively participate in eco-friendly practices?'
                END
        WHEN (series_id % 5) = 1 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'What technology do you believe can have the biggest impact on society?'
                WHEN series_id % 4 = 1 THEN 'Which industry do you think needs technological innovation the most?'
                WHEN series_id % 4 = 2 THEN 'How comfortable are you with using new technologies?'
                ELSE 'Have you ever participated in a hackathon or similar event?'
                END
        WHEN (series_id % 5) = 2 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'What cultural aspect do you believe is most important to preserve?'
                WHEN series_id % 4 = 1 THEN 'Which form of art do you find most expressive?'
                WHEN series_id % 4 = 2 THEN 'How often do you engage with different cultures?'
                ELSE 'Have you ever participated in an international exchange program?'
                END
        WHEN (series_id % 5) = 3 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'What do you think is the biggest challenge in education today?'
                WHEN series_id % 4 = 1 THEN 'Which educational method do you find most effective?'
                WHEN series_id % 4 = 2 THEN 'How satisfied are you with the current education system?'
                ELSE 'Have you ever volunteered as a tutor or mentor?'
                END
        ELSE
            CASE
                WHEN series_id % 4 = 0 THEN 'What improvements would you like to see in healthcare services?'
                WHEN series_id % 4 = 1 THEN 'Which aspect of healthcare accessibility concerns you the most?'
                WHEN series_id % 4 = 2 THEN 'How satisfied are you with your current healthcare coverage?'
                ELSE 'Have you ever participated in a medical mission or volunteer work?'
                END
        END AS text,
    CASE series_id % 4
        WHEN 0 THEN 'SINGLE_CHOICE'
        WHEN 1 THEN 'MULTIPLE_CHOICE'
        WHEN 2 THEN 'RANGE'
        ELSE 'OPEN'
        END AS type
FROM generate_series(1, 1000) AS series_id;

--possible_answers
INSERT INTO public.possible_answers (question_id, answer)
SELECT
    series_id AS question_id,
    CASE
        WHEN (series_id % 20) = 0 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'I believe renewable energy sources are essential for a sustainable future.'
                WHEN series_id % 4 = 1 THEN 'Renewable energy sources are the key to reducing carbon emissions.'
                WHEN series_id % 4 = 2 THEN 'Solar energy'
                ELSE 'Wind energy'
                END
        WHEN (series_id % 20) = 1 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Hydropower'
                WHEN series_id % 4 = 1 THEN 'Geothermal energy'
                WHEN series_id % 4 = 2 THEN 'Extremely important'
                ELSE 'Very important'
                END
        WHEN (series_id % 20) = 2 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Moderately important'
                WHEN series_id % 4 = 1 THEN 'Slightly important'
                WHEN series_id % 4 = 2 THEN 'Not important at all'
                ELSE 'Using public transportation'
                END
        WHEN (series_id % 20) = 3 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Reducing plastic usage'
                WHEN series_id % 4 = 1 THEN 'Conserving water'
                WHEN series_id % 4 = 2 THEN 'Recycling waste materials'
                ELSE 'Artificial Intelligence'
                END
        WHEN (series_id % 20) = 4 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Internet of Things (IoT)'
                WHEN series_id % 4 = 1 THEN 'Blockchain'
                WHEN series_id % 4 = 2 THEN 'Augmented Reality/Virtual Reality (AR/VR)'
                ELSE 'Healthcare'
                END
        WHEN (series_id % 20) = 5 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Education'
                WHEN series_id % 4 = 1 THEN 'Finance'
                WHEN series_id % 4 = 2 THEN 'Transportation'
                ELSE 'Very comfortable'
                END
        WHEN (series_id % 20) = 6 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Comfortable'
                WHEN series_id % 4 = 1 THEN 'Neutral'
                WHEN series_id % 4 = 2 THEN 'Uncomfortable'
                ELSE 'Very uncomfortable'
                END
        WHEN (series_id % 20) = 7 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Yes'
                WHEN series_id % 4 = 1 THEN 'No'
                ELSE 'Language preservation'
                END
        WHEN (series_id % 20) = 8 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Traditional festivals and celebrations'
                WHEN series_id % 4 = 1 THEN 'Cuisine'
                WHEN series_id % 4 = 2 THEN 'Music and dance'
                ELSE 'Painting'
                END
        WHEN (series_id % 20) = 9 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Sculpture'
                WHEN series_id % 4 = 1 THEN 'Literature'
                WHEN series_id % 4 = 2 THEN 'Music'
                ELSE 'Regularly'
                END
        WHEN (series_id % 20) = 10 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Occasionally'
                WHEN series_id % 4 = 1 THEN 'Rarely'
                WHEN series_id % 4 = 2 THEN 'Never'
                ELSE 'Yes'
                END
        WHEN (series_id % 20) = 11 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'No'
                ELSE 'Access to quality education for all'
                END
        WHEN (series_id % 20) = 12 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Inadequate funding for schools'
                WHEN series_id % 4 = 1 THEN 'Lack of access to technology'
                WHEN series_id % 4 = 2 THEN 'Educational inequality'
                ELSE 'Traditional classroom teaching'
                END
        WHEN (series_id % 20) = 13 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Hands-on learning experiences'
                WHEN series_id % 4 = 1 THEN 'Online learning platforms'
                WHEN series_id % 4 = 2 THEN 'Group discussions and collaboration'
                ELSE 'Very satisfied'
                END
        WHEN (series_id % 20) = 14 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Satisfied'
                WHEN series_id % 4 = 1 THEN 'Neutral'
                WHEN series_id % 4 = 2 THEN 'Dissatisfied'
                ELSE 'Very dissatisfied'
                END
        WHEN (series_id % 20) = 15 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Yes'
                ELSE 'Better access to primary care services'
                END
        WHEN (series_id % 20) = 16 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Reducing waiting times for appointments'
                WHEN series_id % 4 = 1 THEN 'Improving access to specialist care'
                WHEN series_id % 4 = 2 THEN 'Enhancing telemedicine services'
                ELSE 'Affordability of healthcare services'
                END
        WHEN (series_id % 20) = 17 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Geographical accessibility to healthcare facilities'
                WHEN series_id % 4 = 1 THEN 'Quality of healthcare services'
                WHEN series_id % 4 = 2 THEN 'Cultural and language barriers'
                ELSE 'Very satisfied'
                END
        WHEN (series_id % 20) = 18 THEN
            CASE
                WHEN series_id % 4 = 0 THEN 'Satisfied'
                WHEN series_id % 4 = 1 THEN 'Neutral'
                WHEN series_id % 4 = 2 THEN 'Dissatisfied'
                ELSE 'Very dissatisfied'
                END
        ELSE
            CASE
                WHEN series_id % 4 = 0 THEN 'Yes'
                ELSE 'No'
                END
        END AS answer
FROM generate_series(1, 1000) AS series_id;

INSERT INTO public.answer (subtheme_id, timestamp, answers, questions)
SELECT
    series_id AS subtheme_id, -- Subtheme_id ranges from 1 to 1000
    CURRENT_TIMESTAMP - RANDOM() * INTERVAL '365 days' * RANDOM(), -- Random timestamp within the past year
    CASE
        WHEN (series_id % 20) = 0 THEN
            'I believe renewable energy sources are essential for a sustainable future.'
        WHEN (series_id % 20) = 1 THEN
            'Artificial Intelligence'
        WHEN (series_id % 20) = 2 THEN
            'Language preservation'
        WHEN (series_id % 20) = 3 THEN
            'Access to quality education for all'
        WHEN (series_id % 20) = 4 THEN
            'Better access to primary care services'
        ELSE
            (SELECT answer
             FROM public.possible_answers
             WHERE question_id = (series_id % 20) + 1 -- Ensure question_id ranges from 1 to 20
             ORDER BY RANDOM()
             LIMIT 1) -- Select a random answer from the possible answers for the corresponding question
        END AS answers,
    (SELECT text
     FROM public.question
     WHERE public.question.id = (series_id % 20) + 1 -- Ensure question_id ranges from 1 to 20
    ) AS questions
FROM generate_series(1, 1000) AS series_id;
