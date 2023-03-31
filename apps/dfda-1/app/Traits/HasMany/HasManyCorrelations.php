<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Traits\HasMany;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\Utils\Stats;
trait HasManyCorrelations {
	/**
	 * @param string $attribute
	 * @return array
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function getUserCorrelationValues(string $attribute): array{
		$userCorrelations = $this->getCorrelations();
		if(!$userCorrelations->count()){
			throw new NoUserCorrelationsToAggregateException($this);
		}
		return $userCorrelations->pluck($attribute)->all();
	}
	/**
	 * @param string $attribute
	 * @return float
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function summedUserCorrelationValue(string $attribute): float{
		$values = $this->getUserCorrelationValues($attribute);
		return Stats::sum($values);
	}
	/**
	 * @param string $attribute
	 * @return float
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function averageUserCorrelationValue(string $attribute): float{
		$values = $this->getUserCorrelationValues($attribute);
		return Stats::average($values);
	}
	/**
	 * @param string $attribute
	 * @return float
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function minimumUserCorrelationValue(string $attribute): float{
		$values = $this->getUserCorrelationValues($attribute);
		return min($values);
	}
	/**
	 * @param string $attribute
	 * @return float
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function weightedAvgFromUserCorrelations(string $attribute): ?float{
		$correlations = $this->getCorrelations();
		if(!$correlations->count()){
			throw new NoUserCorrelationsToAggregateException($this);
		}
		$numerators = [];
		$avgStatisticalSignificance = $correlations->avg('statistical_significance');
		$weightedValues = [];
		/** @var Correlation $c */
		foreach($correlations as $c){
			$statisticalSignificanceAttribute = $c->getStatisticalSignificanceAttribute();
			if(!$statisticalSignificanceAttribute){
				$c->logError("No statistical significance attribute for correlation $c->id");
				continue;
			}
			$weight = $statisticalSignificanceAttribute / $avgStatisticalSignificance;
			$val = $c->getAttribute($attribute);
			if($val === null){
				$c->logError("No value for attribute $attribute for correlation $c->id");
				continue;
			}
			$weightedValues[] = $val * $weight;
		}
		if(!$weightedValues){
			$this->logError("No weighted values for attribute $attribute");
			throw new NoUserCorrelationsToAggregateException($this);
		}
		$weightedAvg = Stats::average($weightedValues);
		return $weightedAvg;
	}
}
