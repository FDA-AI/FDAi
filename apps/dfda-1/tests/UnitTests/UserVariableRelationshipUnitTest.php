<?php /** @noinspection PhpDocMissingThrowsInspection */
/** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\UnitTests;
use App\Correlations\QMUserVariableRelationship;
use App\Models\Correlation;
use Tests\UnitTestCase;
class UserVariableRelationshipUnitTest extends UnitTestCase {
    public function testUserVariableRelationshipFields(){
        $fields = QMUserVariableRelationship::getSelectColumns();
        $this->assertContains(Correlation::TABLE.".". Correlation::FIELD_ANALYSIS_ENDED_AT." as analysisEndedAt", $fields);
        $fields = QMUserVariableRelationship::getColumns();
        $this->assertContains(Correlation::FIELD_ANALYSIS_ENDED_AT, $fields);
    }
}
