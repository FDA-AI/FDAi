<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseCauseChangesProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationCauseChangesProperty extends BaseCauseChangesProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return int
     */
    public static function calculate($model): int {
        $val = $model->summedUserCorrelationValue(static::NAME);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
