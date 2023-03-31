create table user_variables
(
    id                                                   serial
        primary key,
    parent_id                                            integer,
    client_id                                            varchar(80)
        constraint user_variables_client_id_fk
            references oa_clients,
    user_id                                              bigint                                     not null
        constraint user_variables_user_id_fk
            references wp_users,
    variable_id                                          integer                                    not null
        constraint user_variables_variables_id_fk
            references variables,
    default_unit_id                                      smallint
        constraint user_variables_default_unit_id_fk
            references units,
    minimum_allowed_value                                double precision,
    maximum_allowed_value                                double precision,
    filling_value                                        double precision default '-1'::double precision,
    join_with                                            integer,
    onset_delay                                          integer,
    duration_of_action                                   integer,
    variable_category_id                                 smallint
        constraint user_variables_variable_category_id_fk
            references variable_categories,
    cause_only                                           boolean,
    filling_type                                         varchar(255)
        constraint user_variables_filling_type_check
            check ((filling_type)::text = ANY
                   ((ARRAY ['value'::character varying, 'none'::character varying, null])::text[])),
    number_of_processed_daily_measurements               integer,
    measurements_at_last_analysis                        integer          default 0                 not null,
    last_unit_id                                         smallint
        constraint user_variables_last_unit_id_fk
            references units,
    last_original_unit_id                                smallint,
    last_value                                           double precision,
    last_original_value                                  double precision,
    number_of_correlations                               integer,
    status                                               varchar(25),
    standard_deviation                                   double precision,
    variance                                             double precision,
    minimum_recorded_value                               double precision,
    maximum_recorded_value                               double precision,
    mean                                                 double precision,
    median                                               double precision,
    most_common_original_unit_id                         integer,
    most_common_value                                    double precision,
    number_of_unique_daily_values                        integer,
    number_of_unique_values                              integer,
    number_of_changes                                    integer,
    skewness                                             double precision,
    kurtosis                                             double precision,
    latitude                                             double precision,
    longitude                                            double precision,
    location                                             varchar(255),
    created_at                                           timestamp(0)     default CURRENT_TIMESTAMP not null,
    updated_at                                           timestamp(0)     default CURRENT_TIMESTAMP not null,
    outcome                                              boolean,
    data_sources_count                                   text,
    earliest_filling_time                                integer,
    latest_filling_time                                  integer,
    last_processed_daily_value                           double precision,
    outcome_of_interest                                  boolean          default false,
    predictor_of_interest                                boolean          default false,
    experiment_start_time                                timestamp(0),
    experiment_end_time                                  timestamp(0),
    description                                          text,
    deleted_at                                           timestamp(0),
    alias                                                varchar(125),
    second_to_last_value                                 double precision,
    third_to_last_value                                  double precision,
    number_of_user_correlations_as_effect                integer,
    number_of_user_correlations_as_cause                 integer,
    combination_operation                                varchar(255)
        constraint user_variables_combination_operation_check
            check ((combination_operation)::text = ANY
                   ((ARRAY ['SUM'::character varying, 'MEAN'::character varying])::text[])),
    informational_url                                    varchar(2000),
    most_common_connector_id                             integer,
    valence                                              varchar(255)
        constraint user_variables_valence_check
            check ((valence)::text = ANY
                   ((ARRAY ['positive'::character varying, 'negative'::character varying, 'neutral'::character varying])::text[])),
    wikipedia_title                                      varchar(100),
    number_of_tracking_reminders                         integer                                    not null,
    number_of_raw_measurements_with_tags_joins_children  integer,
    most_common_source_name                              varchar(255),
    optimal_value_message                                varchar(500),
    best_cause_variable_id                               integer,
    best_effect_variable_id                              integer,
    user_maximum_allowed_daily_value                     double precision,
    user_minimum_allowed_daily_value                     double precision,
    user_minimum_allowed_non_zero_value                  double precision,
    minimum_allowed_seconds_between_measurements         integer,
    average_seconds_between_measurements                 integer,
    median_seconds_between_measurements                  integer,
    last_correlated_at                                   timestamp(0),
    number_of_measurements_with_tags_at_last_correlation integer,
    analysis_settings_modified_at                        timestamp(0),
    newest_data_at                                       timestamp(0),
    analysis_requested_at                                timestamp(0),
    reason_for_analysis                                  varchar(255),
    analysis_started_at                                  timestamp(0),
    analysis_ended_at                                    timestamp(0),
    user_error_message                                   text,
    internal_error_message                               text,
    earliest_source_measurement_start_at                 timestamp(0),
    latest_source_measurement_start_at                   timestamp(0),
    latest_tagged_measurement_start_at                   timestamp(0),
    earliest_tagged_measurement_start_at                 timestamp(0),
    latest_non_tagged_measurement_start_at               timestamp(0),
    earliest_non_tagged_measurement_start_at             timestamp(0),
    wp_post_id                                           bigint,
    number_of_soft_deleted_measurements                  integer,
    best_user_correlation_id                             integer
        constraint user_variables_correlations_qm_score_fk
            references correlations
            on delete set null,
    number_of_measurements                               integer,
    number_of_tracking_reminder_notifications            integer,
    deletion_reason                                      varchar(280),
    record_size_in_kb                                    integer,
    number_of_common_tags                                integer,
    number_common_tagged_by                              integer,
    number_of_common_joined_variables                    integer,
    number_of_common_ingredients                         integer,
    number_of_common_foods                               integer,
    number_of_common_children                            integer,
    number_of_common_parents                             integer,
    number_of_user_tags                                  integer,
    number_user_tagged_by                                integer,
    number_of_user_joined_variables                      integer,
    number_of_user_ingredients                           integer,
    number_of_user_foods                                 integer,
    number_of_user_children                              integer,
    number_of_user_parents                               integer,
    is_public                                            boolean,
    slug                                                 varchar(200)
        constraint user_variables_slug_uindex
            unique,
    is_goal                                              boolean,
    controllable                                         boolean,
    boring                                               boolean,
    predictor                                            boolean,
    constraint uv_user_id
        unique (user_id, variable_id)
);

