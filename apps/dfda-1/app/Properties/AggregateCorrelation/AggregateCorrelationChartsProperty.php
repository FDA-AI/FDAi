<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Charts\AggregateCorrelationCharts\AggregateCorrelationChartGroup;
use App\Charts\ChartGroup;
use App\Models\AggregateCorrelation;
use App\Properties\Base\BaseChartsProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationChartsProperty extends BaseChartsProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @return AggregateCorrelationChartGroup
     */
    public function getExample(): ChartGroup{
        return new AggregateCorrelationChartGroup();
    }
	/**
	 * @param $model
	 * @return mixed
	 */
	public static function calculate($model){
        $model->getOrSetCharts()->setHighchartConfigs();
        $model->setAttribute(static::NAME, $charts = $model->getOrSetCharts());
        return $charts;
    }
}
