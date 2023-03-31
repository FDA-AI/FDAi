<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Traits\VariableValueTraits;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use App\Models\Variable;
use App\Variables\QMVariable;
trait CauseVariableValueTrait {
	use VariableValueTrait;
	public function getVariable(): Variable{
		/** @var AggregateCorrelation|Correlation $correlation */
		$correlation = $this->getParentModel();
		return $correlation->getCauseVariable();
	}
	public function getQMVariable(): QMVariable{
		return $this->getVariable()->getDBModel();
	}
}
