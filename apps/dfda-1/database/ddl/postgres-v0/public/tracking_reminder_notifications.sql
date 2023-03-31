create table tracking_reminder_notifications
(
    id                   serial
        primary key,
    tracking_reminder_id integer                                not null
        constraint tracking_reminder_notifications_tracking_reminders_id_fk
            references tracking_reminders
            on update cascade on delete cascade,
    created_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at           timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at           timestamp(0),
    user_id              bigint                                 not null
        constraint tracking_reminder_notifications_user_id_fk
            references wp_users
            on delete cascade,
    notified_at          timestamp(0),
    received_at          timestamp(0),
    client_id            varchar(255)
        constraint tracking_reminder_notifications_client_id_fk
            references oa_clients,
    variable_id          integer                                not null
        constraint tracking_reminder_notifications_variables_id_fk
            references variables
            on update cascade on delete cascade,
    notify_at            timestamp(0),
    user_variable_id     integer                                not null
        constraint tracking_reminder_notifications_user_variables_id_fk
            references user_variables
            on update cascade on delete cascade,
    constraint notify_at_tracking_reminder_id_uindex
        unique (notify_at, tracking_reminder_id)
);

comment on column tracking_reminder_notifications.notified_at is 'UTC time when the notification was sent.';

alter table tracking_reminder_notifications
    owner to postgres;

create index tracking_reminder_notifications_tracking_reminders_id_fk
    on tracking_reminder_notifications (tracking_reminder_id);

create index tracking_reminder_notifications_user_id_fk
    on tracking_reminder_notifications (user_id);

create index tracking_reminder_notifications_client_id_fk
    on tracking_reminder_notifications (client_id);

create index tracking_reminder_notifications_variable_id_fk
    on tracking_reminder_notifications (variable_id);

create index tracking_reminder_notifications_user_variables_id_fk
    on tracking_reminder_notifications (user_variable_id);

