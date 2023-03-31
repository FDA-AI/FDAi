create table cohort_studies
(
    id                            integer                                           not null
        primary key,
    cohort_study_statistics_id    integer,
    cause_variable_id             integer                                           not null
        constraint cohort_studies_cause_variable_id_variables_id_fk
            references variables,
    effect_variable_id            integer                                           not null
        constraint cohort_studies_effect_variable_id_variables_id_fk
            references variables,
    user_id                       bigint                                            not null
        constraint cohort_studies_user_id_fk
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
        constraint cohort_studies_client_id_fk
            references oa_clients,
    published_at                  timestamp(0),
    wp_post_id                    integer,
    cohort_correlation_id         integer,
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
        constraint cohort_studies_slug_uindex
            unique,
    constraint user_cause_effect
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column cohort_studies.id is 'Unique ID for the cohort study';

comment on column cohort_studies.cohort_study_statistics_id is 'ID of associated analytical results';

comment on column cohort_studies.cause_variable_id is 'Variable ID of the predictor variable';

comment on column cohort_studies.effect_variable_id is 'Variable ID of the outcome variable';

comment on column cohort_studies.user_id is 'User ID of the principal investigator for the study';

comment on column cohort_studies.analysis_parameters is 'Additional parameters for the study such as experiment_end_time, experiment_start_time, cause_variable_filling_value, effect_variable_filling_value';

comment on column cohort_studies.user_study_text is 'Overrides auto-generated study text';

comment on column cohort_studies.study_images is 'Provided images will override the auto-generated images';

comment on column cohort_studies.is_public is 'Indicates whether the study is private or should be publicly displayed.';

comment on column cohort_studies.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

alter table cohort_studies
    owner to postgres;

create index cohort_studies_cause_variable_id
    on cohort_studies (cause_variable_id);

create index effect_variable_id
    on cohort_studies (effect_variable_id);

create index cause_variable_id
    on cohort_studies (cause_variable_id);

create index cohort_studies_effect_variable_id
    on cohort_studies (effect_variable_id);

create index cohort_studies_client_id_fk
    on cohort_studies (client_id);

