<?php

declare(strict_types=1);

namespace App\DataSources\Connectors\Fitbit\Devices;

use Carbon\Carbon;

class UpdatingAlarm extends Alarm
{
    private $snoozeLength;
    private $snoozeCount;
    private $label;

    public function __construct(
        Carbon $time,
        bool $enabled,
        bool $recurring,
        Weekdays $weekDays,
        int $snoozeLength,
        int $snoozeCount,
        string $label = null
    ) {
        parent::__construct($time, $enabled, $recurring, $weekDays);
        $this->snoozeLength = $snoozeLength;
        $this->snoozeCount = $snoozeCount;
        $this->label = $label;
    }

    /**
     * Returns the updating alarm parameters as an http query to be inserted in an API call.
     */
    public function asUrlParam()
    {
        return parent::asUrlParam() . '&' . http_build_query([
            'snoozeLength' => $this->snoozeLength,
            'snoozeCount' => $this->snoozeCount,
            'label' => $this->label,
        ]);
    }
}
