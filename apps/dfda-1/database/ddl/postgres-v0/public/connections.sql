create table connections
(
    id                                serial
        primary key,
    client_id                         varchar(80)
        constraint connections_client_id_fk
            references oa_clients,
    user_id                           bigint                                 not null
        constraint connections_user_id_fk
            references wp_users,
    connector_id                      integer                                not null
        constraint connections_connectors_id_fk
            references connectors,
    connect_status                    varchar(32)                            not null,
    connect_error                     text,
    update_requested_at               timestamp(0),
    update_status                     varchar(32)                            not null,
    update_error                      text,
    last_successful_updated_at        timestamp(0),
    created_at                        timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                        timestamp(0),
    total_measurements_in_last_update integer,
    user_message                      varchar(255),
    latest_measurement_at             timestamp(0),
    import_started_at                 timestamp(0),
    import_ended_at                   timestamp(0),
    reason_for_import                 varchar(255),
    user_error_message                text,
    internal_error_message            text,
    wp_post_id                        bigint
        constraint "connections_wp_posts_ID_fk"
            references wp_posts,
    number_of_connector_imports       integer,
    number_of_connector_requests      integer,
    credentials                       text,
    imported_data_from_at             timestamp(0),
    imported_data_end_at              timestamp(0),
    number_of_measurements            integer,
    is_public                         boolean,
    slug                              varchar(200)
        constraint connections_slug_uindex
            unique,
    meta                              text,
    constraint "UX_userId_connectorId"
        unique (user_id, connector_id)
);

comment on column connections.connector_id is 'The id for the connector data source for which the connection is connected';

comment on column connections.connect_status is 'Indicates whether a connector is currently connected to a service for a user.';

comment on column connections.connect_error is 'Error message if there is a problem with authorizing this connection.';

comment on column connections.update_status is 'Indicates whether a connector is currently updated.';

comment on column connections.update_error is 'Indicates if there was an error during the update.';

comment on column connections.number_of_connector_imports is 'Number of Connector Imports for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_imports
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_imports = count(grouped.total)
                ]
                ';

comment on column connections.number_of_connector_requests is 'Number of Connector Requests for this Connection.
                [Formula:
                    update connections
                        left join (
                            select count(id) as total, connection_id
                            from connector_requests
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_connector_requests = count(grouped.total)
                ]
                ';

comment on column connections.credentials is 'Encrypted user credentials for accessing third party data';

comment on column connections.imported_data_from_at is 'Earliest data that we''ve requested from this data source ';

comment on column connections.imported_data_end_at is 'Most recent data that we''ve requested from this data source ';

comment on column connections.number_of_measurements is 'Number of Measurements for this Connection.
                    [Formula: update connections
                        left join (
                            select count(id) as total, connection_id
                            from measurements
                            group by connection_id
                        )
                        as grouped on connections.id = grouped.connection_id
                    set connections.number_of_measurements = count(grouped.total)]';

comment on column connections.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column connections.meta is 'Additional meta data instructions for import, such as a list of repositories the Github connector should import from. ';

alter table connections
    owner to postgres;

create index status_update_requested
    on connections (update_requested_at, update_status);

create index connections_client_id_fk
    on connections (client_id);

create index connections_connectors_id_fk
    on connections (connector_id);

create index "IDX_status"
    on connections (connect_status);

create index status
    on connections (update_status);

create index "connections_wp_posts_ID_fk"
    on connections (wp_post_id);

