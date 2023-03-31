<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Base;
use App\Models\Correlation;
use App\Astral\CorrelationBaseAstralResource;
use App\Traits\PropertyTraits\IsNumberOfRelated;
use App\UI\ImageUrls;
use App\UI\FontAwesome;
use App\Properties\BaseProperty;
class BaseNumberOfUserCorrelationsAsEffectProperty extends BaseProperty{
	use IsNumberOfRelated;
	public $dbInput = 'integer,false,true';
	public $dbType = \Doctrine\DBAL\Types\Types::INTEGER;
	public $default = \OpenApi\Generator::UNDEFINED;
	public $description = 'Number of user correlations for which this variable is the effect variable';
	public $example = 105;
	public $fieldType = self::TYPE_INTEGER;
	public $fontAwesome = FontAwesome::CORRELATIONS;
	public $htmlType = 'text';
	public $image = ImageUrls::CORRELATIONS;
	public $inForm = true;
	public $inIndex = true;
	public $inView = true;
	public $isFillable = true;
	public $isOrderable = true;
	public $isSearchable = false;
	public $maximum = 2147483647;
	public $minimum = 0;
	public $name = self::NAME;
	public const NAME = 'number_of_user_correlations_as_effect';
	public $phpType = \App\Types\PhpTypes::INTEGER;
	public $rules = 'nullable|integer|min:0|max:2147483647';
	public $title = 'Causes';
	public $type = self::TYPE_INTEGER;
	public $canBeChangedToNull = true;
	public $validations = 'nullable|integer|min:0|max:2147483647';
	public static function getAstralRelatedResourceClass(): string{return CorrelationBaseAstralResource::class;}
    protected static function getRelationshipClass(): string{return Correlation::class;}
    public static function getForeignKey(): string{return Correlation::FIELD_EFFECT_USER_VARIABLE_ID;}
    public static function getRelatedTable(): string{return Correlation::TABLE;}
}
