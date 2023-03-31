create table oauth_auth_codes
(
    id         varchar(100) not null
        primary key,
    user_id    bigint       not null,
    client_id  bigint       not null,
    scopes     text,
    revoked    boolean      not null,
    expires_at timestamp(0)
);

alter table oauth_auth_codes
    owner to postgres;

create index oauth_auth_codes_user_id_index
    on oauth_auth_codes (user_id);

