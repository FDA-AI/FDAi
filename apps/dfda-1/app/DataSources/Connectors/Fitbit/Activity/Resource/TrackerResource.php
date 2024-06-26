<?php

declare(strict_types=1);

namespace App\DataSources\Connectors\Fitbit\Activity\Resource;

class TrackerResource extends AbstractResource
{
    //TODO: Seems that some metrics are not available for the tracker resource.
    protected function getPath()
    {
        return 'activities/tracker/';
    }
}
