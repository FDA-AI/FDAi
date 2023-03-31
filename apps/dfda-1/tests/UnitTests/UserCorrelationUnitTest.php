<?php /** @noinspection PhpDocMissingThrowsInspection */
/** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\UnitTests;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
use Tests\UnitTestCase;
class UserCorrelationUnitTest extends UnitTestCase {
    public function testUserCorrelationFields(){
        $fields = QMUserCorrelation::getSelectColumns();
        $this->assertContains(Correlation::TABLE.".". Correlation::FIELD_ANALYSIS_ENDED_AT." as analysisEndedAt", $fields);
        $fields = QMUserCorrelation::getColumns();
        $this->assertContains(Correlation::FIELD_ANALYSIS_ENDED_AT, $fields);
    }
}
