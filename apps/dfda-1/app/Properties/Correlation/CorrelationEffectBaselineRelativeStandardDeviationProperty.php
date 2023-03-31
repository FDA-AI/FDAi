<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseEffectBaselineRelativeStandardDeviationProperty;
use App\Correlations\QMUserCorrelation;
class CorrelationEffectBaselineRelativeStandardDeviationProperty extends BaseEffectBaselineRelativeStandardDeviationProperty
{
    use CorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return float|null
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     * @noinspection PhpMissingReturnTypeInspection
     */
    public static function calculate($model) {
        $baselineEffectMean = CorrelationEffectBaselineAverageProperty::calculate($model);
        $baselineEffectStdDev = CorrelationEffectBaselineStandardDeviationProperty::calculate($model);
        if((float)$baselineEffectMean === (float)0 || $model->getEffectVariableCommonUnit()->isPercent()){
            $val = $baselineEffectStdDev;
        } else {
            $val = $baselineEffectStdDev/$baselineEffectMean * 100;
        }
        $val = round($val, 1);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
