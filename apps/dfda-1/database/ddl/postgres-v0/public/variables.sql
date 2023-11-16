create table variables
(
    id                                                  serial
        primary key,
    name                                                varchar(125)                                          not null
        constraint "variables_name_UNIQUE"
            unique,
    number_of_user_variables                            integer          default 0                            not null,
    variable_category_id                                smallint                                              not null
        constraint variables_variable_category_id_fk
            references variable_categories,
    default_unit_id                                     smallint                                              not null
        constraint variables_default_unit_id_fk
            references units,
    default_value                                       double precision,
    cause_only                                          boolean,
    client_id                                           varchar(80)
        constraint variables_client_id_fk
            references oa_clients,
    combination_operation                               varchar(255)
        constraint variables_combination_operation_check
            check ((combination_operation)::text = ANY
                   ((ARRAY ['SUM'::character varying, 'MEAN'::character varying])::text[])),
    common_alias                                        varchar(125),
    created_at                                          timestamp(0)     default CURRENT_TIMESTAMP            not null,
    description                                         text,
    duration_of_action                                  integer,
    filling_value                                       double precision default '-1'::double precision,
    image_url                                           varchar(2083),
    informational_url                                   varchar(2083),
    ion_icon                                            varchar(40),
    kurtosis                                            double precision,
    maximum_allowed_value                               double precision,
    maximum_recorded_value                              double precision,
    mean                                                double precision,
    median                                              double precision,
    minimum_allowed_value                               double precision,
    minimum_recorded_value                              double precision,
    number_of_global_variable_relationships_as_cause           integer,
    most_common_original_unit_id                        integer,
    most_common_value                                   double precision,
    number_of_global_variable_relationships_as_effect          integer,
    number_of_unique_values                             integer,
    onset_delay                                         integer,
    outcome                                             boolean,
    parent_id                                           integer,
    price                                               double precision,
    product_url                                         varchar(2083),
    second_most_common_value                            double precision,
    skewness                                            double precision,
    standard_deviation                                  double precision,
    status                                              varchar(25)      default 'WAITING'::character varying not null,
    third_most_common_value                             double precision,
    updated_at                                          timestamp(0)     default CURRENT_TIMESTAMP            not null,
    variance                                            double precision,
    most_common_connector_id                            integer,
    synonyms                                            varchar(600),
    wikipedia_url                                       varchar(2083),
    brand_name                                          varchar(125),
    valence                                             varchar(255)
        constraint variables_valence_check
            check ((valence)::text = ANY
                   ((ARRAY ['positive'::character varying, 'negative'::character varying, 'neutral'::character varying])::text[])),
    wikipedia_title                                     varchar(100),
    number_of_tracking_reminders                        integer,
    upc_12                                              varchar(255),
    upc_14                                              varchar(255),
    number_common_tagged_by                             integer,
    number_of_common_tags                               integer,
    deleted_at                                          timestamp(0),
    most_common_source_name                             varchar(255),
    data_sources_count                                  text,
    optimal_value_message                               varchar(500),
    best_cause_variable_id                              integer
        constraint variables_best_cause_variable_id_fk
            references variables
            on delete set null,
    best_effect_variable_id                             integer
        constraint variables_best_effect_variable_id_fk
            references variables
            on delete set null,
    common_maximum_allowed_daily_value                  double precision,
    common_minimum_allowed_daily_value                  double precision,
    common_minimum_allowed_non_zero_value               double precision,
    minimum_allowed_seconds_between_measurements        integer,
    average_seconds_between_measurements                integer,
    median_seconds_between_measurements                 integer,
    number_of_raw_measurements_with_tags_joins_children integer,
    additional_meta_data                                text,
    manual_tracking                                     boolean,
    analysis_settings_modified_at                       timestamp(0),
    newest_data_at                                      timestamp(0),
    analysis_requested_at                               timestamp(0),
    reason_for_analysis                                 varchar(255),
    analysis_started_at                                 timestamp(0),
    analysis_ended_at                                   timestamp(0),
    user_error_message                                  text,
    internal_error_message                              text,
    latest_tagged_measurement_start_at                  timestamp(0),
    earliest_tagged_measurement_start_at                timestamp(0),
    latest_non_tagged_measurement_start_at              timestamp(0),
    earliest_non_tagged_measurement_start_at            timestamp(0),
    wp_post_id                                          bigint
        constraint "variables_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete set null,
    number_of_soft_deleted_measurements                 integer,
    charts                                              json,
    creator_user_id                                     bigint                                                not null,
    best_global_variable_relationship_id                       integer
        constraint variables_global_variable_relationships_id_fk
            references global_variable_relationships
            on delete set null,
    filling_type                                        varchar(255)
        constraint variables_filling_type_check
            check ((filling_type)::text = ANY
                   ((ARRAY ['zero'::character varying, 'none'::character varying, 'interpolation'::character varying, 'value'::character varying])::text[])),
    number_of_outcome_population_studies                integer,
    number_of_predictor_population_studies              integer,
    number_of_applications_where_outcome_variable       integer,
    number_of_applications_where_predictor_variable     integer,
    number_of_common_tags_where_tag_variable            integer,
    number_of_common_tags_where_tagged_variable         integer,
    number_of_outcome_case_studies                      integer,
    number_of_measurements                              integer,
    number_of_predictor_case_studies                    integer,
    number_of_studies_where_cause_variable              integer,
    number_of_studies_where_effect_variable             integer,
    number_of_tracking_reminder_notifications           integer,
    number_of_user_tags_where_tag_variable              integer,
    number_of_user_tags_where_tagged_variable           integer,
    number_of_variables_where_best_cause_variable       integer,
    number_of_variables_where_best_effect_variable      integer,
    number_of_votes_where_cause_variable                integer,
    number_of_votes_where_effect_variable               integer,
    number_of_users_where_primary_outcome_variable      integer,
    deletion_reason                                     varchar(280),
    maximum_allowed_daily_value                         double precision,
    record_size_in_kb                                   integer,
    number_of_common_joined_variables                   integer,
    number_of_common_ingredients                        integer,
    number_of_common_foods                              integer,
    number_of_common_children                           integer,
    number_of_common_parents                            integer,
    number_of_user_joined_variables                     integer,
    number_of_user_ingredients                          integer,
    number_of_user_foods                                integer,
    number_of_user_children                             integer,
    number_of_user_parents                              integer,
    is_public                                           boolean,
    sort_order                                          integer,
    slug                                                varchar(200)
        constraint variables_slug_uindex
            unique,
    is_goal                                             boolean,
    controllable                                        boolean,
    boring                                              boolean,
    canonical_variable_id                               integer,
    predictor                                           boolean,
    source_url                                          varchar(2083)
);

