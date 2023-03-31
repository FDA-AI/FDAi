<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\StagingUnitTests\A\Correlations\UserCorrelations;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
use App\PhpUnitJobs\Cleanup\UserVariableCleanupJobTest;
use App\Variables\QMUserVariable;
use Tests\SlimStagingTestCase;
class UserCorrelationCalculationTest extends SlimStagingTestCase {
    public function testUserCorrelationCalculation() {
        UserVariableCleanupJobTest::fixExperimentEndTimes();
        $userId = 230;
        $cause = QMUserVariable::getByNameOrId($userId, "Sleep Quality");
        $raw = $cause->getQMMeasurements();
        $this->assertGreaterThan(1, count($raw));
        $processed = $cause->getValidDailyMeasurementsWithTagsAndFilling();
        $this->assertGreaterThan(1, count($processed));
        $effect = QMUserVariable::getByNameOrId($userId, "Headache Severity");
        $this->assertNotNull($cause->earliestTaggedMeasurementTime);
        $this->assertNotNull($effect->earliestTaggedMeasurementTime);
        $this->assertNotNull($cause->latestTaggedMeasurementTime);
        $this->assertNotNull($effect->latestTaggedMeasurementTime);
        $fields = QMUserCorrelation::getColumns();
        Correlation::whereId(0)->forceDelete();
        $this->assertContains(Correlation::FIELD_ANALYSIS_ENDED_AT, $fields);
        $this->assertContains(Correlation::FIELD_STATUS, $fields);
        $c = QMUserCorrelation::getOrCreateUserCorrelation($userId, $cause->variableId, $effect->variableId);
        $this->assertTrue($c->uniqueFieldsAreSet());
        $c = new QMUserCorrelation(null, $cause, $effect);
        $c->analyzeFully(__FUNCTION__);
        $this->assertGreaterThan(0.1, $c->correlationCoefficient);
        $row = Correlation::whereId($c->id)->first();
        $this->assertNotEmpty($row->correlations_over_delays);
        $this->assertNotEmpty($row->correlations_over_durations);
    }
}
