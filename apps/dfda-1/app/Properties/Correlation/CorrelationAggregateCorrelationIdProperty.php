<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Logging\QMLog;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Storage\DB\Writable;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseAggregateCorrelationIdProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Correlations\QMUserCorrelation;
class CorrelationAggregateCorrelationIdProperty extends BaseAggregateCorrelationIdProperty
{
    use CorrelationProperty;
    use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @param QMUserCorrelation|Correlation $model
     * @return mixed|void
     */
    public static function calculate($model){
        $ac = AggregateCorrelation::whereCauseVariableId($model->getCauseVariableId())
            ->where(AggregateCorrelation::FIELD_EFFECT_VARIABLE_ID, $model->getEffectVariableId())
            ->first();
        if($ac){
            $model->setAttribute(static::NAME, $ac->id);
        }
        return $ac->id;
    }
    public static function updateAll(){
        $updated = Writable::statementStatic("
            update correlations c
                join aggregate_correlations ac
                    on ac.cause_variable_id = c.cause_variable_id and
                       ac.effect_variable_id = c.effect_variable_id
                set c.aggregate_correlation_id = ac.id
        ");
        QMLog::info("Updated aggregate_correlation_id for all correlations!");
    }
}
