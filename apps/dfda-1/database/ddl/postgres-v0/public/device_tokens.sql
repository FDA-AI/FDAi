create table device_tokens
(
    device_token                                      varchar(255)                           not null
        primary key,
    created_at                                        timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                                        timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                                        timestamp(0),
    user_id                                           bigint                                 not null
        constraint device_tokens_user_id_fk
            references wp_users,
    number_of_waiting_tracking_reminder_notifications integer,
    last_notified_at                                  timestamp(0),
    platform                                          varchar(255)                           not null,
    number_of_new_tracking_reminder_notifications     integer,
    number_of_notifications_last_sent                 integer,
    error_message                                     varchar(255),
    last_checked_at                                   timestamp(0),
    received_at                                       timestamp(0),
    server_ip                                         varchar(255),
    server_hostname                                   varchar(255),
    client_id                                         varchar(255)
        constraint device_tokens_client_id_fk
            references oa_clients
);

comment on column device_tokens.number_of_waiting_tracking_reminder_notifications is 'Number of notifications waiting in the reminder inbox';

comment on column device_tokens.number_of_new_tracking_reminder_notifications is 'Number of notifications that have come due since last notification';

comment on column device_tokens.number_of_notifications_last_sent is 'Number of notifications that were sent at last_notified_at batch';

alter table device_tokens
    owner to postgres;

create index index_user_id
    on device_tokens (user_id);

create index device_tokens_client_id_fk
    on device_tokens (client_id);