comment on column variables.name is 'User-defined variable display name';

comment on column variables.number_of_user_variables is 'Number of variables';

comment on column variables.variable_category_id is 'Variable category ID';

comment on column variables.default_unit_id is 'ID of the default unit for the variable';

comment on column variables.cause_only is 'A value of 1 indicates that this variable is generally a cause in a causal relationship.  An example of a causeOnly variable would be a variable such as Cloud Cover which would generally not be influenced by the behaviour of the user';

comment on column variables.combination_operation is 'How to combine values of this variable (for instance, to see a summary of the values over a month) SUM or MEAN';

comment on column variables.duration_of_action is 'How long the effect of a measurement in this variable lasts';

comment on column variables.filling_value is 'Value for replacing null measurements';

comment on column variables.kurtosis is 'Kurtosis';

comment on column variables.maximum_allowed_value is 'Maximum reasonable value for a single measurement for this variable in the default unit. ';

comment on column variables.maximum_recorded_value is 'Maximum recorded value of this variable';

comment on column variables.mean is 'Mean';

comment on column variables.median is 'Median';

comment on column variables.minimum_allowed_value is 'Minimum reasonable value for this variable (uses default unit)';

comment on column variables.minimum_recorded_value is 'Minimum recorded value of this variable';

comment on column variables.number_of_global_variable_relationships_as_cause is 'Number of global variable relationships for which this variable is the cause variable';

comment on column variables.most_common_original_unit_id is 'Most common Unit ID';

comment on column variables.most_common_value is 'Most common value';

comment on column variables.number_of_global_variable_relationships_as_effect is 'Number of global variable relationships for which this variable is the effect variable';

comment on column variables.number_of_unique_values is 'Number of unique values';

comment on column variables.onset_delay is 'How long it takes for a measurement in this variable to take effect';

comment on column variables.outcome is 'Outcome variables (those with `outcome` == 1) are variables for which a human would generally want to identify the influencing factors.  These include symptoms of illness, physique, mood, cognitive performance, etc.  Generally correlation calculations are only performed on outcome variables.';

comment on column variables.parent_id is 'ID of the parent variable if this variable has any parent';

