<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Charts\QMHighcharts\Highcharts\ScatterAndBubble\BubbleChart;
use App\Charts\QMHighcharts\HighchartConfig;
use App\Charts\QMHighcharts\Options\BaseChart;
use App\Charts\QMHighcharts\Options\BaseSeries;
use App\Charts\QMHighcharts\Options\BaseTitle;
class BaseBubbleChart extends HighchartConfig {
	/**
	 * @var BaseChart
	 * @link https://api.highcharts.com/highcharts/chart
	 */
	public $chart;
	/**
	 * @var BaseTitle
	 * @link https://api.highcharts.com/highcharts/title
	 */
	public $title;
	/**
	 * @var BaseSeries[]
	 * @link https://api.highcharts.com/highcharts/series
	 */
	public $series;
	public function __construct(){
		parent::__construct();
		$this->chart = new BaseChart();
		$this->title = new BaseTitle();
		$this->series = [];
		$this->includeExtraScripts();
		$this->chart->renderTo = 'container';
		$this->chart->type = 'bubble';
		$this->chart->zoomType = 'xy';
		$this->title->text = 'Highcharts Bubbles';
		$this->series = [
			[
				'data' => [
					[97, 36, 79],
					[94, 74, 60],
					[68, 76, 58],
					[64, 87, 56],
					[68, 27, 73],
					[74, 99, 42],
					[7, 93, 87],
					[51, 69, 40],
					[38, 23, 33],
					[57, 86, 31],
				],
			],
			[
				'data' => [
					[25, 10, 87],
					[2, 75, 59],
					[11, 54, 8],
					[86, 55, 93],
					[5, 3, 58],
					[90, 63, 44],
					[91, 33, 17],
					[97, 3, 56],
					[15, 67, 48],
					[54, 25, 81],
				],
			],
			[
				'data' => [
					[47, 47, 21],
					[20, 12, 4],
					[6, 76, 91],
					[38, 30, 60],
					[57, 98, 64],
					[61, 17, 80],
					[83, 60, 13],
					[67, 78, 75],
					[64, 12, 10],
					[30, 77, 82],
				],
			],
		];
	}
	public function demo(): string{
		/** @noinspection PhpIncludeInspection */
		require base_path('vendor/ghunti/highcharts-php/demos/highcharts/scatter_and_bubble/bubble_chart.php');
	}
}
