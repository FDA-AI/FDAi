<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Base;
use App\Traits\PropertyTraits\IsString;
use App\Types\PhpTypes;
use App\UI\ImageUrls;
use App\UI\FontAwesome;
use App\Properties\BaseProperty;
class BaseCommonAliasProperty extends BaseProperty{
	use IsString;
	public $dbInput = 'string,125:nullable';
	public $dbType = PhpTypes::STRING;
	public $default = \OpenApi\Generator::UNDEFINED;
	public $description = 'A common alternative variable name';
	public $fieldType = PhpTypes::STRING;
	public $fontAwesome = FontAwesome::COMMON_TAG;
	public $htmlInput = 'text';
	public $htmlType = 'text';
	public $image = ImageUrls::COMMON_TAG;
	public $inForm = true;
	public $inIndex = true;
	public $inView = true;
	public $isFillable = true;
	public $isOrderable = false;
	public $isSearchable = true;
	public $maxLength = 125;
	public $name = self::NAME;
	public const NAME = 'common_alias';
	public $phpType = PhpTypes::STRING;
	public $rules = 'nullable|max:125';
	public $title = 'Common Alias';
	public $type = PhpTypes::STRING;
	public $canBeChangedToNull = true;
	public $validations = 'nullable|max:125';

}
