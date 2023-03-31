create table wp_usermeta
(
    umeta_id   bigserial
        primary key,
    user_id    bigint       default '0'::bigint
        constraint "wp_usermeta_wp_users_ID_fk"
            references wp_users,
    meta_key   varchar(255),
    meta_value text,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

comment on column wp_usermeta.umeta_id is 'Unique number assigned to each row of the table.';

comment on column wp_usermeta.user_id is 'ID of the related user.';

comment on column wp_usermeta.meta_key is 'An identifying key for the piece of data.';

comment on column wp_usermeta.meta_value is 'The actual piece of data.';

alter table wp_usermeta
    owner to postgres;

create index user_id
    on wp_usermeta (user_id);

create index wp_usermeta_meta_key
    on wp_usermeta (meta_key);

