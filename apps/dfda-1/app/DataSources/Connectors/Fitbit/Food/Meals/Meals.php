<?php

declare(strict_types=1);

namespace App\DataSources\Connectors\Fitbit\Food\Meals;

use App\DataSources\Connectors\Fitbit\Api\Fitbit;

class Meals
{
    private $fitbit;

    public function __construct(Fitbit $fitbit)
    {
        $this->fitbit = $fitbit;
    }

    /**
     * Returns a list of meals created by user in his or her food log.
     */
    public function all()
    {
        return $this->fitbit->get('meals.json');
    }

    /**
     * Creates a meal with the given food.
     *
     * @param string $mealId
     */
    public function create(Meal $meal)
    {
        return $this->fitbit->postBody('meals.json', $meal->toArray());
    }

    /**
     * Retrieves a meal for a user given the meal id.
     *
     * @param string $mealId
     */
    public function get(string $mealId)
    {
        return $this->fitbit->get('meals/' . $mealId . '.json');
    }

    /**
     * Edits a meal for a user given the meal id.
     *
     * @param string $mealId
     * @param Meal $meal
     */
    public function edit(string $mealId, Meal $meal)
    {
        return $this->fitbit->postBody('meals/' . $mealId . '.json', $meal->toArray());
    }

    /**
     * Deletes a user's meal with the given ID.
     *
     * @param string $mealId
     */
    public function remove(string $mealId)
    {
        return $this->fitbit->delete('meals/' . $mealId . '.json');
    }
}
