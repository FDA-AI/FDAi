<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\AggregateCorrelation;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\Correlation;
use Illuminate\Database\Eloquent\Relations\HasMany;
class AggregateCorrelationCorrelationsButton extends HasManyRelationshipButton {
    public $interesting = true;
	public $parentClass = AggregateCorrelation::class;
	public $qualifiedParentKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $relatedClass = Correlation::class;
	public $methodName = Correlation::TABLE;
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = Correlation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME;
	public $id = 'correlations-button';
	public $image = Correlation::DEFAULT_IMAGE;
	public $text = 'Individual User Studies';
	public $title = 'Individual User Studies';
	public $tooltip = "See individual user studies that were aggregated to create this analysis. ";
    public function __construct($methodOrModel, HasMany $relation = null){
        parent::__construct($methodOrModel, $relation);
    }
    public function getUrl(array $params = []): string{
        return parent::getUrl($params);
    }
}
