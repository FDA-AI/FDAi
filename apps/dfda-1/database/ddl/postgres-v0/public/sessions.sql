create table sessions
(
    id            varchar(255) not null
        constraint sessions_id_unique
            unique,
    user_id       bigint,
    ip_address    varchar(45),
    user_agent    text,
    payload       text         not null,
    last_activity integer      not null
);

alter table sessions
    owner to postgres;

