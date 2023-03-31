<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseEffectBaselineRelativeStandardDeviationProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationEffectBaselineRelativeStandardDeviationProperty extends BaseEffectBaselineRelativeStandardDeviationProperty
{
    use AggregateCorrelationProperty, IsAverageOfCorrelations;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    use \App\Traits\PropertyTraits\IsCalculated;
}
