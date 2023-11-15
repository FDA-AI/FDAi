<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnused */
namespace App\Slim\Controller\Correlation;
use App\Exceptions\NoUserCorrelationsToAggregateException;
use App\Slim\Middleware\QMAuth;
use App\Slim\QMSlim;
use App\Utils\APIHelper;
class GetUserCorrelationController extends GetCorrelationController {
	/**
	 * @throws NoUserCorrelationsToAggregateException
	 */
	public function get(){
		$this->setCacheControlHeader(5 * 60);
		$app = QMSlim::getInstance();
		$route = $app->router()->getCurrentRoute();
		$routeParts = explode('/', $route->getPattern());
		$target = array_pop($routeParts);
		$variable = $route->getParam('variableName');
		$requestParams = $this->getApp()->request->params();
		$requestParams['fallbackToStudyForCauseAndEffect'] = true;
		if($target == 'effects'){
			$requestParams['causeVariableName'] = $variable;
		} else{
			$requestParams['effectVariableName'] = $variable;
		}
		unset($requestParams['variableName']);
		$requestParams['userId'] = QMAuth::getQMUser()->id;
		$correlations = $this->getOrCreateUserOrGlobalVariableRelationshipsWithStudyHtmlChartsImages($requestParams);
		if(APIHelper::apiVersionIsAbove(3)){
			return $this->writeJsonWithGlobalFields(200, ['correlations' => $correlations]);
		} else{
			$this->writeJsonWithoutGlobalFields(200, $correlations);
		}
	}
}
