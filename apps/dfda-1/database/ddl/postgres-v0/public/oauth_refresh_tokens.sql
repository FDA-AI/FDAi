create table oauth_refresh_tokens
(
    id              varchar(100) not null
        primary key,
    access_token_id varchar(100) not null,
    revoked         boolean      not null,
    expires_at      timestamp(0)
);

alter table oauth_refresh_tokens
    owner to postgres;

create index oauth_refresh_tokens_access_token_id_index
    on oauth_refresh_tokens (access_token_id);

