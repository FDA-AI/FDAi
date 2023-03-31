create table oauth_personal_access_clients
(
    id         bigserial
        primary key,
    client_id  bigint not null,
    created_at timestamp(0),
    updated_at timestamp(0)
);

alter table oauth_personal_access_clients
    owner to postgres;

