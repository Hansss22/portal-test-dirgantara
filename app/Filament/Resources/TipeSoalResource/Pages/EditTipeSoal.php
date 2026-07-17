<?php

namespace App\Filament\Resources\TipeSoalResource\Pages;

use App\Filament\Resources\TipeSoalResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditTipeSoal extends EditRecord
{
    protected static string $resource = TipeSoalResource::class;

    protected function getHeaderActions(): array
    {
        return [Actions\DeleteAction::make()];
    }
}
