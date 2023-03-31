<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Correlation;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\Correlation;
use App\Models\UserVariable;
class CorrelationUserVariablesWhereBestUserCorrelationButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = Correlation::class;
	public $qualifiedParentKeyName = Correlation::TABLE . '.' . Correlation::FIELD_ID;
	public $relatedClass = UserVariable::class;
	public $methodName = 'user_variables_where_best_user_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = UserVariable::COLOR;
	public $fontAwesome = UserVariable::FONT_AWESOME;
	public $id = 'user-variables-where-best-user-correlation-button';
	public $image = UserVariable::DEFAULT_IMAGE;
	public $text = 'User Variables Where Best User Correlation';
	public $title = 'User Variables Where Best User Correlation';
	public $tooltip = 'User Variables where this is the Best User Correlation';
}
