<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Traits\PropertyTraits;
use App\Models\AggregateCorrelation;
use App\Traits\HasModel\HasAggregateCorrelation;
trait AggregateCorrelationProperty {
	use HasAggregateCorrelation;
	public function getAggregateCorrelationId(): int{
		return $this->getParentModel()->getId();
	}
	public function getAggregateCorrelation(): AggregateCorrelation{
		return $this->getParentModel();
	}
}
