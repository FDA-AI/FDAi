<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Logging\QMLog;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Properties\Unit\UnitNameProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseCauseUnitIdProperty;
use App\Types\QMArr;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationCauseUnitIdProperty extends BaseCauseUnitIdProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public $isCalculated = true;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $aggregateCorrelation
     * @return int
     */
    public static function calculate($aggregateCorrelation): ?int {
        $values = $aggregateCorrelation->pluckFromCorrelations(Correlation::FIELD_CAUSE_UNIT_ID);
        if(!$values){
            QMLog::info("TODO: Fix correlation cause units");
            return null;
        }
        $unique = array_unique($values);
        if(count($unique) !== 1){
            $recalculated = $aggregateCorrelation->recalculateUserCorrelationsWithWrongCauseUnitId();
            $newValues = $aggregateCorrelation->pluckFromCorrelations(Correlation::FIELD_CAUSE_UNIT_ID);
            $uniqueAfter = array_unique($newValues);
            if(count($uniqueAfter) !== 1){
                le("Different cause units for $aggregateCorrelation even after recalculation: ".
                   \App\Logging\QMLog::print_r(UnitNameProperty::fromIds($uniqueAfter), true).$aggregateCorrelation->getPHPUnitTestUrl());
            }
        }
        $unitId = QMArr::first($values);
        $aggregateCorrelation->setAttribute(static::NAME, $unitId);
        return $unitId;
    }
    public function showOnUpdate(): bool {return false;}
    public function showOnCreate(): bool {return false;}
    public function showOnIndex(): bool {return false;}
    public function showOnDetail(): bool {return false;}
}
