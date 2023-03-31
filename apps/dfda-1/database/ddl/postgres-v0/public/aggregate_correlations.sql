create table aggregate_correlations
(
    id                                                           serial
        primary key,
    forward_pearson_correlation_coefficient                      double precision                           not null,
    onset_delay                                                  integer                                    not null,
    duration_of_action                                           integer                                    not null,
    number_of_pairs                                              integer                                    not null,
    value_predicting_high_outcome                                double precision                           not null,
    value_predicting_low_outcome                                 double precision                           not null,
    optimal_pearson_product                                      double precision                           not null,
    average_vote                                                 double precision default '0.5'::double precision,
    number_of_users                                              integer                                    not null,
    number_of_correlations                                       integer                                    not null,
    statistical_significance                                     double precision                           not null,
    cause_unit_id                                                smallint
        constraint aggregate_correlations_cause_unit_id_fk
            references units,
    cause_changes                                                integer                                    not null,
    effect_changes                                               integer                                    not null,
    aggregate_qm_score                                           double precision                           not null,
    created_at                                                   timestamp(0)     default CURRENT_TIMESTAMP not null,
    updated_at                                                   timestamp(0)     default CURRENT_TIMESTAMP not null,
    status                                                       varchar(25)                                not null,
    reverse_pearson_correlation_coefficient                      double precision                           not null,
    predictive_pearson_correlation_coefficient                   double precision                           not null,
    data_source_name                                             varchar(255),
    predicts_high_effect_change                                  integer                                    not null,
    predicts_low_effect_change                                   integer                                    not null,
    p_value                                                      double precision                           not null,
    t_value                                                      double precision                           not null,
    critical_t_value                                             double precision                           not null,
    confidence_interval                                          double precision                           not null,
    deleted_at                                                   timestamp(0),
    average_effect                                               double precision                           not null,
    average_effect_following_high_cause                          double precision                           not null,
    average_effect_following_low_cause                           double precision                           not null,
    average_daily_low_cause                                      double precision                           not null,
    average_daily_high_cause                                     double precision                           not null,
    population_trait_pearson_correlation_coefficient             double precision,
    grouped_cause_value_closest_to_value_predicting_low_outcome  double precision                           not null,
    grouped_cause_value_closest_to_value_predicting_high_outcome double precision                           not null,
    client_id                                                    varchar(255)
        constraint aggregate_correlations_client_id_fk
            references oa_clients,
    published_at                                                 timestamp(0),
    wp_post_id                                                   bigint
        constraint "aggregate_correlations_wp_posts_ID_fk"
            references wp_posts
            on update cascade on delete set null,
    cause_variable_category_id                                   smallint                                   not null
        constraint aggregate_correlations_cause_variable_category_id_fk
            references variable_categories,
    effect_variable_category_id                                  smallint                                   not null
        constraint aggregate_correlations_effect_variable_category_id_fk
            references variable_categories,
    interesting_variable_category_pair                           boolean                                    not null,
    newest_data_at                                               timestamp(0),
    analysis_requested_at                                        timestamp(0),
    reason_for_analysis                                          varchar(255)                               not null,
    analysis_started_at                                          timestamp(0),
    analysis_ended_at                                            timestamp(0),
    user_error_message                                           text,
    internal_error_message                                       text,
    cause_variable_id                                            integer                                    not null
        constraint aggregate_correlations_cause_variables_id_fk
            references variables,
    effect_variable_id                                           integer                                    not null
        constraint aggregate_correlations_effect_variables_id_fk
            references variables,
    cause_baseline_average_per_day                               double precision                           not null,
    cause_baseline_average_per_duration_of_action                double precision                           not null,
    cause_treatment_average_per_day                              double precision                           not null,
    cause_treatment_average_per_duration_of_action               double precision                           not null,
    effect_baseline_average                                      double precision                           not null,
    effect_baseline_relative_standard_deviation                  double precision                           not null,
    effect_baseline_standard_deviation                           double precision                           not null,
    effect_follow_up_average                                     double precision                           not null,
    effect_follow_up_percent_change_from_baseline                double precision                           not null,
    z_score                                                      double precision                           not null,
    charts                                                       json                                       not null,
    number_of_variables_where_best_aggregate_correlation         integer                                    not null,
    deletion_reason                                              varchar(280),
    record_size_in_kb                                            integer,
    is_public                                                    boolean                                    not null,
    slug                                                         varchar(200)
        constraint aggregate_correlations_slug_uindex
            unique,
    boring                                                       boolean,
    outcome_is_a_goal                                            boolean,
    predictor_is_controllable                                    boolean,
    plausibly_causal                                             boolean,
    obvious                                                      boolean,
    number_of_up_votes                                           integer                                    not null,
    number_of_down_votes                                         integer                                    not null,
    strength_level                                               varchar(255)                               not null
        constraint aggregate_correlations_strength_level_check
            check ((strength_level)::text = ANY
                   ((ARRAY ['VERY STRONG'::character varying, 'STRONG'::character varying, 'MODERATE'::character varying, 'WEAK'::character varying, 'VERY WEAK'::character varying])::text[])),
    confidence_level                                             varchar(255)                               not null
        constraint aggregate_correlations_confidence_level_check
            check ((confidence_level)::text = ANY
                   ((ARRAY ['HIGH'::character varying, 'MEDIUM'::character varying, 'LOW'::character varying])::text[])),
    relationship                                                 varchar(255)                               not null
        constraint aggregate_correlations_relationship_check
            check ((relationship)::text = ANY
                   ((ARRAY ['POSITIVE'::character varying, 'NEGATIVE'::character varying, 'NONE'::character varying])::text[])),
    constraint aggregate_correlations_pk
        unique (cause_variable_id, effect_variable_id),
    constraint cause_variable_id_effect_variable_id_uindex
        unique (cause_variable_id, effect_variable_id)
);

