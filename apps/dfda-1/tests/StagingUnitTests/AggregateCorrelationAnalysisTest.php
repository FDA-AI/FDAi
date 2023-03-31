<?php /** @noinspection PhpUnhandledExceptionInspection */
/** @noinspection PhpUnusedLocalVariableInspection */
namespace Tests\StagingUnitTests;
use Tests\SlimStagingTestCase;
use App\Correlations\QMAggregateCorrelation;
class AggregateCorrelationAnalysisTest extends SlimStagingTestCase
{
    public function testAggregateCorrelationAnalysis(): void{
		$c = QMAggregateCorrelation::getOrCreateByIds(5954773 ,102685);
		$c->analyzeFully('we are testing');
		$this->checkTestDuration(10);
		$this->checkQueryCount(34);
	}
}
