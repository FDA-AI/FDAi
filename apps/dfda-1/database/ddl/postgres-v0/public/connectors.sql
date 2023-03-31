create table connectors
(
    id                           serial
        primary key,
    name                         varchar(30)                            not null
        constraint connectors_name_unique
            unique,
    display_name                 varchar(30)                            not null,
    image                        varchar(2083)                          not null,
    get_it_url                   varchar(2083),
    short_description            text                                   not null,
    long_description             text                                   not null,
    enabled                      boolean      default true              not null,
    oauth                        boolean      default false             not null,
    qm_client                    boolean      default false,
    created_at                   timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                   timestamp(0) default CURRENT_TIMESTAMP not null,
    client_id                    varchar(80)
        constraint connectors_client_id_fk
            references oa_clients,
    deleted_at                   timestamp(0),
    wp_post_id                   bigint
        constraint "connectors_wp_posts_ID_fk"
            references wp_posts,
    number_of_connections        integer,
    number_of_connector_imports  integer,
    number_of_connector_requests integer,
    number_of_measurements       integer,
    is_public                    boolean,
    sort_order                   integer,
    slug                         varchar(200)
        constraint connectors_slug_uindex
            unique,
    available_outside_us         boolean      default true              not null
);

comment on column connectors.id is 'Connector ID number';

comment on column connectors.name is 'Lowercase system name for the data source';

comment on column connectors.display_name is 'Pretty display name for the data source';

comment on column connectors.image is 'URL to the image of the connector logo';

comment on column connectors.get_it_url is 'URL to a site where one can get this device or application';

comment on column connectors.short_description is 'Short description of the service (such as the categories it tracks)';

comment on column connectors.long_description is 'Longer paragraph description of the data provider';

comment on column connectors.enabled is 'Set to 1 if the connector should be returned when listing connectors';

comment on column connectors.oauth is 'Set to 1 if the connector uses OAuth authentication as opposed to username/password';

comment on column connectors.qm_client is 'Whether its a connector or one of our clients';

comment on column connectors.number_of_connections is 'Number of Connections for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connections
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connections = count(grouped.total)
                ]
                ';

comment on column connectors.number_of_connector_imports is 'Number of Connector Imports for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_imports
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_imports = count(grouped.total)
                ]
                ';

comment on column connectors.number_of_connector_requests is 'Number of Connector Requests for this Connector.
                [Formula:
                    update connectors
                        left join (
                            select count(id) as total, connector_id
                            from connector_requests
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_connector_requests = count(grouped.total)
                ]
                ';

comment on column connectors.number_of_measurements is 'Number of Measurements for this Connector.
                    [Formula: update connectors
                        left join (
                            select count(id) as total, connector_id
                            from measurements
                            group by connector_id
                        )
                        as grouped on connectors.id = grouped.connector_id
                    set connectors.number_of_measurements = count(grouped.total)]';

comment on column connectors.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table connectors
    owner to postgres;

create index connectors_client_id_fk
    on connectors (client_id);

create index "connectors_wp_posts_ID_fk"
    on connectors (wp_post_id);

