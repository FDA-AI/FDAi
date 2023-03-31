create table oa_access_tokens
(
    access_token varchar(40)                            not null
        primary key,
    client_id    varchar(80)                            not null
        constraint access_tokens_client_id_fk
            references oa_clients
        constraint bshaffer_oauth_access_tokens_client_id_fk
            references oa_clients,
    user_id      bigint                                 not null
        constraint bshaffer_oauth_access_tokens_user_id_fk
            references wp_users,
    expires      timestamp(0),
    scope        varchar(2000),
    updated_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp(0)
);

alter table oa_access_tokens
    owner to postgres;

create index access_tokens_client_id_fk
    on oa_access_tokens (client_id);

create index bshaffer_oauth_access_tokens_user_id_fk
    on oa_access_tokens (user_id);

