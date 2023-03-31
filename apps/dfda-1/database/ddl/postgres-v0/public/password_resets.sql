create table password_resets
(
    email      varchar(255)                           not null,
    token      varchar(255)                           not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

alter table password_resets
    owner to postgres;

create index password_resets_email_index
    on password_resets (email);

create index password_resets_token_index
    on password_resets (token);

