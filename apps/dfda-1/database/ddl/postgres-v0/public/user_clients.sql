create table user_clients
(
    id                      serial
        primary key,
    client_id               varchar(80)
        constraint user_clients_client_id_fk
            references oa_clients,
    created_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at              timestamp(0),
    earliest_measurement_at timestamp(0),
    latest_measurement_at   timestamp(0),
    number_of_measurements  integer,
    updated_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id                 bigint                                 not null
        constraint user_clients_user_id_fk
            references wp_users,
    constraint user_clients_user
        unique (user_id, client_id)
);

comment on column user_clients.earliest_measurement_at is 'Earliest measurement time for this variable and client';

comment on column user_clients.latest_measurement_at is 'Earliest measurement time for this variable and client';

alter table user_clients
    owner to postgres;

create index user_clients_client_id_fk
    on user_clients (client_id);

