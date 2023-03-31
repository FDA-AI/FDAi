<?php /** @noinspection PhpMissingReturnTypeInspection */
/** @noinspection ArgumentEqualsDefaultValueInspection */
/** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\SlimTests\Analytics;
use App\Correlations\QMAggregateCorrelation;
use App\Logging\ConsoleLog;
use App\Logging\QMLogLevel;
use App\Utils\Env;
class AggregatedCorrelationsTest extends \Tests\SlimTests\SlimTestCase {
    public function testDurationOfActionCorrelationsFilterParams(){
        $this->setAuthenticatedUser(1);
        $apiUrl = '/api/correlations';
        // durationOfAction parameter test
        $parameters = ['effectVariableName' => 'Body Mass Index Or BMI', 'durationOfAction' => 86400];
        $aggregateCorrelations = $this->getAndDecodeBody($apiUrl, $parameters);
        foreach ($aggregateCorrelations as $aggregateCorrelation) {
            $this->assertEquals(86400, $aggregateCorrelation->durationOfAction);
            $this->checkUserCorrelationObject($aggregateCorrelation);
        }
    }
    /**
     * @param QMAggregateCorrelation $c
     */
    protected function checkGetAggregateCorrelationFromGlobals(QMAggregateCorrelation $c): void{
        $fromMemoryByName = QMAggregateCorrelation::getFromMemoryByCauseAndEffectNameOrId($c->causeVariableName, $c->effectVariableName);
        $this->assertEquals($c->causeVariableName, $fromMemoryByName->causeVariableName);
        $this->assertEquals($c->effectVariableName, $fromMemoryByName->effectVariableName);
        $fromMemoryById = QMAggregateCorrelation::getFromMemoryByCauseAndEffectNameOrId($c->causeVariableId, $c->effectVariableId);
        $this->assertEquals($c->causeVariableId, $fromMemoryById->causeVariableId);
        $this->assertEquals($c->effectVariableId, $fromMemoryById->effectVariableId);
    }
}
