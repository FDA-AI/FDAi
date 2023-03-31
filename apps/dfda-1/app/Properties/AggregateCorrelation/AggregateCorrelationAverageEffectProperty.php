<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseAverageEffectProperty;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationAverageEffectProperty extends BaseAverageEffectProperty
{
    use AggregateCorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
	/**
	 * @param QMAggregateCorrelation|AggregateCorrelation $model
	 * @return float
	 * @throws NoUserCorrelationsToAggregateException
	 */
    public static function calculate($model): float{
        $val = $model->weightedAvgFromUserCorrelations(static::NAME);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
