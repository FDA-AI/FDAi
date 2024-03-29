<?php

namespace App\Filament\Resources\NotificationResource\Pages;

use App\Filament\Resources\NotificationResource;
use Exception;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ViewRecord;

class ViewNotification extends ViewRecord
{
    protected static string $resource = NotificationResource::class;

    /**
     * @throws Exception
     */
    protected function getActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }
}
