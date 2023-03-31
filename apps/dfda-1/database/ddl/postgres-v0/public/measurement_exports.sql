create table measurement_exports
(
    id            serial
        primary key,
    user_id       bigint                                         not null
        constraint measurement_exports_user_id_fk
            references wp_users,
    client_id     varchar(255)
        constraint measurement_exports_client_id_fk
            references oa_clients,
    status        varchar(32)                                    not null,
    type          varchar(255) default 'user'::character varying not null
        constraint measurement_exports_type_check
            check ((type)::text = ANY ((ARRAY ['user'::character varying, 'app'::character varying])::text[])),
    output_type   varchar(255) default 'csv'::character varying  not null
        constraint measurement_exports_output_type_check
            check ((output_type)::text = ANY
                   ((ARRAY ['csv'::character varying, 'xls'::character varying, 'pdf'::character varying])::text[])),
    error_message varchar(255),
    created_at    timestamp(0) default CURRENT_TIMESTAMP         not null,
    updated_at    timestamp(0) default CURRENT_TIMESTAMP         not null,
    deleted_at    timestamp(0)
);

comment on column measurement_exports.status is 'Status of Measurement Export';

comment on column measurement_exports.type is 'Whether user''s measurement export request or app users';

comment on column measurement_exports.output_type is 'Output type of export file';

comment on column measurement_exports.error_message is 'Error message';

alter table measurement_exports
    owner to postgres;

create index measurement_exports_user_id_fk
    on measurement_exports (user_id);

create index measurement_exports_client_id_fk
    on measurement_exports (client_id);