comment on column variables.price is 'Price';

comment on column variables.product_url is 'Product URL';

comment on column variables.skewness is 'Skewness';

comment on column variables.standard_deviation is 'Standard Deviation';

comment on column variables.status is 'status';

comment on column variables.variance is 'Variance';

comment on column variables.synonyms is 'The primary variable name and any synonyms for it. This field should be used for non-specific variable searches.';

comment on column variables.data_sources_count is 'Array of connector or client measurement data source names as key with number of users as value';

comment on column variables.number_of_soft_deleted_measurements is 'Formula: update variables v
                inner join (
                    select measurements.variable_id, count(measurements.id) as number_of_soft_deleted_measurements
                    from measurements
                    where measurements.deleted_at is not null
                    group by measurements.variable_id
                    ) m on v.id = m.variable_id
                set v.number_of_soft_deleted_measurements = m.number_of_soft_deleted_measurements
            ';

comment on column variables.number_of_outcome_population_studies is 'Number of Global Population Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from global_variable_relationships
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_population_studies = count(grouped.total)
                ]
                ';

comment on column variables.number_of_predictor_population_studies is 'Number of Global Population Studies for this Effect Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from global_variable_relationships
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_population_studies = count(grouped.total)
                ]
                ';

comment on column variables.number_of_applications_where_outcome_variable is 'Number of Applications for this Outcome Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, outcome_variable_id
                            from applications
                            group by outcome_variable_id
                        )
                        as grouped on variables.id = grouped.outcome_variable_id
                    set variables.number_of_applications_where_outcome_variable = count(grouped.total)
                ]
                ';

comment on column variables.number_of_applications_where_predictor_variable is 'Number of Applications for this Predictor Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, predictor_variable_id
                            from applications
                            group by predictor_variable_id
                        )
                        as grouped on variables.id = grouped.predictor_variable_id
                    set variables.number_of_applications_where_predictor_variable = count(grouped.total)
                ]
                ';

comment on column variables.number_of_common_tags_where_tag_variable is 'Number of Common Tags for this Tag Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from common_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_common_tags_where_tag_variable = count(grouped.total)
                ]
                ';

comment on column variables.number_of_common_tags_where_tagged_variable is 'Number of Common Tags for this Tagged Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from common_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_common_tags_where_tagged_variable = count(grouped.total)
                ]
                ';

comment on column variables.number_of_outcome_case_studies is 'Number of Individual Case Studies for this Cause Variable.
                [Formula:
                    update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from user_variable_relationships
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_outcome_case_studies = count(grouped.total)
                ]
                ';

comment on column variables.number_of_measurements is 'Number of Measurements for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from measurements
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_measurements = count(grouped.total)]';

comment on column variables.number_of_predictor_case_studies is 'Number of Individual Case Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from user_variable_relationships
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_predictor_case_studies = count(grouped.total)]';

comment on column variables.number_of_studies_where_cause_variable is 'Number of Studies for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from studies
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_studies_where_cause_variable = count(grouped.total)]';

comment on column variables.number_of_studies_where_effect_variable is 'Number of Studies for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from studies
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_studies_where_effect_variable = count(grouped.total)]';

comment on column variables.number_of_tracking_reminder_notifications is 'Number of Tracking Reminder Notifications for this Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, variable_id
                            from tracking_reminder_notifications
                            group by variable_id
                        )
                        as grouped on variables.id = grouped.variable_id
                    set variables.number_of_tracking_reminder_notifications = count(grouped.total)]';

comment on column variables.number_of_user_tags_where_tag_variable is 'Number of User Tags for this Tag Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tag_variable_id
                            from user_tags
                            group by tag_variable_id
                        )
                        as grouped on variables.id = grouped.tag_variable_id
                    set variables.number_of_user_tags_where_tag_variable = count(grouped.total)]';

comment on column variables.number_of_user_tags_where_tagged_variable is 'Number of User Tags for this Tagged Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, tagged_variable_id
                            from user_tags
                            group by tagged_variable_id
                        )
                        as grouped on variables.id = grouped.tagged_variable_id
                    set variables.number_of_user_tags_where_tagged_variable = count(grouped.total)]';

comment on column variables.number_of_variables_where_best_cause_variable is 'Number of Variables for this Best Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_cause_variable_id
                            from variables
                            group by best_cause_variable_id
                        )
                        as grouped on variables.id = grouped.best_cause_variable_id
                    set variables.number_of_variables_where_best_cause_variable = count(grouped.total)]';

