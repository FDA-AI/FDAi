<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Correlation;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\UI\FontAwesome;
use App\UI\HtmlHelper;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
class CorrelationAggregateCorrelationButton extends BelongsToRelationshipButton {
	public $interesting = true;
	public $foreignKeyName = Correlation::FIELD_AGGREGATE_CORRELATION_ID;
	public $qualifiedForeignKeyName = Correlation::TABLE . '.' . Correlation::FIELD_AGGREGATE_CORRELATION_ID;
	public $ownerKeyName = AggregateCorrelation::FIELD_ID;
	public $qualifiedOwnerKeyName = AggregateCorrelation::TABLE . '.' . AggregateCorrelation::FIELD_ID;
	public $childClass = Correlation::class;
	public $parentClass = Correlation::class;
	public $qualifiedParentKeyName = Correlation::TABLE . '.' . Correlation::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = 'aggregate_correlation';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = FontAwesome::PEOPLE_ARROWS_SOLID;
	public $id = 'aggregate-correlation-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlation';
	public $title = 'Aggregate Correlation';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
	public function __construct($methodOrModel = null, BelongsTo $relation = null){
		parent::__construct($methodOrModel, $relation);
		$this->setTooltip(AggregateCorrelation::CLASS_DESCRIPTION);
		$this->title = AggregateCorrelation::getClassNameTitle();
	}
	public function getUrl(array $params = []): string{
		return parent::getUrl($params);
	}
	public function getTooltip(): ?string{
		return $this->tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
	}
	public function getTitleAttribute(): string{
		return $this->title = AggregateCorrelation::getClassNameTitle();
	}
	public function getMaterialStatCard(): string{
		return HtmlHelper::generateMaterialStatCard("Aggregate Correlation", "The Relationship for the Average Person",
			$this->getTooltip(), $this->getBackgroundColor(), $this->getFontAwesome(), $this->getUrl());
	}
}
