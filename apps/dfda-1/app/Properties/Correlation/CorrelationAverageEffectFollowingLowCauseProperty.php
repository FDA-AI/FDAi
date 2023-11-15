<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\Traits\PropertyTraits\IsCalculated;
use App\Traits\VariableValueTraits\EffectVariableValueTrait;
use App\Properties\Base\BaseAverageEffectFollowingLowCauseProperty;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Correlations\QMUserVariableRelationship;
class CorrelationAverageEffectFollowingLowCauseProperty extends BaseAverageEffectFollowingLowCauseProperty
{
    use EffectVariableValueTrait, CorrelationProperty;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserVariableRelationship $model
     * @return float
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     */
    public static function calculate($model): float{
        $lowPairs = $model->getLowCausePairs();
        $val = CorrelationAverageEffectProperty::calculateAverageEffectForPairSubset($lowPairs);
        $effect = $model->getEffectVariable();
        $min = $effect->getMinimumAllowedDailyValue();
        if($min !== null && $val < $min){
            QMLog::exceptionIfTesting("$val too small");
        }
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
