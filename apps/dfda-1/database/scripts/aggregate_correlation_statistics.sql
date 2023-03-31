--Create this view called correlations_statistics

SELECT
	`correlations`.`cause_variable_id` AS `cause_variable_id`,
	`correlations`.`effect_variable_id` AS `effect_variable_id`,
	avg(
		`correlations`.`critical_t_value`
	) AS `critical_t_value`,
	avg(`correlations`.`t_value`) AS `t_value`,
	avg(`correlations`.`p_value`) AS `p_value`,
	avg(
		`correlations`.`confidence_interval`
	) AS `confidence_interval`
FROM
	`correlations`
GROUP BY
	`correlations`.`cause_variable_id`,
	`correlations`.`effect_variable_id`

--  Run this query

UPDATE aggregate_correlations
INNER JOIN correlations_statistics on aggregate_correlations.cause_variable_id = correlations_statistics.cause_variable_id
AND aggregate_correlations.effect_variable_id = correlations_statistics.effect_variable_id
SET
aggregate_correlations.critical_t_value = correlations_statistics.critical_t_value,
aggregate_correlations.t_value = correlations_statistics.t_value,
aggregate_correlations.p_value = correlations_statistics.p_value,
aggregate_correlations.confidence_interval = correlations_statistics.confidence_interval