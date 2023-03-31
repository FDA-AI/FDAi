DELETE
correlations
FROM
correlations
INNER JOIN `variables` AS cvars ON cvars.id = correlations.cause_variable_id
INNER JOIN `variables` AS evars ON correlations.effect_variable_id = evars.id
WHERE
evars.variable_category_id = cvars.variable_category_id;

DELETE
aggregate_correlations
FROM
aggregate_correlations
INNER JOIN `variables` AS cvars ON cvars.id = aggregate_correlations.cause_variable_id
INNER JOIN `variables` AS evars ON aggregate_correlations.effect_variable_id = evars.id
WHERE
evars.variable_category_id = cvars.variable_category_id;
