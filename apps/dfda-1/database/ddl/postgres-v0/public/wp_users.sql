create table wp_users
(
    "ID"                                                     serial
        primary key,
    client_id                                                varchar(255)                                            not null,
    user_login                                               varchar(60)
        constraint user_login_key
            unique,
    user_email                                               varchar(100)
        constraint user_email
            unique,
    email                                                    varchar(320),
    user_pass                                                varchar(255),
    user_nicename                                            varchar(50),
    user_url                                                 varchar(100) default ''::character varying              not null,
    user_registered                                          timestamp(0),
    user_activation_key                                      varchar(255),
    user_status                                              integer      default 0,
    display_name                                             varchar(250),
    avatar_image                                             varchar(2083),
    reg_provider                                             varchar(25),
    provider_id                                              varchar(255),
    provider_token                                           varchar(255),
    remember_token                                           varchar(100),
    updated_at                                               timestamp(0) default CURRENT_TIMESTAMP                  not null,
    created_at                                               timestamp(0) default CURRENT_TIMESTAMP                  not null,
    refresh_token                                            varchar(255),
    unsubscribed                                             boolean      default false,
    old_user                                                 boolean      default false,
    stripe_active                                            boolean      default false,
    stripe_id                                                varchar(255),
    stripe_subscription                                      varchar(255),
    stripe_plan                                              varchar(100),
    last_four                                                varchar(4),
    trial_ends_at                                            timestamp(0),
    subscription_ends_at                                     timestamp(0),
    roles                                                    varchar(255),
    time_zone_offset                                         integer,
    deleted_at                                               timestamp(0),
    earliest_reminder_time                                   time(0)      default '07:00:00'::time without time zone not null,
    latest_reminder_time                                     time(0)      default '21:00:00'::time without time zone not null,
    push_notifications_enabled                               boolean      default true,
    track_location                                           boolean      default false,
    combine_notifications                                    boolean      default false,
    send_reminder_notification_emails                        boolean      default false,
    send_predictor_emails                                    boolean      default true,
    get_preview_builds                                       boolean      default false,
    subscription_provider                                    varchar(255)
        constraint wp_users_subscription_provider_check
            check ((subscription_provider)::text = ANY
                   ((ARRAY ['stripe'::character varying, 'apple'::character varying, 'google'::character varying])::text[])),
    last_sms_tracking_reminder_notification_id               bigint,
    sms_notifications_enabled                                boolean      default false,
    phone_verification_code                                  varchar(25),
    phone_number                                             varchar(25),
    has_android_app                                          boolean      default false,
    has_ios_app                                              boolean      default false,
    has_chrome_extension                                     boolean      default false,
    referrer_user_id                                         bigint
        constraint "wp_users_wp_users_ID_fk"
            references wp_users,
    address                                                  varchar(255),
    birthday                                                 varchar(255),
    country                                                  varchar(255),
    cover_photo                                              varchar(2083),
    currency                                                 varchar(255),
    first_name                                               varchar(255),
    gender                                                   varchar(255),
    language                                                 varchar(255),
    last_name                                                varchar(255),
    state                                                    varchar(255),
    tag_line                                                 varchar(255),
    verified                                                 varchar(255),
    zip_code                                                 varchar(255),
    card_brand                                               varchar(255),
    card_last_four                                           varchar(4),
    last_login_at                                            timestamp(0),
    timezone                                                 varchar(255),
    number_of_correlations                                   integer,
    number_of_connections                                    integer,
    number_of_tracking_reminders                             integer,
    number_of_user_variables                                 integer,
    number_of_raw_measurements_with_tags                     integer,
    number_of_raw_measurements_with_tags_at_last_correlation integer,
    number_of_votes                                          integer,
    number_of_studies                                        integer,
    last_correlation_at                                      timestamp(0),
    last_email_at                                            timestamp(0),
    last_push_at                                             timestamp(0),
    primary_outcome_variable_id                              integer
        constraint wp_users_variables_id_fk
            references variables,
    spam                                                     smallint     default '0'::smallint                      not null,
    deleted                                                  smallint     default '0'::smallint                      not null,
    wp_post_id                                               bigint
        constraint "wp_users_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete set null,
    analysis_ended_at                                        timestamp(0),
    analysis_requested_at                                    timestamp(0),
    analysis_started_at                                      timestamp(0),
    internal_error_message                                   text,
    newest_data_at                                           timestamp(0),
    reason_for_analysis                                      varchar(255),
    user_error_message                                       text,
    status                                                   varchar(25),
    analysis_settings_modified_at                            timestamp(0),
    number_of_applications                                   integer,
    number_of_oauth_access_tokens                            integer,
    number_of_oauth_authorization_codes                      integer,
    number_of_oauth_clients                                  integer,
    number_of_oauth_refresh_tokens                           integer,
    number_of_button_clicks                                  integer,
    number_of_collaborators                                  integer,
    number_of_connector_imports                              integer,
    number_of_connector_requests                             integer,
    number_of_measurement_exports                            integer,
    number_of_measurement_imports                            integer,
    number_of_measurements                                   integer,
    number_of_sent_emails                                    integer,
    number_of_subscriptions                                  integer,
    number_of_tracking_reminder_notifications                integer,
    number_of_user_tags                                      integer,
    number_of_users_where_referrer_user                      integer,
    share_all_data                                           boolean      default false                              not null,
    deletion_reason                                          varchar(280),
    password                                                 varchar(255),
    number_of_patients                                       integer,
    is_public                                                boolean,
    sort_order                                               integer,
    slug                                                     varchar(200)
        constraint wp_users_slug_uindex
            unique,
    number_of_sharers                                        integer,
    number_of_trustees                                       integer,
    eth_address                                              varchar(255)
);

