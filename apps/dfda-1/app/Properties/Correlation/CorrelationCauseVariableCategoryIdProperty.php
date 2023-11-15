<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\Correlation;
use App\Correlations\QMUserVariableRelationship;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\Models\Variable;
use App\Properties\Base\BaseCauseVariableCategoryIdProperty;
use App\Traits\PropertyTraits\CorrelationProperty;
use App\Variables\QMVariableCategory;
class CorrelationCauseVariableCategoryIdProperty extends BaseCauseVariableCategoryIdProperty
{
    use CorrelationProperty;
    public $table = Correlation::TABLE;
    public $parentClass = Correlation::class;
    /**
     * @return array
     */
    public static function deleteCorrelationsWithBoringCauseCategories(): array
    {
        $rows = QMUserVariableRelationship::readonly()
            ->select([
                Correlation::TABLE . '.' . Correlation::FIELD_USER_ID,
                Correlation::TABLE . '.' . Correlation::FIELD_CAUSE_VARIABLE_ID,
                Correlation::TABLE . '.' . Correlation::FIELD_EFFECT_VARIABLE_ID,
                Correlation::TABLE . '.' . Correlation::FIELD_QM_SCORE,
            ])
            ->join(Variable::TABLE . ' as cv',
                'cv.' . Variable::FIELD_ID, '=',
                Correlation::TABLE . '.' . Correlation::FIELD_CAUSE_VARIABLE_ID)
            ->whereIn('cv.' . Variable::FIELD_VARIABLE_CATEGORY_ID, QMVariableCategory::getBoringVariableCategoryIds())
            //->limit(10)
            ->getDBModels();
        QMLog::info(count($rows) . " rows");
        $correlations = [];
        foreach ($rows as $row) {
            $row->hardDelete(__FUNCTION__);
        }
        return $correlations;
    }

}
