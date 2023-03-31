<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn 
 */

namespace App\Charts\CorrelationCharts;
use App\Charts\QMHighcharts\CorrelationsOverOnsetDelaysHighchart;
use App\Charts\QMHighcharts\HighchartConfig;
use App\Correlations\QMUserCorrelation;
use App\Exceptions\AnalysisException;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\NotEnoughMeasurementsForCorrelationException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Studies\QMUserStudy;
class CorrelationsOverOnsetDelaysChart extends CorrelationChart {
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
		$this->setExplanation("Peak correlation suggests the delay between predictor and observable outcome"
		//"If the curve exhibits a semi-normal distribution, the onset delay with ".
		//" the peak correlation is most likely to be the amount of time before ".$correlation->getCauseVariableDisplayNameWithoutSuffix().
		//" produces an observable effect on ".$correlation->getEffectVariableDisplayNameWithoutSuffix()."."
		);
		parent::__construct($c, "Correlation Between " . $c->getCauseNameWithoutCategoryOrUnit() . " and " .
			$c->getEffectNameWithoutCategoryOrUnit() . " by Onset Delay");
		$l = $c->l();
		if($l->correlations_over_delays){
			try {
				$this->generateHighchartConfig();
			} catch (NotEnoughMeasurementsForCorrelationException | TooSlowToAnalyzeException | AnalysisException | NotEnoughDataException $e) {
				le($e);
			}
		}
	}
	/**
	 * @return HighchartConfig
	 * @throws TooSlowToAnalyzeException
	 * @throws AnalysisException
	 * @throws NotEnoughDataException
	 */
	public function generateHighchartConfig(): HighchartConfig{
		//if(AppMode::isApiRequest()){$this->throwTooSlowException();}
		$c = $this->getSourceObject();
		$l = $c->l();
		if($arr = $l->getCorrelationsOverDelays()){
			$config = new CorrelationsOverOnsetDelaysHighchart($c, $this);
		} else{
			$config = $c->getQMUserCorrelation()->calculateCorrelationsOverOnsetDelaysAndGenerateChartConfig();
		}
		$config->setTitle($this->getTitleAttribute());
		$config->setSubtitle($this->getSubtitleAttribute());
		return $this->setHighchartConfig($config);
	}
	public function setHighchartConfig(HighchartConfig $highchartConfig): HighchartConfig{
		if(count($highchartConfig->getSeries()) > 1){
			le("should only have 1 series!");
		}
		return parent::setHighchartConfig($highchartConfig);
	}
}
