<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseDataSourceNameProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationDataSourceNameProperty extends BaseDataSourceNameProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public const DATA_SOURCE_NAME_MedDRA = "MedDRA";
    public const DATA_SOURCE_NAME_CURE_TOGETHER = "ct";
    public const DATA_SOURCE_NAME_USER = "user";
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return string
     */
    public static function calculate($model): string {
        $names = $model->pluckFromCorrelations(static::NAME);
        $names = array_unique($names);
        $val = implode(', ',$names);
        $model->setAttribute(static::NAME, $val);
        if(empty($val)){
            $val = self::DATA_SOURCE_NAME_USER;
        }
        return $val;
    }
}
