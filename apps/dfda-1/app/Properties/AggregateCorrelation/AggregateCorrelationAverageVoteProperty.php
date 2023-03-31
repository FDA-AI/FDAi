<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\Properties\AggregateCorrelation;
use App\Correlations\QMAggregateCorrelation;
use App\Models\AggregateCorrelation;
use App\Models\Vote;
use App\Properties\Base\BaseAverageVoteProperty;
use App\Storage\DB\Writable;
use App\Traits\PropertyTraits\AggregateCorrelationProperty;
use App\Traits\PropertyTraits\IsCalculated;
class AggregateCorrelationAverageVoteProperty extends BaseAverageVoteProperty
{
    use AggregateCorrelationProperty;
    use IsCalculated;
    public $table = AggregateCorrelation::TABLE;
    public $parentClass = AggregateCorrelation::class;
    /**
     * @param QMAggregateCorrelation|AggregateCorrelation $model
     * @return float
     */
    public static function calculate($model): ?float{
        /** @var QMAggregateCorrelation $model */
	    $avg = null;
	    if($model->hasId()){
		    $votes = $model->getVotes();
	    } else {
		    $votes = Vote::whereCauseVariableId($model->getCauseVariableId())
			    ->where(Vote::FIELD_EFFECT_VARIABLE_ID, $model->getEffectVariableId())
			    ->get();
	    }
	    if($votes->count()){
		    $avg = $votes->pluck('value')->average();
	    }
        $model->setAttribute(static::NAME, $avg);
        return $avg;
    }
	public static function updateAverageVotes(): void{
		Vote::createView();
		$view = Vote::VIEW_AVERAGE_VOTES;
        $sql = "ifnull(av.average_vote, 0)";
        if(Writable::getConnectionName() === 'pgsql'){
            $sql = "coalesce(av.average_vote, 0)";
        }
		Writable::statementStatic("
            update aggregate_correlations ac
                left join average_votes av on
                    ac.cause_variable_id = av.cause_variable_id and
                ac.effect_variable_id = av.effect_variable_id
            set ac.average_vote = $sql;
        ");
	}
}
