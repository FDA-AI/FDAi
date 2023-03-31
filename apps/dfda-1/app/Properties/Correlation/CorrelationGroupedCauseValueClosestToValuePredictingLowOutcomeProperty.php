<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
use App\Properties\Base\BaseGroupedCauseValueClosestToValuePredictingLowOutcomeProperty;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Traits\VariableValueTraits\CauseAggregatedVariableValueTrait;
class CorrelationGroupedCauseValueClosestToValuePredictingLowOutcomeProperty extends BaseGroupedCauseValueClosestToValuePredictingLowOutcomeProperty
{
    use CorrelationProperty, CauseAggregatedVariableValueTrait;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param Correlation $model
     * @return float
     */
    public static function calculate($model): float{
        $low = $model->getDailyValuePredictingLowOutcome();
        if($low === null){le("No avgDailyValuePredicting LOW Outcome");}
        if($model->getDirection() === QMUserCorrelation::DIRECTION_HIGHER){
            $value = $model->calculateClosestCauseValueGroupedOverDurationOfAction($low, null, $low);
        } else {
            $value = $model->calculateClosestCauseValueGroupedOverDurationOfAction($low, $low);
        }
        $model->setAttribute(static::NAME, $value);
        return $value;
    }
}
