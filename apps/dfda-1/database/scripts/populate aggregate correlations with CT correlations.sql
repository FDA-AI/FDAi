INSERT INTO aggregate_correlations (
  aggregate_correlations.correlation,
onset_delay,
duration_of_action,
aggregate_correlations.cause_variable_id,
aggregate_correlations.effect_variable_id,
aggregate_correlations.number_of_pairs,
aggregate_correlations.optimal_pearson_product,
aggregate_correlations.number_of_users,
aggregate_correlations.number_of_correlations,
aggregate_correlations.statistical_significance,
aggregate_correlations.aggregate_qm_score,
aggregate_correlations.reverse_pearson_correlation_coefficient,
aggregate_correlations.predictive_pearson_correlation_coefficient,
aggregate_correlations.`status`
)
SELECT
  correlations.forward_pearson_correlation_coefficient,
  0,
  86400,
  correlations.cause_variable_id,
  correlations.effect_variable_id,
  correlations.number_of_pairs,
  ABS(correlations.forward_pearson_correlation_coefficient),
  correlations.number_of_pairs,
  correlations.number_of_pairs,
  1-EXP(-correlations.number_of_pairs/100),
  ABS(correlations.forward_pearson_correlation_coefficient) * (1-EXP(-correlations.number_of_pairs/100)),
  0,
  correlations.forward_pearson_correlation_coefficient,
  'CT'
FROM
  correlations
WHERE correlations.user_id = 2