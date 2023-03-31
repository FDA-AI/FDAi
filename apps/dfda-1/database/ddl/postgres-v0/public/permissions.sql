create table permissions
(
    id          serial
        primary key,
    name        varchar(255) not null,
    slug        varchar(255) not null
        constraint permissions_slug_unique
            unique,
    description varchar(255),
    model       varchar(255),
    created_at  timestamp(0),
    updated_at  timestamp(0),
    deleted_at  timestamp(0)
);

alter table permissions
    owner to postgres;

