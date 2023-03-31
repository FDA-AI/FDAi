create table role_user
(
    id         serial
        primary key,
    role_id    integer not null
        constraint role_user_role_id_foreign
            references roles
            on delete cascade,
    user_id    bigint  not null
        constraint role_user_user_id_foreign
            references wp_users
            on delete cascade,
    created_at timestamp(0),
    updated_at timestamp(0),
    deleted_at timestamp(0)
);

alter table role_user
    owner to postgres;

create index role_user_role_id_index
    on role_user (role_id);

create index role_user_user_id_index
    on role_user (user_id);