comment on column variables.number_of_variables_where_best_effect_variable is 'Number of Variables for this Best Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, best_effect_variable_id
                            from variables
                            group by best_effect_variable_id
                        )
                        as grouped on variables.id = grouped.best_effect_variable_id
                    set variables.number_of_variables_where_best_effect_variable = count(grouped.total)]';

comment on column variables.number_of_votes_where_cause_variable is 'Number of Votes for this Cause Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, cause_variable_id
                            from votes
                            group by cause_variable_id
                        )
                        as grouped on variables.id = grouped.cause_variable_id
                    set variables.number_of_votes_where_cause_variable = count(grouped.total)]';

comment on column variables.number_of_votes_where_effect_variable is 'Number of Votes for this Effect Variable.
                    [Formula: update variables
                        left join (
                            select count(id) as total, effect_variable_id
                            from votes
                            group by effect_variable_id
                        )
                        as grouped on variables.id = grouped.effect_variable_id
                    set variables.number_of_votes_where_effect_variable = count(grouped.total)]';

comment on column variables.number_of_users_where_primary_outcome_variable is 'Number of Users for this Primary Outcome Variable.
                    [Formula: update variables
                        left join (
                            select count(ID) as total, primary_outcome_variable_id
                            from wp_users
                            group by primary_outcome_variable_id
                        )
                        as grouped on variables.id = grouped.primary_outcome_variable_id
                    set variables.number_of_users_where_primary_outcome_variable = count(grouped.total)]';

comment on column variables.deletion_reason is 'The reason the variable was deleted.';

comment on column variables.maximum_allowed_daily_value is 'The maximum allowed value in the default unit for measurements aggregated over a single day. ';

comment on column variables.number_of_common_joined_variables is 'Joined variables are duplicate variables measuring the same thing. ';

comment on column variables.number_of_common_ingredients is 'Measurements for this variable can be used to synthetically generate ingredient measurements. ';

comment on column variables.number_of_common_foods is 'Measurements for this ingredient variable can be synthetically generate by food measurements. ';

comment on column variables.number_of_common_children is 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ';

comment on column variables.number_of_common_parents is 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. ';

comment on column variables.number_of_user_joined_variables is 'Joined variables are duplicate variables measuring the same thing. This only includes ones created by users. ';

comment on column variables.number_of_user_ingredients is 'Measurements for this variable can be used to synthetically generate ingredient measurements. This only includes ones created by users. ';

comment on column variables.number_of_user_foods is 'Measurements for this ingredient variable can be synthetically generate by food measurements. This only includes ones created by users. ';

comment on column variables.number_of_user_children is 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ';

comment on column variables.number_of_user_parents is 'Measurements for this parent category variable can be synthetically generated by measurements from its child variables. This only includes ones created by users. ';

comment on column variables.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column variables.is_goal is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ';

comment on column variables.controllable is 'You can control the foods you eat directly. However, symptom severity or weather is not directly controllable. ';

comment on column variables.boring is 'The variable is boring if the average person would not be interested in its causes or effects. ';

comment on column variables.canonical_variable_id is 'If a variable duplicates another but with a different name, set the canonical variable id to match the variable with the more appropriate name.  Then only the canonical variable will be displayed and all data for the duplicate variable will be included when fetching data for the canonical variable. ';

comment on column variables.predictor is 'predictor is true if the variable is a factor that could influence an outcome of interest';

comment on column variables.source_url is 'URL for the website related to the database containing the info that was used to create this variable such as https://world.openfoodfacts.org or https://dsld.od.nih.gov/dsld ';

alter table variables
    owner to postgres;

create index "IDX_cat_unit_public_name"
    on variables (variable_category_id, default_unit_id, name, number_of_user_variables, id);

create index variables_public_name_number_of_user_variables_index
    on variables (name, number_of_user_variables);

create index public_deleted_at_synonyms_number_of_user_variables_index
    on variables (deleted_at, synonyms, number_of_user_variables);

create index "fk_variableDefaultUnit"
    on variables (default_unit_id);

create index variables_client_id_fk
    on variables (client_id);

create index variables_best_cause_variable_id_fk
    on variables (best_cause_variable_id);

create index variables_best_effect_variable_id_fk
    on variables (best_effect_variable_id);

create index "variables_wp_posts_ID_fk"
    on variables (wp_post_id);

create index variables_global_variable_relationships_id_fk
    on variables (best_global_variable_relationship_id);

