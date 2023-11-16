create table ct_correlations
(
    id                            serial
        primary key,
    user_id                       integer                                    not null,
    correlation_coefficient       double precision,
    cause_variable_id             integer                                    not null,
    effect_variable_id            integer                                    not null,
    onset_delay                   integer,
    duration_of_action            integer,
    number_of_pairs               integer,
    value_predicting_high_outcome double precision,
    value_predicting_low_outcome  double precision,
    optimal_pearson_product       double precision,
    vote                          double precision default '0.5'::double precision,
    statistical_significance      double precision,
    cause_unit_id                 integer,
    cause_changes                 integer,
    effect_changes                integer,
    qm_score                      double precision,
    error                         text,
    created_at                    timestamp(0)     default CURRENT_TIMESTAMP not null,
    updated_at                    timestamp(0)     default CURRENT_TIMESTAMP not null,
    deleted_at                    timestamp(0),
    constraint ct_correlations_user
        unique (user_id, cause_variable_id, effect_variable_id)
);

alter table ct_correlations
    owner to postgres;

create index cause
    on ct_correlations (cause_variable_id);

create index effect
    on ct_correlations (effect_variable_id);