comment on column wp_users."ID" is 'Unique number assigned to each user.';

comment on column wp_users.user_login is 'Unique username for the user.';

comment on column wp_users.user_email is 'Email address of the user.';

comment on column wp_users.email is 'Needed for laravel password resets because WP user_email field will not work';

comment on column wp_users.user_pass is 'Hash of the user’s password.';

comment on column wp_users.user_nicename is 'Display name for the user.';

comment on column wp_users.user_registered is 'Time and date the user registered.';

comment on column wp_users.user_activation_key is 'Used for resetting passwords.';

comment on column wp_users.user_status is 'Was used in Multisite pre WordPress 3.0 to indicate a spam user.';

comment on column wp_users.display_name is 'Desired name to be used publicly in the site, can be user_login, user_nicename, first name or last name defined in wp_usermeta.';

comment on column wp_users.reg_provider is 'Registered via';

comment on column wp_users.provider_id is 'Unique id from provider';

comment on column wp_users.provider_token is 'Access token from provider';

comment on column wp_users.remember_token is 'Remember me token';

comment on column wp_users.refresh_token is 'Refresh token from provider';

comment on column wp_users.unsubscribed is 'Indicates whether the use has specified that they want no emails or any form of communication. ';

comment on column wp_users.roles is 'An array containing all roles possessed by the user.  This indicates whether the use has roles such as administrator, developer, patient, student, researcher or physician. ';

comment on column wp_users.time_zone_offset is 'The time-zone offset is the difference, in minutes, between UTC and local time. Note that this means that the offset is positive if the local timezone is behind UTC (i.e. UTC−06:00 Central) and negative if it is ahead.';

comment on column wp_users.earliest_reminder_time is 'Earliest time of day at which reminders should appear in HH:MM:SS format in user timezone';

comment on column wp_users.latest_reminder_time is 'Latest time of day at which reminders should appear in HH:MM:SS format in user timezone';

comment on column wp_users.push_notifications_enabled is 'Should we send the user push notifications?';

comment on column wp_users.track_location is 'Set to true if the user wants to track their location';