comment on column aggregate_correlations.forward_pearson_correlation_coefficient is 'Pearson correlation coefficient between cause and effect measurements';

comment on column aggregate_correlations.onset_delay is 'User estimated or default time after cause measurement before a perceivable effect is observed';

comment on column aggregate_correlations.duration_of_action is 'Time over which the cause is expected to produce a perceivable effect following the onset delay';

comment on column aggregate_correlations.number_of_pairs is 'Number of points that went into the correlation calculation';

comment on column aggregate_correlations.value_predicting_high_outcome is 'cause value that predicts an above average effect value (in default unit for cause variable)';

comment on column aggregate_correlations.value_predicting_low_outcome is 'cause value that predicts a below average effect value (in default unit for cause variable)';

comment on column aggregate_correlations.optimal_pearson_product is 'Optimal Pearson Product';

comment on column aggregate_correlations.average_vote is 'The average opinion on the causal plausibility of a relationship.';

comment on column aggregate_correlations.number_of_users is 'Number of Users by which correlation is aggregated';

comment on column aggregate_correlations.number_of_correlations is 'Number of Correlations by which correlation is aggregated';

comment on column aggregate_correlations.statistical_significance is 'A function of the effect size and sample size';

comment on column aggregate_correlations.cause_unit_id is 'Unit ID of Cause';

comment on column aggregate_correlations.cause_changes is 'The number of times the cause measurement value was different from the one preceding it.';

comment on column aggregate_correlations.effect_changes is 'The number of times the effect measurement value was different from the one preceding it.';

comment on column aggregate_correlations.aggregate_qm_score is 'A number representative of the relative importance of the relationship based on the strength, usefulness, and plausible causality.  The higher the number, the greater the perceived importance.  This value can be used for sorting relationships by importance. ';

comment on column aggregate_correlations.status is 'Whether the correlation is being analyzed, needs to be analyzed, or is up to date already.';

comment on column aggregate_correlations.reverse_pearson_correlation_coefficient is 'Correlation when cause and effect are reversed. For any causal relationship, the forward correlation should exceed the reverse correlation';

comment on column aggregate_correlations.predictive_pearson_correlation_coefficient is 'Pearson correlation coefficient of cause and effect values lagged by the onset delay and grouped based on the duration of action. ';

comment on column aggregate_correlations.predicts_high_effect_change is 'The percent change in the outcome typically seen when the predictor value is closer to the predictsHighEffect value. ';

comment on column aggregate_correlations.predicts_low_effect_change is 'The percent change in the outcome from average typically seen when the predictor value is closer to the predictsHighEffect value.';

comment on column aggregate_correlations.p_value is 'The measure of statistical significance. A value less than 0.05 means that a correlation is statistically significant or consistent enough that it is unlikely to be a coincidence.';

comment on column aggregate_correlations.t_value is 'Function of correlation and number of samples.';

comment on column aggregate_correlations.critical_t_value is 'Value of t from lookup table which t must exceed for significance.';

comment on column aggregate_correlations.confidence_interval is 'A margin of error around the effect size.  Wider confidence intervals reflect greater uncertainty about the true value of the correlation.';

comment on column aggregate_correlations.average_effect is 'The average effect variable measurement value used in analysis in the common unit. ';

comment on column aggregate_correlations.average_effect_following_high_cause is 'The average effect variable measurement value following an above average cause value (in the common unit). ';

comment on column aggregate_correlations.average_effect_following_low_cause is 'The average effect variable measurement value following a below average cause value (in the common unit). ';

comment on column aggregate_correlations.average_daily_low_cause is 'The average of below average cause values (in the common unit). ';

comment on column aggregate_correlations.average_daily_high_cause is 'The average of above average cause values (in the common unit). ';

comment on column aggregate_correlations.population_trait_pearson_correlation_coefficient is 'The pearson correlation of pairs which each consist of the average cause value and the average effect value for a given user. ';

comment on column aggregate_correlations.grouped_cause_value_closest_to_value_predicting_low_outcome is 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ';

