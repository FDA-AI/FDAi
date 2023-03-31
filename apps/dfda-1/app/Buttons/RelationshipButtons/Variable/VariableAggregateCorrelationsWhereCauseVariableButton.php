<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\BaseModel;
use App\Models\UserVariable;
use App\Models\Variable;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
class VariableAggregateCorrelationsWhereCauseVariableButton extends HasManyRelationshipButton {
	public $interesting = false;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'aggregate_correlations_where_cause_variable';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'aggregate-correlations-where-cause-variable-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlations Where Cause Variable';
	public $title = 'Aggregate Correlations Where Cause Variable';
	public $tooltip = 'Aggregate Correlations where this is the Cause Variable';
	public function __construct($methodOrModel, HasMany $relation = null){
		parent::__construct($methodOrModel, $relation);
		$this->setTooltip("Outcomes that could be influenced by " . $this->getVariable()->getTitleAttribute() .
			" based on aggregated population level data");
	}
	/**
	 * @return BaseModel|UserVariable|Model
	 */
	public function getVariable(){
		return $this->getParent();
	}
}
