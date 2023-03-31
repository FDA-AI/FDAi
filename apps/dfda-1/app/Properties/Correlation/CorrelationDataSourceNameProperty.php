<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
use App\Properties\AggregateCorrelation\AggregateCorrelationDataSourceNameProperty;
use App\Properties\Base\BaseDataSourceNameProperty;
use App\Traits\PropertyTraits\CorrelationProperty;
class CorrelationDataSourceNameProperty extends BaseDataSourceNameProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;

    /**
     * @return int
     */
    public static function fixDataSourceNamesForUserCorrelations()
    {
        $names = BaseDataSourceNameProperty::get3rdPartyDataSourceNames();
        $result = QMUserCorrelation::writable()
            ->whereNotIn(Correlation::FIELD_DATA_SOURCE_NAME, $names)
            ->update([Correlation::FIELD_DATA_SOURCE_NAME => AggregateCorrelationDataSourceNameProperty::DATA_SOURCE_NAME_USER]);
        return $result;
    }
}
