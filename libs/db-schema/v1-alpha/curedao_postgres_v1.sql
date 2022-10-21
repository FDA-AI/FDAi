create table announcement_user
(
    announcement_id bigint,
    user_id         bigint
);

alter table announcement_user
    owner to postgres;

create table announcements
(
    id          integer,
    title       varchar(191),
    description varchar(191),
    body        text,
    created_at  timestamp,
    updated_at  timestamp
);

alter table announcements
    owner to postgres;

create table api_connections
(
    id                                integer,
    client_id                         varchar(80),
    user_id                           bigint,
    connector_id                      integer,
    connect_status                    varchar(32),
    connect_error                     text,
    update_requested_at               timestamp,
    update_status                     varchar(32),
    update_error                      text,
    last_successful_updated_at        timestamp,
    created_at                        timestamp,
    updated_at                        timestamp,
    deleted_at                        timestamp,
    total_measurements_in_last_update integer,
    user_message                      varchar(255),
    latest_measurement_at             timestamp,
    import_started_at                 timestamp,
    import_ended_at                   timestamp,
    reason_for_import                 varchar(255),
    user_error_message                text,
    internal_error_message            text,
    wp_post_id                        bigint,
    number_of_connector_imports       integer,
    number_of_connector_requests      integer,
    credentials                       text,
    imported_data_from_at             timestamp,
    imported_data_end_at              timestamp,
    number_of_measurements            integer,
    is_public                         smallint,
    slug                              varchar(200),
    meta                              text
);

alter table api_connections
    owner to postgres;

create table api_connector_devices
(
    id                integer,
    name              varchar(255),
    display_name      varchar(255),
    image             varchar(2083),
    get_it_url        varchar(2083),
    short_description text,
    long_description  text,
    enabled           smallint,
    oauth             smallint,
    qm_client         smallint,
    created_at        timestamp,
    updated_at        timestamp,
    client_id         varchar(255),
    deleted_at        timestamp,
    is_parent         smallint
);

alter table api_connector_devices
    owner to postgres;

create table api_connector_imports
(
    id                           integer,
    client_id                    varchar(80),
    connection_id                integer,
    connector_id                 integer,
    created_at                   timestamp,
    deleted_at                   timestamp,
    earliest_measurement_at      timestamp,
    import_ended_at              timestamp,
    import_started_at            timestamp,
    internal_error_message       text,
    latest_measurement_at        timestamp,
    number_of_measurements       integer,
    reason_for_import            varchar(255),
    success                      smallint,
    updated_at                   timestamp,
    user_error_message           text,
    user_id                      bigint,
    additional_meta_data         json,
    number_of_connector_requests integer,
    imported_data_from_at        timestamp,
    imported_data_end_at         timestamp,
    credentials                  text,
    connector_requests           timestamp
);

alter table api_connector_imports
    owner to postgres;

create table api_connector_requests
(
    id                    integer,
    connector_id          integer,
    user_id               bigint,
    connection_id         integer,
    connector_import_id   integer,
    method                varchar(10),
    code                  integer,
    uri                   varchar(2083),
    response_body         text,
    request_body          text,
    request_headers       text,
    created_at            timestamp,
    updated_at            timestamp,
    deleted_at            timestamp,
    content_type          varchar(100),
    imported_data_from_at timestamp
);

alter table api_connector_requests
    owner to postgres;

create table api_connectors
(
    id                           integer,
    name                         varchar(30),
    display_name                 varchar(30),
    image                        varchar(2083),
    get_it_url                   varchar(2083),
    short_description            text,
    long_description             text,
    enabled                      smallint,
    oauth                        smallint,
    qm_client                    smallint,
    created_at                   timestamp,
    updated_at                   timestamp,
    client_id                    varchar(80),
    deleted_at                   timestamp,
    wp_post_id                   bigint,
    number_of_connections        integer,
    number_of_connector_imports  integer,
    number_of_connector_requests integer,
    number_of_measurements       integer,
    is_public                    smallint,
    sort_order                   integer,
    slug                         varchar(200)
);

alter table api_connectors
    owner to postgres;

create table api_keys
(
    id           integer,
    user_id      integer,
    name         varchar(191),
    key          varchar(60),
    last_used_at timestamp,
    created_at   timestamp,
    updated_at   timestamp
);

alter table api_keys
    owner to postgres;

create table applications
(
    id                                integer,
    organization_id                   integer,
    client_id                         varchar(80),
    app_display_name                  varchar(255),
    app_description                   varchar(255),
    long_description                  text,
    user_id                           bigint,
    icon_url                          varchar(2083),
    text_logo                         varchar(2083),
    splash_screen                     varchar(2083),
    homepage_url                      varchar(255),
    app_type                          varchar(32),
    app_design                        text,
    created_at                        timestamp,
    updated_at                        timestamp,
    deleted_at                        timestamp,
    enabled                           smallint,
    stripe_active                     smallint,
    stripe_id                         varchar(255),
    stripe_subscription               varchar(255),
    stripe_plan                       varchar(100),
    last_four                         varchar(4),
    trial_ends_at                     timestamp,
    subscription_ends_at              timestamp,
    company_name                      varchar(100),
    country                           varchar(100),
    address                           varchar(255),
    state                             varchar(100),
    city                              varchar(100),
    zip                               varchar(10),
    plan_id                           integer,
    exceeding_call_count              integer,
    exceeding_call_charge             numeric(16, 2),
    study                             smallint,
    billing_enabled                   smallint,
    outcome_variable_id               integer,
    predictor_variable_id             integer,
    physician                         smallint,
    additional_settings               text,
    app_status                        text,
    build_enabled                     smallint,
    wp_post_id                        bigint,
    number_of_collaborators_where_app integer,
    is_public                         smallint,
    sort_order                        integer,
    slug                              varchar(200)
);

alter table applications
    owner to postgres;

create table biomarkers
(
    slug           text,
    type           text,
    subtype        text,
    classification text,
    name_short     text,
    name_long      text,
    unit           text,
    default_value  text,
    description    text,
    "references"   text,
    range_min      text,
    range_max      text,
    id             integer
);

alter table biomarkers
    owner to postgres;

create table blood_lipids
(
    slug           text,
    type           text,
    subtype        text,
    classification text,
    name_short     text,
    name_long      text,
    unit           text,
    default_value  text,
    description    text,
    "references"   text,
    range_min      text,
    range_max      text,
    id             integer
);

alter table blood_lipids
    owner to postgres;

create table blood_test_reference_ranges
(
    "Test"              varchar(59),
    "Normal_Range_Low"  real,
    "Normal_Range_High" real,
    "Ideal_Range_Low"   real,
    "Ideal_Range_High"  real,
    "Unit"              varchar(255),
    Abbreviation       varchar(255),
    "Age_Variance"      varchar(1),
    "Category"          varchar(35),
    "Wikipedia"         varchar(999),
    "Short_Description" text,
    "AwesomeList"       varchar(1),
    "Notes"             time,
    "Source1"           varchar(255),
    "Source1_URL"       varchar(255),
    "Source2"           varchar(255),
    "Source2_URL"       varchar(255)
);

alter table blood_test_reference_ranges
    owner to postgres;

create table categories
(
    id         integer,
    parent_id  integer,
    "order"    integer,
    name       varchar(191),
    slug       varchar(191),
    created_at timestamp,
    updated_at timestamp
);

alter table categories
    owner to postgres;

