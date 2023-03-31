create table studies
(
    id                            varchar(80)                                       not null
        primary key,
    type                          varchar(20)                                       not null,
    cause_variable_id             integer                                           not null
        constraint studies_cause_variable_id_variables_id_fk
            references variables,
    effect_variable_id            integer                                           not null
        constraint studies_effect_variable_id_variables_id_fk
            references variables,
    user_id                       bigint                                            not null
        constraint studies_user_id_fk
            references wp_users,
    created_at                    timestamp(0) default CURRENT_TIMESTAMP            not null,
    deleted_at                    timestamp(0),
    analysis_parameters           text,
    user_study_text               text,
    user_title                    text,
    study_status                  varchar(20)  default 'publish'::character varying not null,
    comment_status                varchar(20)  default 'open'::character varying    not null,
    study_password                varchar(20),
    study_images                  text,
    updated_at                    timestamp(0) default CURRENT_TIMESTAMP            not null,
    client_id                     varchar(255)
        constraint studies_client_id_fk
            references oa_clients,
    published_at                  timestamp(0),
    wp_post_id                    integer,
    newest_data_at                timestamp(0),
    analysis_requested_at         timestamp(0),
    reason_for_analysis           varchar(255),
    analysis_ended_at             timestamp(0),
    analysis_started_at           timestamp(0),
    internal_error_message        varchar(255),
    user_error_message            varchar(255),
    status                        varchar(25),
    analysis_settings_modified_at timestamp(0),
    is_public                     boolean                                           not null,
    sort_order                    integer,
    slug                          varchar(200)
        constraint studies_slug_uindex
            unique,
    constraint user_cause_effect_type
        unique (user_id, cause_variable_id, effect_variable_id, type)
);

comment on column studies.id is 'Study id which should match OAuth client id';

comment on column studies.type is 'The type of study may be population, individual, or cohort study';

comment on column studies.cause_variable_id is 'variable ID of the cause variable for which the user desires correlations';

comment on column studies.effect_variable_id is 'variable ID of the effect variable for which the user desires correlations';

comment on column studies.analysis_parameters is 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value';

comment on column studies.user_study_text is 'Overrides auto-generated study text';

comment on column studies.study_images is 'Provided images will override the auto-generated images';

comment on column studies.is_public is 'Indicates whether the study is private or should be publicly displayed.';

comment on column studies.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table studies
    owner to postgres;

create index studies_cause_variable_id
    on studies (cause_variable_id);

create index studies_effect_variable_id
    on studies (effect_variable_id);

create index studies_client_id_fk
    on studies (client_id);

