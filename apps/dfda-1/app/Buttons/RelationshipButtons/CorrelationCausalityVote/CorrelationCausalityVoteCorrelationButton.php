<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\CorrelationCausalityVote;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\Correlation;
use App\Models\CorrelationCausalityVote;
class CorrelationCausalityVoteCorrelationButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = CorrelationCausalityVote::FIELD_CORRELATION_ID;
	public $qualifiedForeignKeyName = CorrelationCausalityVote::TABLE.'.'.CorrelationCausalityVote::FIELD_CORRELATION_ID;
	public $ownerKeyName = Correlation::FIELD_ID;
	public $qualifiedOwnerKeyName = Correlation::TABLE.'.'.Correlation::FIELD_ID;
	public $childClass = CorrelationCausalityVote::class;
	public $parentClass = CorrelationCausalityVote::class;
	public $qualifiedParentKeyName = CorrelationCausalityVote::TABLE.'.'.CorrelationCausalityVote::FIELD_ID;
	public $relatedClass = Correlation::class;
	public $methodName = 'correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = Correlation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME;
	public $id = 'correlation-button';
	public $image = Correlation::DEFAULT_IMAGE;
	public $text = 'Correlation';
	public $title = 'Correlation';
	public $tooltip = Correlation::CLASS_DESCRIPTION;

}
