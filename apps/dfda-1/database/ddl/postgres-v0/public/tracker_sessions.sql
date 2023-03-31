create table tracker_sessions
(
    id         bigserial
        primary key,
    uuid       varchar(255)                           not null
        constraint tracker_sessions_uuid_unique
            unique,
    user_id    bigint                                 not null,
    device_id  bigint,
    agent_id   bigint,
    client_ip  varchar(255)                           not null,
    referer_id bigint,
    cookie_id  bigint,
    geoip_id   bigint,
    is_robot   boolean                                not null,
    created_at timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at timestamp(0)                           not null,
    deleted_at timestamp(0),
    client_id  varchar(255)
);

alter table tracker_sessions
    owner to postgres;

create index tracker_sessions_user_id_index
    on tracker_sessions (user_id);

create index tracker_sessions_device_id_index
    on tracker_sessions (device_id);

create index tracker_sessions_agent_id_index
    on tracker_sessions (agent_id);

create index tracker_sessions_client_ip_index
    on tracker_sessions (client_ip);

create index tracker_sessions_referer_id_index
    on tracker_sessions (referer_id);

create index tracker_sessions_cookie_id_index
    on tracker_sessions (cookie_id);

create index tracker_sessions_geoip_id_index
    on tracker_sessions (geoip_id);

create index tracker_sessions_created_at_index
    on tracker_sessions (created_at);

create index tracker_sessions_updated_at_index
    on tracker_sessions (updated_at);

create index tracker_sessions_client_id_fk
    on tracker_sessions (client_id);

