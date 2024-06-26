create table quantimodo_test.wp_usermeta
(
    umeta_id   bigint unsigned auto_increment comment 'Unique number assigned to each row of the table.'
        primary key,
    user_id    bigint unsigned default '0'               null comment 'ID of the related user.',
    meta_key   varchar(255)                              null comment 'An identifying key for the piece of data.',
    meta_value longtext                                  null comment 'The actual piece of data.',
    updated_at timestamp       default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP,
    created_at timestamp       default CURRENT_TIMESTAMP not null,
    deleted_at timestamp                                 null,
    client_id  varchar(255)                              null,
    constraint wp_usermeta_wp_users_ID_fk
        foreign key (user_id) references quantimodo_test.wp_users (ID)
)
    comment 'This table stores any further information related to the users. You will see other user profile fields for a user in the dashboard that are stored here.'
    charset = utf8mb3;

create index meta_key
    on quantimodo_test.wp_usermeta (meta_key);

create index user_id
    on quantimodo_test.wp_usermeta (user_id);

