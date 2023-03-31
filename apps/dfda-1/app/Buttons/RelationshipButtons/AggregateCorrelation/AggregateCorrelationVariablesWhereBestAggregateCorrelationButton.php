<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\AggregateCorrelation;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\Variable;
use App\Models\AggregateCorrelation;
class AggregateCorrelationVariablesWhereBestAggregateCorrelationButton extends HasManyRelationshipButton {
    public $interesting = true;
	public $parentClass = AggregateCorrelation::class;
	public $qualifiedParentKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $relatedClass = Variable::class;
	public $methodName = 'variables_where_best_aggregate_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = Variable::COLOR;
	public $fontAwesome = Variable::FONT_AWESOME;
	public $id = 'variables-where-best-aggregate-correlation-button';
	public $image = Variable::DEFAULT_IMAGE;
	public $text = 'Variables Where Best Aggregate Correlation';
	public $title = 'Variables Where Best Aggregate Correlation';
	public $tooltip = 'Variables where this is the Best Aggregate Correlation';

}
