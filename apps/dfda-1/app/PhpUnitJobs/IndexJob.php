<?php
/*
*  GNU General Public License v3.0
*  Contributors: ADD YOUR NAME HERE, Mike P. Sinn
 */

namespace App\PhpUnitJobs;
use App\Console\Kernel;
use App\Logging\QMLog;
use App\Models\Correlation;
class IndexJob extends JobTestCase
{
    public function testIndex(){
        Kernel::artisan("scout:import", ["model" => \App\Models\Correlation::class]);
    }
    public function testStatus(){
        Kernel::artisan("scout:status");
    }
    public function testSearch(){
        $correlation = Correlation::search("Cal");
        //$paginator = $correlation->paginate(10);
        $start = microtime(true);
        $before = microtime(true) - $start;
        $posts = $correlation->get();
        $duration = microtime(true) - $start;
        QMLog::info($duration);
    }
}
