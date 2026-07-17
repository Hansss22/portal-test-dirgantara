<?php

namespace App\Filament\Resources;

use App\Filament\Resources\HasilTestResource\Pages;
use App\Models\EventPeserta;
use App\Models\HasilJawabanPeserta;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Table;
use Filament\Notifications\Notification;

// Ini menjawab wireframe "4. Report Hasil Test"
class HasilTestResource extends Resource
{
    protected static ?string $model = EventPeserta::class;

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';

    protected static ?string $navigationLabel = 'Report Hasil Test';

    protected static ?string $modelLabel = 'Hasil Test';

    // Report ini read-only, tidak butuh form create manual
    public static function canCreate(): bool
    {
        return false;
    }

    public static function form(Form $form): Form
    {
        return $form->schema([]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->query(EventPeserta::query()->with(['event', 'peserta']))
            ->columns([
                Tables\Columns\TextColumn::make('event.nama_event')->label('Nama Event')->searchable(),
                Tables\Columns\TextColumn::make('event.tanggal_event')->label('Tahun')
                    ->date('Y')->sortable(),
                Tables\Columns\TextColumn::make('peserta.nama')->label('Nama Peserta')->searchable(),
                Tables\Columns\TextColumn::make('peserta.email')->label('Email')->searchable(),
                Tables\Columns\BadgeColumn::make('status_pengerjaan'),
                Tables\Columns\TextColumn::make('skor_pg')->label('Skor PG (otomatis)'),
                Tables\Columns\TextColumn::make('skor_esai_manual')->label('Skor Esai (manual)')
                    ->default('Menunggu penilaian'),
                Tables\Columns\TextColumn::make('skor_total')->label('Skor Akhir'),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('event_id')
                    ->relationship('event', 'nama_event')
                    ->label('Nama Event'),
            ])
            ->headerActions([
                // Export rekap SEMUA peserta yang sudah selesai mengerjakan (bisa difilter per event)
                Tables\Actions\Action::make('exportSemua')
                    ->label('Export Semua ke Excel')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->form([
                        Forms\Components\Select::make('event_id')
                            ->label('Filter Nama Event (kosongkan untuk semua event)')
                            ->relationship('event', 'nama_event'),
                    ])
                    ->action(function (array $data) {
                        return \Maatwebsite\Excel\Facades\Excel::download(
                            new \App\Exports\SemuaHasilTestExport($data['event_id'] ?? null),
                            'rekap-hasil-test.xlsx'
                        );
                    }),
            ])
            ->actions([
                // Admin melihat rincian benar/salah tiap jawaban peserta
                Tables\Actions\Action::make('lihatDetail')
                    ->label('Lihat Detail Jawaban')
                    ->icon('heroicon-o-eye')
                    ->modalHeading('Detail Jawaban Peserta')
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Tutup')
                    ->infolist(function (EventPeserta $record) {
                        $jawabanList = HasilJawabanPeserta::with(['soal.jawabanSoals', 'jawabanSoal'])
                            ->where('event_id', $record->event_id)
                            ->where('peserta_id', $record->peserta_id)
                            ->get();

                        $entries = [];
                        foreach ($jawabanList as $j) {
                            $jawabanBenar = $j->soal->isPg()
                                ? optional($j->soal->jawabanSoals->firstWhere('nilai', true))->jawaban
                                : '-';
                            $jawabanPeserta = $j->soal->isPg() ? optional($j->jawabanSoal)->jawaban : $j->jawaban_esai;
                            $status = $j->soal->isPg()
                                ? ($j->is_benar ? 'Benar' : 'Salah')
                                : (is_null($j->nilai_manual) ? 'Menunggu penilaian' : ('Nilai: ' . $j->nilai_manual));

                            $entries[] = TextEntry::make('soal_' . $j->id)
                                ->label($j->soal->pertanyaan)
                                ->state("Jawaban: {$jawabanPeserta}\nJawaban Benar: {$jawabanBenar}\nStatus: {$status}");
                        }

                        return Infolist::make()->schema($entries);
                    }),

                // Menjawab pertanyaan di catatan: "kalau report-nya esai gimana?"
                // -> admin menilai jawaban esai secara manual di sini, lalu skor esai
                //    otomatis dijumlah ke skor akhir peserta.
                Tables\Actions\Action::make('nilaiEsai')
                    ->label('Nilai Esai')
                    ->icon('heroicon-o-pencil-square')
                    ->visible(fn (EventPeserta $record) => $record->jawabanEsai()->exists())
                    ->form(function (EventPeserta $record) {
                        $jawaban = $record->jawabanEsai()->with('soal')->get();
                        $schema = [];
                        foreach ($jawaban as $j) {
                            $schema[] = Forms\Components\Placeholder::make('soal_' . $j->id)
                                ->label($j->soal->pertanyaan)
                                ->content($j->jawaban_esai);
                            $schema[] = Forms\Components\TextInput::make('nilai_' . $j->id)
                                ->label('Nilai (0-100)')
                                ->numeric()->minValue(0)->maxValue(100)
                                ->default($j->nilai_manual);
                        }
                        return $schema;
                    })
                    ->action(function (EventPeserta $record, array $data) {
                        $jawaban = $record->jawabanEsai()->get();
                        $total = 0;
                        $count = 0;
                        foreach ($jawaban as $j) {
                            $nilai = $data['nilai_' . $j->id] ?? 0;
                            $j->update(['nilai_manual' => $nilai]);
                            $total += $nilai;
                            $count++;
                        }
                        $record->update([
                            'skor_esai_manual' => $count ? intdiv($total, $count) : 0,
                        ]);
                        Notification::make()->title('Nilai esai tersimpan')->success()->send();
                    }),

                // Export detail jawaban peserta ini: kode soal, pertanyaan, jawaban benar,
                // jawaban peserta, kategori pertanyaan - sesuai wireframe "export to excel"
                Tables\Actions\Action::make('export')
                    ->label('Export to Excel')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->action(function (EventPeserta $record) {
                        return \Maatwebsite\Excel\Facades\Excel::download(
                            new \App\Exports\HasilTestExport($record->event_id, $record->peserta_id),
                            'hasil-test-' . $record->peserta->nik . '.xlsx'
                        );
                    }),
            ]);
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListHasilTests::route('/'),
        ];
    }
}
