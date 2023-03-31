<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseEffectVariableCategoryIdProperty;
class AggregateCorrelationEffectVariableCategoryIdProperty extends BaseEffectVariableCategoryIdProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public function showOnUpdate(): bool {return false;}
    public function showOnCreate(): bool {return false;}
    public function showOnIndex(): bool {return false;}
    public function showOnDetail(): bool {return true;}
    public function validate(): void {
        parent::validate();
//        $ac = $this->getAggregateCorrelation();
//        if($ac->number_of_correlations < 2){
//            $this->assertNotBoring(); // We can just mark these correlations as boring in DB
//        }
    }
}
