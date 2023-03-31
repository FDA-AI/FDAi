<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseOnsetDelayProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationOnsetDelayProperty extends BaseOnsetDelayProperty
{
    use AggregateCorrelationProperty, IsAverageOfCorrelations;
    use IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public $canBeChangedToNull = false;
    public $required = true;
}
