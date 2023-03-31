<?php

namespace App\Filament\Resources\AggregateCorrelationResource\Pages;

use App\Filament\Resources\AggregateCorrelationResource;
use Exception;
use Filament\Pages\Actions;
use Filament\Resources\Pages\ListRecords;

class ListAggregateCorrelations extends ListRecords
{
    protected static string $resource = AggregateCorrelationResource::class;

    /**
     * @throws Exception
     */
    protected function getActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
