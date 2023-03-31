<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\DataLab\AggregateCorrelations;
use App\Buttons\QMButton;
use App\Models\AggregateCorrelation;
class CreateAggregateCorrelationButton extends QMButton {
	public $accessibilityText = 'Create Aggregate Correlation';
	public $action = 'datalab/aggregateCorrelations/create';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'datalab-aggregate-correlations-create-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $link = 'datalab/aggregateCorrelations/create';
	public $parameters = [
		'middleware' => [
			'web',
			'auth',
		],
		'as' => 'datalab.aggregateCorrelations.create',
		'uses' => 'App\\Http\\Controllers\\DataLab\\AggregateCorrelationController@create',
		'controller' => 'App\\Http\\Controllers\\DataLab\\AggregateCorrelationController@create',
		'namespace' => 'App\\Http\\Controllers',
		'prefix' => '/datalab',
		'where' => [],
	];
	public $target = 'self';
	public $text = 'Create Aggregate Correlation';
	public $title = 'Create Aggregate Correlation';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
	public $visible = true;
}
