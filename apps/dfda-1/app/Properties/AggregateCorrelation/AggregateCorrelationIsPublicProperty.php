<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Logging\QMLog;
use App\Models\AggregateCorrelation;
use App\Models\Variable;
use App\Properties\Correlation\CorrelationAggregateCorrelationIdProperty;
use App\Properties\Correlation\CorrelationIsPublicProperty;
use App\Storage\DB\Writable;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseIsPublicProperty;
use App\Traits\PropertyTraits\IsCalculated;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Relations\HasMany;
class AggregateCorrelationIsPublicProperty extends BaseIsPublicProperty
{
    use AggregateCorrelationProperty,
        IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param AggregateCorrelation $model
     * @return bool
     */
    public static function calculate($model): bool{
        $val = $model->hasPublicCorrelation();
        if($model->getCauseVariable()->getIsPublic() && $model->getEffectVariable()->getIsPublic()){
            $val  = true;
        }
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
    public static function updateAll(){
        CorrelationAggregateCorrelationIdProperty::updateAll();
        CorrelationIsPublicProperty::updateAll();
        self::setPublicWhereUserCorrelationIsPublic();
        self::setPrivateWhereOneVariableIsPrivate();
        self::setPublicWhereBothVariablesArePublic();
    }
    protected static function setPublicWhereBothVariablesArePublic(): void{
        $updated = AggregateCorrelation::whereHas('cause_variable',
            function($q){
                return $q->where(Variable::FIELD_IS_PUBLIC, 1);
            })->whereHas('effect_variable',
            function($q){
                return $q->where(Variable::FIELD_IS_PUBLIC, 1);
            })->update([AggregateCorrelation::FIELD_IS_PUBLIC => true]);
        QMLog::info("Set $updated aggregate correlations PUBLIC where the cause and effect were public");
    }
    protected static function setPrivateWhereOneVariableIsPrivate(): void{
        $updated = AggregateCorrelation::whereHas('cause_variable',
            function($q){
                return $q->whereNotNull(Variable::FIELD_IS_PUBLIC)
                    ->where(Variable::FIELD_IS_PUBLIC, 0);
            })->update([AggregateCorrelation::FIELD_IS_PUBLIC => false]);
        QMLog::info("Set $updated aggregate correlations PRIVATE where the cause was private");
        $updated = AggregateCorrelation::whereHas('effect_variable',
            function($q){
                return $q->whereNotNull(Variable::FIELD_IS_PUBLIC)
                    ->where(Variable::FIELD_IS_PUBLIC, 0);
            })->update([AggregateCorrelation::FIELD_IS_PUBLIC => false]);
        QMLog::info("Set $updated aggregate correlations PRIVATE where the effect was private");
    }
    protected static function setPublicWhereUserCorrelationIsPublic(): void{
        Writable::statementStatic("
            update aggregate_correlations ac
            join correlations c on ac.id = c.aggregate_correlation_id
            set ac.is_public = true
            where c.is_public = true;
        ");
    }
    /**
     * @param Builder|HasMany $qb
     * @return mixed
     */
    public static function restrict($qb){
        return $qb->where(self::NAME, true)
            ->orderByDesc(AggregateCorrelation::FIELD_NUMBER_OF_PAIRS)
            ->where(AggregateCorrelation::FIELD_NUMBER_OF_PAIRS, ">",
                AggregateCorrelationNumberOfPairsProperty::MIN_PAIRS_FOR_PUBLIC)
            ->limit(500)
            ;
    }
}