create table clinical_trial_conditions
(
    id            integer,
    nct_id        varchar(4369),
    name          varchar(4369),
    downcase_name varchar(4369),
    variable_id   integer
);

alter table clinical_trial_conditions
    owner to postgres;

create table clinical_trial_intervention_other_names
(
    id              integer,
    nct_id          varchar(4369),
    intervention_id integer,
    name            varchar(4369)
);

alter table clinical_trial_intervention_other_names
    owner to postgres;

create table clinical_trial_interventions
(
    id                integer,
    nct_id            varchar(4369),
    intervention_type varchar(4369),
    name              varchar(4369),
    description       text,
    variable_id       integer
);

alter table clinical_trial_interventions
    owner to postgres;

create table collaborators
(
    id         integer,
    user_id    bigint,
    app_id     integer,
    type       text,
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    client_id  varchar(80)
);

alter table collaborators
    owner to postgres;

create table data_collection_methods
(
    slug         text,
    name         text,
    error        double precision,
    quality      text,
    description  text,
    "references" text,
    biomarkers_0 text,
    biomarkers_1 text,
    biomarkers_2 text,
    biomarkers_3 text,
    biomarkers_4 text,
    biomarkers_5 text,
    biomarkers_6 text,
    biomarkers_7 text,
    id           integer
);

alter table data_collection_methods
    owner to postgres;

create table data_rows
(
    id           integer,
    data_type_id integer,
    field        varchar(191),
    type         varchar(191),
    display_name varchar(191),
    required     smallint,
    browse       smallint,
    read         smallint,
    edit         smallint,
    add          smallint,
    delete       smallint,
    details      text,
    "order"      integer
);

alter table data_rows
    owner to postgres;

create table data_source_platforms
(
    id         smallint,
    name       varchar(32),
    created_at timestamp,
    updated_at timestamp,
    deleted_at timestamp,
    client_id  varchar(255)
);

alter table data_source_platforms
    owner to postgres;

create table data_types
(
    id                    integer,
    name                  varchar(191),
    slug                  varchar(191),
    display_name_singular varchar(191),
    display_name_plural   varchar(191),
    icon                  varchar(191),
    model_name            varchar(191),
    policy_name           varchar(191),
    controller            varchar(191),
    description           varchar(191),
    generate_permissions  smallint,
    server_side           smallint,
    details               text,
    created_at            timestamp,
    updated_at            timestamp
);

alter table data_types
    owner to postgres;

create table dlsd_supplement_ingredients
(
    "Ingredient_Name"             varchar(255),
    "Primary_Ingredient_Group_ID" integer,
    synonyms                      text,
    "Total_Number_of_Labels"      integer,
    "Count_of_Labels_in_NHANES"   integer,
    "All_Ingredient_Group_ID"     integer,
    "Sample_DSLD_IDs"             text,
    "Sample_DSLD_IDs_in_NHANES"   text,
    id                            integer
);

alter table dlsd_supplement_ingredients
    owner to postgres;

create table dsld_supplement_products
(
    dsld_id                 integer,
    "Brand_Name"            text,
    "Product_Name"          text,
    "Net_Contents"          double precision,
    "Net_Content_Unit"      text,
    "Serving_Size_Quantity" integer,
    "Serving_Size_Unit"     text,
    "Product_Type"          text,
    "Supplement_Form"       text,
    "Dietary_Claims"        text,
    "Intended_Target_Group" text,
    "Database"              text,
    "Tracking_History"      text,
    "Date"                  text,
    id                      integer
);

alter table dsld_supplement_products
    owner to postgres;

create table global_studies
(
    id                            varchar(80),
    type                          varchar(20),
    cause_variable_id             integer,
    effect_variable_id            integer,
    user_id                       bigint,
    created_at                    timestamp,
    deleted_at                    timestamp,
    analysis_parameters           text,
    user_study_text               text,
    user_title                    text,
    study_status                  varchar(20),
    comment_status                varchar(20),
    study_password                varchar(20),
    study_images                  text,
    updated_at                    timestamp,
    client_id                     varchar(255),
    published_at                  timestamp,
    wp_post_id                    integer,
    newest_data_at                timestamp,
    analysis_requested_at         timestamp,
    reason_for_analysis           varchar(255),
    analysis_ended_at             timestamp,
    analysis_started_at           timestamp,
    internal_error_message        varchar(255),
    user_error_message            varchar(255),
    status                        varchar(25),
    analysis_settings_modified_at timestamp,
    is_public                     smallint,
    sort_order                    integer,
    slug                          varchar(200)
);

alter table global_studies
    owner to postgres;

create table global_study_causality_votes
(
    id                       integer,
    cause_variable_id        integer,
    effect_variable_id       integer,
    correlation_id           integer,
    aggregate_correlation_id integer,
    user_id                  bigint,
    vote                     integer,
    created_at               timestamp,
    updated_at               timestamp,
    deleted_at               timestamp,
    client_id                varchar(80),
    is_public                smallint
);

alter table global_study_causality_votes
    owner to postgres;

create table global_study_results
(
    id                                                           integer,
    forward_pearson_correlation_coefficient                      real,
    onset_delay                                                  integer,
    duration_of_action                                           integer,
    number_of_pairs                                              integer,
    value_predicting_high_outcome                                double precision,
    value_predicting_low_outcome                                 double precision,
    optimal_pearson_product                                      double precision,
    average_vote                                                 real,
    number_of_users                                              integer,
    number_of_correlations                                       integer,
    statistical_significance                                     real,
    cause_unit_id                                                smallint,
    cause_changes                                                integer,
    effect_changes                                               integer,
    aggregate_qm_score                                           double precision,
    created_at                                                   timestamp,
    updated_at                                                   timestamp,
    status                                                       varchar(25),
    reverse_pearson_correlation_coefficient                      double precision,
    predictive_pearson_correlation_coefficient                   double precision,
    data_source_name                                             varchar(255),
    predicts_high_effect_change                                  integer,
    predicts_low_effect_change                                   integer,
    p_value                                                      double precision,
    t_value                                                      double precision,
    critical_t_value                                             double precision,
    confidence_interval                                          double precision,
    deleted_at                                                   timestamp,
    average_effect                                               double precision,
    average_effect_following_high_cause                          double precision,
    average_effect_following_low_cause                           double precision,
    average_daily_low_cause                                      double precision,
    average_daily_high_cause                                     double precision,
    population_trait_pearson_correlation_coefficient             double precision,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision,
    client_id                                                    varchar(255),
    published_at                                                 timestamp,
    wp_post_id                                                   bigint,
    cause_variable_category_id                                   smallint,
    effect_variable_category_id                                  smallint,
    interesting_variable_category_pair                           smallint,
    newest_data_at                                               timestamp,
    analysis_requested_at                                        timestamp,
    reason_for_analysis                                          varchar(255),
    analysis_started_at                                          timestamp,
    analysis_ended_at                                            timestamp,
    user_error_message                                           text,
    internal_error_message                                       text,
    cause_variable_id                                            integer,
    effect_variable_id                                           integer,
    cause_baseline_average_per_day                               real,
    cause_baseline_average_per_duration_of_action                real,
    cause_treatment_average_per_day                              real,
    cause_treatment_average_per_duration_of_action               real,
    effect_baseline_average                                      real,
    effect_baseline_relative_standard_deviation                  real,
    effect_baseline_standard_deviation                           real,
    effect_follow_up_average                                     real,
    effect_follow_up_percent_change_from_baseline                real,
    z_score                                                      real,
    charts                                                       json,
    number_of_variables_where_best_aggregate_correlation         integer,
    deletion_reason                                              varchar(280),
    record_size_in_kb                                            integer,
    is_public                                                    smallint,
    boring                                                       smallint,
    outcome_is_a_goal                                            smallint,
    predictor_is_controllable                                    smallint,
    plausibly_causal                                             smallint,
    obvious                                                      smallint,
    number_of_up_votes                                           integer,
    number_of_down_votes                                         integer,
    strength_level                                               text,
    confidence_level                                             text,
    relationship                                                 text,
    slug                                                         varchar(200)
);

