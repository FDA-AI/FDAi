<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnhandledExceptionInspection */
/** @noinspection PhpDocMissingThrowsInspection */
namespace App\PhpUnitJobs\Cleanup;
use App\Correlations\QMUserCorrelation;
use App\Exceptions\AlreadyAnalyzingException;
use App\Exceptions\InsufficientVarianceException;
use App\Exceptions\NotEnoughMeasurementsForCorrelationException;
use App\Exceptions\TooManyMeasurementsException;
use App\Exceptions\TooSlowToAnalyzeException;
use App\Exceptions\UnauthorizedException;
use App\Logging\QMLog;
use App\Models\Correlation;
use App\PhpUnitJobs\JobTestCase;
use App\Properties\GlobalVariableRelationship\GlobalVariableRelationshipDataSourceNameProperty;
use App\Properties\Correlation\CorrelationChartsProperty;
use App\Slim\View\Request\Variable\GetCommonVariablesRequest;
use App\Utils\UrlHelper;
use Illuminate\Support\Arr;
class UserCorrelationsCleanUpJobTest extends JobTestCase {
    //public const SLACK_CHANNEL = "user-correlations";
    protected const SLACK_CHANNEL = '#emergency';
    public function testUserCorrelationCleanup(){
        CorrelationChartsProperty::shrinkLargeCorrelations();
        self::getCorrelationsWithoutMeasurements();
    }
    /**
     * @throws UnauthorizedException
     */
    public static function deleteActivitiesCorrelations(){
        QMLog::infoWithoutContext("=== ".__FUNCTION__." ===");
        // CORRELATIONS WITH STUPID VARIABLES SHOULD ALREADY BE DELETED BY \App\Variables\CommonVariable::deleteStupidVariables
        $activityVariables = GetCommonVariablesRequest::getWithNameContainingAllWords('Activities');
        $t = count($activityVariables);
        $i = 0;
        foreach($activityVariables as $variable){
            $i++;
            QMLog::info("$i out of $t Activities variables completed...");
            $deleted = $variable->hardDeleteCorrelationsWhereOutcome(__FUNCTION__);
            if($deleted){
                $variable->analyzeFully(__FUNCTION__);
            }
        }
    }
    /**
     * @param string|int $date
     * @throws AlreadyAnalyzingException
     * @throws InsufficientVarianceException
     * @throws TooSlowToAnalyzeException
     */
    public static function reCorrelateUserCorrelationsOlderThan($date){
        $allRows = QMUserCorrelation::readonly()
            //->select([UserCorrelation::FIELD_USER_ID])
            //->selectRaw("MIN(updated_at) as min_updated_at")
            ->where(Correlation::FIELD_UPDATED_AT, '<', db_date($date))
            ->where(Correlation::FIELD_DATA_SOURCE_NAME, GlobalVariableRelationshipDataSourceNameProperty::DATA_SOURCE_NAME_USER)
            ->whereNull(Correlation::FIELD_DELETED_AT)
            ->orderBy(Correlation::FIELD_UPDATED_AT, 'asc')
            //->groupBy(self::FIELD_USER_ID)
            ->getArray();
        $userIds = array_unique(Arr::pluck($allRows, 'user_id'));
        QMLog::infoWithoutContext(count($userIds)." users with correlations older than $date");
        foreach($userIds as $userId){
            $forUser = Arr::where($allRows, static function($row) use ($userId){
                return $row->user_id === $userId;
            });
            QMLog::infoWithoutContext(count($forUser)." correlations for user $userId older than $date");
            foreach($forUser as $row){
                $c = QMUserCorrelation::findByNamesOrIds($userId, $row->cause_variable_id, $row->effect_variable_id);
                if(!$c){
                    QMLog::infoWithoutContext("NOT FOUND user_id $userId, cause_variable_id $row->cause_variable_id, effect_variable_id $row->effect_variable_id");
                    continue;
                }
                if($c->getCauseQMVariableCategory()->isSoftware()){
                    $c->softDelete([], "$c->causeVariableName is an app or website");
                    continue;
                }
                if(!$c->getOrSetEffectQMVariable()->isOutcome()){
                    $c->softDelete([], "$c->effectVariableName is not an outcome");
                    continue;
                }
                try {
                    $c->analyzeFully(__FUNCTION__);
                } catch (InsufficientVarianceException $e) {
                } catch (NotEnoughMeasurementsForCorrelationException $e) {
                    $c->logError("Deleting because ".$e->getMessage());
                    $c->softDelete([], $e->getMessage());
                } catch (TooManyMeasurementsException $e) {
                }
            }
        }
    }
    public static function getCorrelationsWithoutMeasurements(){
        \App\Logging\ConsoleLog::info(UrlHelper::getCleanupSelectUrl("select c.* from correlations c",
            "delete c from correlations c",
            "left join measurements m on c.cause_user_variable_id = m.user_variable_id where m.id is null",
            "Missing cause measurements"));
        \App\Logging\ConsoleLog::info(UrlHelper::getCleanupSelectUrl("select c.* from correlations c",
            "delete c from correlations c",
            "left join measurements m on c.effect_user_variable_id = m.user_variable_id where m.id is null",
            "Missing effect measurements"));
    }
}
