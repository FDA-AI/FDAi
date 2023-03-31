<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\DataTableServices;
use App\Models\Correlation;
use App\Utils\Stats;
use App\Types\QMStr;
use Illuminate\Database\Eloquent\Builder;
class CorrelationDataTableService extends BaseDataTableService
{
    public $with = ['cause_variable', 'effect_variable', 'cause_user_variable', 'effect_user_variable'];
    /**
     * Build DataTable class.
     * @param mixed $query Results from query() method.
     * @return BaseEloquentDataTable
     */
    public function getEloquentDataTable($query = null): BaseEloquentDataTable{
        $dataTable = parent::getEloquentDataTable($query);
        $dataTable->skipTotalRecords(); // Too slow with lots of records
        $dataTable->addGaugeLink();
        $dataTable
            ->addCauseImageNameDropDown("prefix")
            ->addEffectSize("prefix")
            ->addEffectImageNameDropDown("prefix")
            ->addMiddleColumn(Correlation::FIELD_NUMBER_OF_PAIRS, function(Correlation $m) {
                return $m->number_of_pairs;
            })
            ->addMiddleColumn(Correlation::FIELD_QM_SCORE, function(Correlation $m) {
                return QMStr::truncate(Stats::roundByNumberOfSignificantDigits($m->qm_score, 3), 10);
            })
            ->addMiddleColumn(Correlation::FIELD_Z_SCORE, function(Correlation $m) {
                return QMStr::truncate(Stats::roundByNumberOfSignificantDigits($m->z_score, 3), 10);
            })
            ->addAnalysisEndedAt()
            ->addInternalErrorMessage()
            //->addPostLink()
            ;
        return $dataTable;
    }
    /**
     * Get query source of dataTable.
     *
     * @param Correlation $model
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function query(Correlation $model): Builder{
        return $this->buildDataTableQueryFromRequest($model);
    }
}
