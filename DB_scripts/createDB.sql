-- Operation DB for DWH
-- Mock data for testing

CREATE TABLE IF NOT EXISTS locations (
                                         id SERIAL PRIMARY KEY,
                                         latitude INT NOT NULL,
                                         longitude INT NOT NULL,
                                         city VARCHAR(255),
                                         province VARCHAR(255),
                                         street VARCHAR(255),
                                         number INT
);

CREATE TABLE IF NOT EXISTS users (
                                     id SERIAL PRIMARY KEY,
                                     email VARCHAR(255) NOT NULL,
                                     password VARCHAR(255) NOT NULL,
                                     role VARCHAR(255) NOT NULL
                                         constraint users_role_check
                                             check ((role)::text = ANY
                                                    ((ARRAY ['ADMIN'::character varying, 'MANAGER'::character varying, 'SUPERVISOR'::character varying])::text[]))
);

-- Create the project table
CREATE TABLE IF NOT EXISTS project (
                                       id SERIAL PRIMARY KEY,
                                       name VARCHAR(255) NOT NULL,
                                       active BOOLEAN NOT NULL,
                                       avg_time_spent REAL NOT NULL,
                                       total_participants INT NOT NULL
);

-- Create the installations table
CREATE TABLE IF NOT EXISTS installations (
    id SERIAL PRIMARY KEY,
    is_running BOOLEAN NOT NULL,
    location_id INT NOT NULL,
    user_id INT NOT NULL,
    project_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (project_id) REFERENCES project(id)
);

-- Create the theme table
CREATE TABLE IF NOT EXISTS theme (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    information VARCHAR(255) NOT NULL,
    project_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES project(id)
);

-- Create the flow table with new columns
CREATE TABLE IF NOT EXISTS flow (
                                    id SERIAL PRIMARY KEY,
                                    is_circular BOOLEAN NOT NULL,
                                    project_id INT NOT NULL,
                                    name VARCHAR(255) NOT NULL,
                                    start_date TIMESTAMP,
                                    end_date TIMESTAMP,
                                    completed BOOLEAN,
                                    FOREIGN KEY (project_id) REFERENCES project(id)
);

-- Create the administrator table
CREATE TABLE IF NOT EXISTS administrator (
                                             id SERIAL PRIMARY KEY,
                                             name VARCHAR(255) NOT NULL
);
-- Create the sharing_platform table
CREATE TABLE IF NOT EXISTS sharing_platform (
                                                id SERIAL PRIMARY KEY,
                                                name VARCHAR(255) NOT NULL,
                                                contact_email VARCHAR(255) NOT NULL,
                                                total_participants INT NOT NULL,
                                                administrator_id INT NOT NULL,
                                                FOREIGN KEY (administrator_id) REFERENCES administrator(id)
);

-- Create the sub_theme table
CREATE TABLE IF NOT EXISTS sub_theme (
                                         id SERIAL PRIMARY KEY,
                                         name VARCHAR(255) NOT NULL,
                                         information TEXT NOT NULL,
                                         is_visible BOOLEAN NOT NULL,
                                         flow_id INT NOT NULL,
                                         current_index INT NOT NULL,
                                         FOREIGN KEY (flow_id) REFERENCES flow(id)
);

-- Create the question table
CREATE TABLE IF NOT EXISTS question (
                                        id SERIAL PRIMARY KEY,
                                        text TEXT NOT NULL,
                                        type VARCHAR(50) NOT NULL,
                                        is_visible BOOLEAN NOT NULL,
                                        sub_theme_id INT NOT NULL,
                                        FOREIGN KEY (sub_theme_id) REFERENCES sub_theme(id)
);
