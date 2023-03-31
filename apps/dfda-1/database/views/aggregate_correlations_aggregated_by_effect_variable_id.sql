create or replace view aggregate_correlations_aggregated_by_effect_variable_id as
	select `aggregate_correlations`.`effect_variable_id` AS `effect_variable_id`,
       count(`aggregate_correlations`.`id`)          AS `number_of_aggregate_correlations_as_effect`
from `aggregate_correlations`
where isnull(`aggregate_correlations`.`deleted_at`)
group by `aggregate_correlations`.`effect_variable_id`;

