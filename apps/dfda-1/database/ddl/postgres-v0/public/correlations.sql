create table correlations
(
    id                                                           serial
        primary key,
    user_id                                                      bigint                                 not null
        constraint correlations_user_id_fk
            references wp_users,
    cause_variable_id                                            integer                                not null
        constraint correlations_cause_variable_id_fk
            references variables,
    effect_variable_id                                           integer                                not null
        constraint correlations_effect_variable_id_fk
            references variables,
    qm_score                                                     double precision,
    forward_pearson_correlation_coefficient                      double precision,
    value_predicting_high_outcome                                double precision,
    value_predicting_low_outcome                                 double precision,
    predicts_high_effect_change                                  integer,
    predicts_low_effect_change                                   integer                                not null,
    average_effect                                               double precision                       not null,
    average_effect_following_high_cause                          double precision                       not null,
    average_effect_following_low_cause                           double precision                       not null,
    average_daily_low_cause                                      double precision                       not null,
    average_daily_high_cause                                     double precision                       not null,
    average_forward_pearson_correlation_over_onset_delays        double precision,
    average_reverse_pearson_correlation_over_onset_delays        double precision,
    cause_changes                                                integer                                not null,
    cause_filling_value                                          double precision,
    cause_number_of_processed_daily_measurements                 integer                                not null,
    cause_number_of_raw_measurements                             integer                                not null,
    cause_unit_id                                                smallint
        constraint correlations_cause_unit_id_fk
            references units,
    confidence_interval                                          double precision                       not null,
    critical_t_value                                             double precision                       not null,
    created_at                                                   timestamp(0) default CURRENT_TIMESTAMP not null,
    data_source_name                                             varchar(255),
    deleted_at                                                   timestamp(0),
    duration_of_action                                           integer                                not null,
    effect_changes                                               integer                                not null,
    effect_filling_value                                         double precision,
    effect_number_of_processed_daily_measurements                integer                                not null,
    effect_number_of_raw_measurements                            integer                                not null,
    forward_spearman_correlation_coefficient                     double precision                       not null,
    number_of_days                                               integer                                not null,
    number_of_pairs                                              integer                                not null,
    onset_delay                                                  integer                                not null,
    onset_delay_with_strongest_pearson_correlation               integer,
    optimal_pearson_product                                      double precision,
    p_value                                                      double precision,
    pearson_correlation_with_no_onset_delay                      double precision,
    predictive_pearson_correlation_coefficient                   double precision,
    reverse_pearson_correlation_coefficient                      double precision,
    statistical_significance                                     double precision,
    strongest_pearson_correlation_coefficient                    double precision,
    t_value                                                      double precision,
    updated_at                                                   timestamp(0)                           not null,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision                       not null,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision                       not null,
    client_id                                                    varchar(255)
        constraint correlations_client_id_fk
            references oa_clients,
    published_at                                                 timestamp(0),
    wp_post_id                                                   bigint
        constraint "correlations_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete set null,
    status                                                       varchar(25),
    cause_variable_category_id                                   smallint                               not null
        constraint correlations_cause_variable_category_id_fk
            references variable_categories,
    effect_variable_category_id                                  smallint                               not null,
    interesting_variable_category_pair                           boolean                                not null,
    newest_data_at                                               timestamp(0),
    analysis_requested_at                                        timestamp(0),
    reason_for_analysis                                          varchar(255)                           not null,
    analysis_started_at                                          timestamp(0),
    analysis_ended_at                                            timestamp(0),
    user_error_message                                           text,
    internal_error_message                                       text,
    cause_user_variable_id                                       integer                                not null
        constraint correlations_user_variables_cause_user_variable_id_fk
            references user_variables
            on update cascade on delete cascade,
    effect_user_variable_id                                      integer                                not null
        constraint correlations_user_variables_effect_user_variable_id_fk
            references user_variables
            on update cascade on delete cascade,
    latest_measurement_start_at                                  timestamp(0),
    earliest_measurement_start_at                                timestamp(0),
    cause_baseline_average_per_day                               double precision                       not null,
    cause_baseline_average_per_duration_of_action                double precision                       not null,
    cause_treatment_average_per_day                              double precision                       not null,
    cause_treatment_average_per_duration_of_action               double precision                       not null,
    effect_baseline_average                                      double precision,
    effect_baseline_relative_standard_deviation                  double precision                       not null,
    effect_baseline_standard_deviation                           double precision,
    effect_follow_up_average                                     double precision                       not null,
    effect_follow_up_percent_change_from_baseline                double precision                       not null,
    z_score                                                      double precision,
    experiment_start_at                                          timestamp(0),
    experiment_end_at                                            timestamp(0),
    global_variable_relationship_id                                     integer
        constraint correlations_global_variable_relationships_id_fk
            references global_variable_relationships,
    aggregated_at                                                timestamp(0),
    usefulness_vote                                              integer,
    causality_vote                                               integer,
    deletion_reason                                              varchar(280),
    record_size_in_kb                                            integer,
    correlations_over_durations                                  text,
    correlations_over_delays                                     text,
    is_public                                                    boolean,
    sort_order                                                   integer,
    slug                                                         varchar(200)
        constraint correlations_slug_uindex
            unique,
    boring                                                       boolean,
    outcome_is_goal                                              boolean,
    predictor_is_controllable                                    boolean,
    plausibly_causal                                             boolean,
    obvious                                                      boolean,
    number_of_up_votes                                           integer,
    number_of_down_votes                                         integer,
    strength_level                                               varchar(255)                           not null
        constraint correlations_strength_level_check
            check ((strength_level)::text = ANY
                   ((ARRAY ['VERY STRONG'::character varying, 'STRONG'::character varying, 'MODERATE'::character varying, 'WEAK'::character varying, 'VERY WEAK'::character varying])::text[])),
    confidence_level                                             varchar(255)                           not null
        constraint correlations_confidence_level_check
            check ((confidence_level)::text = ANY
                   ((ARRAY ['HIGH'::character varying, 'MEDIUM'::character varying, 'LOW'::character varying])::text[])),
    relationship                                                 varchar(255)                           not null
        constraint correlations_relationship_check
            check ((relationship)::text = ANY
                   ((ARRAY ['POSITIVE'::character varying, 'NEGATIVE'::character varying, 'NONE'::character varying])::text[])),
    constraint correlations_user_id_cause_variable_id_effect_variable_id_uinde
        unique (user_id, cause_variable_id, effect_variable_id),
    constraint correlations_pk
        unique (user_id, cause_variable_id, effect_variable_id)
);

