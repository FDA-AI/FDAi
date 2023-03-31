<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Traits\HasModel;
use App\Buttons\QMButton;
use App\Models\BaseModel;
use App\Models\CtConditionCause;
use App\Properties\BaseProperty;
use App\Slim\Model\DBModel;
trait HasCtConditionCause {
	public function getCtConditionCauseId(): int{
		$nameOrId = $this->getAttribute('ct_condition_cause_id');
		return $nameOrId;
	}
	public function getCtConditionCauseButton(): QMButton{
		$ctConditionCause = $this->getCtConditionCause();
		if($ctConditionCause){
			return $ctConditionCause->getButton();
		}
		return CtConditionCause::generateDataLabShowButton($this->getCtConditionCauseId());
	}
	/**
	 * @return CtConditionCause
	 */
	public function getCtConditionCause(): CtConditionCause{
		if($this instanceof BaseProperty && $this->parentModel instanceof CtConditionCause){
			return $this->parentModel;
		}
		/** @var BaseModel|DBModel $this */
		if($l = $this->getRelationIfLoaded('ct_condition_cause')){
			return $l;
		}
		$id = $this->getCtConditionCauseId();
		$ctConditionCause = CtConditionCause::findInMemoryOrDB($id);
		if(property_exists($this, 'relations')){
			$this->relations['ct_condition_cause'] = $ctConditionCause;
		}
		if(property_exists($this, 'ctConditionCause')){
			$this->ctConditionCause = $ctConditionCause;
		}
		return $ctConditionCause;
	}
	public function getCtConditionCauseNameLink(): string{
		return $this->getCtConditionCause()->getDataLabDisplayNameLink();
	}
	public function getCtConditionCauseImageNameLink(): string{
		return $this->getCtConditionCause()->getDataLabImageNameLink();
	}
}
