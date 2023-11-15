<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseEffectFollowUpAverageProperty;
use App\Utils\Stats;
use Illuminate\Support\Arr;
use App\Correlations\QMUserVariableRelationship;
class CorrelationEffectFollowUpAverageProperty extends BaseEffectFollowUpAverageProperty
{
    use CorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserVariableRelationship $model
     * @return float|null
     * @throws \App\Exceptions\NotEnoughDataException
     * @throws \App\Exceptions\TooSlowToAnalyzeException
     * @noinspection PhpMissingReturnTypeInspection
     */
    public static function calculate($model) {
        $followupPairs = $model->getFollowupPairs();
        $followUpEffectValues = Arr::pluck($followupPairs, 'effectMeasurementValue');
        $val = Stats::average($followUpEffectValues);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
