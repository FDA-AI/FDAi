create table oauth_access_tokens
(
    id         varchar(100) not null
        primary key,
    user_id    bigint,
    client_id  bigint       not null,
    name       varchar(255),
    scopes     text,
    revoked    boolean      not null,
    created_at timestamp(0),
    updated_at timestamp(0),
    expires_at timestamp(0)
);

alter table oauth_access_tokens
    owner to postgres;

create index oauth_access_tokens_user_id_index
    on oauth_access_tokens (user_id);

