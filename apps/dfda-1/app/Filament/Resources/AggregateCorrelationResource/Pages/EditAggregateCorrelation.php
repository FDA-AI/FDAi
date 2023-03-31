<?php

namespace App\Filament\Resources\AggregateCorrelationResource\Pages;

use App\Filament\Resources\AggregateCorrelationResource;
use Exception;
use Filament\Pages\Actions;
use Filament\Resources\Pages\EditRecord;

class EditAggregateCorrelation extends EditRecord
{
    protected static string $resource = AggregateCorrelationResource::class;

    /**
     * @throws Exception
     */
    protected function getActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
