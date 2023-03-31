create table applications
(
    id                                serial
        primary key,
    organization_id                   integer,
    client_id                         varchar(80)                            not null
        constraint applications_client_id_unique
            unique
        constraint applications_client_id_fk
            references oa_clients,
    app_display_name                  varchar(255)                           not null,
    app_description                   varchar(255),
    long_description                  text,
    user_id                           bigint                                 not null
        constraint applications_user_id_fk
            references wp_users,
    icon_url                          varchar(2083),
    text_logo                         varchar(2083),
    splash_screen                     varchar(2083),
    homepage_url                      varchar(255),
    app_type                          varchar(32),
    app_design                        text,
    created_at                        timestamp(0) default CURRENT_TIMESTAMP not null,
    updated_at                        timestamp(0) default CURRENT_TIMESTAMP not null,
    deleted_at                        timestamp(0),
    enabled                           smallint     default '1'::smallint     not null,
    stripe_active                     smallint     default '0'::smallint     not null,
    stripe_id                         varchar(255),
    stripe_subscription               varchar(255),
    stripe_plan                       varchar(100),
    last_four                         varchar(4),
    trial_ends_at                     timestamp(0),
    subscription_ends_at              timestamp(0),
    company_name                      varchar(100),
    country                           varchar(100),
    address                           varchar(255),
    state                             varchar(100),
    city                              varchar(100),
    zip                               varchar(10),
    plan_id                           integer,
    exceeding_call_count              integer      default 0                 not null,
    exceeding_call_charge             numeric(16, 2),
    study                             smallint     default '0'::smallint     not null,
    billing_enabled                   smallint     default '1'::smallint     not null,
    outcome_variable_id               integer
        constraint applications_outcome_variable_id_fk
            references variables,
    predictor_variable_id             integer
        constraint applications_predictor_variable_id_fk
            references variables,
    physician                         smallint     default '0'::smallint     not null,
    additional_settings               text,
    app_status                        text,
    build_enabled                     boolean      default false             not null,
    wp_post_id                        bigint
        constraint "applications_wp_posts_ID_fk"
            references wp_posts,
    number_of_collaborators_where_app integer,
    is_public                         boolean,
    sort_order                        integer,
    slug                              varchar(200)
        constraint applications_slug_uindex
            unique
);

comment on column applications.app_status is 'The current build status for the iOS app, Android app, and Chrome extension.';

comment on column applications.number_of_collaborators_where_app is 'Number of Collaborators for this App.
                [Formula:
                    update applications
                        left join (
                            select count(id) as total, app_id
                            from collaborators
                            group by app_id
                        )
                        as grouped on applications.id = grouped.app_id
                    set applications.number_of_collaborators_where_app = count(grouped.total)
                ]
                ';

comment on column applications.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table applications
    owner to postgres;

create index applications_user_id_fk
    on applications (user_id);

create index applications_outcome_variable_id_fk
    on applications (outcome_variable_id);

create index applications_predictor_variable_id_fk
    on applications (predictor_variable_id);

create index "applications_wp_posts_ID_fk"
    on applications (wp_post_id);

