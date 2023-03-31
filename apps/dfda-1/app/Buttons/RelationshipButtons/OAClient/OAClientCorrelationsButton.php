<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\OAClient;
use App\Buttons\RelationshipButtons\HasManyRelationshipButton;
use App\Models\Correlation;
use App\Models\OAClient;
class OAClientCorrelationsButton extends HasManyRelationshipButton {
	public $interesting = true;
	public $parentClass = OAClient::class;
	public $qualifiedParentKeyName = OAClient::TABLE . '.' . OAClient::FIELD_ID;
	public $relatedClass = Correlation::class;
	public $methodName = Correlation::TABLE;
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\HasMany';
	public $color = Correlation::COLOR;
	public $fontAwesome = Correlation::FONT_AWESOME;
	public $id = 'correlations-button';
	public $image = Correlation::DEFAULT_IMAGE;
	public $text = 'Correlations';
	public $title = 'Correlations';
	public $tooltip = Correlation::CLASS_DESCRIPTION;
}
