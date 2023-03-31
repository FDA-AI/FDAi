<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\DataTableServices;
use App\Models\AggregateCorrelation;
use App\Utils\Stats;
use App\Types\QMStr;
class AggregateCorrelationDataTableService extends BaseDataTableService
{
    public $with = [
        'cause_variable',
        'effect_variable',
        'votes'
    ];
    public function query(AggregateCorrelation $model): \Illuminate\Database\Eloquent\Builder{
        return $this->buildDataTableQueryFromRequest($model);
    }
    public function getEloquentDataTable($query = null): BaseEloquentDataTable {
        $dataTable = parent::getEloquentDataTable($query);
        $dataTable->addGaugeNameDropDown();
        return $dataTable
            ->addCauseImageNameDropDown()
            ->addEffectSize()
            ->addEffectImageNameDropDown()
            ->addMiddleColumn(AggregateCorrelation::FIELD_NUMBER_OF_CORRELATIONS, function(AggregateCorrelation $m) {
                return $m->getUserCorrelationsAdminLink();
            })
            ->addMiddleColumn(AggregateCorrelation::FIELD_AGGREGATE_QM_SCORE, function(AggregateCorrelation $m) {
                return QMStr::truncate(Stats::roundByNumberOfSignificantDigits($m->aggregate_qm_score, 3), 10);
            })
            ->addAnalysisEndedAt()
            ->addInternalErrorMessage()
            ->addMiddleColumns([
                'forward_pearson_correlation_coefficient' => [
                    'title'      => 'Correlation',
                    'data'       => 'forward_pearson_correlation_coefficient',
                    'name'       => 'forward_pearson_correlation_coefficient',
                    'searchable' => false
                ],
            ]);
    }
}
