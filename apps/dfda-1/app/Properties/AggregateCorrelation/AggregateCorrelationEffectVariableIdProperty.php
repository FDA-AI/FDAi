<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseEffectVariableIdProperty;
use App\Http\Requests\AstralRequest;
class AggregateCorrelationEffectVariableIdProperty extends BaseEffectVariableIdProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public function showOnUpdate(): bool {return false;}
    public function showOnCreate(): bool {return false;}
    public function showOnIndex(): bool {
        return AstralRequest::forRelationshipTable("aggregate_correlations_where_cause_variable");
    }
    public function showOnDetail(): bool {return true;}
}
