<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\UserVariableRelationship;
use App\Models\Variable;
class VariableCorrelationsWhereCauseVariableButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = UserVariableRelationship::class;
	public $methodName = 'correlations_where_cause_variable';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = UserVariableRelationship::COLOR;
	public $fontAwesome = UserVariableRelationship::FONT_AWESOME;
	public $id = 'correlations-where-cause-variable-button';
	public $image = UserVariableRelationship::DEFAULT_IMAGE;
	public $text = 'Correlations Where Cause Variable';
	public $title = 'Correlations Where Cause Variable';
	public $tooltip = 'Correlations where this is the Cause Variable';
}
