<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Properties\Correlation\CorrelationPredictivePearsonCorrelationCoefficientProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BasePredictivePearsonCorrelationCoefficientProperty;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationPredictivePearsonCorrelationCoefficientProperty extends BasePredictivePearsonCorrelationCoefficientProperty
{
    use AggregateCorrelationProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
	/**
	 * @param QMAggregateCorrelation|AggregateCorrelation $model
	 * @return float
	 */
    public static function calculate($model){
	    try {
//		    /** @var Correlation[] $userCorrelations */
//		    $userCorrelations = $model->getCorrelations();
//			foreach($userCorrelations as $userCorrelation){
//				$correlation = $userCorrelation->getQMUserCorrelation();
//				try {
//					$predictive = $correlation->getPredictivePearsonCorrelationCoefficient();
//				} catch (NotEnoughDataException $e) {
//					$model->addWarning("Could not calculate predictive pearson correlation coefficient for user correlation {$correlation->id} because: ".
//					                   $e->getMessage());
//				} catch (TooSlowToAnalyzeException $e) {
//					le($e);
//				}
//			}
		    $val = $model->weightedAvgFromUserCorrelations(static::NAME);
		    $model->setAttribute(static::NAME, $val);
		    return $val;
	    } catch (NoUserCorrelationsToAggregateException $e) {
			$model->logError(__METHOD__.": ".$e->getMessage());
		    return null;
	    }
    }
}
