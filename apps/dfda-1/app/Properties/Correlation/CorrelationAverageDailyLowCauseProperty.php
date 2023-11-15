<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Correlations\QMUserVariableRelationship;
use App\Models\Correlation;
use App\Properties\Base\BaseAverageDailyLowCauseProperty;
use App\Slim\Model\Measurement\Pair;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Traits\PropertyTraits\IsCalculated;
use App\Types\QMArr;
class CorrelationAverageDailyLowCauseProperty extends BaseAverageDailyLowCauseProperty {
	use CorrelationProperty;
	use IsCalculated;
	public $parentClass = Correlation::class;
	public $table = Correlation::TABLE;
	/**
	 * @param QMUserVariableRelationship $model
	 * @return bool|float
	 * @throws \App\Exceptions\InvalidAttributeException
	 * @throws \App\Exceptions\InvalidVariableValueException
	 * @throws \App\Exceptions\NotEnoughDataException
	 * @throws \App\Exceptions\TooSlowToAnalyzeException
	 */
	public static function calculate($model){
		$pairs = $model->getLowCausePairs();
		$val = QMUserVariableRelationship::calculateAverageCauseForPairSubset($pairs);
		$cause = $model->getCauseQMVariable();
		$cause->validateValueForCommonVariableAndUnit($val, static::NAME);
		$dailyMeasurements = $cause->getValidDailyMeasurementsWithTags();
		$max = QMArr::max($dailyMeasurements, 'value');
		if($val > $max){
			le(static::NAME . " cannot be greater than max daily value $val for $cause");
		}
		$model->validateAndSet(static::NAME, $val);
		return $val;
	}
	/**
	 * @param float $lowCauseMaximum
	 * @param Pair[] $allPairs
	 * @return Pair[]
	 */
	public static function getLowCausePairs(float $lowCauseMaximum, array $allPairs): array{
		$lowCausePairs = $allPairs;
		foreach($lowCausePairs as $i => $iValue){
			if($iValue->causeMeasurementValue > $lowCauseMaximum){
				unset($lowCausePairs[$i]);
			}
		}
		$lowCausePairs = array_values($lowCausePairs);
		return $lowCausePairs;
	}
}
