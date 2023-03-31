create table sources
(
    id         smallserial
        primary key,
    client_id  varchar(80),
    name       varchar(80)                            not null
        constraint "sources_name_UNIQUE"
            unique,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0)
);

comment on column sources.name is 'Name of the application or device';

alter table sources
    owner to postgres;

create index sources_client_id_fk
    on sources (client_id);

