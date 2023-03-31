create table tracker_log
(
    id            bigserial
        primary key,
    session_id    bigint,
    path_id       bigint,
    query_id      bigint,
    method        varchar(10)                            not null,
    route_path_id bigint,
    is_ajax       boolean                                not null,
    is_secure     boolean                                not null,
    is_json       boolean                                not null,
    wants_json    boolean                                not null,
    error_id      bigint,
    created_at    timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at    timestamp(0)                           not null,
    client_id     varchar(255),
    user_id       bigint                                 not null,
    deleted_at    timestamp(0)
);

alter table tracker_log
    owner to postgres;

create index tracker_log_session_id_index
    on tracker_log (session_id);

create index tracker_log_path_id_index
    on tracker_log (path_id);

create index tracker_log_query_id_index
    on tracker_log (query_id);

create index tracker_log_method_index
    on tracker_log (method);

create index tracker_log_route_path_id_index
    on tracker_log (route_path_id);

create index tracker_log_error_id_index
    on tracker_log (error_id);

create index tracker_log_created_at_index
    on tracker_log (created_at);

create index tracker_log_updated_at_index
    on tracker_log (updated_at);

create index tracker_log_client_id_fk
    on tracker_log (client_id);

create index tracker_log_user_id_fk
    on tracker_log (user_id);

