<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Traits\HasModel;
use App\Buttons\QMButton;
use App\Models\AggregateCorrelation;
use App\Models\BaseModel;
trait HasAggregateCorrelation {
	/**
	 * @return AggregateCorrelation
	 */
	public function findAggregateCorrelation(): ?AggregateCorrelation{
		return AggregateCorrelation::findByData([
			AggregateCorrelation::FIELD_CAUSE_VARIABLE_ID => $this->getCauseVariableId(),
			AggregateCorrelation::FIELD_EFFECT_VARIABLE_ID => $this->getEffectVariableId(),
		]);
	}
	public function getAggregateCorrelationId(): ?int{
		if(property_exists($this, 'aggregateCorrelationId')){
			return $this->aggregateCorrelationId;
		}
		return $this->getAttribute('aggregate_correlation_id');
	}
	public function getAggregateCorrelationButton(): QMButton{
		/** @var AggregateCorrelation $aggregateCorrelation */
		if($this instanceof BaseModel){
			$aggregateCorrelation = $this->relations['aggregate_correlation'] ?? null;
		} else{
			$aggregateCorrelation = $this->aggregateCorrelation ?? null;
		}
		if($aggregateCorrelation){
			return $aggregateCorrelation->getButton();
		}
		return AggregateCorrelation::generateDataLabShowButton($this->getAggregateCorrelationId());
	}
	/**
	 * @throws \App\Exceptions\NotEnoughDataException
	 */
	public function getAggregateCorrelationNameLink(): string{
		return $this->findAggregateCorrelation()->getDataLabDisplayNameLink();
	}
}