comment on column wp_users.combine_notifications is 'Should we combine push notifications or send one for each tracking reminder notification?';

comment on column wp_users.send_reminder_notification_emails is 'Should we send reminder notification emails?';

comment on column wp_users.send_predictor_emails is 'Should we send predictor emails?';

comment on column wp_users.get_preview_builds is 'Should we send preview builds of the mobile application?';

comment on column wp_users.sms_notifications_enabled is 'Should we send tracking reminder notifications via tex messages?';

comment on column wp_users.number_of_applications is 'Number of Applications for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from applications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_applications = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_oauth_access_tokens is 'Number of OAuth Access Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(access_token) as total, user_id
                            from oa_access_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_oauth_authorization_codes is 'Number of OAuth Authorization Codes for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(authorization_code) as total, user_id
                            from oa_authorization_codes
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_oauth_clients is 'Number of OAuth Clients for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(client_id) as total, user_id
                            from oa_clients
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_clients = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_oauth_refresh_tokens is 'Number of OAuth Refresh Tokens for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(refresh_token) as total, user_id
                            from oa_refresh_tokens
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_button_clicks is 'Number of Button Clicks for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from button_clicks
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_button_clicks = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_collaborators is 'Number of Collaborators for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from collaborators
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_collaborators = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_connector_imports is 'Number of Connector Imports for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_imports = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_connector_requests is 'Number of Connector Requests for this User.
                [Formula:
                    update wp_users
                        left join (
                            select count(id) as total, user_id
                            from connector_requests
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_connector_requests = count(grouped.total)
                ]
                ';

comment on column wp_users.number_of_measurement_exports is 'Number of Measurement Exports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_exports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_exports = count(grouped.total)]';

comment on column wp_users.number_of_measurement_imports is 'Number of Measurement Imports for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurement_imports
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurement_imports = count(grouped.total)]';

comment on column wp_users.number_of_measurements is 'Number of Measurements for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from measurements
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_measurements = count(grouped.total)]';

comment on column wp_users.number_of_sent_emails is 'Number of Sent Emails for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from sent_emails
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_sent_emails = count(grouped.total)]';

comment on column wp_users.number_of_subscriptions is 'Number of Subscriptions for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from subscriptions
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_subscriptions = count(grouped.total)]';

comment on column wp_users.number_of_tracking_reminder_notifications is 'Number of Tracking Reminder Notifications for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from tracking_reminder_notifications
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_tracking_reminder_notifications = count(grouped.total)]';

comment on column wp_users.number_of_user_tags is 'Number of User Tags for this User.
                    [Formula: update wp_users
                        left join (
                            select count(id) as total, user_id
                            from user_tags
                            group by user_id
                        )
                        as grouped on wp_users.ID = grouped.user_id
                    set wp_users.number_of_user_tags = count(grouped.total)]';

comment on column wp_users.number_of_users_where_referrer_user is 'Number of Users for this Referrer User.
                    [Formula: update wp_users
                        left join (
                            select count(ID) as total, referrer_user_id
                            from wp_users
                            group by referrer_user_id
                        )
                        as grouped on wp_users.ID = grouped.referrer_user_id
                    set wp_users.number_of_users_where_referrer_user = count(grouped.total)]';

comment on column wp_users.deletion_reason is 'The reason the user deleted their account.';

comment on column wp_users.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column wp_users.number_of_sharers is 'Number of people sharing their data with you.';

comment on column wp_users.number_of_trustees is 'Number of people that you are sharing your data with.';

alter table wp_users
    owner to postgres;

create index user_nicename
    on wp_users (user_nicename);

create index "wp_users_wp_users_ID_fk"
    on wp_users (referrer_user_id);

create index wp_users_variables_id_fk
    on wp_users (primary_outcome_variable_id);

create index "wp_users_wp_posts_ID_fk"
    on wp_users (wp_post_id);

create index wp_users_eth_address_index
    on wp_users (eth_address);