comment on column aggregate_correlations.grouped_cause_value_closest_to_value_predicting_high_outcome is 'A realistic daily value (not a fraction from averaging) that typically precedes below average outcome values. ';

comment on column aggregate_correlations.interesting_variable_category_pair is 'True if the combination of cause and effect variable categories are generally interesting.  For instance, treatment cause variables paired with symptom effect variables are interesting. ';

comment on column aggregate_correlations.reason_for_analysis is 'The reason analysis was requested.';

comment on column aggregate_correlations.cause_baseline_average_per_day is 'Predictor Average at Baseline (The average low non-treatment value of the predictor per day)';

comment on column aggregate_correlations.cause_baseline_average_per_duration_of_action is 'Predictor Average at Baseline (The average low non-treatment value of the predictor per duration of action)';

comment on column aggregate_correlations.cause_treatment_average_per_day is 'Predictor Average During Treatment (The average high value of the predictor per day considered to be the treatment dosage)';

comment on column aggregate_correlations.cause_treatment_average_per_duration_of_action is 'Predictor Average During Treatment (The average high value of the predictor per duration of action considered to be the treatment dosage)';

comment on column aggregate_correlations.effect_baseline_average is 'Outcome Average at Baseline (The normal value for the outcome seen without treatment during the previous duration of action time span)';

comment on column aggregate_correlations.effect_baseline_relative_standard_deviation is 'Outcome Average at Baseline (The average value seen for the outcome without treatment during the previous duration of action time span)';

comment on column aggregate_correlations.effect_baseline_standard_deviation is 'Outcome Relative Standard Deviation at Baseline (How much the outcome value normally fluctuates without treatment during the previous duration of action time span)';

comment on column aggregate_correlations.effect_follow_up_average is 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)';

comment on column aggregate_correlations.effect_follow_up_percent_change_from_baseline is 'Outcome Average at Follow-Up (The average value seen for the outcome during the duration of action following the onset delay of the treatment)';

comment on column aggregate_correlations.z_score is 'The absolute value of the change over duration of action following the onset delay of treatment divided by the baseline outcome relative standard deviation. A.K.A The number of standard deviations from the mean. A zScore > 2 means pValue < 0.05 and is typically considered statistically significant.';

comment on column aggregate_correlations.number_of_variables_where_best_aggregate_correlation is 'Number of Variables for this Best Aggregate Correlation.';

comment on column aggregate_correlations.deletion_reason is 'The reason the variable was deleted.';

comment on column aggregate_correlations.slug is 'The slug is the part of a URL that identifies a page in human-readable keywords.';

comment on column aggregate_correlations.boring is 'The relationship is boring if it is obvious, the predictor is not controllable, or the outcome is not a goal, the relationship could not be causal, or the confidence is low.  ';

comment on column aggregate_correlations.outcome_is_a_goal is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  The foods you eat are not generally an objective end in themselves. ';

comment on column aggregate_correlations.predictor_is_controllable is 'The effect of a food on the severity of a symptom is useful because you can control the predictor directly. However, the effect of a symptom on the foods you eat is not very useful.  Symptom severity is not directly controllable. ';

comment on column aggregate_correlations.plausibly_causal is 'The effect of aspirin on headaches is plausibly causal. The effect of aspirin on precipitation does not have a plausible causal relationship. ';

comment on column aggregate_correlations.obvious is 'The effect of aspirin on headaches is obvious. The effect of aspirin on productivity is not obvious. ';

comment on column aggregate_correlations.number_of_up_votes is 'Number of people who feel this relationship is plausible and useful. ';

comment on column aggregate_correlations.number_of_down_votes is 'Number of people who feel this relationship is implausible or not useful. ';

comment on column aggregate_correlations.strength_level is 'Strength level describes magnitude of the change in outcome observed following changes in the predictor. ';

comment on column aggregate_correlations.confidence_level is 'Describes the confidence that the strength level will remain consist in the future.  The more data there is, the lesser the chance that the findings are a spurious correlation. ';

comment on column aggregate_correlations.relationship is 'If higher predictor values generally precede HIGHER outcome values, the relationship is considered POSITIVE.  If higher predictor values generally precede LOWER outcome values, the relationship is considered NEGATIVE. ';

alter table aggregate_correlations
    owner to postgres;

create index aggregate_correlations_cause_unit_id_fk
    on aggregate_correlations (cause_unit_id);

create index aggregate_correlations_client_id_fk
    on aggregate_correlations (client_id);

create index "aggregate_correlations_wp_posts_ID_fk"
    on aggregate_correlations (wp_post_id);

create index aggregate_correlations_cause_variable_category_id_fk
    on aggregate_correlations (cause_variable_category_id);

create index aggregate_correlations_effect_variable_category_id_fk
    on aggregate_correlations (effect_variable_category_id);

create index aggregate_correlations_effect_variable_id_index
    on aggregate_correlations (effect_variable_id);

