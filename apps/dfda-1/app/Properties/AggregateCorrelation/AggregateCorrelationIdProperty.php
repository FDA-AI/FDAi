<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Traits\PropertyTraits\IsPrimaryKey;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseIntegerIdProperty;
class AggregateCorrelationIdProperty extends BaseIntegerIdProperty{
	use IsPrimaryKey;
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public $isPrimary = true;
    public $autoIncrement = true;
    public const SYNONYMS = [
        'aggregate_correlation_id',
        'id',
    ];
    public function validate(): void {
        parent::validate();
    }
    public function cannotBeChangedToNull(): bool{
        return parent::cannotBeChangedToNull();
    }
}
