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
class VariablePopulationEffectStudiesButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'population_effect_studies';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME_EFFECTS;
	public $id = 'population-effect-studies-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Outcomes';
	public $title = 'Outcomes';
	public $tooltip = "Analyses of possible effects of this variable for the average person based on aggregated population level data. ";
}
