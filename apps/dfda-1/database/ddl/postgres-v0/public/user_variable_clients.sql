create table user_variable_clients
(
    id                      serial
        primary key,
    client_id               varchar(80)                            not null
        constraint user_variable_clients_client_id_fk
            references oa_clients,
    created_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp(0),
    earliest_measurement_at timestamp(0),
    latest_measurement_at   timestamp(0),
    number_of_measurements  integer,
    updated_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id                 bigint                                 not null
        constraint user_variable_clients_user_id_fk
            references wp_users,
    user_variable_id        integer                                not null
        constraint user_variable_clients_user_variables_user_variable_id_fk
            references user_variables,
    variable_id             integer                                not null
        constraint user_variable_clients_variable_id_fk
            references variables,
    constraint user_variable_clients_user
        unique (user_id, variable_id, client_id)
);

comment on column user_variable_clients.earliest_measurement_at is 'Earliest measurement time for this variable and client';

comment on column user_variable_clients.latest_measurement_at is 'Earliest measurement time for this variable and client';

comment on column user_variable_clients.variable_id is 'Id of variable';

alter table user_variable_clients
    owner to postgres;

create index user_variable_clients_client_id_fk
    on user_variable_clients (client_id);

create index user_variable_clients_user_variables_user_variable_id_fk
    on user_variable_clients (user_variable_id);

create index user_variable_clients_variable_id_fk
    on user_variable_clients (variable_id);

