create table user_tags
(
    id                      serial
        primary key,
    tagged_variable_id      integer                                not null
        constraint user_tags_tagged_variable_id_variables_id_fk
            references variables,
    tag_variable_id         integer                                not null,
    conversion_factor       double precision                       not null,
    user_id                 bigint                                 not null
        constraint user_tags_user_id_fk
            references wp_users,
    created_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at              timestamp(0) default CURRENT_TIMESTAMP not null,
    client_id               varchar(80)
        constraint user_tags_client_id_fk
            references oa_clients,
    deleted_at              timestamp(0),
    tagged_user_variable_id integer
        constraint user_tags_tagged_user_variable_id_fk
            references user_variables,
    tag_user_variable_id    integer                                not null
        constraint user_tags_tag_user_variable_id_fk
            references user_variables,
    constraint "UK_user_tag_tagged"
        unique (tagged_variable_id, tag_variable_id, user_id)
);

comment on column user_tags.tagged_variable_id is 'This is the id of the variable being tagged with an ingredient or something.';

comment on column user_tags.tag_variable_id is 'This is the id of the ingredient variable whose value is determined based on the value of the tagged variable.';

comment on column user_tags.conversion_factor is 'Number by which we multiply the tagged variable''s value to obtain the tag variable''s value';

alter table user_tags
    owner to postgres;

create index "fk_conversionUnit"
    on user_tags (tag_variable_id);

create index user_tags_user_id_fk
    on user_tags (user_id);

create index user_tags_client_id_fk
    on user_tags (client_id);

create index user_tags_tagged_user_variable_id_fk
    on user_tags (tagged_user_variable_id);

