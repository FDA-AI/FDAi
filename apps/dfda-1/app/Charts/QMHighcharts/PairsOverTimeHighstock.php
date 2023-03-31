<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Charts\QMHighcharts;
use App\Charts\QMChart;
use App\Correlations\QMUserCorrelation;
class PairsOverTimeHighstock extends MultivariateHighstock {
	protected $correlationId;
	protected $correlation;
	/**
	 * @param QMUserCorrelation|int $correlationOrId
	 * @param QMChart|null $QMChart
	 */
	public function __construct($correlationOrId = null, QMChart $QMChart = null){
		if(!$this->qmChart){$this->qmChart = $QMChart;}
		if(is_int($correlationOrId)){
			$this->correlationId = $correlationOrId;
		} else{
			/** @var QMUserCorrelation $correlationOrId */
			$this->correlationId = $correlationOrId->id;
			$this->correlation = $correlationOrId;
		}
		parent::__construct([], $QMChart);
	}
	public function getVariables(): array{
		$c = $this->getCorrelation();
		return [$c->getCauseQMVariable(), $c->getEffectQMVariable()];
	}
	/**
	 * @return QMUserCorrelation
	 */
	public function getCorrelation(): QMUserCorrelation{
		if($c = $this->correlation){
			return $c;
		}
		if($this->correlationId){
			return $this->correlation = QMUserCorrelation::find($this->correlationId);
		}
		throw new \LogicException("No correlation");
	}
}
