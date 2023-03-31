<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Correlations\QMUserCorrelation;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseReversePearsonCorrelationCoefficientProperty;
use App\Traits\PropertyTraits\IsCalculated;
class CorrelationReversePearsonCorrelationCoefficientProperty extends BaseReversePearsonCorrelationCoefficientProperty
{
    use CorrelationProperty;
	use IsCalculated;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
	/**
	 * @param QMUserCorrelation $model
	 * @return float
	 */
	public static function calculate($model): float {
		$c = new QMUserCorrelation(null, $model->getEffectQMVariable(), $model->getCauseQMVariable());
		try {
			$val = CorrelationForwardPearsonCorrelationCoefficientProperty::calculate($c);
		} catch (NotEnoughDataException|TooSlowToAnalyzeException $e) {
			le($e);
		}
		$model->setAttribute(self::NAME, $val);
		return $val;
	}
}
