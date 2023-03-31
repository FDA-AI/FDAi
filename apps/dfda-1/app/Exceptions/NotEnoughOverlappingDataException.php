<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Exceptions;
use App\Correlations\QMUserCorrelation;
class NotEnoughOverlappingDataException extends NotEnoughDataException {
    /**
     * @var QMUserCorrelation
     */
    public $userCorrelation;
    /**
     * NotEnoughBaselineDataException constructor.
     * @param QMUserCorrelation $c
     */
    public function __construct(QMUserCorrelation $c){
        $this->analyzable = $this->userCorrelation = $c;
        $causeEffect = $c->getCauseAndEffectString();
        $problemDetails = "Not Enough Overlapping $causeEffect Data";
        $problemDetails.= "\n<br>".$c->getCauseUserVariable()->getUrl();
        $problemDetails.= "\n<br>".$c->getEffectUserVariable()->getUrl();
        $c->addException($this);
        parent::__construct($c, $problemDetails, $problemDetails);
    }
}
