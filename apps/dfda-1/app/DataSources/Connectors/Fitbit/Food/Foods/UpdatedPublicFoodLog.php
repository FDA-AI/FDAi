<?php

declare(strict_types=1);

namespace App\DataSources\Connectors\Fitbit\Food\Foods;

class UpdatedPublicFoodLog extends UpdatedFoodLog
{
    protected $nutritionalValues;

    public function __construct(
        MealType $mealType,
        string $unitId,
        int $amount
    ) {
        parent::__construct(
            $mealType,
            $unitId,
            $amount,
            null
        );
    }
}
