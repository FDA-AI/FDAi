<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Traits\PropertyTraits\IsPrimaryKey;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseIntegerIdProperty;
class CorrelationIdProperty extends BaseIntegerIdProperty{
	use IsPrimaryKey;
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public $isPrimary = true;
    public $autoIncrement = true;
    public const SYNONYMS = [
        'correlation_id',
        'id',
    ];
}
