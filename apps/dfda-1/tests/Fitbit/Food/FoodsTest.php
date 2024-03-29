<?php

declare(strict_types=1);

namespace Tests\Fitbit\Food;

use Mockery;
use App\DataSources\Connectors\Fitbit\Api\Fitbit;
use App\DataSources\Connectors\Fitbit\Food\Foods\Food;
use App\DataSources\Connectors\Fitbit\Food\Foods\Foods;
use App\DataSources\Connectors\Fitbit\Food\Foods\FormType;
use App\DataSources\Connectors\Fitbit\Food\Foods\NutritionalValues;

class FoodsTest extends \Tests\Fitbit\FitbitTestCase
{
    private $fitbit;
    private $foods;

    public function setUp():void
    {
        parent::setUp();
        $this->fitbit = Mockery::mock(Fitbit::class);
        $this->foods = new Foods($this->fitbit);
    }

    public function testGettingLocales()
    {
        $this->fitbit->shouldReceive('getNonUserEndpoint')
            ->once()
            ->with('foods/locales.json')
            ->andReturn('foodLocales');
        $this->assertEquals(
            'foodLocales',
            $this->foods->getLocales()
        );
    }

    public function testSearchingFoods()
    {
        $this->fitbit->shouldReceive('getNonUserEndpoint')
            ->once()
            ->with('foods/search.json?query=food+search+query')
            ->andReturn('searchResults');
        $this->assertEquals(
            'searchResults',
            $this->foods->search('food search query')
        );
    }

    public function testGettingTheFoodUnits()
    {
        $this->fitbit->shouldReceive('getNonUserEndpoint')
            ->once()
            ->with('foods/units.json')
            ->andReturn('foodUnits');
        $this->assertEquals(
            'foodUnits',
            $this->foods->getUnits()
        );
    }

    public function testGettingAFoodDetails()
    {
        $this->fitbit->shouldReceive('getNonUserEndpoint')
            ->once()
            ->with('foods/foodId.json')
            ->andReturn('foodDetails');
        $this->assertEquals(
            'foodDetails',
            $this->foods->get('foodId')
        );
    }

    public function testGettingRecentFoods()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('foods/log/recent.json')
            ->andReturn('recentFoods');
        $this->assertEquals(
            'recentFoods',
            $this->foods->recent()
        );
    }

    public function testGettingFrequentFoods()
    {
        $this->fitbit->shouldReceive('get')
            ->once()
            ->with('foods/log/frequent.json')
            ->andReturn('frequentFoods');
        $this->assertEquals(
            'frequentFoods',
            $this->foods->frequent()
        );
    }

    public function testCreatingAFoodWithoutNutritionalInformation()
    {
        $this->fitbit->shouldReceive('postNonUserEndpoint')
            ->once()
            ->with('foods.json?name=test+food&defaultFoodMeasurementUnitId=unitId&defaultServingSize=servingSize&calories=400&formType=DRY&description=test+food+description')
            ->andReturn('newFood');
        $this->assertEquals(
            'newFood',
            $this->foods->create(
                new Food(
                    'test food',
                    'unitId',
                    'servingSize',
                    400,
                    new FormType(FormType::DRY),
                    'test food description'
                )
            )
        );
    }

    public function testCreatingAFoodWithNutritionalInformation()
    {
        $this->fitbit->shouldReceive('postNonUserEndpoint')
            ->once()
            ->with('foods.json?name=test+food&defaultFoodMeasurementUnitId=unitId&defaultServingSize=servingSize&calories=400&formType=DRY&description=test+food+description&protein=10')
            ->andReturn('newFood');
        $this->assertEquals(
            'newFood',
            $this->foods->create(
                (new Food(
                    'test food',
                    'unitId',
                    'servingSize',
                    400,
                    new FormType(FormType::DRY),
                    'test food description'
                ))->setNutritionalValues((new NutritionalValues())->setProtein(10))
            )
        );
    }

    public function testRemovingACustomFood()
    {
        $this->fitbit->shouldReceive('delete')
            ->once()
            ->with('foods/1210.json')
            ->andReturn('deletedCustomFood');
        $this->assertEquals(
            'deletedCustomFood',
            $this->foods->remove('1210')
        );
    }
}
