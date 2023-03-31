<?php /*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */ /** @noinspection PhpUnhandledExceptionInspection */
namespace App\PhpUnitJobs\Analytics;
use App\Exceptions\InsufficientMemoryException;
use App\Logging\QMLog;
use App\Properties\AggregateCorrelation\AggregateCorrelationAggregateQmScoreProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationIsPublicProperty;
use App\Properties\AggregateCorrelation\AggregateCorrelationNumberOfCorrelationsProperty;
use App\Correlations\QMAggregateCorrelation;
use App\PhpUnitJobs\JobTestCase;
class AggregateCorrelationsJob extends JobTestCase {
    public function testAggregateCorrelationsJob(): void{
        AggregateCorrelationNumberOfCorrelationsProperty::fixInvalidRecords();
        AggregateCorrelationAggregateQmScoreProperty::updateAll();
        AggregateCorrelationIsPublicProperty::updateAll();
        QMAggregateCorrelation::analyzeNeverAnalyzedUntilComplete();
        try {
            QMAggregateCorrelation::analyzeWaitingStaleStuck();
        } catch (InsufficientMemoryException $e){ // We don't want to fail the job just because we ran out of memory
            QMLog::info(__METHOD__.": ".$e->getMessage());
        }
        $this->checkAggregatedCorrelationStats();
    }
}