comment on column correlations.qm_score is 'A number representative of the relative importance of the relationship based on the strength,
                    usefulness, and plausible causality.  The higher the number, the greater the perceived importance.
                    This value can be used for sorting relationships by importance.  ';

comment on column correlations.forward_pearson_correlation_coefficient is 'Pearson correlation coefficient between cause and effect measurements';

comment on column correlations.value_predicting_high_outcome is 'cause value that predicts an above average effect value (in default unit for cause variable)';

comment on column correlations.value_predicting_low_outcome is 'cause value that predicts a below average effect value (in default unit for cause variable)';

comment on column correlations.predicts_high_effect_change is 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ';

comment on column correlations.predicts_low_effect_change is 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.';

comment on column correlations.average_effect is 'The average effect variable measurement value used in analysis in the common unit. ';

comment on column correlations.average_effect_following_high_cause is 'The average effect variable measurement value following an above average cause value (in the common unit). ';

comment on column correlations.average_effect_following_low_cause is 'The average effect variable measurement value following a below average cause value (in the common unit). ';

comment on column correlations.average_daily_low_cause is 'The average of below average cause values (in the common unit). ';

comment on column correlations.average_daily_high_cause is 'The average of above average cause values (in the common unit). ';

comment on column correlations.cause_changes is 'The number of times the cause measurement value was different from the one preceding it. ';

comment on column correlations.cause_unit_id is 'Unit ID of Cause';

comment on column correlations.confidence_interval is 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.';

comment on column correlations.critical_t_value is 'Value of t from lookup table which t must exceed for significance.';

comment on column correlations.duration_of_action is 'Time over which the cause is expected to produce a perceivable effect following the onset delay';

comment on column correlations.effect_changes is 'The number of times the effect measurement value was different from the one preceding it. ';

comment on column correlations.forward_spearman_correlation_coefficient is 'Predictive spearman correlation of the lagged pair data. While the Pearson correlation assesses linear relationships, the Spearman correlation assesses monotonic relationships (whether linear or not).';

comment on column correlations.number_of_pairs is 'Number of points that went into the correlation calculation';

comment on column correlations.onset_delay is 'User estimated or default time after cause measurement before a perceivable effect is observed';

comment on column correlations.optimal_pearson_product is 'Optimal Pearson Product';

comment on column correlations.p_value is 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.';

comment on column correlations.predictive_pearson_correlation_coefficient is 'Predictive Pearson Correlation Coefficient';

comment on column correlations.reverse_pearson_correlation_coefficient is 'User Variable Relationship when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation';

