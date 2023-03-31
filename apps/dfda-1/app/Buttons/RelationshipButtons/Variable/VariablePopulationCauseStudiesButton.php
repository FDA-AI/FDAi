<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Models\Variable;
class VariablePopulationCauseStudiesButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'population_cause_studies';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME_CAUSES;
	public $id = 'population-cause-studies-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Factors';
	public $title = 'Factors';
	public $tooltip = "Analyses of factors that could influence this variable for the average person based on aggregated population level data. ";
}
