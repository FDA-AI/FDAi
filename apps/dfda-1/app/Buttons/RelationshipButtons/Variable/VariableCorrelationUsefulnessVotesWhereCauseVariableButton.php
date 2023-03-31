<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\CorrelationUsefulnessVote;
use App\Models\Variable;
class VariableCorrelationUsefulnessVotesWhereCauseVariableButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = CorrelationUsefulnessVote::class;
	public $methodName = 'correlation_usefulness_votes_where_cause_variable';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = CorrelationUsefulnessVote::COLOR;
	public $fontAwesome = CorrelationUsefulnessVote::FONT_AWESOME;
	public $id = 'correlation-usefulness-votes-where-cause-variable-button';
	public $image = CorrelationUsefulnessVote::DEFAULT_IMAGE;
	public $text = 'Correlation Usefulness Votes Where Cause Variable';
	public $title = 'Correlation Usefulness Votes Where Cause Variable';
	public $tooltip = 'Correlation Usefulness Votes where this is the Cause Variable';
}
