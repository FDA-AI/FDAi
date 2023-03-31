<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Models\Correlation;
use \App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseConfidenceLevelProperty;
class CorrelationConfidenceLevelProperty extends BaseConfidenceLevelProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
}
