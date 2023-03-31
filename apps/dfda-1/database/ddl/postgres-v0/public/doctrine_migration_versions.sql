create table doctrine_migration_versions
(
    version    varchar(255)                           not null
        primary key,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

alter table doctrine_migration_versions
    owner to postgres;

