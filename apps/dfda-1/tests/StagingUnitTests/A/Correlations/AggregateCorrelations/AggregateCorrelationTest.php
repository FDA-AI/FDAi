<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\StagingUnitTests\A\Correlations\AggregateCorrelations;
use Tests\SlimStagingTestCase;
use App\Correlations\QMAggregateCorrelation;

class AggregateCorrelationTest extends SlimStagingTestCase
{
    public function testAggregateCorrelation(): void{
		QMAggregateCorrelation::getOrCreateByIds(1248 ,1398);
		$this->checkTestDuration(18);
		$this->checkQueryCount(5);
	}
}
