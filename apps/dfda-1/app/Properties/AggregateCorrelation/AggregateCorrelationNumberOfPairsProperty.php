<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseNumberOfPairsProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationNumberOfPairsProperty extends BaseNumberOfPairsProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public const MIN_PAIRS_FOR_PUBLIC = 3;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return float
     * @throws \App\Exceptions\NoUserCorrelationsToAggregateException
     */
    public static function calculate($model): float{
        $val = $model->summedUserCorrelationValue(static::NAME);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