alter table global_study_results
    owner to postgres;

create table global_study_usefulness_votes
(
    id                       integer,
    cause_variable_id        integer,
    effect_variable_id       integer,
    correlation_id           integer,
    aggregate_correlation_id integer,
    user_id                  bigint,
    vote                     integer,
    created_at               timestamp,
    updated_at               timestamp,
    deleted_at               timestamp,
    client_id                varchar(80),
    is_public                smallint
);

alter table global_study_usefulness_votes
    owner to postgres;

create table global_study_votes
(
    id                       integer,
    client_id                varchar(80),
    user_id                  bigint,
    value                    integer,
    created_at               timestamp,
    updated_at               timestamp,
    deleted_at               timestamp,
    cause_variable_id        integer,
    effect_variable_id       integer,
    correlation_id           integer,
    aggregate_correlation_id integer,
    is_public                smallint
);

alter table global_study_votes
    owner to postgres;

create table global_variable_child_parent
(
    id                        integer,
    child_global_variable_id  integer,
    parent_global_variable_id integer,
    client_id                 varchar(80),
    created_at                timestamp,
    updated_at                timestamp,
    deleted_at                timestamp
);

alter table global_variable_child_parent
    owner to postgres;

create table global_variable_food_ingredient
(
    id                                 integer,
    food_global_variable_id            integer,
    ingredient_global_variable_id      integer,
    number_of_data_points              integer,
    standard_error                     real,
    ingredient_global_variable_unit_id smallint,
    food_global_variable_unit_id       smallint,
    conversion_factor                  double precision,
    client_id                          varchar(80),
    created_at                         timestamp,
    updated_at                         timestamp,
    deleted_at                         timestamp
);

alter table global_variable_food_ingredient
    owner to postgres;

create table global_variables
(
    id                                                  integer,
    name                                                varchar(125),
    number_of_user_variables                            integer,
    variable_category_id                                smallint,
    default_unit_id                                     smallint,
    default_value                                       double precision,
    cause_only                                          smallint,
    client_id                                           varchar(80),
    combination_operation                               text,
    common_alias                                        varchar(125),
    created_at                                          timestamp,
    description                                         text,
    duration_of_action                                  integer,
    filling_value                                       double precision,
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
    number_of_aggregate_correlations_as_cause           integer,
    most_common_original_unit_id                        integer,
    most_common_value                                   double precision,
    number_of_aggregate_correlations_as_effect          integer,
    number_of_unique_values                             integer,
    onset_delay                                         integer,
    outcome                                             smallint,
    parent_id                                           integer,
    price                                               double precision,
    product_url                                         varchar(2083),
    second_most_common_value                            double precision,
    skewness                                            double precision,
    standard_deviation                                  double precision,
    status                                              varchar(25),
    third_most_common_value                             double precision,
    updated_at                                          timestamp,
    variance                                            double precision,
    most_common_connector_id                            integer,
    synonyms                                            varchar(600),
    wikipedia_url                                       varchar(2083),
    brand_name                                          varchar(125),
    valence                                             text,
    wikipedia_title                                     varchar(100),
    number_of_tracking_reminders                        integer,
    upc_12                                              varchar(255),
    upc_14                                              varchar(255),
    number_common_tagged_by                             integer,
    number_of_common_tags                               integer,
    deleted_at                                          timestamp,
    most_common_source_name                             varchar(255),
    data_sources_count                                  text,
    optimal_value_message                               varchar(500),
    best_cause_variable_id                              integer,
    best_effect_variable_id                             integer,
    common_maximum_allowed_daily_value                  double precision,
    common_minimum_allowed_daily_value                  double precision,
    common_minimum_allowed_non_zero_value               double precision,
    minimum_allowed_seconds_between_measurements        integer,
    average_seconds_between_measurements                integer,
    median_seconds_between_measurements                 integer,
    number_of_raw_measurements_with_tags_joins_children integer,
    additional_meta_data                                text,
    manual_tracking                                     smallint,
    analysis_settings_modified_at                       timestamp,
    newest_data_at                                      timestamp,
    analysis_requested_at                               timestamp,
    reason_for_analysis                                 varchar(255),
    analysis_started_at                                 timestamp,
    analysis_ended_at                                   timestamp,
    user_error_message                                  text,
    internal_error_message                              text,
    latest_tagged_measurement_start_at                  timestamp,
    earliest_tagged_measurement_start_at                timestamp,
    latest_non_tagged_measurement_start_at              timestamp,
    earliest_non_tagged_measurement_start_at            timestamp,
    wp_post_id                                          bigint,
    number_of_soft_deleted_measurements                 integer,
    charts                                              json,
    creator_user_id                                     bigint,
    best_aggregate_correlation_id                       integer,
    filling_type                                        text,
    number_of_outcome_population_studies                integer,
    number_of_predictor_population_studies              integer,
    number_of_applications_where_outcome_variable       integer,
    number_of_applications_where_predictor_variable     integer,
    number_of_common_tags_where_tag_variable            integer,
    number_of_common_tags_where_tagged_variable         integer,
    number_of_outcome_case_studies                      integer,
    number_of_predictor_case_studies                    integer,
    number_of_measurements                              integer,
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
    is_public                                           smallint,
    sort_order                                          integer,
    is_goal                                             smallint,
    controllable                                        smallint,
    boring                                              smallint,
    slug                                                varchar(200),
    canonical_variable_id                               integer,
    predictor                                           smallint,
    source_url                                          varchar(2083),
    loinc_core_id                                       integer,
    abbreviated_name                                    varchar(100),
    version_first_released                              varchar(255),
    version_last_changed                                varchar(255),
    loinc_id                                            integer,
    rxnorm_id                                           integer,
    snomed_id                                           integer,
    meddra_all_indications_id                           integer,
    meddra_all_side_effects_id                          integer,
    icd10_id                                            integer,
    uniprot_id                                          integer,
    hmdb_id                                             integer,
    gene_ontology_id                                    integer,
    aact_id                                             integer
);

alter table global_variables
    owner to postgres;

create table intuitive_causes
(
    id                   integer,
    name                 varchar(100),
    variable_id          integer,
    updated_at           timestamp,
    created_at           timestamp,
    deleted_at           timestamp,
    number_of_conditions integer
);

alter table intuitive_causes
    owner to postgres;

create table intuitive_condition_symptom
(
    id                    integer,
    condition_variable_id integer,
    condition_id          integer,
    symptom_variable_id   integer,
    symptom_id            integer,
    votes                 integer,
    extreme               integer,
    severe                integer,
    moderate              integer,
    mild                  integer,
    minimal               integer,
    no_symptoms           integer,
    updated_at            timestamp,
    deleted_at            timestamp,
    created_at            timestamp
);

