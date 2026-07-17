<?php

namespace App\Filament\Resources\KataPengantarResource\Pages;

use App\Filament\Resources\KataPengantarResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditKataPengantar extends EditRecord
{
    protected static string $resource = KataPengantarResource::class;

    protected function getHeaderActions(): array
    {
        return [Actions\DeleteAction::make()];
    }
}
