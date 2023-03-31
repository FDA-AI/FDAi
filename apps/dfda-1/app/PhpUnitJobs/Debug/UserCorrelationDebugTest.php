<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnusedLocalVariableInspection */
/** @noinspection PhpUnhandledExceptionInspection */
namespace App\PhpUnitJobs\Debug;
use App\Correlations\QMUserCorrelation;
use App\Models\Correlation;
use App\PhpUnitJobs\JobTestCase;
use App\Variables\QMUserVariable;
class UserCorrelationDebugTest extends JobTestCase {
    private const CAUSE = "Outdoor Temperature";
    private const EFFECT = "Overall Mood";
    public function testDebugUserCorrelationAnalysis(){
        $c = QMUserCorrelation::getOrCreateUserCorrelation(65141, self::CAUSE, self::EFFECT);
        $c->analyzeFully(__FUNCTION__);
    }
    public function testUserCorrelationDebug(){
        $cause = QMUserVariable::getByNameOrId(230, self::CAUSE);
        $effect = QMUserVariable::getByNameOrId(230, self::EFFECT);
        QMUserCorrelation::shouldWeCalculate($cause, $effect);
        $c = new QMUserCorrelation(null, $cause, $effect);
        $c->analyzeFully(__FUNCTION__);
        $html = $c->getStudyHtml()->getTitleGaugesTagLineHeader(true, true);
        $cause->forceAnalyze(__FUNCTION__);
        $correlations = $cause->getCorrelationsAsCause();
        $rows = QMUserCorrelation::readonly()
            ->where(Correlation::FIELD_CAUSE_VARIABLE_ID, $cause->getVariableIdAttribute())
            ->getArray();
        $correlations = QMUserCorrelation::get([
            Correlation::FIELD_USER_ID => 230,
            'causeVariableName'              => self::CAUSE,
            'effectVariableName'             => self::EFFECT,
        ]);
        $c = $correlations[0];
        $val = $c->changeFromBaselineSentence();
        $this->assertNotNull($val);
    }
    public function testOutputNumberOfCorrelationsByUser(){
        $v = QMUserVariable::getByNameOrId(230, "Spending on Restaurants");
        $v->analyzeFully(__FUNCTION__);
    }
}
