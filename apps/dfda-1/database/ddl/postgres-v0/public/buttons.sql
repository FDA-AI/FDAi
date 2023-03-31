create table buttons
(
    accessibility_text     varchar(100),
    action                 varchar(20),
    additional_information varchar(20),
    client_id              varchar(80)                            not null
        constraint buttons_client_id_fk
            references oa_clients,
    color                  varchar(20),
    confirmation_text      varchar(100),
    created_at             timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at             timestamp(0),
    function_name          varchar(20),
    function_parameters    text,
    html                   varchar(200),
    element_id             varchar(80)                            not null,
    image                  varchar(100),
    input_fields           text,
    ion_icon               varchar(20),
    link                   varchar(100),
    state_name             varchar(20),
    state_params           text,
    success_alert_body     varchar(200),
    success_alert_title    varchar(80),
    success_toast_text     varchar(80),
    text                   varchar(80),
    title                  varchar(80),
    tooltip                varchar(80),
    type                   varchar(80)                            not null,
    updated_at             timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id                bigint                                 not null
        constraint buttons_user_id_fk
            references wp_users,
    id                     serial
        primary key
        constraint buttons_id_uindex
            unique,
    slug                   varchar(200)
        constraint buttons_slug_uindex
            unique
);

comment on column buttons.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table buttons
    owner to postgres;

create index buttons_client_id_fk
    on buttons (client_id);

create index buttons_user_id_fk
    on buttons (user_id);

