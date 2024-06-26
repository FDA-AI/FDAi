<?php

declare(strict_types=1);

namespace Tests\Fitbit\Body;

use Carbon\Carbon;
use Mockery;
use App\DataSources\Connectors\Fitbit\Api\Fitbit;
use App\DataSources\Connectors\Fitbit\Body\Fat\Fat;
use App\DataSources\Connectors\Fitbit\Body\Fat\Log;
use App\DataSources\Connectors\Fitbit\Body\Period;

class FatTest extends \Tests\Fitbit\FitbitTestCase
{
    private $fitbit;
    private $fat;

    public function setUp():void
    {
        parent::setUp();
        $this->fitbit = Mockery::mock(Fitbit::class);
        $this->fat = new Fat($this->fitbit);
    }

    public function testGettingByDate()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('body/log/fat/date/2019-03-21.json')
            ->andReturn('dateFat');
        $this->assertEquals(
            'dateFat',
            $this->fat->getByDate(
                Carbon::today()
            )
        );
    }

    public function testGettingByPeriod()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('body/log/fat/date/2019-03-21/1w.json')
            ->andReturn('periodFat');
        $this->assertEquals(
            'periodFat',
            $this->fat->getByPeriod(
                Carbon::today(),
                new Period(Period::ONE_WEEK)
            )
        );
    }

    public function testGettingByDateRange()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('body/log/fat/date/2019-03-21/2019-03-25.json')
            ->andReturn('rangeFat');
        $this->assertEquals(
            'rangeFat',
            $this->fat->getByDateRange(
                Carbon::today(),
                Carbon::today()->addDays(4)
            )
        );
    }

    public function testAddingALog()
    {
        $this->fitbit->shouldReceive('post')
            ->once()
            ->with('body/log/fat.json?fat=1.95&date=2019-03-21&time=10%3A25%3A40')
            ->andReturn('addedFatLog');
        $this->assertEquals(
            'addedFatLog',
            $this->fat->add(
                new Log(195, Carbon::now())
            )
        );
    }

    public function testDeletingALog()
    {
        $this->fitbit->shouldReceive('delete')
            ->once()
            ->with('body/log/fat/FatLogId.json')
            ->andReturn('removedFatLog');
        $this->assertEquals(
            'removedFatLog',
            $this->fat->remove('FatLogId')
        );
    }
}
