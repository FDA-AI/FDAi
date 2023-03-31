<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\UserVariable;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\Correlation;
use App\Models\UserVariable;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
class UserVariableBestUserCorrelationButton extends BelongsToRelationshipButton {
	public $interesting = true;
	public $foreignKeyName = UserVariable::FIELD_BEST_USER_CORRELATION_ID;
	public $qualifiedForeignKeyName = UserVariable::TABLE . '.' . UserVariable::FIELD_BEST_USER_CORRELATION_ID;
	public $ownerKeyName = Correlation::FIELD_ID;
	public $qualifiedOwnerKeyName = Correlation::TABLE . '.' . Correlation::FIELD_ID;
	public $childClass = UserVariable::class;
	public $parentClass = UserVariable::class;
	public $qualifiedParentKeyName = UserVariable::TABLE . '.' . UserVariable::FIELD_ID;
	public $relatedClass = Correlation::class;
	public $methodName = 'best_user_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = Correlation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME;
	public $id = 'best-user-correlation-button';
	public $image = Correlation::DEFAULT_IMAGE;
	public $text = 'Best User Correlation';
	public $title = 'Best User Correlation';
	public $tooltip = Correlation::CLASS_DESCRIPTION;
	public function __construct($methodOrModel, BelongsTo $relation = null){
		parent::__construct($methodOrModel, $relation);
	}
}
