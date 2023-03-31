<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Correlations\QMAggregateCorrelation;
use App\Logging\QMLog;
use App\Models\AggregateCorrelation;
use App\Properties\Base\BaseGroupedCauseValueClosestToValuePredictingHighOutcomeProperty;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Traits\PropertyTraits\IsAverageOfCorrelations;
use App\Traits\PropertyTraits\IsCalculated;
use App\Traits\VariableValueTraits\CauseAggregatedVariableValueTrait;
use Throwable;
class AggregateCorrelationGroupedCauseValueClosestToValuePredictingHighOutcomeProperty extends BaseGroupedCauseValueClosestToValuePredictingHighOutcomeProperty
{
    use AggregateCorrelationProperty, CauseAggregatedVariableValueTrait, IsAverageOfCorrelations;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    use IsCalculated;
    public static function fixInvalidRecords() {
        QMLog::infoWithoutContext('=== ' . __FUNCTION__ . ' ===');
        $qb = QMAggregateCorrelation::readonly()
            ->whereNull(AggregateCorrelation::FIELD_DELETED_AT)
            ->whereNull(AggregateCorrelation::FIELD_GROUPED_CAUSE_VALUE_CLOSEST_TO_VALUE_PREDICTING_HIGH_OUTCOME)
            ->whereLike(AggregateCorrelation::FIELD_DATA_SOURCE_NAME, "%user%");
        $rows = $qb->getArray();
        QMLog::info(count($rows) . " before");
        foreach ($rows as $row) {
            try {
                $c = QMAggregateCorrelation::getByNamesOrIds($row->cause_variable_id, $row->effect_variable_id);
                $c->logInfo("");
            } catch (Throwable $exception) {
                QMLog::error($exception->getMessage());
            }
        }
        foreach ($rows as $row) {
            try {
                $c = QMAggregateCorrelation::getByNamesOrIds($row->cause_variable_id, $row->effect_variable_id);
                $c->analyzeFullyAndSave(__FUNCTION__);
            } catch (Throwable $exception) {
                QMLog::error($exception->getMessage());
            }
        }
        $rows = $qb->getDBModels();
        QMLog::info(count($rows) . " after");
    }
}
