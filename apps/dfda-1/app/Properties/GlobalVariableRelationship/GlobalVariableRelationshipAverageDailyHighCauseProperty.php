<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\GlobalVariableRelationship;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Models\GlobalVariableRelationship;
use App\Traits\PropertyTraits\GlobalVariableRelationshipProperty;
use App\Properties\Base\BaseAverageDailyHighCauseProperty;
use App\Correlations\QMGlobalVariableRelationship;
class GlobalVariableRelationshipAverageDailyHighCauseProperty extends BaseAverageDailyHighCauseProperty
{
    use GlobalVariableRelationshipProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = GlobalVariableRelationship::TABLE;
    public $parentClass = GlobalVariableRelationship::class;
    /**
     * @param QMGlobalVariableRelationship|GlobalVariableRelationship $model
     * @return float
     */
    public static function calculate($model): float{
	    try {
		    $val = $model->weightedAvgFromUserCorrelations(static::NAME);
	    } catch (NoUserCorrelationsToAggregateException $e) {
			le($e);
	    }
	    $model->setAttribute(static::NAME, $val);
        return $val;
    }
}
