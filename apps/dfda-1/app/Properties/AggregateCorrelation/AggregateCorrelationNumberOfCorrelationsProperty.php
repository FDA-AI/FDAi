<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Exceptions\AlreadyAnalyzedException;
use App\Exceptions\AlreadyAnalyzingException;
use App\Exceptions\DuplicateFailedAnalysisException;
use App\Exceptions\NotEnoughDataException;
use App\Exceptions\StupidVariableException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Logging\QMLog;
use App\Models\AggregateCorrelation;
use App\Storage\DB\Writable;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Properties\Base\BaseNumberOfCorrelationsProperty;
use App\Traits\PropertyTraits\IsCalculated;
use Google\Collection;
use LogicException;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationNumberOfCorrelationsProperty extends BaseNumberOfCorrelationsProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public $minimum = 1;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return int
     */
    public static function calculate($model): int {
        $correlations = $model->getCorrelations();
        $val = $correlations->count();
        $model->setAttribute(static::NAME, $val);
        return $val;
    }
    public static function updateAll(){
        $prop = new static();
        $me = $prop->name;
        Writable::statementStatic("
            update aggregate_correlations ac
                join (
                    SELECT
                        c.cause_variable_id,
                        c.effect_variable_id,
                        COUNT(c.id) AS total
                    FROM correlations c
                    GROUP BY c.cause_variable_id, c.effect_variable_id
                ) as sel
                on sel.cause_variable_id = ac.cause_variable_id and sel.effect_variable_id = ac.effect_variable_id
                set ac.$me = sel.total
        ");
    }
    /**
     * @return AggregateCorrelation[]|\Illuminate\Database\Eloquent\Collection
     */
    protected static function getWithoutCorrelations(){
        /** @var AggregateCorrelation[]|Collection $where0 */
        $where0 = static::where("=", 0)
            ->with('cause_variable')
            ->with('effect_variable')
            ->get();
        QMLog::info($where0->count()." without user correlations...");
        $names = [];
        foreach($where0 as $ac){
            $names[] = $ac->getTitleAttribute();
        }
        QMLog::print($names, "without user correlations");
        return $where0;
    }
    public static function fixInvalidRecords(){
        self::updateAll();
        $where0 = self::getWithoutCorrelations();
        foreach($where0 as $ac){
            try {
                $correlations[$ac->getLogMetaDataString()] = $ac->recalculateUserCorrelations();
            } catch (AlreadyAnalyzedException | TooSlowToAnalyzeException |
            DuplicateFailedAnalysisException | AlreadyAnalyzingException $e) {
                le($e);
            } catch (NotEnoughDataException|StupidVariableException $e) {
                QMLog::info(__METHOD__.": ".$e->getMessage());
            }
        }
        QMLog::table($where0);
    }
}
