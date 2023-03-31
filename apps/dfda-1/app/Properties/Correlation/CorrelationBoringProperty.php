<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Models\VariableCategory;
use \App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseBoringProperty;
class CorrelationBoringProperty extends BaseBoringProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public static function fixNulls(): void {
        self::setNonPredictorCauseCategoriesBoring();
        self::setNonOutcomeEffectCategoriesBoring();
    }
    protected static function setNonPredictorCauseCategoriesBoring(): void{
        foreach(VariableCategory::all() as $cat){
            if(!$cat->predictor && $cat->outcome){
                Correlation::whereCauseVariableCategoryId($cat->getId())
                    ->whereNull(Correlation::FIELD_BORING)
                    ->update([Correlation::FIELD_BORING => true]);
            }
        }
    }
    protected static function setNonOutcomeEffectCategoriesBoring(): void{
        foreach(VariableCategory::all() as $cat){
            if(!$cat->outcome && $cat->predictor){
                Correlation::whereCauseVariableCategoryId($cat->getId())
                    ->whereNull(Correlation::FIELD_BORING)
                    ->update([Correlation::FIELD_BORING => true]);
            }
        }
    }
}
