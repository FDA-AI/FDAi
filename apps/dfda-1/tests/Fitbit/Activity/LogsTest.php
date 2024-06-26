<?php

declare(strict_types=1);

namespace Tests\Fitbit\Activity;

use Carbon\Carbon;
use Mockery;
use App\DataSources\Connectors\Fitbit\Activity\Logs\ActivityLog;
use App\DataSources\Connectors\Fitbit\Activity\Logs\CustomActivityLog;
use App\DataSources\Connectors\Fitbit\Activity\Logs\Logs;
use App\DataSources\Connectors\Fitbit\Api\Fitbit;

class LogsTest extends \Tests\Fitbit\FitbitTestCase
{
    private $fitbit;
    private $logs;

    public function setUp():void
    {
        parent::setUp();
        $this->fitbit = Mockery::mock(Fitbit::class);
        $this->logs = new Logs($this->fitbit);
    }

    public function testAddingALog()
    {
        $this->fitbit->shouldReceive('post')
            ->once()
            ->with('activities.json?startTime=10%3A25%3A40&durationMillis=320&date=2019-03-21&activityId=10')
            ->andReturn('loggedActivity');
        $this->assertEquals(
            'loggedActivity',
            $this->logs->add(
                new ActivityLog(10, Carbon::now(), 320)
            )
        );
    }

    public function testAddingACustomActivityLog()
    {
        $this->fitbit->shouldReceive('post')
            ->once()
            ->with('activities.json?startTime=10%3A25%3A40&durationMillis=320&date=2019-03-21&activityName=customActivity&manualCalories=160')
            ->andReturn('loggedActivity');
        $this->assertEquals(
            'loggedActivity',
            $this->logs->add(
                new CustomActivityLog('customActivity', Carbon::now(), 320, 160)
            )
        );
    }

    public function testGettingALogTCX()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities/1210.tcx')
            ->andReturn('tcxContent');
        $this->assertEquals(
            'tcxContent',
            $this->logs->getTCX('1210')
        );
    }

    public function testRemovingAnActivityLog()
    {
        $this->fitbit->shouldReceive('delete')
            ->once()
            ->with('activities/1210.json')
            ->andReturn('deletedActivityLog');
        $this->assertEquals(
            'deletedActivityLog',
            $this->logs->remove('1210')
        );
    }

    public function testListingLogsAfterADate()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities/list.json?afterDate=2019-03-21&sort=desc&limit=200&offset=0')
            ->andReturn('logsList');
        $this->assertEquals(
            'logsList',
            $this->logs->listAfter(Carbon::now(), 'desc', 200)
        );
    }

    public function testListingLogsBeforeADate()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities/list.json?beforeDate=2019-03-21&sort=asc&limit=200&offset=0')
            ->andReturn('logsList');
        $this->assertEquals(
            'logsList',
            $this->logs->listBefore(Carbon::now(), 'asc', 200)
        );
    }
}
