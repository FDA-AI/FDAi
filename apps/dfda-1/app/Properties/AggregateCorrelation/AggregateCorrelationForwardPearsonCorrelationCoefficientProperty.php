<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseForwardPearsonCorrelationCoefficientProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationForwardPearsonCorrelationCoefficientProperty extends BaseForwardPearsonCorrelationCoefficientProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    use IsCalculated;
    /**
     * @param QMAggregateCorrelation $model
     * @return float
     * @throws \App\Exceptions\NoUserCorrelationsToAggregateException
     */
    public static function calculate($model): float{
        $val = $model->weightedAvgFromUserCorrelations(static::NAME);
        if($val === null){
            $val = $model->weightedAvgFromUserCorrelations(static::NAME);
        }
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
    public function showOnIndex(): bool {return true;}
    public function showOnDetail(): bool {return true;}
}
