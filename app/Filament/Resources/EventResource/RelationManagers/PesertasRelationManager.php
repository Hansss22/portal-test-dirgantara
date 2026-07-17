<?php

namespace App\Filament\Resources\EventResource\RelationManagers;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables;
use Filament\Tables\Table;

// Ini yang mewujudkan wireframe "B. Mengelola Peserta -> Tambah Peserta"
// tinggal pilih peserta yang sudah ada (master data Peserta) untuk didaftarkan ke event ini.
class PesertasRelationManager extends RelationManager
{
    protected static string $relationship = 'pesertas';

    protected static ?string $title = 'Daftar Peserta';

    public function form(Form $form): Form
    {
        // Tidak ada field form di sini karena peserta hanya di-attach dari master data
        // (dibuat/di-edit lewat menu Peserta), sesuai wireframe "Tambah Peserta" yang
        // memilih dari data peserta yang sudah ada.
        return $form->schema([]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('nama')
            ->columns([
                Tables\Columns\TextColumn::make('nik'),
                Tables\Columns\TextColumn::make('nama'),
                Tables\Columns\TextColumn::make('organisasi'),
                Tables\Columns\TextColumn::make('jobTitle.nama_jobtitle')->label('Job Title'),
                Tables\Columns\TextColumn::make('pivot.status_pengerjaan')->label('Status')->badge(),
                Tables\Columns\TextColumn::make('pivot.skor_pg')->label('Skor PG'),
            ])
            ->headerActions([
                Tables\Actions\AttachAction::make()
                    ->label('Tambah Peserta')
                    ->preloadRecordSelect()
                    ->recordSelectSearchColumns(['nik', 'nama', 'email']),
            ])
            ->actions([
                Tables\Actions\DetachAction::make()->label('Hapus'),
            ])
            ->bulkActions([
                Tables\Actions\DetachBulkAction::make(),
            ]);
    }
}
