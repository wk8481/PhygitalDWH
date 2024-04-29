-- Insert mock data into the locations table
INSERT INTO locations (latitude, longitude, city, province, street, number)
SELECT
    50.8503 + (series_id * 0.01), -- latitude
    4.3517 + (series_id * 0.01), -- longitude
    CASE series_id % 3
        WHEN 0 THEN 'Brussels'
        WHEN 1 THEN 'Antwerp'
        ELSE 'Liège'
        END, -- city
    'Province ' || series_id, -- province
    'Street ' || series_id, -- street
    series_id -- number
FROM generate_series(1, 20) AS series_id;




-- Insert mock data into the users table
INSERT INTO users (email, password, role)
SELECT
    'user' || series_id || '@example.com', -- email
    'password' || series_id, -- password
    CASE series_id % 3
        WHEN 0 THEN 'ADMIN'
        WHEN 1 THEN 'MANAGER'
        ELSE 'SUPERVISOR'
        END -- role
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the installations table
INSERT INTO installations (is_running, location_id, user_id)
SELECT
    series_id % 2 = 0, -- is_running
    series_id, -- location_id
    series_id -- user_id
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the project table
INSERT INTO project (name, active, avg_time_spent, total_participants)
SELECT
    'Project ' || series_id, -- name
    series_id % 2 = 0, -- active
    RANDOM() * 10, -- avg_time_spent
    series_id -- total_participants
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the flow table
INSERT INTO flow (is_circular, project_id, name, start_date, end_date, completed)
SELECT
    series_id % 2 = 0, -- is_circular
    series_id, -- project_id
    'Flow ' || series_id, -- name
    CURRENT_TIMESTAMP - RANDOM() * INTERVAL '365 days', -- start_date
    CURRENT_TIMESTAMP + RANDOM() * INTERVAL '365 days', -- end_date
    series_id % 2 = 0 -- completed
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the administrator table
INSERT INTO administrator (name)
SELECT
    'Admin ' || series_id -- name
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the sharing_platform table
INSERT INTO sharing_platform (name, contact_email, total_participants, administrator_id)
SELECT
    'Platform ' || series_id, -- name
    'contact@example.com', -- contact_email
    series_id * 100, -- total_participants
    series_id -- administrator_id
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the sub_theme table
INSERT INTO sub_theme (name, information, is_visible, flow_id, current_index)
SELECT
    'Sub Theme ' || series_id, -- name
    'Information for Sub Theme ' || series_id, -- information
    series_id % 2 = 0, -- is_visible
    series_id, -- flow_id
    series_id % 10 -- current_index
FROM generate_series(1, 20) AS series_id;

-- Insert mock data into the question table
INSERT INTO question (text, type, is_visible, sub_theme_id)
SELECT
    'Question ' || series_id, -- text
    CASE series_id % 3
        WHEN 0 THEN 'MULTIPLE_CHOICE'
        WHEN 1 THEN 'SINGLE_CHOICE'
        ELSE 'OPEN'
        END, -- type
    series_id % 2 = 0, -- is_visible
    series_id -- sub_theme_id
FROM generate_series(1, 20) AS series_id;
