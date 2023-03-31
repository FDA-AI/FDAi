create table measurement_imports
(
    id                     serial
        primary key,
    user_id                bigint                                            not null
        constraint measurement_imports_user_id_fk
            references wp_users,
    file                   varchar(255)                                      not null,
    created_at             timestamp(0) default CURRENT_TIMESTAMP            not null,
    updated_at             timestamp(0) default CURRENT_TIMESTAMP            not null,
    status                 varchar(25)  default 'WAITING'::character varying not null,
    error_message          text,
    source_name            varchar(80),
    deleted_at             timestamp(0),
    client_id              varchar(255)
        constraint measurement_imports_client_id_fk
            references oa_clients,
    import_started_at      timestamp(0),
    import_ended_at        timestamp(0),
    reason_for_import      varchar(255),
    user_error_message     varchar(255),
    internal_error_message varchar(255)
);

comment on column measurement_imports.source_name is 'Name of the application or device';

alter table measurement_imports
    owner to postgres;

create index measurement_imports_user_id_fk
    on measurement_imports (user_id);

create index measurement_imports_client_id_fk
    on measurement_imports (client_id);

