<?php

namespace App\Filament\Resources\KataPengantarResource\Pages;

use App\Filament\Resources\KataPengantarResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListKataPengantars extends ListRecords
{
    protected static string $resource = KataPengantarResource::class;

    protected function getHeaderActions(): array
    {
        return [Actions\CreateAction::make()->label('Tambah')];
    }
}
