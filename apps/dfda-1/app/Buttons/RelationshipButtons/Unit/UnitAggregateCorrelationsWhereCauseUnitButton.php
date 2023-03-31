<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Unit;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\Unit;
class UnitAggregateCorrelationsWhereCauseUnitButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = Unit::class;
	public $qualifiedParentKeyName = Unit::TABLE . '.' . Unit::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'aggregate_correlations_where_cause_unit';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'aggregate-correlations-where-cause-unit-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlations Where Cause Unit';
	public $title = 'Aggregate Correlations Where Cause Unit';
	public $tooltip = 'Aggregate Correlations where this is the Cause Unit';
}
