<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use App\Traits\VariableValueTraits\CauseDailyVariableValueTrait;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseCauseFillingValueProperty;
class CorrelationCauseFillingValueProperty extends BaseCauseFillingValueProperty
{
    use CorrelationProperty, CauseDailyVariableValueTrait;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public function getExample(): ?float{
        $c = $this->getCorrelation();
        $v = $c->getCauseVariable();
        return $v->getFillingValueAttribute();
    }
}
