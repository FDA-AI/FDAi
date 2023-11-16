<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\User;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\UserVariableRelationship;
use App\Models\User;
class UserVariableRelationshipsButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = User::class;
	public $qualifiedParentKeyName = 'id';
	public $relatedClass = UserVariableRelationship::class;
	public $methodName = UserVariableRelationship::TABLE;
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = UserVariableRelationship::COLOR;
	public $fontAwesome = UserVariableRelationship::FONT_AWESOME;
	public $id = 'correlations-button';
	public $image = UserVariableRelationship::DEFAULT_IMAGE;
	public $text = 'Correlations';
	public $title = 'Correlations';
	public $tooltip = UserVariableRelationship::CLASS_DESCRIPTION;
}
