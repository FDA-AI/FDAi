create table wp_termmeta
(
    meta_id    bigserial
        primary key,
    term_id    bigint       default '0'::bigint       not null,
    meta_key   varchar(255),
    meta_value text,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

alter table wp_termmeta
    owner to postgres;

create index term_id
    on wp_termmeta (term_id);

create index wp_termmeta_meta_key
    on wp_termmeta (meta_key);

