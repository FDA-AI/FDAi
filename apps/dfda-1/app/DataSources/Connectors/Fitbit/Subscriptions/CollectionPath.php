<?php

declare(strict_types=1);

namespace App\DataSources\Connectors\Fitbit\Subscriptions;

use App\DataSources\Connectors\Fitbit\BasicEnum;

class CollectionPath extends BasicEnum
{
    public const ACTIVITIES = 'activities';
    public const BODY = 'body';
    public const FOODS = 'foods';
    public const SLEEP = 'sleep';

    private $collectionPath;

    public function __construct(string $collectionPath)
    {
        parent::checkValidity($collectionPath);
        $this->collectionPath = $collectionPath;
    }

    public function __toString()
    {
        return $this->collectionPath;
    }
}
