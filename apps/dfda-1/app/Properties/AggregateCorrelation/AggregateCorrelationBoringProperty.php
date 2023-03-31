<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Models\VariableCategory;
use \App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseBoringProperty;
class AggregateCorrelationBoringProperty extends BaseBoringProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public static function fixNulls(): void {
        self::setNonPredictorCauseCategoriesBoring();
        self::setNonOutcomeEffectCategoriesBoring();
    }
    protected static function setNonPredictorCauseCategoriesBoring(): void{
        foreach(VariableCategory::all() as $cat){
            if(!$cat->predictor && $cat->outcome){
                AggregateCorrelation::whereCauseVariableCategoryId($cat->getId())
                    ->whereNull(AggregateCorrelation::FIELD_BORING)
                    ->update([AggregateCorrelation::FIELD_BORING => true]);
            }
        }
    }
    protected static function setNonOutcomeEffectCategoriesBoring(): void{
        foreach(VariableCategory::all() as $cat){
            if(!$cat->outcome && $cat->predictor){
                AggregateCorrelation::whereCauseVariableCategoryId($cat->getId())
                    ->whereNull(AggregateCorrelation::FIELD_BORING)
                    ->update([AggregateCorrelation::FIELD_BORING => true]);
            }
        }
    }
}
