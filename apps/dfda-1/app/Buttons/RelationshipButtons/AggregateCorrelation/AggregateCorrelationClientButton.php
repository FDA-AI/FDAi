<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\AggregateCorrelation;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\OAClient;
use App\Models\AggregateCorrelation;
class AggregateCorrelationClientButton extends BelongsToRelationshipButton {
    public $interesting = true;
	public $foreignKeyName = OAClient::FIELD_ID;
	public $qualifiedForeignKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_CLIENT_ID;
	public $ownerKeyName = OAClient::FIELD_ID;
	public $qualifiedOwnerKeyName = OAClient::TABLE.'.'.OAClient::FIELD_ID;
	public $childClass = AggregateCorrelation::class;
	public $parentClass = AggregateCorrelation::class;
	public $qualifiedParentKeyName = AggregateCorrelation::TABLE.'.'.AggregateCorrelation::FIELD_ID;
	public $relatedClass = OAClient::class;
	public $methodName = 'oa_client';
	public $fontAwesome = OAClient::FONT_AWESOME;
	public $id = 'client-button';
	public $image = OAClient::DEFAULT_IMAGE;
	public $text = 'Client';
	public $title = 'Client';
	public $tooltip = OAClient::COLOR;

}
