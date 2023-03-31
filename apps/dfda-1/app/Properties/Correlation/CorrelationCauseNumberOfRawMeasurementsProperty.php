<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Properties\UserVariable\UserVariableNumberOfRawMeasurementsWithTagsJoinsChildrenProperty;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseCauseNumberOfRawMeasurementsProperty;
use App\Correlations\QMUserCorrelation;
class CorrelationCauseNumberOfRawMeasurementsProperty extends BaseCauseNumberOfRawMeasurementsProperty
{
    use CorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation $model
     * @return int
     */
    public static function calculate($model): int {
        $cause = $model->getOrSetCauseQMVariable();
        $value = UserVariableNumberOfRawMeasurementsWithTagsJoinsChildrenProperty::calculate($cause);
        $model->setAttribute(static::NAME, $value);
        return $value;
    }
}
