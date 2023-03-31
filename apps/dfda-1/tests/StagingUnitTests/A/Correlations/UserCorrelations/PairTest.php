<?php /** @noinspection PhpUnhandledExceptionInspection */
namespace Tests\StagingUnitTests\A\Correlations\UserCorrelations;
use App\Correlations\QMUserCorrelation;
use App\Variables\CommonVariables\EmotionsCommonVariables\OverallMoodCommonVariable;
use App\Variables\QMUserVariable;
use Tests\SlimStagingTestCase;
class PairTest extends SlimStagingTestCase {
    public function testPairCreation() {
        $temp = QMUserVariable::findByName(65141, "Outdoor Temperature");
        $this->assertNoFillingValue($temp);
        $mood = QMUserVariable::findByName(65141, OverallMoodCommonVariable::NAME);
        $this->assertNoFillingValue($temp);
        $c = QMUserCorrelation::getOrCreateUserCorrelation(65141,
            $temp->name, $mood->name);
        $pairs = $c->getPairs();
        $this->assertGreaterThanOrEqual(14, count($pairs));
    }
}
