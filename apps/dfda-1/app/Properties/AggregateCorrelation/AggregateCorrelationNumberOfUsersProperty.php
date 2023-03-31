<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseNumberOfUsersProperty;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationNumberOfUsersProperty extends BaseNumberOfUsersProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public $minimum = 1;
    const MIN_FOR_REQUEST = 2;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param AggregateCorrelation $model
     * @return int
     */
    public static function calculate($model): int{
        $correlations = $model->getCorrelations();
        $ids = $correlations->unique(Correlation::FIELD_USER_ID);
        $model->setAttribute(static::NAME, $val = $ids->count());
        return $val;
    }
    public function showOnUpdate(): bool {return false;}
    public function showOnCreate(): bool {return false;}
    public function showOnIndex(): bool {return true;}
    public function showOnDetail(): bool {return true;}
}
