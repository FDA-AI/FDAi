<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\CorrelationCausalityVote;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\CorrelationCausalityVote;
class CorrelationCausalityVoteAggregateCorrelationButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = CorrelationCausalityVote::FIELD_AGGREGATE_CORRELATION_ID;
	public $qualifiedForeignKeyName = CorrelationCausalityVote::TABLE.'.'.CorrelationCausalityVote::FIELD_AGGREGATE_CORRELATION_ID;
	public $ownerKeyName = AggregateCorrelation::FIELD_ID;
	public $qualifiedOwnerKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $childClass = CorrelationCausalityVote::class;
	public $parentClass = CorrelationCausalityVote::class;
	public $qualifiedParentKeyName = CorrelationCausalityVote::TABLE.'.'.CorrelationCausalityVote::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'aggregate_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'aggregate-correlation-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlation';
	public $title = 'Aggregate Correlation';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;

}
