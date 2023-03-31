<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Base;
use App\Models\AggregateCorrelation;
use App\Astral\AggregateCorrelationBaseAstralResource;
use App\Traits\ForeignKeyIdTrait;
use App\UI\ImageUrls;
use App\UI\FontAwesome;
use App\Properties\BaseProperty;
use Doctrine\DBAL\Types\Types;
use App\Fields\Field;
use OpenApi\Generator;
class BaseAggregateCorrelationIdProperty extends BaseProperty{
	use ForeignKeyIdTrait;
	public $dbInput = 'integer,false';
	public $dbType = Types::INTEGER;
	public $default = Generator::UNDEFINED;
	public $description = 'aggregate_correlation_id';
	public $fieldType = self::TYPE_INTEGER;
	public $fontAwesome = FontAwesome::AGGREGATE_CORRELATION;
	public $htmlType = 'text';
	public $image = ImageUrls::AGGREGATE_CORRELATION;
	public $inForm = true;
	public $inIndex = true;
	public $inView = true;
	public $isFillable = true;
	public $isOrderable = true;
	public $isSearchable = false;
	public $name = self::NAME;
	public const NAME = 'aggregate_correlation_id';
	public $phpType = \App\Types\PhpTypes::INTEGER;
	public $title = 'Aggregate Correlation';
	public $type = self::TYPE_INTEGER;
    public function validate(): void {
        if(!$this->shouldValidate()){return;}
        parent::validate();
    }
    /**
     * @return AggregateCorrelation
     */
    public static function getForeignClass(): string{
        return AggregateCorrelation::class;
    }

}
