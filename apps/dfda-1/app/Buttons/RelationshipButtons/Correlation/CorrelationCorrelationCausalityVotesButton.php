<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Correlation;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\Correlation;
use App\Models\CorrelationCausalityVote;
class CorrelationCorrelationCausalityVotesButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = Correlation::class;
	public $qualifiedParentKeyName = Correlation::TABLE . '.' . Correlation::FIELD_ID;
	public $relatedClass = CorrelationCausalityVote::class;
	public $methodName = CorrelationCausalityVote::TABLE;
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = CorrelationCausalityVote::COLOR;
	public $fontAwesome = CorrelationCausalityVote::FONT_AWESOME;
	public $id = 'correlation-causality-votes-button';
	public $image = CorrelationCausalityVote::DEFAULT_IMAGE;
	public $text = 'Correlation Causality Votes';
	public $title = 'Correlation Causality Votes';
	public $tooltip = CorrelationCausalityVote::CLASS_DESCRIPTION;
}
