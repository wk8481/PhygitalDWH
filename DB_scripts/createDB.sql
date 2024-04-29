-- Operation DB for DWH
-- Mock data for testing

CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    latitude INT NOT NULL,
    longitude INT NOT NULL,
    city VARCHAR(255),
)

CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(255) NOT NULL
        constraint users_role_check
                check ((role)::text = ANY
                   ((ARRAY ['ADMIN'::character varying, 'MANAGER'::character varying, 'SUPERVISOR'::character varying])::text[]))
    )

CREATE TABLE IF NOT EXISTS installations (
    id SERIAL PRIMARY KEY,
    is_running BOOLEAN NOT NULL,
    location_id INT NOT NULL
        constraint fk_location
            references locations(id),
    user_id INT NOT NULL
        constraint fk_user
            references users(id),
    )

CREATE TABLE IF NOT EXISTS project (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL,
    avg_time_spent real NOT NULL,
    total_participants INT NOT NULL,
)

CREATE TABLE IF NOT EXISTS flow (
    id SERIAL PRIMARY KEY,
    is_circular BOOLEAN NOT NULL,
    project_id INT NOT NULL
        constraint fk_project
            references project(id),
    name VARCHAR(255) NOT NULL,
)
