create table permission_role
(
    id            serial
        primary key,
    permission_id integer not null
        constraint permission_role_permission_id_foreign
            references permissions
            on delete cascade,
    role_id       integer not null
        constraint permission_role_role_id_foreign
            references roles
            on delete cascade,
    created_at    timestamp(0),
    updated_at    timestamp(0),
    deleted_at    timestamp(0)
);

alter table permission_role
    owner to postgres;

create index permission_role_permission_id_index
    on permission_role (permission_id);

create index permission_role_role_id_index
    on permission_role (role_id);

