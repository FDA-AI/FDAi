<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Exceptions\NotEnoughDataException;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseAverageForwardPearsonCorrelationOverOnsetDelaysProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Types\QMStr;
use App\Correlations\QMUserCorrelation;
class CorrelationAverageForwardPearsonCorrelationOverOnsetDelaysProperty extends BaseAverageForwardPearsonCorrelationOverOnsetDelaysProperty
{
    use CorrelationProperty;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return float
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     */
    public static function calculate($model): float{
        $correlations = $model->getOverDelays();
        $key = QMStr::camelize(Correlation::FIELD_FORWARD_PEARSON_CORRELATION_COEFFICIENT);
        $forward = collect($correlations)->where('onsetDelay', ">", 0);
        if(!$forward->count()){
            throw new NotEnoughDataException($model, "No Forward correlations for $model");
        }
        $values = $forward->pluck($key);
        $val = $values->avg();
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
