<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Properties\Base\BaseStatusProperty;
use App\Properties\Correlation\CorrelationStatusProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
class AggregateCorrelationStatusProperty extends BaseStatusProperty
{
    use AggregateCorrelationProperty;

    const STATUS_WAITING = 'WAITING';
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public $enum = [
        CorrelationStatusProperty::STATUS_UPDATED,
        CorrelationStatusProperty::STATUS_ANALYZING,
        CorrelationStatusProperty::STATUS_ERROR,
        CorrelationStatusProperty::STATUS_WAITING,
    ];
    protected function isLowerCase():bool{return false;}
	public function getEnumOptions(): array{
		return $this->enum;
	}
}
