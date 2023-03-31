create table oauth_clients
(
    id                     bigserial
        primary key,
    user_id                bigint,
    name                   varchar(255) not null,
    secret                 varchar(100),
    provider               varchar(255),
    redirect               text         not null,
    personal_access_client boolean      not null,
    password_client        boolean      not null,
    revoked                boolean      not null,
    created_at             timestamp(0),
    updated_at             timestamp(0)
);

alter table oauth_clients
    owner to postgres;

create index oauth_clients_user_id_index
    on oauth_clients (user_id);

