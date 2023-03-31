<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\VariableValueTraits\EffectDailyVariableValueTrait;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseAverageEffectFollowingHighCauseProperty;
use App\Correlations\QMUserCorrelation;
class CorrelationAverageEffectFollowingHighCauseProperty extends BaseAverageEffectFollowingHighCauseProperty
{
    use CorrelationProperty, EffectDailyVariableValueTrait;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return float
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     * @noinspection PhpMissingReturnTypeInspection
     */
    public static function calculate($model){
        $highPairs = $model->getHighCausePairs();
        $val = CorrelationAverageEffectProperty::calculateAverageEffectForPairSubset($highPairs);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
