<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\CorrelationUsefulnessVote;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\CorrelationUsefulnessVote;
class CorrelationUsefulnessVoteAggregateCorrelationButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = CorrelationUsefulnessVote::FIELD_AGGREGATE_CORRELATION_ID;
	public $qualifiedForeignKeyName = CorrelationUsefulnessVote::TABLE.'.'.CorrelationUsefulnessVote::FIELD_AGGREGATE_CORRELATION_ID;
	public $ownerKeyName = AggregateCorrelation::FIELD_ID;
	public $qualifiedOwnerKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $childClass = CorrelationUsefulnessVote::class;
	public $parentClass = CorrelationUsefulnessVote::class;
	public $qualifiedParentKeyName = CorrelationUsefulnessVote::TABLE.'.'.CorrelationUsefulnessVote::FIELD_ID;
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
