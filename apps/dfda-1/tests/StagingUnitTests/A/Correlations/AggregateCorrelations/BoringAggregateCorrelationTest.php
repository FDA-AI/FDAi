<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\StagingUnitTests\A\Correlations\AggregateCorrelations;
use App\Logging\QMLog;
use App\Properties\Variable\VariableNameProperty;
use App\PhpUnitJobs\Cleanup\CorrelationsCleanUpJob;
use Tests\SlimStagingTestCase;
use App\Correlations\QMAggregateCorrelation;

class BoringAggregateCorrelationTest extends SlimStagingTestCase
{
    public function testBoringAggregateCorrelation(): void{
        //CorrelationsCleanUpJobTest::fix3rdPartyQmScore();
        $fix = false;
        if($fix){
            VariableNameProperty::deleteStupidBoringVariables();
            CorrelationsCleanUpJob::testDeleteStupidCorrelations();
        }
		$correlations = QMAggregateCorrelation::getOrCreateAggregateCorrelations();
		$this->assertCount(10, $correlations);
		foreach($correlations as $correlation){
		    QMLog::infoWithoutContext($correlation->generateStudyTitle());
		    if($correlation->isBoring()){
		        $correlation->logInfo("QM SCORE: ".$correlation->getAggregateQMScore());
                $this->assertFalse($correlation->isBoring(), $correlation->generateStudyTitle());
            }
        }
		$this->checkTestDuration(16);
		$this->checkQueryCount(5);
	}
}
