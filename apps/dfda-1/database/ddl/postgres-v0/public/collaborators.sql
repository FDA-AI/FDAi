create table collaborators
(
    id         serial
        primary key,
    user_id    bigint                                                 not null
        constraint collaborators_user_id_fk
            references wp_users
            on update cascade on delete cascade,
    app_id     integer                                                not null
        constraint collaborators_applications_id_fk
            references applications
            on update cascade on delete cascade,
    type       varchar(255) default 'collaborator'::character varying not null
        constraint collaborators_type_check
            check ((type)::text = ANY
                   ((ARRAY ['owner'::character varying, 'collaborator'::character varying])::text[])),
    created_at timestamp(0) default CURRENT_TIMESTAMP                 not null,
    updated_at timestamp(0) default CURRENT_TIMESTAMP                 not null,
    deleted_at timestamp(0),
    client_id  varchar(80)
        constraint collaborators_client_id_fk
            references oa_clients
            on update cascade on delete cascade,
    constraint collaborators_user_client_index
        unique (user_id, client_id)
);

alter table collaborators
    owner to postgres;

create index collaborators_applications_id_fk
    on collaborators (app_id);

create index collaborators_client_id_fk
    on collaborators (client_id);