alter table intuitive_condition_symptom
    owner to postgres;

create table intuitive_condition_treatment
(
    id                    integer,
    condition_id          integer,
    treatment_id          integer,
    condition_variable_id integer,
    treatment_variable_id integer,
    major_improvement     integer,
    moderate_improvement  integer,
    no_effect             integer,
    worse                 integer,
    much_worse            integer,
    popularity            integer,
    average_effect        integer,
    updated_at            timestamp,
    created_at            timestamp,
    deleted_at            timestamp
);

alter table intuitive_condition_treatment
    owner to postgres;

create table intuitive_conditions
(
    id                   integer,
    name                 varchar(100),
    variable_id          integer,
    updated_at           timestamp,
    created_at           timestamp,
    deleted_at           timestamp,
    number_of_treatments integer,
    number_of_symptoms   integer,
    number_of_causes     integer
);

alter table intuitive_conditions
    owner to postgres;

create table intuitive_relationships
(
    id                            integer,
    user_id                       integer,
    correlation_coefficient       real,
    cause_variable_id             integer,
    effect_variable_id            integer,
    onset_delay                   integer,
    duration_of_action            integer,
    number_of_pairs               integer,
    value_predicting_high_outcome double precision,
    value_predicting_low_outcome  double precision,
    optimal_pearson_product       double precision,
    vote                          real,
    statistical_significance      real,
    cause_unit_id                 integer,
    cause_changes                 integer,
    effect_changes                integer,
    qm_score                      double precision,
    error                         text,
    created_at                    timestamp,
    updated_at                    timestamp,
    deleted_at                    timestamp
);

alter table intuitive_relationships
    owner to postgres;

create table intuitive_side_effects
(
    id                   integer,
    name                 varchar(100),
    variable_id          integer,
    updated_at           timestamp,
    created_at           timestamp,
    deleted_at           timestamp,
    number_of_treatments integer
);

alter table intuitive_side_effects
    owner to postgres;

create table intuitive_symptoms
(
    id                   integer,
    name                 varchar(100),
    variable_id          integer,
    updated_at           timestamp,
    created_at           timestamp,
    deleted_at           timestamp,
    number_of_conditions integer
);

alter table intuitive_symptoms
    owner to postgres;

create table intuitive_treatments
(
    id                     integer,
    name                   varchar(100),
    variable_id            integer,
    updated_at             timestamp,
    created_at             timestamp,
    deleted_at             timestamp,
    number_of_conditions   integer,
    number_of_side_effects integer
);

alter table intuitive_treatments
    owner to postgres;

create table intutitive_treatment_side_effect
(
    id                      integer,
    treatment_variable_id   integer,
    side_effect_variable_id integer,
    treatment_id            integer,
    side_effect_id          integer,
    votes_percent           integer,
    updated_at              timestamp,
    created_at              timestamp,
    deleted_at              timestamp
);

alter table intutitive_treatment_side_effect
    owner to postgres;

create table inutitive_condition_cause
(
    id                    integer,
    condition_id          integer,
    cause_id              integer,
    condition_variable_id integer,
    cause_variable_id     integer,
    votes_percent         integer,
    updated_at            timestamp,
    created_at            timestamp,
    deleted_at            timestamp
);

alter table inutitive_condition_cause
    owner to postgres;

create table loinc_core
(
    loinc_num                 text,
    component                 text,
    property                  text,
    time_aspct                text,
    system                    text,
    scale_typ                 text,
    method_typ                text,
    class                     text,
    classtype                 integer,
    long_common_name          text,
    shortname                 text,
    external_copyright_notice text,
    status                    text,
    "VersionFirstReleased"    text,
    "VersionLastChanged"      double precision,
    id                        integer
);

alter table loinc_core
    owner to postgres;

create table longevity_supplements
(
    id                integer,
    category          text,
    rxnorm_code       text,
    name_short        text,
    name_long         text,
    application_route text,
    description       text,
    "references"      text
);

alter table longevity_supplements
    owner to postgres;

create table measurement_exports
(
    id            integer,
    user_id       bigint,
    client_id     varchar(255),
    status        varchar(32),
    type          text,
    output_type   text,
    error_message varchar(255),
    created_at    timestamp,
    updated_at    timestamp,
    deleted_at    timestamp
);

alter table measurement_exports
    owner to postgres;

create table measurement_imports
(
    id                     integer,
    user_id                bigint,
    file                   varchar(255),
    created_at             timestamp,
    updated_at             timestamp,
    status                 varchar(25),
    error_message          text,
    source_name            varchar(80),
    deleted_at             timestamp,
    client_id              varchar(255),
    import_started_at      timestamp,
    import_ended_at        timestamp,
    reason_for_import      varchar(255),
    user_error_message     varchar(255),
    internal_error_message varchar(255)
);

alter table measurement_imports
    owner to postgres;

create table meddra_all_indications
(
    "STITCH_compound_id_flat"                      varchar(55),
    "UMLS_concept_id_as_it_was_found_on_the_label" varchar(55),
    method_of_detection                            varchar(55),
    concept_name                                   varchar(55),
    "MedDRA_concept_type"                          varchar(55),
    "UMLS_concept_id_for_MedDRA_term"              varchar(55),
    "MedDRA_concept_name"                          varchar(55),
    compound_name                                  varchar(255),
    compound_variable_id                           integer,
    condition_variable_id                          integer,
    updated_at                                     timestamp,
    created_at                                     timestamp,
    deleted_at                                     timestamp,
    id                                             integer
);

alter table meddra_all_indications
    owner to postgres;

create table meddra_all_side_effects
(
    "STITCH_compound_id_flat"                      varchar(255),
    "STITCH_compound_id_stereo"                    varchar(255),
    "UMLS_concept_id_as_it_was_found_on_the_label" varchar(255),
    "MedDRA_concept_type"                          varchar(255),
    "UMLS_concept_id_for_MedDRA_term"              varchar(255),
    side_effect_name                               varchar(255),
    id                                             integer
);

alter table meddra_all_side_effects
    owner to postgres;

create table meddra_side_effect_frequencies
(
    "STITCH_compound_id_flat"                      varchar(50),
    "STITCH_compound_id_stereo"                    varchar(50),
    "UMLS_concept_id_as_it_was_found_on_the_label" varchar(50),
    placebo                                        varchar(50),
    description_of_the_frequency                   double precision,
    a_lower_bound_on_the_frequency                 double precision,
    an_upper_bound_on_the_frequency                double precision,
    "MedDRA_concept_type"                          varchar(50),
    "UMLS_concept_id_for_MedDRA_term"              varchar(50),
    side_effect_name                               varchar(50),
    id                                             integer
);

alter table meddra_side_effect_frequencies
    owner to postgres;

create table media
(
    id                bigint,
    model_type        varchar(255),
    model_id          bigint,
    collection_name   varchar(255),
    name              varchar(255),
    file_name         varchar(255),
    mime_type         varchar(255),
    disk              varchar(255),
    size              bigint,
    manipulations     json,
    custom_properties json,
    responsive_images json,
    order_column      integer,
    created_at        timestamp,
    updated_at        timestamp
);

alter table media
    owner to postgres;

