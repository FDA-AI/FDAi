<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseCauseTreatmentAveragePerDurationOfActionProperty;
use App\Utils\Stats;
use Illuminate\Support\Arr;
use App\Correlations\QMUserCorrelation;
class CorrelationCauseTreatmentAveragePerDurationOfActionProperty extends BaseCauseTreatmentAveragePerDurationOfActionProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    use \App\Traits\PropertyTraits\IsCalculated;
    /**
     * @param QMUserCorrelation $model
     * @return int
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     */
    public static function calculate($model): float {
        $pairs = $model->getFollowupPairs();
        $causeTreatmentValues = Arr::pluck($pairs, 'causeMeasurementValue');
        $value = Stats::average($causeTreatmentValues, 3);
        $model->setAttribute(static::NAME, $value);
        return $value;
    }
}
