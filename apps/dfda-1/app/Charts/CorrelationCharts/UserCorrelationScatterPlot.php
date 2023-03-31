<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Charts\CorrelationCharts;
use App\Charts\QMHighcharts\HighchartConfig;
use App\Charts\QMHighcharts\ScatterHighchartConfig;
use App\Correlations\QMCorrelation;
use App\Correlations\QMUserCorrelation;
use App\Exceptions\HighchartExportException;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Slim\Model\Measurement\Pair;
use App\Studies\QMUserStudy;
use App\Types\QMStr;
class UserCorrelationScatterPlot extends CorrelationChart {
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
		$increaseDecrease = ($c->correlationCoefficient > 0) ? "an increase" : "a decrease";
		$effectName = $c->getEffectNameWithoutCategoryOrUnit();
		$causeName = $c->getCauseNameWithoutCategoryOrUnit();
		$this->setExplanation("An increase in " . $c->getDurationOfActionHumanString() . " cumulative " . $causeName .
			" is usually followed by $increaseDecrease in " . $effectName . ". " . '(R = ' .
			$c->getCorrelationCoefficient(4) . ')');
		parent::__construct($c, $effectName . ' Following ' . $causeName);
	}
	/**
	 * @return QMUserCorrelation
	 */
	public function getCorrelation(): QMCorrelation{
		return $this->getSourceObject();
	}
	/**
	 * @return ScatterHighchartConfig
	 * @throws NotEnoughDataException
	 * @throws TooSlowToAnalyzeException
	 */
	public function generateHighchartConfig(): HighchartConfig{
		$c = $this->getCorrelation();
		$pairs = $c->getPairs();
		$causeName = $c->getCauseNameWithoutCategoryOrUnit();
		$effectName = $c->getEffectNameWithoutCategoryOrUnit();
		$causeUnit = $c->getCauseVariableCommonUnit()->abbreviatedName;
		$effectUnit = $c->getEffectVariableCommonUnit()->abbreviatedName;
		$values = $this->getXyVariableValues($pairs, $c);
		$config = new ScatterHighchartConfig($c, $this);
		$config->setTitle($this->getTitleAttribute());
		$config->setSubtitle($this->getSubtitleAttribute());
		$config->addSeriesArray($causeName . ' by ' . $effectName, $values);
		$config->setYAxisTitle($effectName . " ($effectUnit)");
		$config->setXAxisTitleText($causeName . " ($causeUnit)");
		$effectName = QMStr::escapeSingleQuotes($effectName);
		$causeName = QMStr::escapeSingleQuotes($causeName);
		$config->setTooltipFormatter("
            return this.y +'$effectUnit $effectName<br/>'+this.x +'$causeUnit $causeName';
        ");
		$config->setLegendEnabled(false);
		return $this->setHighchartConfig($config);
	}
	/**
	 * @param Pair[] $pairs
	 * @param QMUserCorrelation $correlation
	 * @return array
	 */
	public function getXyVariableValues(array $pairs, QMUserCorrelation $correlation): array{
		$cause = $correlation->getOrSetCauseQMVariable();
		$min = $cause->getVariable()->minimum_allowed_value;
		foreach($pairs as $pair){
			if($min && $pair->causeMeasurementValue < $min){
				$this->exceptionIfNotProductionAPI("$pair->causeMeasurementValue is less than min $min for $cause");
				continue;
			}
			$this->xyVariableValues[] = [
				$pair->causeMeasurementValue,
				$pair->effectMeasurementValue,
			];
			$this->dataX[] = $pair->causeMeasurementValue;
			$this->dataY[] = $pair->effectMeasurementValue;
		}
		return $this->xyVariableValues;
	}
	/**
	 * @param string $type
	 * @return string
	 * @throws HighchartExportException
	 */
	public function getOrGenerateEmbeddedImageHtml(string $type): string{
		return parent::getOrGenerateEmbeddedImageHtml($type);
	}
	public function getDynamicHtml(bool $includeJS = true): string{
		return parent::getDynamicHtml($includeJS);
	}
}
