<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\GlobalVariableRelationship;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Models\GlobalVariableRelationship;
use App\Models\Correlation;
use App\Properties\Correlation\CorrelationPredictivePearsonCorrelationCoefficientProperty;
use App\Traits\PropertyTraits\GlobalVariableRelationshipProperty;
use App\Properties\Base\BasePredictivePearsonCorrelationCoefficientProperty;
use App\Correlations\QMGlobalVariableRelationship;
class GlobalVariableRelationshipPredictivePearsonCorrelationCoefficientProperty extends BasePredictivePearsonCorrelationCoefficientProperty
{
    use GlobalVariableRelationshipProperty;
    use \App\Traits\PropertyTraits\IsCalculated;
    public $table = GlobalVariableRelationship::TABLE;
    public $parentClass = GlobalVariableRelationship::class;
	/**
	 * @param QMGlobalVariableRelationship|GlobalVariableRelationship $model
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
