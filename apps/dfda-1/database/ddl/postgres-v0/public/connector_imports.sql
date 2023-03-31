create table connector_imports
(
    id                           serial
        primary key,
    client_id                    varchar(80)
        constraint connector_imports_client_id_fk
            references oa_clients,
    connection_id                integer
        constraint connector_imports_connections_id_fk
            references connections,
    connector_id                 integer                                not null
        constraint connector_imports_connectors_id_fk
            references connectors,
    created_at                   timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                   timestamp(0),
    earliest_measurement_at      timestamp(0),
    import_ended_at              timestamp(0),
    import_started_at            timestamp(0),
    internal_error_message       text,
    latest_measurement_at        timestamp(0),
    number_of_measurements       integer      default 0                 not null,
    reason_for_import            varchar(255),
    success                      boolean      default true,
    updated_at                   timestamp(0) default CURRENT_TIMESTAMP not null,
    user_error_message           text,
    user_id                      bigint                                 not null
        constraint "connector_imports_wp_users_ID_fk"
            references wp_users,
    additional_meta_data         json,
    number_of_connector_requests integer,
    imported_data_from_at        timestamp(0),
    imported_data_end_at         timestamp(0),
    credentials                  text,
    connector_requests           timestamp(0),
    constraint connector_imports_connection_id_created_at_uindex
        unique (connection_id, created_at),
    constraint connector_imports_connector_id_user_id_created_at_uindex
        unique (connector_id, user_id, created_at)
);

comment on column connector_imports.number_of_connector_requests is 'Number of Connector Requests for this Connector Import.
                [Formula:
                    update connector_imports
                        left join (
                            select count(id) as total, connector_import_id
                            from connector_requests
                            group by connector_import_id
                        )
                        as grouped on connector_imports.id = grouped.connector_import_id
                    set connector_imports.number_of_connector_requests = count(grouped.total)
                ]
                ';

comment on column connector_imports.imported_data_from_at is 'Earliest data that we''ve requested from this data source ';

comment on column connector_imports.imported_data_end_at is 'Most recent data that we''ve requested from this data source ';

comment on column connector_imports.credentials is 'Encrypted user credentials for accessing third party data';

comment on column connector_imports.connector_requests is 'Most recent data that we''ve requested from this data source ';

alter table connector_imports
    owner to postgres;

create index "IDX_connector_imports_user_connector"
    on connector_imports (user_id, connector_id);

create index connector_imports_client_id_fk
    on connector_imports (client_id);

