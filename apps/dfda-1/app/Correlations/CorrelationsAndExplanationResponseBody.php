<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Correlations;
use App\Models\AggregateCorrelation;
use App\Types\QMArr;
use Illuminate\Support\Collection;
use App\Slim\Model\QMResponseBody;
class CorrelationsAndExplanationResponseBody extends QMResponseBody {
    public $correlations;
    public $explanation;
    public $studies;
    /**
     * CorrelationsAndExplanationResponseBody constructor.
     * @param AggregateCorrelation[]|QMCorrelation[]|QMAggregateCorrelation[]|Collection $correlations
     * @param $requestParams
     */
    public function __construct($correlations, array $requestParams){
        parent::__construct();
        $this->correlations = $correlations;
        $this->explanation = new AggregatedCorrelationListExplanationResponseBody($requestParams, $correlations);
        if(isset($correlations[0], $correlations[0]->userId) && $correlations){
            $this->explanation = new UserCorrelationListExplanationResponseBody($requestParams, $correlations);
        }
    }
    /**
     * @return string
     */
    public function getHtml(): string {
        return $this->getExplanation()->getHtml();
    }
    /**
     * @return CorrelationListExplanationResponseBody
     */
    public function getExplanation(): CorrelationListExplanationResponseBody{
        return $this->explanation;
    }
    public static function get(array $filters): CorrelationsAndExplanationResponseBody {
        if($filters['aggregate'] ?? false){
            $correlations = QMAggregateCorrelation::getAggregateCorrelations($filters);
        } else {
            $correlations = QMUserCorrelation::getUserCorrelations($filters);
        }
        return new CorrelationsAndExplanationResponseBody($correlations, $filters);
    }
    /**
     * @return AggregateCorrelation[]|Collection|QMAggregateCorrelation[]|QMCorrelation[]
     */
    public function getCorrelations(): array {
        return QMArr::toArray($this->correlations);
    }
}
