SELECT
	count(
		`aggregate_correlations`.`id`
	) AS `number_of_aggregate_correlations_as_effect`,
	`variables`.`id` AS `id`
FROM
	(
		`variables`
		JOIN `aggregate_correlations` ON (
			(
				`aggregate_correlations`.`effect_variable_id` = `variables`.`id`
			)
		)
	)
GROUP BY
	`variables`.`id`
LIMIT 1000