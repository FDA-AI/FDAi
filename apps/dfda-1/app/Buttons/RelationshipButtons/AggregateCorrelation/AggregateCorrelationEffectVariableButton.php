<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\AggregateCorrelation;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\Variable;
use App\Models\AggregateCorrelation;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
class AggregateCorrelationEffectVariableButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = AggregateCorrelation::FIELD_EFFECT_VARIABLE_ID;
	public $qualifiedForeignKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_EFFECT_VARIABLE_ID;
	public $ownerKeyName = Variable::FIELD_ID;
	public $qualifiedOwnerKeyName = Variable::TABLE.'.'.Variable::FIELD_ID;
	public $childClass = AggregateCorrelation::class;
	public $parentClass = AggregateCorrelation::class;
	public $qualifiedParentKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $relatedClass = Variable::class;
	public $methodName = 'effect_variable';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = Variable::COLOR;
	public $fontAwesome = Variable::FONT_AWESOME;
	public $id = 'effect-variable-button';
	public $image = Variable::DEFAULT_IMAGE;
	public $text = 'Effect Variable';
	public $title = 'Effect Variable';
	public $tooltip = Variable::CLASS_DESCRIPTION;
    /**
     * CorrelationCauseUserVariableButton constructor.
     * @param AggregateCorrelation $methodOrModel
     * @param BelongsTo|null $relation
     */
    public function __construct($methodOrModel, BelongsTo $relation = null){
        parent::__construct($methodOrModel, $relation);
        $this->setTextAndTitle($methodOrModel->getEffectVariableName());
    }
}
