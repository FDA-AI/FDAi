create table tracking_reminders
(
    id                                              serial
        primary key,
    user_id                                         bigint                                                  not null
        constraint tracking_reminders_user_id_fk
            references wp_users
            on update cascade on delete cascade,
    client_id                                       varchar(80)                                             not null
        constraint tracking_reminders_client_id_fk
            references oa_clients,
    variable_id                                     integer                                                 not null
        constraint tracking_reminders_variables_id_fk
            references variables,
    default_value                                   double precision,
    reminder_start_time                             time(0)      default '00:00:00'::time without time zone not null,
    reminder_end_time                               time(0),
    reminder_sound                                  varchar(125),
    reminder_frequency                              integer,
    pop_up                                          boolean,
    sms                                             boolean,
    email                                           boolean,
    notification_bar                                boolean,
    last_tracked                                    timestamp(0),
    created_at                                      timestamp(0) default CURRENT_TIMESTAMP                  not null,
    updated_at                                      timestamp(0) default CURRENT_TIMESTAMP                  not null,
    start_tracking_date                             date,
    stop_tracking_date                              date,
    instructions                                    text,
    deleted_at                                      timestamp(0),
    image_url                                       varchar(2083),
    user_variable_id                                integer                                                 not null
        constraint tracking_reminders_user_variables_user_variable_id_fk
            references user_variables
            on update cascade on delete cascade,
    latest_tracking_reminder_notification_notify_at timestamp(0),
    number_of_tracking_reminder_notifications       integer,
    constraint "UK_user_var_time_freq"
        unique (user_id, variable_id, reminder_start_time, reminder_frequency),
    constraint tracking_reminders_user_variables_user_id_variable_id_fk
        foreign key (user_id, variable_id) references user_variables (user_id, variable_id)
);

comment on column tracking_reminders.variable_id is 'Id for the variable to be tracked';

comment on column tracking_reminders.default_value is 'Default value to use for the measurement when tracking';

comment on column tracking_reminders.reminder_start_time is 'LOCAL TIME: Earliest time of day at which reminders should appear';

comment on column tracking_reminders.reminder_end_time is 'LOCAL TIME: Latest time of day at which reminders should appear';

comment on column tracking_reminders.reminder_sound is 'String identifier for the sound to accompany the reminder';

comment on column tracking_reminders.reminder_frequency is 'Number of seconds between one reminder and the next';

comment on column tracking_reminders.pop_up is 'True if the reminders should appear as a popup notification';

comment on column tracking_reminders.sms is 'True if the reminders should be delivered via SMS';

comment on column tracking_reminders.email is 'True if the reminders should be delivered via email';

comment on column tracking_reminders.notification_bar is 'True if the reminders should appear in the notification bar';

comment on column tracking_reminders.start_tracking_date is 'Earliest date on which the user should be reminded to track in YYYY-MM-DD format';

comment on column tracking_reminders.stop_tracking_date is 'Latest date on which the user should be reminded to track  in YYYY-MM-DD format';

comment on column tracking_reminders.number_of_tracking_reminder_notifications is 'Number of Tracking Reminder Notifications for this Tracking Reminder.
                    [Formula: update tracking_reminders
                        left join (
                            select count(id) as total, tracking_reminder_id
                            from tracking_reminder_notifications
                            group by tracking_reminder_id
                        )
                        as grouped on tracking_reminders.id = grouped.tracking_reminder_id
                    set tracking_reminders.number_of_tracking_reminder_notifications = count(grouped.total)]';

alter table tracking_reminders
    owner to postgres;

create index tracking_reminders_user_variables_variable_id_user_id_fk
    on tracking_reminders (variable_id, user_id);

create index user_client
    on tracking_reminders (user_id, client_id);

create index tracking_reminders_client_id_fk
    on tracking_reminders (client_id);

create index tracking_reminders_user_variables_user_variable_id_fk
    on tracking_reminders (user_variable_id);

