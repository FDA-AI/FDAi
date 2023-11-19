create table oa_refresh_tokens
(
    refresh_token varchar(40)                            not null
        primary key,
    client_id     varchar(80)                            not null
        constraint oa_refresh_tokens_client_id_fk
            references oa_clients
        constraint refresh_tokens_client_id_fk
            references oa_clients,
    user_id       bigint                                 not null
        constraint oa_refresh_tokens_user_id_fk
            references wp_users,
    expires       timestamp(0),
    scope         varchar(2000),
    updated_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at    timestamp(0)
);

alter table oa_refresh_tokens
    owner to postgres;

create index refresh_tokens_client_id_fk
    on oa_refresh_tokens (client_id);

create index oa_refresh_tokens_user_id_fk
    on oa_refresh_tokens (user_id);

