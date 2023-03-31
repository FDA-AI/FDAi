<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseCriticalTValueProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationCriticalTValueProperty extends BaseCriticalTValueProperty
{
    use IsCalculated;
    use AggregateCorrelationProperty, IsAverageOfCorrelations;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
}