create table menu_items
(
    id         integer,
    menu_id    integer,
    title      varchar(191),
    url        varchar(191),
    target     varchar(191),
    icon_class varchar(191),
    color      varchar(191),
    parent_id  integer,
    "order"    integer,
    created_at timestamp,
    updated_at timestamp,
    route      varchar(191),
    parameters text
);

alter table menu_items
    owner to postgres;

create table menus
(
    id         integer,
    name       varchar(191),
    created_at timestamp,
    updated_at timestamp
);

alter table menus
    owner to postgres;

create table migrations
(
    id        integer,
    migration varchar(191),
    batch     integer
);

alter table migrations
    owner to postgres;

create table notifications
(
    id              char(36),
    type            varchar(191),
    notifiable_id   integer,
    notifiable_type varchar(191),
    data            text,
    read_at         timestamp,
    created_at      timestamp,
    updated_at      timestamp
);

alter table notifications
    owner to postgres;

create table nutrients
(
    slug          text,
    category      text,
    name_long     text,
    unit          text,
    default_value text,
    description   text,
    id            integer
);

alter table nutrients
    owner to postgres;

create table oa_clients
(
    client_id                                 varchar(80),
    client_secret                             varchar(80),
    redirect_uri                              varchar(2000),
    grant_types                               varchar(80),
    user_id                                   bigint,
    created_at                                timestamp,
    updated_at                                timestamp,
    icon_url                                  varchar(2083),
    app_identifier                            varchar(255),
    deleted_at                                timestamp,
    earliest_measurement_start_at             timestamp,
    latest_measurement_start_at               timestamp,
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

alter table oa_clients
    owner to postgres;

create table oauth_access_tokens
(
    id         varchar(100),
    user_id    bigint,
    client_id  integer,
    name       varchar(255),
    scopes     text,
    revoked    smallint,
    created_at timestamp,
    updated_at timestamp,
    expires_at timestamp
);

alter table oauth_access_tokens
    owner to postgres;

create table oauth_auth_codes
(
    id         varchar(100),
    user_id    bigint,
    client_id  integer,
    scopes     text,
    revoked    smallint,
    expires_at timestamp
);

alter table oauth_auth_codes
    owner to postgres;

create table oauth_clients
(
    id                     integer,
    user_id                bigint,
    name                   varchar(255),
    secret                 varchar(100),
    redirect               text,
    personal_access_client smallint,
    password_client        smallint,
    revoked                smallint,
    created_at             timestamp,
    updated_at             timestamp
);

alter table oauth_clients
    owner to postgres;

create table oauth_personal_access_clients
(
    id         integer,
    client_id  integer,
    created_at timestamp,
    updated_at timestamp
);

alter table oauth_personal_access_clients
    owner to postgres;

create table oauth_refresh_tokens
(
    id              varchar(100),
    access_token_id varchar(100),
    revoked         smallint,
    expires_at      timestamp
);

alter table oauth_refresh_tokens
    owner to postgres;

create table opencures_biomarkers
(
    slug          varchar(34),
    apple_mapping varchar(12),
    category      varchar(12),
    name_long     varchar(40),
    unit          varchar(13),
    default_value varchar(1),
    description   text,
    references_0  varchar(161),
    references_1  varchar(67),
    id            integer
);

alter table opencures_biomarkers
    owner to postgres;

create table paddle_subscriptions
(
    id              bigint,
    subscription_id integer,
    plan_id         integer,
    user_id         integer,
    status          varchar(191),
    update_url      varchar(191),
    cancel_url      varchar(191),
    cancelled_at    timestamp,
    created_at      timestamp,
    updated_at      timestamp
);

alter table paddle_subscriptions
    owner to postgres;

create table prodrome_scan_biomarker_panel
(
    slug                    text,
    type                    text,
    subtype                 text,
    classification          text,
    name_long               text,
    name_long_prodrome_scan text,
    unit                    text,
    default_value           text,
    description             text,
    "references"            text,
    id                      integer
);

alter table prodrome_scan_biomarker_panel
    owner to postgres;

create table property_tags
(
    id          integer,
    name        varchar(100),
    description varchar(100)
);

alter table property_tags
    owner to postgres;

create table test_panels
(
    slug         text,
    biomarker_id text,
    name         text,
    entries      text,
    description  text,
    "references" text,
    id           integer
);

alter table test_panels
    owner to postgres;

create table third_party_study_results
(
    cause_id                                                     integer,
    effect_id                                                    integer,
    qm_score                                                     double precision,
    forward_pearson_correlation_coefficient                      real,
    value_predicting_high_outcome                                double precision,
    value_predicting_low_outcome                                 double precision,
    predicts_high_effect_change                                  integer,
    predicts_low_effect_change                                   integer,
    average_effect                                               double precision,
    average_effect_following_high_cause                          double precision,
    average_effect_following_low_cause                           double precision,
    average_daily_low_cause                                      double precision,
    average_daily_high_cause                                     double precision,
    average_forward_pearson_correlation_over_onset_delays        real,
    average_reverse_pearson_correlation_over_onset_delays        real,
    cause_changes                                                integer,
    cause_filling_value                                          double precision,
    cause_number_of_processed_daily_measurements                 integer,
    cause_number_of_raw_measurements                             integer,
    cause_unit_id                                                integer,
    confidence_interval                                          double precision,
    critical_t_value                                             double precision,
    created_at                                                   timestamp,
    data_source_name                                             varchar(255),
    deleted_at                                                   timestamp,
    duration_of_action                                           integer,
    effect_changes                                               integer,
    effect_filling_value                                         double precision,
    effect_number_of_processed_daily_measurements                integer,
    effect_number_of_raw_measurements                            integer,
    error                                                        text,
    forward_spearman_correlation_coefficient                     real,
    id                                                           integer,
    number_of_days                                               integer,
    number_of_pairs                                              integer,
    onset_delay                                                  integer,
    onset_delay_with_strongest_pearson_correlation               integer,
    optimal_pearson_product                                      double precision,
    p_value                                                      double precision,
    pearson_correlation_with_no_onset_delay                      real,
    predictive_pearson_correlation_coefficient                   double precision,
    reverse_pearson_correlation_coefficient                      double precision,
    statistical_significance                                     real,
    strongest_pearson_correlation_coefficient                    real,
    t_value                                                      double precision,
    updated_at                                                   timestamp,
    user_id                                                      bigint,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision,
    client_id                                                    varchar(255),
    published_at                                                 timestamp,
    wp_post_id                                                   integer,
    status                                                       varchar(25),
    cause_variable_category_id                                   smallint,
    effect_variable_category_id                                  smallint,
    interesting_variable_category_pair                           smallint,
    cause_variable_id                                            integer,
    effect_variable_id                                           integer
);

alter table third_party_study_results
    owner to postgres;

create table tracking_reminder_notifications
(
    id                   integer,
    tracking_reminder_id integer,
    created_at           timestamp,
    updated_at           timestamp,
    deleted_at           timestamp,
    user_id              bigint,
    notified_at          timestamp,
    received_at          timestamp,
    client_id            varchar(255),
    variable_id          integer,
    notify_at            timestamp,
    user_variable_id     integer
);

alter table tracking_reminder_notifications
    owner to postgres;

create table tracking_reminders
(
    id                                              integer,
    user_id                                         bigint,
    client_id                                       varchar(80),
    variable_id                                     integer,
    default_value                                   double precision,
    reminder_start_time                             time,
    reminder_end_time                               time,
    reminder_sound                                  varchar(125),
    reminder_frequency                              integer,
    pop_up                                          smallint,
    sms                                             smallint,
    email                                           smallint,
    notification_bar                                smallint,
    last_tracked                                    timestamp,
    created_at                                      timestamp,
    updated_at                                      timestamp,
    start_tracking_date                             date,
    stop_tracking_date                              date,
    instructions                                    text,
    deleted_at                                      timestamp,
    image_url                                       varchar(2083),
    user_variable_id                                integer,
    latest_tracking_reminder_notification_notify_at timestamp,
    number_of_tracking_reminder_notifications       integer
);

alter table tracking_reminders
    owner to postgres;

create table ucum_units_of_measure
(
    "Code"             text,
    "Descriptive_Name" text,
    "Code_System"      text,
    "Definition"       text,
    "Date_Created"     text,
    "Synonym"          text,
    "Status"           text,
    "Kind_of_Quantity" text,
    "Date_Revised"     text,
    "ConceptID"        text,
    "Dimension"        text,
    id                 integer
);

alter table ucum_units_of_measure
    owner to postgres;

create table unit_categories
(
    id            smallint,
    name          varchar(64),
    created_at    timestamp,
    updated_at    timestamp,
    can_be_summed smallint,
    deleted_at    timestamp,
    sort_order    integer
);

alter table unit_categories
    owner to postgres;

create table unit_conversions
(
    unit_id     integer,
    step_number smallint,
    operation   smallint,
    value       double precision,
    created_at  timestamp,
    updated_at  timestamp,
    deleted_at  timestamp,
    id          integer
);

alter table unit_conversions
    owner to postgres;

create table units
(
    id                                               smallint,
    name                                             varchar(64),
    abbreviated_name                                 varchar(16),
    unit_category_id                                 smallint,
    minimum_value                                    double precision,
    maximum_value                                    double precision,
    created_at                                       timestamp,
    updated_at                                       timestamp,
    deleted_at                                       timestamp,
    filling_type                                     text,
    number_of_outcome_population_studies             integer,
    number_of_common_tags_where_tag_variable_unit    integer,
    number_of_common_tags_where_tagged_variable_unit integer,
    number_of_outcome_case_studies                   integer,
    number_of_measurements                           integer,
    number_of_user_variables_where_default_unit      integer,
    number_of_variable_categories_where_default_unit integer,
    number_of_variables_where_default_unit           integer,
    advanced                                         smallint,
    manual_tracking                                  smallint,
    filling_value                                    real,
    scale                                            text,
    conversion_steps                                 text,
    maximum_daily_value                              double precision,
    sort_order                                       integer,
    slug                                             varchar(200)
);

alter table units
    owner to postgres;

create table user_clients
(
    id                      integer,
    client_id               varchar(80),
    created_at              timestamp,
    deleted_at              timestamp,
    earliest_measurement_at timestamp,
    latest_measurement_at   timestamp,
    number_of_measurements  integer,
    updated_at              timestamp,
    user_id                 bigint
);

alter table user_clients
    owner to postgres;

create table user_meta
(
    umeta_id   bigint,
    user_id    bigint,
    meta_key   varchar(255),
    meta_value text,
    updated_at timestamp,
    created_at timestamp,
    deleted_at timestamp,
    client_id  varchar(255)
);

alter table user_meta
    owner to postgres;

create table user_studies
(
    id                            varchar(80),
    type                          varchar(20),
    cause_variable_id             integer,
    effect_variable_id            integer,
    correlation_id                integer,
    user_id                       bigint,
    created_at                    timestamp,
    deleted_at                    timestamp,
    analysis_parameters           text,
    user_study_text               text,
    user_title                    text,
    study_status                  varchar(20),
    comment_status                varchar(20),
    study_password                varchar(20),
    study_images                  text,
    updated_at                    timestamp,
    client_id                     varchar(255),
    published_at                  timestamp,
    wp_post_id                    integer,
    newest_data_at                timestamp,
    analysis_requested_at         timestamp,
    reason_for_analysis           varchar(255),
    analysis_ended_at             timestamp,
    analysis_started_at           timestamp,
    internal_error_message        varchar(255),
    user_error_message            varchar(255),
    status                        varchar(25),
    analysis_settings_modified_at timestamp,
    is_public                     smallint,
    sort_order                    integer,
    slug                          varchar(200)
);

alter table user_studies
    owner to postgres;

create table user_study_results
(
    id                                                           integer,
    user_id                                                      bigint,
    cause_variable_id                                            integer,
    effect_variable_id                                           integer,
    qm_score                                                     double precision,
    forward_pearson_correlation_coefficient                      real,
    value_predicting_high_outcome                                double precision,
    value_predicting_low_outcome                                 double precision,
    predicts_high_effect_change                                  integer,
    predicts_low_effect_change                                   integer,
    average_effect                                               double precision,
    average_effect_following_high_cause                          double precision,
    average_effect_following_low_cause                           double precision,
    average_daily_low_cause                                      double precision,
    average_daily_high_cause                                     double precision,
    average_forward_pearson_correlation_over_onset_delays        real,
    average_reverse_pearson_correlation_over_onset_delays        real,
    cause_changes                                                integer,
    cause_filling_value                                          double precision,
    cause_number_of_processed_daily_measurements                 integer,
    cause_number_of_raw_measurements                             integer,
    cause_unit_id                                                smallint,
    confidence_interval                                          double precision,
    critical_t_value                                             double precision,
    created_at                                                   timestamp,
    data_source_name                                             varchar(255),
    deleted_at                                                   timestamp,
    duration_of_action                                           integer,
    effect_changes                                               integer,
    effect_filling_value                                         double precision,
    effect_number_of_processed_daily_measurements                integer,
    effect_number_of_raw_measurements                            integer,
    forward_spearman_correlation_coefficient                     real,
    number_of_days                                               integer,
    number_of_pairs                                              integer,
    onset_delay                                                  integer,
    onset_delay_with_strongest_pearson_correlation               integer,
    optimal_pearson_product                                      double precision,
    p_value                                                      double precision,
    pearson_correlation_with_no_onset_delay                      real,
    predictive_pearson_correlation_coefficient                   double precision,
    reverse_pearson_correlation_coefficient                      double precision,
    statistical_significance                                     real,
    strongest_pearson_correlation_coefficient                    real,
    t_value                                                      double precision,
    updated_at                                                   timestamp,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision,
    client_id                                                    varchar(255),
    published_at                                                 timestamp,
    wp_post_id                                                   bigint,
    status                                                       varchar(25),
    cause_variable_category_id                                   smallint,
    effect_variable_category_id                                  smallint,
    interesting_variable_category_pair                           smallint,
    newest_data_at                                               timestamp,
    analysis_requested_at                                        timestamp,
    reason_for_analysis                                          varchar(255),
    analysis_started_at                                          timestamp,
    analysis_ended_at                                            timestamp,
    user_error_message                                           text,
    internal_error_message                                       text,
    cause_user_variable_id                                       integer,
    effect_user_variable_id                                      integer,
    latest_measurement_start_at                                  timestamp,
    earliest_measurement_start_at                                timestamp,
    cause_baseline_average_per_day                               real,
    cause_baseline_average_per_duration_of_action                real,
    cause_treatment_average_per_day                              real,
    cause_treatment_average_per_duration_of_action               real,
    effect_baseline_average                                      real,
    effect_baseline_relative_standard_deviation                  real,
    effect_baseline_standard_deviation                           real,
    effect_follow_up_average                                     real,
    effect_follow_up_percent_change_from_baseline                real,
    z_score                                                      real,
    experiment_end_at                                            timestamp,
    experiment_start_at                                          timestamp,
    aggregate_correlation_id                                     integer,
    aggregated_at                                                timestamp,
    usefulness_vote                                              integer,
    causality_vote                                               integer,
    deletion_reason                                              varchar(280),
    record_size_in_kb                                            integer,
    correlations_over_durations                                  text,
    correlations_over_delays                                     text,
    is_public                                                    smallint,
    sort_order                                                   integer,
    boring                                                       smallint,
    outcome_is_goal                                              smallint,
    predictor_is_controllable                                    smallint,
    plausibly_causal                                             smallint,
    obvious                                                      smallint,
    number_of_up_votes                                           integer,
    number_of_down_votes                                         integer,
    strength_level                                               text,
    confidence_level                                             text,
    relationship                                                 text,
    slug                                                         varchar(200)
);

alter table user_study_results
    owner to postgres;

create table user_variable_child_parent
(
    id                      integer,
    child_user_variable_id  integer,
    parent_user_variable_id integer,
    client_id               varchar(80),
    created_at              timestamp,
    updated_at              timestamp,
    deleted_at              timestamp
);

alter table user_variable_child_parent
    owner to postgres;

create table user_variable_clients
(
    id                      integer,
    client_id               varchar(80),
    created_at              timestamp,
    deleted_at              timestamp,
    earliest_measurement_at timestamp,
    latest_measurement_at   timestamp,
    number_of_measurements  integer,
    updated_at              timestamp,
    user_id                 bigint,
    user_variable_id        integer,
    variable_id             integer
);

alter table user_variable_clients
    owner to postgres;

create table user_variable_food_ingredient
(
    id                               integer,
    food_user_variable_id            integer,
    ingredient_user_variable_id      integer,
    number_of_data_points            integer,
    standard_error                   real,
    ingredient_user_variable_unit_id smallint,
    food_user_variable_unit_id       smallint,
    conversion_factor                double precision,
    client_id                        varchar(80),
    created_at                       timestamp,
    updated_at                       timestamp,
    deleted_at                       timestamp
);

alter table user_variable_food_ingredient
    owner to postgres;

create table user_variable_outcome_category
(
    id                               integer,
    user_variable_id                 integer,
    variable_id                      integer,
    variable_category_id             smallint,
    number_of_outcome_user_variables integer,
    created_at                       timestamp,
    updated_at                       timestamp,
    deleted_at                       timestamp
);

alter table user_variable_outcome_category
    owner to postgres;

create table user_variable_predictor_category
(
    id                                 integer,
    user_variable_id                   integer,
    variable_id                        integer,
    variable_category_id               smallint,
    number_of_predictor_user_variables integer,
    created_at                         timestamp,
    updated_at                         timestamp,
    deleted_at                         timestamp
);

alter table user_variable_predictor_category
    owner to postgres;

create table user_variable_tags
(
    id                      integer,
    tagged_variable_id      integer,
    tag_variable_id         integer,
    conversion_factor       double precision,
    user_id                 bigint,
    created_at              timestamp,
    updated_at              timestamp,
    client_id               varchar(80),
    deleted_at              timestamp,
    tagged_user_variable_id integer,
    tag_user_variable_id    integer
);

alter table user_variable_tags
    owner to postgres;

create table user_variables
(
    id                                                   integer,
    parent_id                                            integer,
    client_id                                            varchar(80),
    user_id                                              bigint,
    variable_id                                          integer,
    default_unit_id                                      smallint,
    minimum_allowed_value                                double precision,
    maximum_allowed_value                                double precision,
    filling_value                                        double precision,
    join_with                                            integer,
    onset_delay                                          integer,
    duration_of_action                                   integer,
    variable_category_id                                 smallint,
    cause_only                                           smallint,
    filling_type                                         text,
    number_of_processed_daily_measurements               integer,
    measurements_at_last_analysis                        integer,
    last_unit_id                                         smallint,
    last_original_unit_id                                smallint,
    last_value                                           double precision,
    last_original_value                                  text,
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
    created_at                                           timestamp,
    updated_at                                           timestamp,
    outcome                                              smallint,
    data_sources_count                                   text,
    earliest_filling_time                                integer,
    latest_filling_time                                  integer,
    last_processed_daily_value                           double precision,
    outcome_of_interest                                  smallint,
    predictor_of_interest                                smallint,
    experiment_start_time                                timestamp,
    experiment_end_time                                  timestamp,
    description                                          text,
    alias                                                varchar(125),
    deleted_at                                           timestamp,
    second_to_last_value                                 double precision,
    third_to_last_value                                  double precision,
    number_of_user_correlations_as_effect                integer,
    number_of_user_correlations_as_cause                 integer,
    combination_operation                                text,
    informational_url                                    varchar(2000),
    most_common_connector_id                             integer,
    valence                                              text,
    wikipedia_title                                      varchar(100),
    number_of_tracking_reminders                         integer,
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
    last_correlated_at                                   timestamp,
    number_of_measurements_with_tags_at_last_correlation integer,
    analysis_settings_modified_at                        timestamp,
    newest_data_at                                       timestamp,
    analysis_requested_at                                timestamp,
    reason_for_analysis                                  varchar(255),
    analysis_started_at                                  timestamp,
    analysis_ended_at                                    timestamp,
    user_error_message                                   text,
    internal_error_message                               text,
    earliest_source_measurement_start_at                 timestamp,
    latest_source_measurement_start_at                   timestamp,
    latest_tagged_measurement_start_at                   timestamp,
    earliest_tagged_measurement_start_at                 timestamp,
    latest_non_tagged_measurement_start_at               timestamp,
    earliest_non_tagged_measurement_start_at             timestamp,
    wp_post_id                                           bigint,
    number_of_soft_deleted_measurements                  integer,
    best_user_correlation_id                             integer,
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
    is_public                                            smallint,
    is_goal                                              smallint,
    controllable                                         smallint,
    boring                                               smallint,
    slug                                                 varchar(200),
    predictor                                            smallint
);

alter table user_variables
    owner to postgres;

create table users
(
    id                                                       bigint,
    client_id                                                varchar(255),
    user_login                                               varchar(60),
    user_email                                               varchar(100),
    email                                                    varchar(320),
    user_nicename                                            varchar(50),
    user_url                                                 varchar(2083),
    user_registered                                          timestamp,
    user_status                                              integer,
    display_name                                             varchar(250),
    avatar_image                                             varchar(2083),
    reg_provider                                             varchar(25),
    provider_id                                              varchar(255),
    provider_token                                           varchar(255),
    updated_at                                               timestamp,
    created_at                                               timestamp,
    unsubscribed                                             smallint,
    old_user                                                 smallint,
    stripe_active                                            smallint,
    stripe_id                                                varchar(255),
    stripe_subscription                                      varchar(255),
    stripe_plan                                              varchar(100),
    trial_ends_at                                            timestamp,
    subscription_ends_at                                     timestamp,
    roles                                                    varchar(255),
    time_zone_offset                                         integer,
    deleted_at                                               timestamp,
    earliest_reminder_time                                   time,
    latest_reminder_time                                     time,
    push_notifications_enabled                               smallint,
    track_location                                           smallint,
    combine_notifications                                    smallint,
    send_reminder_notification_emails                        smallint,
    send_predictor_emails                                    smallint,
    get_preview_builds                                       smallint,
    subscription_provider                                    text,
    last_sms_tracking_reminder_notification_id               bigint,
    sms_notifications_enabled                                smallint,
    phone_verification_code                                  varchar(25),
    phone_number                                             varchar(25),
    has_android_app                                          smallint,
    has_ios_app                                              smallint,
    has_chrome_extension                                     smallint,
    referrer_user_id                                         bigint,
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
    spam                                                     smallint,
    deleted                                                  smallint,
    last_login_at                                            timestamp,
    timezone                                                 varchar(255),
    number_of_correlations                                   integer,
    number_of_connections                                    integer,
    number_of_tracking_reminders                             integer,
    number_of_user_variables                                 integer,
    number_of_raw_measurements_with_tags                     integer,
    number_of_raw_measurements_with_tags_at_last_correlation integer,
    number_of_votes                                          integer,
    number_of_studies                                        integer,
    last_correlation_at                                      timestamp,
    last_email_at                                            timestamp,
    last_push_at                                             timestamp,
    primary_outcome_variable_id                              integer,
    wp_post_id                                               bigint,
    analysis_ended_at                                        timestamp,
    analysis_requested_at                                    timestamp,
    analysis_started_at                                      timestamp,
    internal_error_message                                   text,
    newest_data_at                                           timestamp,
    reason_for_analysis                                      varchar(255),
    user_error_message                                       text,
    status                                                   varchar(25),
    analysis_settings_modified_at                            timestamp,
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
    share_all_data                                           smallint,
    deletion_reason                                          varchar(280),
    number_of_patients                                       integer,
    is_public                                                smallint,
    sort_order                                               integer,
    number_of_sharers                                        integer,
    number_of_trustees                                       integer,
    slug                                                     varchar(200)
);

alter table users
    owner to postgres;

create table variable_categories
(
    id                                           smallint,
    name                                         varchar(64),
    filling_value                                double precision,
    maximum_allowed_value                        double precision,
    minimum_allowed_value                        double precision,
    duration_of_action                           integer,
    onset_delay                                  integer,
    combination_operation                        text,
    cause_only                                   smallint,
    outcome                                      smallint,
    created_at                                   timestamp,
    updated_at                                   timestamp,
    image_url                                    varchar(255),
    default_unit_id                              smallint,
    deleted_at                                   timestamp,
    manual_tracking                              smallint,
    minimum_allowed_seconds_between_measurements integer,
    average_seconds_between_measurements         integer,
    median_seconds_between_measurements          integer,
    wp_post_id                                   bigint,
    filling_type                                 text,
    number_of_outcome_population_studies         integer,
    number_of_predictor_population_studies       integer,
    number_of_outcome_case_studies               integer,
    number_of_predictor_case_studies             integer,
    number_of_measurements                       integer,
    number_of_user_variables                     integer,
    number_of_variables                          integer,
    is_public                                    smallint,
    synonyms                                     varchar(600),
    amazon_product_category                      varchar(100),
    boring                                       smallint,
    effect_only                                  smallint,
    predictor                                    smallint,
    font_awesome                                 varchar(100),
    ion_icon                                     varchar(100),
    more_info                                    varchar(255),
    valence                                      text,
    name_singular                                varchar(255),
    sort_order                                   integer,
    is_goal                                      text,
    controllable                                 text,
    slug                                         varchar(200)
);

alter table variable_categories
    owner to postgres;

create table variable_outcome_category
(
    id                          integer,
    variable_id                 integer,
    variable_category_id        smallint,
    number_of_outcome_variables integer,
    created_at                  timestamp,
    updated_at                  timestamp,
    deleted_at                  timestamp
);

alter table variable_outcome_category
    owner to postgres;

create table variable_predictor_category
(
    id                            integer,
    variable_id                   integer,
    variable_category_id          smallint,
    number_of_predictor_variables integer,
    created_at                    timestamp,
    updated_at                    timestamp,
    deleted_at                    timestamp
);

alter table variable_predictor_category
    owner to postgres;

create table variable_user_sources
(
    user_id                       bigint,
    variable_id                   integer,
    timestamp                     integer,
    earliest_measurement_time     integer,
    latest_measurement_time       integer,
    created_at                    timestamp,
    updated_at                    timestamp,
    deleted_at                    timestamp,
    data_source_name              varchar(80),
    number_of_raw_measurements    integer,
    client_id                     varchar(255),
    id                            integer,
    user_variable_id              integer,
    earliest_measurement_start_at timestamp,
    latest_measurement_start_at   timestamp
);

alter table variable_user_sources
    owner to postgres;

create table wp_posts
(
    id                    bigint,
    post_author           bigint,
    post_date             timestamp,
    post_date_gmt         timestamp,
    post_content          text,
    post_title            text,
    post_excerpt          text,
    post_status           varchar(20),
    comment_status        varchar(20),
    ping_status           varchar(20),
    post_password         varchar(255),
    post_name             varchar(200),
    to_ping               text,
    pinged                text,
    post_modified         timestamp,
    post_modified_gmt     timestamp,
    post_content_filtered text,
    post_parent           bigint,
    guid                  varchar(255),
    menu_order            integer,
    post_type             varchar(20),
    post_mime_type        varchar(100),
    comment_count         bigint,
    updated_at            timestamp,
    created_at            timestamp,
    deleted_at            timestamp,
    client_id             varchar(255),
    record_size_in_kb     integer
);

alter table wp_posts
    owner to postgres;

create table wp_term_taxonomy
(
    term_taxonomy_id bigint,
    term_id          bigint,
    taxonomy         varchar(32),
    description      text,
    parent           bigint,
    count            bigint,
    updated_at       timestamp,
    created_at       timestamp,
    deleted_at       timestamp,
    client_id        varchar(255)
);

alter table wp_term_taxonomy
    owner to postgres;

create table wp_terms
(
    term_id    bigint,
    name       varchar(200),
    slug       varchar(200),
    term_group bigint,
    updated_at timestamp,
    created_at timestamp,
    deleted_at timestamp,
    client_id  varchar(255)
);

alter table wp_terms
    owner to postgres;

create table measurements
(
    id                   bigint,
    user_id              bigint,
    client_id            varchar(80),
    connector_id         bigint,
    variable_id          bigint,
    start_time           bigint,
    value                double precision,
    unit_id              integer,
    original_value       double precision,
    original_unit_id     integer,
    duration             integer,
    note                 text,
    latitude             double precision,
    longitude            double precision,
    location             varchar(255),
    created_at           timestamp,
    updated_at           timestamp,
    error                text,
    variable_category_id smallint,
    deleted_at           timestamp,
    source_name          varchar(80),
    user_variable_id     bigint,
    start_at             timestamp,
    connection_id        bigint,
    connector_import_id  bigint,
    deletion_reason      varchar(280),
    original_start_at    timestamp
);

alter table measurements
    owner to postgres;

create table nc_evolutions
(
    id          serial
        primary key,
    title       varchar(255) not null,
    "titleDown" varchar(255),
    description varchar(255),
    batch       integer,
    checksum    varchar(255),
    status      integer,
    created     timestamp with time zone,
    created_at  timestamp with time zone,
    updated_at  timestamp with time zone
);

alter table nc_evolutions
    owner to postgres;

