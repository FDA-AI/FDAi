<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\VariableValueTraits\CauseAggregatedVariableValueTrait;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseGroupedCauseValueClosestToValuePredictingHighOutcomeProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMUserVariableRelationship;
class CorrelationGroupedCauseValueClosestToValuePredictingHighOutcomeProperty extends BaseGroupedCauseValueClosestToValuePredictingHighOutcomeProperty
{
    use CorrelationProperty, CauseAggregatedVariableValueTrait;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserVariableRelationship $model
     * @return float
     */
    public static function calculate($model): float{
        $high = $model->getDailyValuePredictingHighOutcome();
		if($high === null){le("No avgDailyValuePredictingHighOutcome");}
        if($model->setDirection() === QMUserVariableRelationship::DIRECTION_HIGHER){
            $value = $model->calculateClosestCauseValueGroupedOverDurationOfAction($high, $high, null);
        } else {
            $value = $model->calculateClosestCauseValueGroupedOverDurationOfAction($high, null, $high);
        }
        $model->setAttribute(static::NAME, $value);
        return $value;
    }
}
