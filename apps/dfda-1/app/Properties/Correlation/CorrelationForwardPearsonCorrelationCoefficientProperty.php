<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseForwardPearsonCorrelationCoefficientProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Utils\Stats;
use App\Correlations\QMUserCorrelation;
class CorrelationForwardPearsonCorrelationCoefficientProperty extends BaseForwardPearsonCorrelationCoefficientProperty
{
    use CorrelationProperty;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return float|int|null
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     */
    public static function calculate($model){
        $causeValues = $model->getCauseValues();
        $effectValues = $model->getEffectValues();
        $cc = Stats::calculatePearsonCorrelationCoefficient($causeValues, $effectValues);
        $model->setAndValidateAttribute(static::NAME, $cc);
        return $cc;
    }
}
