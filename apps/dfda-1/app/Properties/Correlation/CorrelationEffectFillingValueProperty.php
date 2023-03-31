<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\VariableValueTraits\EffectDailyVariableValueTrait;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseEffectFillingValueProperty;
class CorrelationEffectFillingValueProperty extends BaseEffectFillingValueProperty
{
    use CorrelationProperty, EffectDailyVariableValueTrait;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public function getExample(): ?float{
        $c = $this->getCorrelation();
        $v = $c->getEffectVariable();
        return $v->getFillingValueAttribute();
    }
}
