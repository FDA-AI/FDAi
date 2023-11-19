create table oa_authorization_codes
(
    authorization_code varchar(40)                            not null
        primary key,
    client_id          varchar(80)                            not null
        constraint oa_authorization_codes_client_id_fk
            references oa_clients,
    user_id            bigint                                 not null
        constraint oa_authorization_codes_user_id_fk
            references wp_users,
    redirect_uri       varchar(2000),
    expires            timestamp(0),
    scope              varchar(2000),
    updated_at         timestamp(0) default CURRENT_TIMESTAMP not null,
    created_at         timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at         timestamp(0)
);

alter table oa_authorization_codes
    owner to postgres;

create index oa_authorization_codes_client_id_fk
    on oa_authorization_codes (client_id);

create index oa_authorization_codes_user_id_fk
    on oa_authorization_codes (user_id);