comment on column correlations.statistical_significance is 'A function of the effect size and sample size';

comment on column correlations.t_value is 'Function of correlation and number of samples.';

comment on column correlations.grouped_cause_value_closest_to_value_predicting_low_outcome is 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ';

comment on column correlations.grouped_cause_value_closest_to_value_predicting_high_outcome is 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ';

comment on column correlations.interesting_variable_category_pair is 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ';

comment on column correlations.newest_data_at is 'The time the source data was last updated. This indicated whether the analysis is stale and should be performed again. ';

comment on column correlations.reason_for_analysis is 'The reason analysis was requested.';

comment on column correlations.cause_baseline_average_per_day is 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)';

comment on column correlations.cause_baseline_average_per_duration_of_action is 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)';

comment on column correlations.cause_treatment_average_per_day is 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)';

comment on column correlations.cause_treatment_average_per_duration_of_action is 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)';

comment on column correlations.effect_baseline_average is 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)';

comment on column correlations.effect_baseline_relative_standard_deviation is 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)';

comment on column correlations.effect_baseline_standard_deviation is 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)';

comment on column correlations.effect_follow_up_average is 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)';

comment on column correlations.effect_follow_up_percent_change_from_baseline is 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)';

comment on column correlations.z_score is 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.';

comment on column correlations.experiment_start_at is 'The earliest data used in the analysis. ';

comment on column correlations.experiment_end_at is 'The latest data used in the analysis. ';

comment on column correlations.usefulness_vote is 'The opinion of the data owner on whether or not knowledge of this relationship is useful.
                        -1 corresponds to a down vote. 1 corresponds to an up vote. 0 corresponds to removal of a
                        previous vote.  null corresponds to never having voted before.';

comment on column correlations.causality_vote is 'The opinion of the data owner on whether or not there is a plausible mechanism of action
                        by which the predictor variable could influence the outcome variable.';

comment on column correlations.deletion_reason is 'The reason the variable was deleted.';

comment on column correlations.correlations_over_durations is 'Pearson user_variable_relationships calculated with various duration of action lengths. This can be used to compare short and long term effects. ';

comment on column correlations.correlations_over_delays is 'Pearson user_variable_relationships calculated with various onset delay lags used to identify reversed causality or asses the significant of a correlation with a given lag parameters. ';

comment on column correlations.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column correlations.boring is 'The relationship is boring if it is obvious, the predictor is not controllable, the outcome is not a goal, the relationship could not be causal, or the confidence is low. ';

comment on column correlations.outcome_is_goal is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ';

comment on column correlations.predictor_is_controllable is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ';

comment on column correlations.plausibly_causal is 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ';

comment on column correlations.obvious is 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ';

comment on column correlations.number_of_up_votes is 'Number of people who feel this relationship is plausible and useful. ';

comment on column correlations.number_of_down_votes is 'Number of people who feel this relationship is implausible or not useful. ';

comment on column correlations.strength_level is 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ';

comment on column correlations.confidence_level is 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ';

comment on column correlations.relationship is 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ';

alter table correlations
    owner to postgres;

create index user_id_effect_variable_id_deleted_at_qm_score_index
    on correlations (user_id, effect_variable_id, deleted_at, qm_score);

create index correlations_user_id_deleted_at_qm_score_index
    on correlations (user_id, deleted_at, qm_score);

create index user_id_cause_variable_id_deleted_at_qm_score_index
    on correlations (user_id, cause_variable_id, deleted_at, qm_score);

create index correlations_deleted_at_analysis_ended_at_index
    on correlations (deleted_at, analysis_ended_at);

create index correlations_cause_variable_id_fk
    on correlations (cause_variable_id);

create index correlations_effect_variable_id_fk
    on correlations (effect_variable_id);

create index correlations_cause_unit_id_fk
    on correlations (cause_unit_id);

create index correlations_updated_at_index
    on correlations (updated_at);

create index correlations_client_id_fk
    on correlations (client_id);

create index "correlations_wp_posts_ID_fk"
    on correlations (wp_post_id);

create index correlations_cause_variable_category_id_fk
    on correlations (cause_variable_category_id);

create index c_effect_variable_category_id_fk
    on correlations (effect_variable_category_id);

create index correlations_analysis_started_at_index
    on correlations (analysis_started_at);

create index correlations_user_variables_cause_user_variable_id_fk
    on correlations (cause_user_variable_id);

create index correlations_user_variables_effect_user_variable_id_fk
    on correlations (effect_user_variable_id);

create index correlations_global_variable_relationships_id_fk
    on correlations (global_variable_relationship_id);

