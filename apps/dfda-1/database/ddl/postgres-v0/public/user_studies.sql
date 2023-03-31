create table user_studies
(
    id                            varchar(80)                                       not null
        primary key,
    cause_variable_id             integer                                           not null
        constraint user_studies_cause_variables_id_fk
            references variables,
    effect_variable_id            integer                                           not null
        constraint user_studies_effect_variables_id_fk
            references variables,
    cause_user_variable_id        integer                                           not null
        constraint user_studies_cause_user_variables_id_fk
            references user_variables,
    effect_user_variable_id       integer                                           not null
        constraint user_studies_effect_user_variables_id_fk
            references user_variables,
    correlation_id                integer
        constraint user_studies_correlation_id_uindex
            unique
        constraint user_studies_correlations_id_fk
            references correlations,
    user_id                       bigint                                            not null
        constraint user_studies_user_id_fk
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
    client_id                     varchar(255),
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
    is_public                     boolean,
    sort_order                    integer,
    slug                          varchar(200)
        constraint user_studies_slug_uindex
            unique,
    constraint user_studies_user_cause_effect
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column user_studies.id is 'Study id which should match OAuth client id';

comment on column user_studies.cause_variable_id is 'variable ID of the cause variable for which the user desires correlations';

comment on column user_studies.effect_variable_id is 'variable ID of the effect variable for which the user desires correlations';

comment on column user_studies.cause_user_variable_id is 'variable ID of the cause variable for which the user desires correlations';

comment on column user_studies.effect_user_variable_id is 'variable ID of the effect variable for which the user desires correlations';

comment on column user_studies.correlation_id is 'ID of the correlation statistics';

comment on column user_studies.analysis_parameters is 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value';

comment on column user_studies.user_study_text is 'Overrides auto-generated study text';

comment on column user_studies.study_images is 'Provided images will override the auto-generated images';

comment on column user_studies.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table user_studies
    owner to postgres;

create index user_studies_cause_variables_id_fk
    on user_studies (cause_variable_id);

create index user_studies_effect_variables_id_fk
    on user_studies (effect_variable_id);

create index user_studies_cause_user_variables_id_fk
    on user_studies (cause_user_variable_id);

create index user_studies_effect_user_variables_id_fk
    on user_studies (effect_user_variable_id);

