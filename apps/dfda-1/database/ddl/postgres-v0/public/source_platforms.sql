create table source_platforms
(
    id         smallserial
        primary key,
    name       varchar(32)                            not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
        constraint source_platforms_client_id_fk
            references oa_clients
);

alter table source_platforms
    owner to postgres;

create index source_platforms_client_id_fk
    on source_platforms (client_id);