comment on column user_variables.parent_id is 'ID of the parent variable if this variable has any parent';

comment on column user_variables.variable_id is 'ID of variable';

comment on column user_variables.default_unit_id is 'ID of unit to use for this variable';

comment on column user_variables.minimum_allowed_value is 'Minimum reasonable value for this variable (uses default unit)';

comment on column user_variables.maximum_allowed_value is 'Maximum reasonable value for this variable (uses default unit)';

comment on column user_variables.filling_value is 'Value for replacing null measurements';

comment on column user_variables.join_with is 'The Variable this Variable should be joined with. If the variable is joined with some other variable then it is not shown to user in the list of variables';

comment on column user_variables.duration_of_action is 'Estimated duration of time following the onset delay in which a stimulus produces a perceivable effect';

comment on column user_variables.variable_category_id is 'ID of variable category';

comment on column user_variables.cause_only is 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user';

comment on column user_variables.filling_type is '0 -> No filling, 1 -> Use filling-value';

comment on column user_variables.number_of_processed_daily_measurements is 'Number of processed measurements';

comment on column user_variables.last_original_unit_id is 'ID of last original Unit';

alter table user_variables
    owner to postgres;

create index user_variables_client_id_fk
    on user_variables (client_id);

create index user_variables_user_id_latest_tagged_measurement_time_index
    on user_variables (user_id);

create index "fk_variableSettings"
    on user_variables (variable_id);

create index user_variables_default_unit_id_fk
    on user_variables (default_unit_id);

create index user_variables_variable_category_id_fk
    on user_variables (variable_category_id);

create index user_variables_analysis_started_at_index
    on user_variables (analysis_started_at);

create index "user_variables_wp_posts_ID_fk"
    on user_variables (wp_post_id);

create index user_variables_correlations_qm_score_fk
    on user_variables (best_user_correlation_id);

