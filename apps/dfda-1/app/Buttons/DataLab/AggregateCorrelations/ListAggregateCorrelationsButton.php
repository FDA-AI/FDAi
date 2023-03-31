<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Buttons\DataLab\AggregateCorrelations;
use App\Buttons\QMButton;
use App\Models\AggregateCorrelation;
class ListAggregateCorrelationsButton extends QMButton {
	public $accessibilityText = 'List Aggregate Correlations';
	public $action = 'datalab/aggregateCorrelations';
	public $color = AggregateCorrelation::COLOR;
	public $fontAwesome = AggregateCorrelation::FONT_AWESOME;
	public $id = 'datalab-aggregate-correlations-button';
	public $image = AggregateCorrelation::DEFAULT_IMAGE;
	public $link = 'datalab/aggregateCorrelations';
	public $parameters = [
		'middleware' => [
			'web',
			'auth',
		],
		'as' => 'datalab.aggregateCorrelations.index',
		'uses' => 'App\\Http\\Controllers\\DataLab\\AggregateCorrelationController@index',
		'controller' => 'App\\Http\\Controllers\\DataLab\\AggregateCorrelationController@index',
		'namespace' => 'App\\Http\\Controllers',
		'prefix' => '/datalab',
		'where' => [],
	];
	public $target = 'self';
	public $text = 'List Aggregate Correlations';
	public $title = 'List Aggregate Correlations';
	public $tooltip = AggregateCorrelation::CLASS_DESCRIPTION;
	public $visible = true;
}
