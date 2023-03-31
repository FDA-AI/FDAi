<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Variable;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\Variable;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
class VariableBestAggregateCorrelationButton extends BelongsToRelationshipButton {
	public $interesting = true;
	public $foreignKeyName = Variable::FIELD_BEST_AGGREGATE_CORRELATION_ID;
	public $qualifiedForeignKeyName = Variable::TABLE . '.' . Variable::FIELD_BEST_AGGREGATE_CORRELATION_ID;
	public $ownerKeyName = AggregateCorrelation::FIELD_ID;
	public $qualifiedOwnerKeyName = AggregateCorrelation::TABLE . '.' . AggregateCorrelation::FIELD_ID;
	public $childClass = Variable::class;
	public $parentClass = Variable::class;
	public $qualifiedParentKeyName = Variable::TABLE . '.' . Variable::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'best_aggregate_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'best-aggregate-correlation-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Best Aggregate Correlation';
	public $title = 'Best Aggregate Correlation';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
	public function __construct($methodOrModel, BelongsTo $relation = null){
		parent::__construct($methodOrModel, $relation);
	}
}
