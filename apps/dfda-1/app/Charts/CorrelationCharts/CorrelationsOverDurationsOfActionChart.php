<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Charts\CorrelationCharts;
use App\Charts\QMHighcharts\CorrelationsOverDurationsOfActionHighchart;
use App\Charts\QMHighcharts\HighchartConfig;
use App\Correlations\QMUserCorrelation;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Logging\QMLog;
use App\Studies\QMUserStudy;
class CorrelationsOverDurationsOfActionChart extends CorrelationChart {
	/**
	 * @param QMUserCorrelation|QMUserStudy|null $c
	 */
	public function __construct($c = null){
		if(!$c){
			return;
		}
		try {
			$c = $c->getQMUserCorrelation();
		} catch (NotEnoughDataException $e) {
			return;
		}
		$this->setExplanation("Correlation between outcome and aggregated predictor measurements over given number of days"
		//"If the curve exhibits a semi-normal distribution, the duration of action with ".
		//" the peak correlation is most likely to be the duration over which ".$correlation->getCauseVariableDisplayNameWithoutSuffix(). " has an effect on ".
		//$correlation->getEffectVariableDisplayNameWithoutSuffix()."."
		);
		parent::__construct($c, "Correlation Between " . $c->getCauseNameWithoutCategoryOrUnit() . " and " .
			$c->getEffectNameWithoutCategoryOrUnit() . " by Duration of Action");
		$l = $c->l();
		if($l->correlations_over_durations){
			try {
				$this->generateHighchartConfig();
			} catch (NotEnoughDataException | TooSlowToAnalyzeException $e) {
				le($e);
			}
		}
	}
	/**
	 * @return HighchartConfig
	 * @throws TooSlowToAnalyzeException
	 * @throws NotEnoughDataException
	 */
	public function generateHighchartConfig(): HighchartConfig{
		//if(AppMode::isApiRequest()){$this->throwTooSlowException();}
		$correlation = $this->getSourceObject();
		\App\Logging\ConsoleLog::info(__METHOD__);
		$l = $correlation->l();
		if($arr = $l->getCorrelationsOverDurations()){
			$config = new CorrelationsOverDurationsOfActionHighchart($correlation);
		} else{
			$config = $correlation->calculateCorrelationOverDurationsOfActionAndGenerateChartConfig();
		}
		$config->setTitle($this->getTitleAttribute());
		$config->setSubtitle($this->getSubtitleAttribute());
		return $this->setHighchartConfig($config);
	}
}
