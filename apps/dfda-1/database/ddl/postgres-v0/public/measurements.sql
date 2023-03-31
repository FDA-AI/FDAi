create table measurements
(
    id                   bigserial
        primary key,
    user_id              bigint                                 not null
        constraint measurements_user_id_fk
            references wp_users,
    client_id            varchar(80)
        constraint measurements_client_id_fk
            references oa_clients,
    connector_id         integer
        constraint measurements_connectors_id_fk
            references connectors,
    variable_id          integer                                not null
        constraint measurements_variables_id_fk
            references variables,
    start_time           integer                                not null,
    value                double precision                       not null,
    unit_id              smallint                               not null
        constraint measurements_unit_id_fk
            references units,
    original_value       double precision                       not null,
    original_unit_id     smallint                               not null
        constraint measurements_original_unit_id_fk
            references units,
    duration             integer,
    note                 text,
    latitude             double precision,
    longitude            double precision,
    location             varchar(255),
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    error                text,
    variable_category_id smallint                               not null
        constraint measurements_variable_category_id_fk
            references variable_categories,
    deleted_at           timestamp(0),
    source_name          varchar(80),
    user_variable_id     integer                                not null
        constraint measurements_user_variables_user_variable_id_fk
            references user_variables,
    start_at             timestamp(0),
    connection_id        integer
        constraint measurements_connections_id_fk
            references connections,
    connector_import_id  integer
        constraint measurements_connector_imports_id_fk
            references connector_imports,
    deletion_reason      varchar(280),
    original_start_at    timestamp(0),
    constraint measurements_pk
        unique (user_id, variable_id, start_time)
);

comment on column measurements.connector_id is 'The id for the connector data source from which the measurement was obtained';

comment on column measurements.variable_id is 'ID of the variable for which we are creating the measurement records';

comment on column measurements.start_time is 'Start time for the measurement event in ISO 8601';

comment on column measurements.value is 'The value of the measurement after conversion to the default unit for that variable';

comment on column measurements.unit_id is 'The default unit for the variable';

comment on column measurements.original_value is 'Value of measurement as originally posted (before conversion to default unit)';

comment on column measurements.original_unit_id is 'Unit id of measurement as originally submitted';

comment on column measurements.duration is 'Duration of the event being measurement in seconds';

comment on column measurements.note is 'An optional note the user may include with their measurement';

comment on column measurements.latitude is 'Latitude at which the measurement was taken';

comment on column measurements.longitude is 'Longitude at which the measurement was taken';

comment on column measurements.location is 'location';

comment on column measurements.created_at is 'Time at which this measurement was originally stored';

comment on column measurements.updated_at is 'Time at which this measurement was last updated';

comment on column measurements.error is 'An error message if there is a problem with the measurement';

comment on column measurements.variable_category_id is 'Variable category ID';

comment on column measurements.source_name is 'Name of the application or device';

comment on column measurements.deletion_reason is 'The reason the variable was deleted.';

alter table measurements
    owner to postgres;

create index measurements_variable_id_value_start_time_index
    on measurements (variable_id, value, start_time);

create index measurements_variable_id_start_time_index
    on measurements (variable_id, start_time);

create index measurements_user_variables_variable_id_user_id_fk
    on measurements (variable_id, user_id);

create index measurements_user_id_variable_category_id_start_time_index
    on measurements (user_id, variable_category_id, start_time);

create index measurements_client_id_fk
    on measurements (client_id);

create index measurements_connectors_id_fk
    on measurements (connector_id);

create index measurements_start_time_index
    on measurements (start_time);

create index "fk_measurementUnits"
    on measurements (unit_id);

create index measurements_original_unit_id_fk
    on measurements (original_unit_id);

create index measurements_variable_category_id_fk
    on measurements (variable_category_id);

create index measurements_user_variables_user_variable_id_fk
    on measurements (user_variable_id);

create index measurements_connections_id_fk
    on measurements (connection_id);

create index measurements_connector_imports_id_fk
    on measurements (connector_import_id);

