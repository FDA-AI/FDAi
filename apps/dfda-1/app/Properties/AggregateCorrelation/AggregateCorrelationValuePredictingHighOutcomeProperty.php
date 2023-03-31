<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\VariableValueTraits\CauseDailyVariableValueTrait;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseValuePredictingHighOutcomeProperty;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationValuePredictingHighOutcomeProperty extends BaseValuePredictingHighOutcomeProperty
{
    use AggregateCorrelationProperty, CauseDailyVariableValueTrait;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public const SYNONYMS = [
        'avgDailyValuePredictingHighOutcome',
    ];
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return float
     */
    public static function calculate($model){
        $val = $model->weightedAvgFromUserCorrelations(static::NAME);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
