create table cache
(
    key        varchar(255) not null
        constraint cache_key_unique
            unique,
    value      text         not null,
    expiration integer      not null
);

alter table cache
    owner to postgres;

