create table roles
(
    id          serial
        primary key,
    name        varchar(255)      not null,
    slug        varchar(255)      not null
        constraint roles_slug_unique
            unique,
    description varchar(255),
    level       integer default 1 not null,
    created_at  timestamp(0),
    updated_at  timestamp(0),
    deleted_at  timestamp(0)
);

alter table roles
    owner to postgres;

