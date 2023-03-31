<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\RelationshipButtons\Correlation;
use App\Buttons\RelationshipButtons\BelongsToRelationshipButton;
use App\Models\Correlation;
use App\Models\OAClient;
class CorrelationOAuthClientButton extends BelongsToRelationshipButton {
	public $interesting = false;
	public $foreignKeyName = OAClient::FIELD_ID;
	public $qualifiedForeignKeyName = Correlation::TABLE . '.' . Correlation::FIELD_CLIENT_ID;
	public $ownerKeyName = OAClient::FIELD_ID;
	public $qualifiedOwnerKeyName = OAClient::TABLE . '.' . OAClient::FIELD_ID;
	public $childClass = Correlation::class;
	public $parentClass = Correlation::class;
	public $qualifiedParentKeyName = Correlation::TABLE . '.' . Correlation::FIELD_ID;
	public $relatedClass = OAClient::class;
	public $methodName = 'oa_client';
	public $relationshipType = 'Illuminate\\Database\\Eloquent\\Relations\\BelongsTo';
	public $color = OAClient::COLOR;
	public $fontAwesome = OAClient::FONT_AWESOME;
	public $id = 'oauth-client-button';
	public $image = OAClient::DEFAULT_IMAGE;
	public $text = 'OAuth Client';
	public $title = 'OAuth Client';
	public $tooltip = OAClient::CLASS_DESCRIPTION;
}
