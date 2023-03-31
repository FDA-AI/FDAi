<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseAverageDailyHighCauseProperty;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationAverageDailyHighCauseProperty extends BaseAverageDailyHighCauseProperty
{
    use AggregateCorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return float
     */
    public static function calculate($model): float{
	    try {
		    $val = $model->weightedAvgFromUserCorrelations(static::NAME);
	    } catch (NoUserCorrelationsToAggregateException $e) {
			le($e);
	    }
	    $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
