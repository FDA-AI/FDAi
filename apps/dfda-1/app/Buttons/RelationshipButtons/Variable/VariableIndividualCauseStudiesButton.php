<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\Correlation;
use App\Models\Variable;
class VariableIndividualCauseStudiesButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = Correlation::class;
	public $methodName = 'individual_cause_studies';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = Correlation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME;
	public $id = 'individual-cause-studies-button';
	public $image = Correlation::DEFAULT_IMAGE;
	public $text = 'Individual Cause Studies';
	public $title = 'Individual Cause Studies';
	public $tooltip = Correlation::CLASS_DESCRIPTION;
}
