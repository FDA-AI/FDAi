create or replace view aggregate_correlations_aggregated_by_cause_variable_id as
	select `aggregate_correlations`.`cause_variable_id` AS `cause_variable_id`,
       count(`aggregate_correlations`.`id`)         AS `number_of_aggregate_correlations_as_cause`
from `aggregate_correlations`
where isnull(`aggregate_correlations`.`deleted_at`)
group by `aggregate_correlations`.`cause_variable_id`;

