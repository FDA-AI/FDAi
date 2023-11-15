<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnhandledExceptionInspection */
namespace App\PhpUnitJobs\Analytics;
use App\Computers\ThisComputer;
use App\Correlations\QMUserCorrelation;
use App\Models\User;
use App\Models\UserVariable;
use App\PhpUnitJobs\JobTestCase;
use App\Slim\Model\User\QMUser;
/** Class UserCorrelationsJobTest
 * @package App\PhpUnitJobs
 */
class UserCorrelationsJob extends JobTestCase {
    //public const SLACK_CHANNEL = "user-variable-relationships";
    protected const SLACK_CHANNEL = '#emergency';
    public function testUserCorrelationAnalysisJob(){
        $this->assertGreaterThanOrEqual(1500, ThisComputer::getMemoryLimitWithBufferInMB());
        //CorrelationInternalErrorMessageProperty::fixInvalidRecords();
        UserVariable::correlateNeverCorrelated();
        QMUserCorrelation::analyzeNeverAnalyzedUntilComplete();
        $correlations = QMUserCorrelation::analyzeWaitingStaleStuck();
        if(!$correlations){$correlations = QMUserCorrelation::analyzeStuck();}
        if(!$correlations){$correlations = QMUserCorrelation::analyzeNeverFinished();}
        $this->assertGreaterThan(0, count($correlations), "We didn't find any correlations that needed analysis!");
    }
    private static function correlateByUser(): void{
        /** @var QMUser[] $rows */
        $rows = QMUser::readonly()
            ->orderBy(User::FIELD_LAST_CORRELATION_AT, 'asc')
            ->limit(100)
            ->getDBModels();
        foreach($rows as $row){
            $row->updateUserStatisticsAndCorrelate();
        }
    }
}
