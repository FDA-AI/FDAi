<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\SlimTests\Analytics;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
class CorrelationModelTest extends \Tests\SlimTests\SlimTestCase {
	protected function setUp(): void{
		parent::setUp();
		QMUserCorrelation::writable()->update([Correlation::FIELD_PREDICTS_LOW_EFFECT_CHANGE => 10]);
	}
	public function testGetCorrelationsWithCause(){
		$this->skipTest('TODO: Create aggregate correlations test fixture');
		$params['userId'] = 1;
		$params['causeVariableName'] = 'Active Time';
		$correlationsWithCause = QMUserCorrelation::getOrCreateUserOrAggregateCorrelations($params);
		$this->assertCount(1, $correlationsWithCause);
		foreach($correlationsWithCause as $correlation){
			$this->assertEquals($params['causeVariableName'], $correlation->causeVariableName);
		}
	}
}
