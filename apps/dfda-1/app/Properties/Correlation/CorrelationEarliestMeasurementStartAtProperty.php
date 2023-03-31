<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseEarliestMeasurementStartAtProperty;
use App\Correlations\QMUserCorrelation;
class CorrelationEarliestMeasurementStartAtProperty extends BaseEarliestMeasurementStartAtProperty
{
    use CorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return int
     */
    public static function calculate($model) {
        // TODO $model->setAttribute(static::NAME, $value);
        //return $value;
    }
}
