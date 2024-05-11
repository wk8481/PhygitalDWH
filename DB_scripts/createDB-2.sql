create table if not exists public.project
(
    active               boolean not null,
    avg_time_spent       real    not null,
    id                   serial
        primary key,
    total_participants   integer not null,
    background_color_hex varchar(255),
    font_name            varchar(255),
    logo_path            varchar(255),
    name                 varchar(255)
);

create table if not exists public.flow
(
    id              serial primary key,
    installation_id integer,
    is_circular     boolean not null,
    project_id      integer not null
        constraint fkb4rl1klmcfreuj9g4x0rsfub6
            references public.project,
    end_time        timestamp(6) check (end_time <= CURRENT_TIMESTAMP),
    start_time      timestamp(6) check (start_time <= CURRENT_TIMESTAMP),
    name            varchar(255)
);


create table if not exists public.location
(
    id              serial
        primary key,
    street_number   integer not null,
    city            varchar(255),
    province        varchar(255),
    street          varchar(255)
);

create table if not exists public.sub_theme
(
    current_index integer not null,
    flow_id       integer
        constraint fkb1k1tlnmnsvup7prd40o7e8mk
            references public.flow,
    id            serial
        primary key,
    is_visible    boolean not null,
    information   varchar(255),
    name          varchar(255)
);

create table if not exists public.flow_sub_themes
(
    flow_id       integer not null
        constraint fk4h7s9hmf0259tngoq6btlrojm
            references public.flow,
    sub_themes_id integer not null
        unique
        constraint fkr1d3stnyciwaltcxeqn1b5tx3
            references public.sub_theme
);

create table if not exists public.question
(
    id           serial
        primary key,
    is_visible   boolean not null,
    sub_theme_id integer not null
        constraint fknvrelb2wo6rfwtakcm5vraehs
            references public.sub_theme,
    text         varchar(255),
    type         varchar(255)
        constraint question_type_check
            check ((type)::text = ANY
                   ((ARRAY ['SINGLE_CHOICE'::character varying, 'MULTIPLE_CHOICE'::character varying, 'RANGE'::character varying, 'OPEN'::character varying])::text[]))
);

create table if not exists public.possible_answers
(
    id          serial
        primary key,
    question_id integer
        constraint fko1t5ptypg4xxa0mhnse574lqi
            references public.question,
    answer      varchar(255)
);


create table if not exists public.theme
(
    id          serial
        primary key,
    project_id  integer
        unique
        constraint fk9imfv6ixeqibe0k7ly3otkeq5
            references public.project,
    information varchar(255),
    name        varchar(255)
);

create table if not exists public.installation
(
    id          serial
        primary key,
    is_running  boolean not null,
    location_id integer
        unique
        constraint fk1loxrtrl00y79043bnq1e1nbq
            references public.location,
    name        varchar(255)
);


alter table public.flow
    add constraint fkt8ehiuo4wn2nhwip4go8jj8r5
        foreign key (installation_id) references public.installation;


create table if not exists public.answer
(
    id          serial primary key,
    subtheme_id integer unique
        constraint fkrje4k4gtv2maq1h99ts7uce23
            references public.sub_theme,
    timestamp   timestamp(6) check (timestamp <= CURRENT_TIMESTAMP),
    answers     varchar(255),
    questions   varchar(255)
);


