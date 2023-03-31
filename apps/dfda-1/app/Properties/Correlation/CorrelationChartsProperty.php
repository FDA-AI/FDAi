<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Charts\ChartGroup;
use App\Charts\CorrelationCharts\CorrelationChartGroup;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Properties\Base\BaseChartsProperty;
use App\Types\QMStr;
class CorrelationChartsProperty extends BaseChartsProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    public static function shrinkLargeCorrelations(){
        $max = BaseChartsProperty::make()->getMaxLength();
        $kb = $max / 1024;
        $qb = Correlation::query()->whereRaw("length(" . Correlation::FIELD_CHARTS . ") > " . $max);
        $shrunk = [];
        $ids = $qb->pluck(Correlation::FIELD_ID);
        \App\Logging\ConsoleLog::info(count($ids) . " with charts greater than $kb KB");
        /** @var static $one */
        foreach ($ids as $id) {
            $one = Correlation::findInMemoryOrDB($id);
            $internal = $one->internal_error_message;
            if ($internal && strlen($internal) > 900) {
                $one->internal_error_message = QMStr::truncate($internal, 900, "[TRUNCATED]");
            }
            $before = round(strlen(json_encode($one->attributes)) / 1024);
            try {
                $one->save();
            } catch (\Throwable $e) {
                QMLog::error(__METHOD__.": ".$e->getMessage());
                $shrunk[$one->getTitleAttribute()] = ['id' => $one->id, 'before' => $before, 'error' => $e->getMessage()];
                continue;
            }
            lei(isset($shrunk[$one->getTitleAttribute()]),
                "already shrunk " . $one->getTitleAttribute());
            $after = round(strlen(json_encode($one->attributes)) / 1024);
            $shrunk[$one->getTitleAttribute()] = ['id' => $one->id, 'before' => $before, 'after' => $after];
        }
        QMLog::table($shrunk);
    }
    /**
     * @return CorrelationChartGroup
     */
    public function getExample(): ChartGroup {
        return new CorrelationChartGroup();
    }
}
