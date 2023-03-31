<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\VariableCategory;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\VariableCategory;
class VariableCategoryAggregateCorrelationsWhereCauseVariableCategoryButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = VariableCategory::class;
	public $qualifiedParentKeyName = VariableCategory::TABLE . '.' . VariableCategory::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'aggregate_correlations_where_cause_variable_category';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'aggregate-correlations-where-cause-variable-category-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlations Where Cause Variable Category';
	public $title = 'Aggregate Correlations Where Cause Variable Category';
	public $tooltip = 'Aggregate Correlations where this is the Cause Variable Category';
}
