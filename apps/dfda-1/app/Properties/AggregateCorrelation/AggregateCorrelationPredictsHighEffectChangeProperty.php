<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Properties\Base\BasePredictsHighEffectChangeProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationPredictsHighEffectChangeProperty extends BasePredictsHighEffectChangeProperty {
	use AggregateCorrelationProperty, IsAverageOfCorrelations;
	use IsCalculated;
	public $parentClass = AggregateCorrelation::class;
	public $table = AggregateCorrelation::TABLE;
}
