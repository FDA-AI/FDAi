create table sharer_trustees
(
    id                serial
        primary key,
    sharer_user_id    bigint                                 not null
        constraint "sharer_trustees_wp_users_ID_fk"
            references wp_users,
    trustee_user_id   bigint                                 not null
        constraint "sharer_trustees_wp_users_ID_fk_2"
            references wp_users,
    scopes            varchar(2000)                          not null,
    relationship_type varchar(255)                           not null
        constraint sharer_trustees_relationship_type_check
            check ((relationship_type)::text = ANY
                   ((ARRAY ['patient-physician'::character varying, 'student-teacher'::character varying, 'child-parent'::character varying, 'friend'::character varying])::text[])),
    created_at        timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at        timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at        timestamp(0),
    constraint sharer_user_id_trustee_user_id_uindex
        unique (sharer_user_id, trustee_user_id)
);

comment on column sharer_trustees.sharer_user_id is 'The sharer who has granted data access to the trustee. ';

comment on column sharer_trustees.trustee_user_id is 'The trustee who has been granted access to the sharer data.';

comment on column sharer_trustees.scopes is 'Whether the trustee has read access and/or write access to the data.';

alter table sharer_trustees
    owner to postgres;

create index "sharer_trustees_wp_users_ID_fk_2"
    on sharer_trustees (trustee_user_id);

