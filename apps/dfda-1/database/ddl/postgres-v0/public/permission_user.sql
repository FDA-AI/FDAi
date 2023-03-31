create table permission_user
(
    id            serial
        primary key,
    permission_id integer not null
        constraint permission_user_permission_id_foreign
            references permissions
            on delete cascade,
    user_id       bigint  not null
        constraint permission_user_user_id_foreign
            references wp_users
            on delete cascade,
    created_at    timestamp(0),
    updated_at    timestamp(0),
    deleted_at    timestamp(0)
);

alter table permission_user
    owner to postgres;

create index permission_user_permission_id_index
    on permission_user (permission_id);

create index permission_user_user_id_index
    on permission_user (user_id);

