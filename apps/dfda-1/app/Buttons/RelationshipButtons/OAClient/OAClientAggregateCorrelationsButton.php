<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\OAClient;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\AggregateCorrelation;
use App\Models\OAClient;
class OAClientAggregateCorrelationsButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = OAClient::class;
	public $qualifiedParentKeyName = OAClient::TABLE . '.' . OAClient::FIELD_ID;
	public $relatedClass = AggregateCorrelation::class;
	public $methodName = AggregateCorrelation::TABLE;
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'aggregate-correlations-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $text = 'Aggregate Correlations';
	public $title = 'Aggregate Correlations';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
}
