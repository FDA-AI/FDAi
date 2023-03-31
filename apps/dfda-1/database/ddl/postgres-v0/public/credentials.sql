create table credentials
(
    user_id      bigint                                 not null
        constraint credentials_user_id_fk
            references wp_users,
    connector_id integer                                not null,
    attr_key     varchar(16)                            not null,
    attr_value   bytea                                  not null,
    status       varchar(32)  default 'UPDATED'::character varying,
    message      text,
    expires_at   timestamp(0),
    created_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at   timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at   timestamp(0),
    client_id    varchar(255)
        constraint credentials_client_id_fk
            references oa_clients,
    primary key (user_id, connector_id, attr_key)
);

comment on column credentials.connector_id is 'Connector id';

comment on column credentials.attr_key is 'Attribute name such as token, userid, username, or password';

comment on column credentials.attr_value is 'Encrypted value for the attribute specified';

alter table credentials
    owner to postgres;

create index "IDX_status_expires_connector"
    on credentials (connector_id, expires_at, status);

create index credentials_client_id_fk
    on credentials (client_id);

