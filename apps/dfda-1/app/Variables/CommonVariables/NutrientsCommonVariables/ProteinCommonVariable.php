<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Variables\CommonVariables\NutrientsCommonVariables;
use App\Properties\Base\BaseFillingTypeProperty;
use App\Variables\QMCommonVariable;
use App\VariableCategories\NutrientsVariableCategory;
use App\Units\GramsUnit;
class ProteinCommonVariable extends QMCommonVariable {
	public const CAUSE_ONLY = false;

	public const DEFAULT_UNIT_ID = GramsUnit::ID;
	public const DURATION_OF_ACTION = 604800;
	public const FILLING_TYPE = BaseFillingTypeProperty::FILLING_TYPE_NONE;
	public const ID = 1420;
	public const IMAGE_URL = 'https://images-na.ssl-images-amazon.com/images/I/41YJKx19%2BLL._SL160_.jpg';
	public const MAXIMUM_ALLOWED_VALUE = 7257.0;
	public const NAME = 'Protein';
	public const PRICE = 56.899999999999999;
	public const PRODUCT_URL = 'https://www.amazon.com/Optimum-Nutrition-Standard-Protein-Chocolate/dp/B000QSNYGI?psc=1&linkCode=xm2&camp=2025&creative=165953&creativeASIN=B000QSNYG';
	public const PUBLIC = true;
	public const SYNONYMS = ['Protein'];
	public const VARIABLE_CATEGORY_ID = NutrientsVariableCategory::ID;
	public $causeOnly = self::CAUSE_ONLY;

	public $defaultUnitId = self::DEFAULT_UNIT_ID;
	public $durationOfAction = self::DURATION_OF_ACTION;
	public $fillingType = self::FILLING_TYPE;
	public $id = self::ID;
	public $imageUrl = self::IMAGE_URL;
	public $maximumAllowedValue = self::MAXIMUM_ALLOWED_VALUE;
	public $name = self::NAME;
	public float $price = self::PRICE;
	public $productUrl = self::PRODUCT_URL;
	public $public = self::PUBLIC;
	public $synonyms = self::SYNONYMS;
	public $variableCategoryId = self::VARIABLE_CATEGORY_ID;
}
