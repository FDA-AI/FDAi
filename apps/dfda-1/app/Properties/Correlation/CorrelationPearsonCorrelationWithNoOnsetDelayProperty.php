<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BasePearsonCorrelationWithNoOnsetDelayProperty;
use App\Correlations\QMUserCorrelation;
class CorrelationPearsonCorrelationWithNoOnsetDelayProperty extends BasePearsonCorrelationWithNoOnsetDelayProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    use \App\Traits\PropertyTraits\IsCalculated;
    /**
     * @param QMUserCorrelation $model
     * @return float|null
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     * @noinspection PhpMissingReturnTypeInspection
     */
    public static function calculate($model) {
        $overDelays = $model->getOverDelays();
        /** @var QMUserCorrelation $zero */
        $zero = collect($overDelays)
            ->where('onsetDelay', 0)
            ->where('durationOfAction', CorrelationCorrelationsOverDelaysProperty::DURATION)
            ->first();
        if(!$zero){
            $model->logError("No correlation with zero onset delay!");
            return null;
        }
        $val = $zero->getForwardPearsonCorrelationCoefficient();
        $model->setAttribute(self::NAME, $val);
        return $val;
    }
}
