<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Exceptions;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use Facade\IgnitionContracts\ProvidesSolution;
use App\Buttons\Analyzable\CreateStudyButton;
use App\Correlations\QMAggregateCorrelation;
use App\Utils\IonicHelper;
use App\Logging\QMLog;
class NoUserCorrelationsToAggregateException extends NotEnoughDataException implements ProvidesSolution {
    /**
     * @var QMAggregateCorrelation
     */
    public $aggregateCorrelation;
    /**
     * NoUserCorrelationsException constructor.
     * @param QMAggregateCorrelation|AggregateCorrelation $correlation
     */
    public function __construct($correlation){
        $this->analyzable = $c = $this->aggregateCorrelation = $correlation;
	    $internalErrorMessage = "No user correlations for cause ".
		    $correlation->getCauseVariableName()." and effect ".$correlation->getEffectVariableName();
		if($correlation->hasId()){
			$show = $correlation->getDataLabShowUrl();
			$internalErrorMessage .= ".\n\tDelete at $show. \n";
		}
        parent::__construct($correlation,
            "Not Enough Shared Data",
            "There are not enough users who have collected and anonymously shared their data to ".
            "create a population study on the relationship between $c->causeVariableName and $c->effectVariableName. ".
            "See available correlations at ".$correlation->getAstralIndexUrl(),
            $internalErrorMessage);
        $this->userErrorMessageBodyHtml = $this->getSolutionDescription().
            "\n".(new CreateStudyButton())->getLink();
    }
    public function getDocumentationLinks(): array{
        $links["Create a Study"] = IonicHelper::getStudyCreationUrl();
        return $this->links = array_merge($links, parent::getDocumentationLinks());
    }
    public function getSolutionTitle(): string{
        return $this->solutionTitle = "Create a Study";
    }
    public function getSolutionDescription(): string{
        $c = $this->getQMAggregateCorrelation();
        return $this->solutionDescription = "Please create a study and share it with your friends so we can collect enough data to ".
            "determine the effect of $c->causeVariableName on $c->effectVariableName.  ";
    }
    /**
     * @return AggregateCorrelation
     */
    public function getAggregateCorrelation(): AggregateCorrelation{
        return $this->aggregateCorrelation->l();
    }
    /**
     * @return QMAggregateCorrelation
     */
    public function getQMAggregateCorrelation(): QMAggregateCorrelation{
        return $this->aggregateCorrelation->getDBModel();
    }
}
