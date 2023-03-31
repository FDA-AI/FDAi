create table oa_clients
(
    client_id                                 varchar(80)                            not null
        primary key,
    client_secret                             varchar(80)                            not null,
    redirect_uri                              varchar(2000),
    grant_types                               varchar(80),
    user_id                                   bigint                                 not null
        constraint bshaffer_oauth_clients_user_id_fk
            references wp_users,
    created_at                                timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                                timestamp(0) default CURRENT_TIMESTAMP not null,
    icon_url                                  varchar(2083),
    app_identifier                            varchar(255),
    deleted_at                                timestamp(0),
    earliest_measurement_start_at             timestamp(0),
    latest_measurement_start_at               timestamp(0),
    number_of_aggregate_correlations          integer,
    number_of_applications                    integer,
    number_of_oauth_access_tokens             integer,
    number_of_oauth_authorization_codes       integer,
    number_of_oauth_refresh_tokens            integer,
    number_of_button_clicks                   integer,
    number_of_collaborators                   integer,
    number_of_common_tags                     integer,
    number_of_connections                     integer,
    number_of_connector_imports               integer,
    number_of_connectors                      integer,
    number_of_correlations                    integer,
    number_of_measurement_exports             integer,
    number_of_measurement_imports             integer,
    number_of_measurements                    integer,
    number_of_sent_emails                     integer,
    number_of_studies                         integer,
    number_of_tracking_reminder_notifications integer,
    number_of_tracking_reminders              integer,
    number_of_user_tags                       integer,
    number_of_user_variables                  integer,
    number_of_variables                       integer,
    number_of_votes                           integer
);

comment on column oa_clients.number_of_aggregate_correlations is 'Number of Global Population Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from aggregate_correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_aggregate_correlations = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_applications is 'Number of Applications for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from applications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_applications = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_oauth_access_tokens is 'Number of OAuth Access Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(access_token) as total, client_id
                            from bshaffer_oauth_access_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_access_tokens = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_oauth_authorization_codes is 'Number of OAuth Authorization Codes for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(authorization_code) as total, client_id
                            from bshaffer_oauth_authorization_codes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_authorization_codes = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_oauth_refresh_tokens is 'Number of OAuth Refresh Tokens for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(refresh_token) as total, client_id
                            from bshaffer_oauth_refresh_tokens
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_oauth_refresh_tokens = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_button_clicks is 'Number of Button Clicks for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from button_clicks
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_button_clicks = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_collaborators is 'Number of Collaborators for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from collaborators
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_collaborators = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_common_tags is 'Number of Common Tags for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from common_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_common_tags = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_connections is 'Number of Connections for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connections
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connections = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_connector_imports is 'Number of Connector Imports for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connector_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connector_imports = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_connectors is 'Number of Connectors for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from connectors
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_connectors = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_correlations is 'Number of Individual Case Studies for this Client.
                [Formula:
                    update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from correlations
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_correlations = count(grouped.total)
                ]
                ';

comment on column oa_clients.number_of_measurement_exports is 'Number of Measurement Exports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_exports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_exports = count(grouped.total)]';

comment on column oa_clients.number_of_measurement_imports is 'Number of Measurement Imports for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurement_imports
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurement_imports = count(grouped.total)]';

comment on column oa_clients.number_of_measurements is 'Number of Measurements for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from measurements
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_measurements = count(grouped.total)]';

comment on column oa_clients.number_of_sent_emails is 'Number of Sent Emails for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from sent_emails
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_sent_emails = count(grouped.total)]';

comment on column oa_clients.number_of_studies is 'Number of Studies for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from studies
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_studies = count(grouped.total)]';

comment on column oa_clients.number_of_tracking_reminder_notifications is 'Number of Tracking Reminder Notifications for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminder_notifications
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminder_notifications = count(grouped.total)]';

comment on column oa_clients.number_of_tracking_reminders is 'Number of Tracking Reminders for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from tracking_reminders
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_tracking_reminders = count(grouped.total)]';

comment on column oa_clients.number_of_user_tags is 'Number of User Tags for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_tags
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_tags = count(grouped.total)]';

comment on column oa_clients.number_of_user_variables is 'Number of User Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from user_variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_user_variables = count(grouped.total)]';

comment on column oa_clients.number_of_variables is 'Number of Variables for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from variables
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_variables = count(grouped.total)]';

comment on column oa_clients.number_of_votes is 'Number of Votes for this Client.
                    [Formula: update bshaffer_oauth_clients
                        left join (
                            select count(id) as total, client_id
                            from votes
                            group by client_id
                        )
                        as grouped on bshaffer_oauth_clients.client_id = grouped.client_id
                    set bshaffer_oauth_clients.number_of_votes = count(grouped.total)]';

alter table oa_clients
    owner to postgres;

create index bshaffer_oauth_clients_user_id_fk
    on oa_clients (user_id);

