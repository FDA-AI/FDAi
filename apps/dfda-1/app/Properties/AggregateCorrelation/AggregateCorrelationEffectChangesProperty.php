<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseEffectChangesProperty;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationEffectChangesProperty extends BaseEffectChangesProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    use \App\Traits\PropertyTraits\IsCalculated;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return float
     */
    public static function calculate($model){
        $val = $model->summedUserCorrelationValue(static::NAME);
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
