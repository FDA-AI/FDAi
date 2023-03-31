create table button_clicks
(
    card_id      varchar(80)                            not null,
    button_id    varchar(80)                            not null,
    client_id    varchar(80)                            not null
        constraint button_clicks_client_id_fk
            references oa_clients,
    created_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp(0),
    id           serial
        primary key,
    input_fields text,
    intent_name  varchar(80),
    parameters   text,
    updated_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id      bigint                                 not null
        constraint button_clicks_user_id_fk
            references wp_users
);

alter table button_clicks
    owner to postgres;

create index button_clicks_client_id_fk
    on button_clicks (client_id);

create index button_clicks_user_id_fk
    on button_clicks (user_id);

