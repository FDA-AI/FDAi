<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Base;
class BaseBestAggregateCorrelationIdProperty extends BaseAggregateCorrelationIdProperty{
	public $description = 'The global variable relationship including this variable with the greatest strength and statistical power';
	public $name = self::NAME;
	public const NAME = 'best_aggregate_correlation_id';
	public $title = 'Best Aggregate Correlation';
	public $type = self::TYPE_INTEGER;
	public $canBeChangedToNull = true;
}
