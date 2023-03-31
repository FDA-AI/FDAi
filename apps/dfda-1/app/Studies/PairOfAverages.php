<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Studies;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
class PairOfAverages {
    public float $causeVariableAverageValue;
    public float $effectVariableAverageValue;
    protected int $causeUserVariableId;
    protected int $effectUserVariableId;
    protected AggregateCorrelation $aggregateCorrelation;
    protected int $number;
	/**
	 * @var \App\Models\Correlation
	 */
	private Correlation $correlation;
	/**
	 * @param \App\Models\Correlation $correlation
	 */
	public function __construct(Correlation $correlation) {
		$this->correlation = $correlation;
		$this->causeUserVariableId = $correlation->cause_user_variable_id;
		$this->effectUserVariableId = $correlation->effect_user_variable_id;
		$this->number = $correlation->user_id;
		$this->setAggregateCorrelation($correlation->getAggregateCorrelation());
		$this->causeVariableAverageValue = $correlation->getCauseUserVariable()->mean;
		$this->effectVariableAverageValue = $correlation->getEffectUserVariable()->getMean();
    }
    /**
     * @return int
     */
    public function getUserId(): ?int{
        return $this->number;
    }
    /**
     * @return int
     */
    public function getCauseVariableId(): int{
        return $this->getAggregateCorrelation()->getCauseVariableId();
    }
    /**
     * @return int
     */
    public function getEffectVariableId(): int{
        return $this->getAggregateCorrelation()->getEffectVariableId();
    }
    /**
     * @return AggregateCorrelation
     */
    public function getAggregateCorrelation(): ?AggregateCorrelation{
        return $this->aggregateCorrelation;
    }
	/**
	 * @param \App\Models\AggregateCorrelation $aggregateCorrelation
	 */
    public function setAggregateCorrelation(AggregateCorrelation $aggregateCorrelation): void{
        $this->aggregateCorrelation = $aggregateCorrelation;
    }
    /**
     * @return int
     */
    public function getCauseUserVariableId(): int {
        return $this->causeUserVariableId;
    }
    /**
     * @return int
     */
    public function getEffectUserVariableId(): int {
        return $this->effectUserVariableId;
    }

    /**
     * @return Correlation
     */
    public function getCorrelation(): Correlation
    {
        return $this->correlation;
    }
}
