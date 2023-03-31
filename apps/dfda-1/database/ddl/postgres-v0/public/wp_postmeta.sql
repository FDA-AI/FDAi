create table wp_postmeta
(
    meta_id    bigserial
        primary key,
    post_id    bigint       default '0'::bigint
        constraint "wp_postmeta_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete cascade,
    meta_key   varchar(255),
    meta_value text,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

comment on column wp_postmeta.meta_id is 'Unique number assigned to each row of the table.';

comment on column wp_postmeta.post_id is 'The ID of the post the data relates to.';

comment on column wp_postmeta.meta_key is 'An identifying key for the piece of data.';

comment on column wp_postmeta.meta_value is 'The actual piece of data.';

alter table wp_postmeta
    owner to postgres;

create index post_id
    on wp_postmeta (post_id);

create index wp_postmeta_meta_key
    on wp_postmeta (meta_key);

