<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseCauseVariableIdProperty;
use App\Http\Requests\AstralRequest;
class AggregateCorrelationCauseVariableIdProperty extends BaseCauseVariableIdProperty
{
    use AggregateCorrelationProperty;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    public function showOnUpdate(): bool {return false;}
    public function showOnCreate(): bool {return false;}
    public function showOnIndex(): bool {
        return AstralRequest::forRelationshipTable("aggregate_correlations_where_effect_variable");
    }
    public function showOnDetail(): bool {return true;}
}
