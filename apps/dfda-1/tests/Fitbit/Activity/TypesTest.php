<?php

declare(strict_types=1);

namespace Tests\Fitbit\Activity;

use Mockery;
use App\DataSources\Connectors\Fitbit\Activity\Types;
use App\DataSources\Connectors\Fitbit\Api\Fitbit;

class TypesTest extends \Tests\Fitbit\FitbitTestCase
{
    private $fitbit;
    private $types;

    public function setUp():void
    {
        parent::setUp();
        $this->fitbit = Mockery::mock(Fitbit::class);
        $this->types = new Types($this->fitbit);
    }

    public function testBrowsingActivityTypes()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities.json')
            ->andReturn('allActivities');
        $this->assertEquals(
            'allActivities',
            $this->types->browse()
        );
    }

    public function testGettingAnActivityById()
    {
        $id = 1;
        $this->fitbit->shouldReceive('getNonUserEndpoint')
            ->once()
            ->with('activities/1.json')
            ->andReturn('activity1');
        $this->assertEquals(
            'activity1',
            $this->types->get($id)
        );
    }

    public function testGettingTheFrequentActivities()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities/frequent.json')
            ->andReturn('frequentActivities');
        $this->assertEquals(
            'frequentActivities',
            $this->types->frequent()
        );
    }

    public function testGettingTheRecentActivities()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('activities/recent.json')
            ->andReturn('recentActivities');
        $this->assertEquals(
            'recentActivities',
            $this->types->recent()
        );
    }
}
