<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\AggregateCorrelation;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\Unit;
use App\Models\AggregateCorrelation;
class AggregateCorrelationCauseUnitButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = AggregateCorrelation::FIELD_CAUSE_UNIT_ID;
	public $qualifiedForeignKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_CAUSE_UNIT_ID;
	public $ownerKeyName = Unit::FIELD_ID;
	public $qualifiedOwnerKeyName = Unit::TABLE.'.'.Unit::FIELD_ID;
	public $childClass = AggregateCorrelation::class;
	public $parentClass = AggregateCorrelation::class;
	public $qualifiedParentKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $relatedClass = Unit::class;
	public $methodName = 'cause_unit';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = Unit::COLOR;
	public $fontAwesome = Unit::FONT_AWESOME;
	public $id = 'cause-unit-button';
	public $image = Unit::DEFAULT_IMAGE;
	public $text = 'Cause Unit';
	public $title = 'Cause Unit';
	public $tooltip = Unit::CLASS_DESCRIPTION;

}
