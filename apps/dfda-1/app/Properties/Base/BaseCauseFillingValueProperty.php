<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Base;
use App\Traits\PropertyTraits\IsFloat;
use App\UI\ImageUrls;
use App\UI\FontAwesome;
use OpenApi\Generator;
class BaseCauseFillingValueProperty extends BaseFillingValueProperty {
	use IsFloat;
	public $dbInput = 'float,10,0';
	public $dbType = 'float';
	public $default = Generator::UNDEFINED;
	public $description = 'cause_filling_value';
	public $fieldType = 'float';
	public $fontAwesome = FontAwesome::QUESTION_CIRCLE;
	public $htmlType = 'text';
	public $image = ImageUrls::QUESTION_MARK;
	public $inForm = true;
	public $inIndex = true;
	public $inView = true;
	public $isFillable = true;
	public $isOrderable = true;
	public $isSearchable = false;
	public $name = self::NAME;
	public const NAME = 'cause_filling_value';
	public $phpType = 'float';
	public $rules = 'nullable|numeric';
	public $title = 'Cause Filling Value';
	public $type = 'number';
	public $canBeChangedToNull = true;
	public $validations = 'nullable|numeric';

}
