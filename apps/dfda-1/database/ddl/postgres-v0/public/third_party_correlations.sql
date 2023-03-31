create table third_party_correlations
(
    cause_id                                                     integer                                not null
        constraint third_party_correlations_cause_variables_id_fk
            references variables,
    effect_id                                                    integer                                not null
        constraint third_party_correlations_effect_variables_id_fk
            references variables,
    qm_score                                                     double precision,
    forward_pearson_correlation_coefficient                      double precision,
    value_predicting_high_outcome                                double precision,
    value_predicting_low_outcome                                 double precision,
    predicts_high_effect_change                                  integer,
    predicts_low_effect_change                                   integer,
    average_effect                                               double precision,
    average_effect_following_high_cause                          double precision,
    average_effect_following_low_cause                           double precision,
    average_daily_low_cause                                      double precision,
    average_daily_high_cause                                     double precision,
    average_forward_pearson_correlation_over_onset_delays        double precision,
    average_reverse_pearson_correlation_over_onset_delays        double precision,
    cause_changes                                                integer,
    cause_filling_value                                          double precision,
    cause_number_of_processed_daily_measurements                 integer                                not null,
    cause_number_of_raw_measurements                             integer                                not null,
    cause_unit_id                                                integer,
    confidence_interval                                          double precision,
    critical_t_value                                             double precision,
    created_at                                                   timestamp(0) default CURRENT_TIMESTAMP not null,
    data_source_name                                             varchar(255),
    deleted_at                                                   timestamp(0),
    duration_of_action                                           integer,
    effect_changes                                               integer,
    effect_filling_value                                         double precision,
    effect_number_of_processed_daily_measurements                integer                                not null,
    effect_number_of_raw_measurements                            integer                                not null,
    error                                                        text,
    forward_spearman_correlation_coefficient                     double precision,
    id                                                           serial
        primary key,
    number_of_days                                               integer                                not null,
    number_of_pairs                                              integer,
    onset_delay                                                  integer,
    onset_delay_with_strongest_pearson_correlation               integer,
    optimal_pearson_product                                      double precision,
    p_value                                                      double precision,
    pearson_correlation_with_no_onset_delay                      double precision,
    predictive_pearson_correlation_coefficient                   double precision,
    reverse_pearson_correlation_coefficient                      double precision,
    statistical_significance                                     double precision,
    strongest_pearson_correlation_coefficient                    double precision,
    t_value                                                      double precision,
    updated_at                                                   timestamp(0) default CURRENT_TIMESTAMP not null,
    user_id                                                      bigint                                 not null,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision,
    client_id                                                    varchar(255)                           not null
        constraint third_party_correlations_client_id_fk
            references oa_clients,
    published_at                                                 timestamp(0),
    wp_post_id                                                   integer,
    status                                                       varchar(25),
    cause_variable_category_id                                   smallint                               not null
        constraint third_party_correlations_cause_variable_category_id_fk
            references variable_categories,
    effect_variable_category_id                                  smallint                               not null
        constraint third_party_correlations_effect_variable_category_id_fk
            references variable_categories,
    interesting_variable_category_pair                           boolean,
    cause_variable_id                                            integer,
    effect_variable_id                                           integer,
    constraint tpc_user_cause_effect
        unique (user_id, cause_id, effect_id)
);

alter table third_party_correlations
    owner to postgres;

