create table spreadsheet_importers
(
    id                            serial
        primary key,
    name                          varchar(30)                            not null,
    display_name                  varchar(30)                            not null,
    image                         varchar(2083)                          not null,
    get_it_url                    varchar(2083),
    short_description             text                                   not null,
    long_description              text                                   not null,
    enabled                       boolean      default true              not null,
    created_at                    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp(0) default CURRENT_TIMESTAMP not null,
    client_id                     varchar(80)
        constraint spreadsheet_importers_client_id_fk
            references oa_clients,
    deleted_at                    timestamp(0),
    wp_post_id                    bigint
        constraint "spreadsheet_importers_wp_posts_ID_fk"
            references wp_posts,
    number_of_measurement_imports integer,
    number_of_measurements        integer,
    sort_order                    integer
);

comment on column spreadsheet_importers.id is 'Spreadsheet Importer ID number';

comment on column spreadsheet_importers.name is 'Lowercase system name for the data source';

comment on column spreadsheet_importers.display_name is 'Pretty display name for the data source';

comment on column spreadsheet_importers.image is 'URL to the image of the Spreadsheet Importer logo';

comment on column spreadsheet_importers.get_it_url is 'URL to a site where one can get this device or application';

comment on column spreadsheet_importers.short_description is 'Short description of the service (such as the categories it tracks)';

comment on column spreadsheet_importers.long_description is 'Longer paragraph description of the data provider';

comment on column spreadsheet_importers.enabled is 'Set to 1 if the Spreadsheet Importer should be returned when listing Spreadsheet Importers';

comment on column spreadsheet_importers.number_of_measurement_imports is 'Number of Spreadsheet Import Requests for this Spreadsheet Importer.
                            [Formula:
                                update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from spreadsheet_importer_requests
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_spreadsheet_importer_requests = count(grouped.total)
                            ]
                            ';

comment on column spreadsheet_importers.number_of_measurements is 'Number of Measurements for this Spreadsheet Importer.
                                [Formula: update spreadsheet_importers
                                    left join (
                                        select count(id) as total, spreadsheet_importer_id
                                        from measurements
                                        group by spreadsheet_importer_id
                                    )
                                    as grouped on spreadsheet_importers.id = grouped.spreadsheet_importer_id
                                set spreadsheet_importers.number_of_measurements = count(grouped.total)]';

alter table spreadsheet_importers
    owner to postgres;

create index spreadsheet_importers_client_id_fk
    on spreadsheet_importers (client_id);

create index "spreadsheet_importers_wp_posts_ID_fk"
    on spreadsheet_importers (wp_post_id);

