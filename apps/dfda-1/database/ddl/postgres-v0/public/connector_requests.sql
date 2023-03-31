create table connector_requests
(
    id                    serial
        primary key,
    connector_id          integer                                not null
        constraint connector_requests_connectors_id_fk
            references connectors,
    user_id               bigint                                 not null
        constraint "connector_requests_wp_users_ID_fk"
            references wp_users,
    connection_id         integer
        constraint connector_requests_connections_id_fk
            references connections,
    connector_import_id   integer                                not null
        constraint connector_requests_connector_imports_id_fk
            references connector_imports,
    method                varchar(10)                            not null,
    code                  integer                                not null,
    uri                   varchar(2083)                          not null,
    response_body         text,
    request_body          text,
    request_headers       text                                   not null,
    created_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at            timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at            timestamp(0),
    content_type          varchar(100),
    imported_data_from_at timestamp(0)
);

comment on column connector_requests.imported_data_from_at is 'Earliest data that we''ve requested from this data source ';

alter table connector_requests
    owner to postgres;

create index connector_requests_connectors_id_fk
    on connector_requests (connector_id);

create index "connector_requests_wp_users_ID_fk"
    on connector_requests (user_id);

create index connector_requests_connections_id_fk
    on connector_requests (connection_id);

create index connector_requests_connector_imports_id_fk
    on connector_requests (connector_import_id);

