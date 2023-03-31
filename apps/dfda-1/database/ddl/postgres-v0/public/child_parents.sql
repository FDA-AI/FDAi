create table child_parents
(
    id             serial
        primary key,
    child_user_id  bigint                                 not null
        constraint "child_parents_wp_users_ID_fk"
            references wp_users,
    parent_user_id bigint                                 not null
        constraint "child_parents_wp_users_ID_fk_2"
            references wp_users,
    scopes         varchar(2000)                          not null,
    created_at     timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at     timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at     timestamp(0),
    constraint child_user_id_parent_user_id_uindex
        unique (child_user_id, parent_user_id)
);

comment on column child_parents.child_user_id is 'The child who has granted data access to the parent. ';

comment on column child_parents.parent_user_id is 'The parent who has been granted access to the child data.';

comment on column child_parents.scopes is 'Whether the parent has read access and/or write access to the data.';

alter table child_parents
    owner to postgres;

create index "child_parents_wp_users_ID_fk_2"
    on child_parents (parent_user_id);

