create table variable_user_sources
(
    user_id                       bigint                                 not null
        constraint variable_user_sources_user_id_fk
            references wp_users,
    variable_id                   integer                                not null
        constraint variable_user_sources_variable_id_fk
            references variables,
    timestamp                     integer,
    earliest_measurement_time     integer,
    latest_measurement_time       integer,
    created_at                    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                    timestamp(0),
    data_source_name              varchar(80)                            not null,
    number_of_raw_measurements    integer,
    client_id                     varchar(255)
        constraint variable_user_sources_client_id_fk
            references oa_clients,
    id                            serial
        primary key,
    user_variable_id              integer                                not null
        constraint variable_user_sources_user_variables_user_variable_id_fk
            references user_variables
            on update cascade on delete cascade,
    earliest_measurement_start_at timestamp(0),
    latest_measurement_start_at   timestamp(0),
    constraint variable_user_sources_user
        unique (user_id, variable_id, data_source_name),
    constraint variable_user_sources_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references user_variables (user_id, variable_id)
);

comment on column variable_user_sources.variable_id is 'ID of variable';

alter table variable_user_sources
    owner to postgres;

create index variable_user_sources_user_variables_variable_id_user_id_fk
    on variable_user_sources (variable_id, user_id);

create index variable_user_sources_user_variables_user_variable_id_fk
    on variable_user_sources (user_variable_id);

