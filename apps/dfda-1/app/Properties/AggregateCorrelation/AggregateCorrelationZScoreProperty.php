<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseZScoreProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationZScoreProperty extends BaseZScoreProperty
{
    use AggregateCorrelationProperty, IsAverageOfCorrelations;
    use IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public function showOnIndex(): bool {return true;}
    public function showOnDetail(): bool {return true;}
}
