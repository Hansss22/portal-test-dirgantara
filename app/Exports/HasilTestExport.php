<?php

namespace App\Exports;

use App\Models\HasilJawabanPeserta;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;

// Export detail jawaban 1 peserta pada 1 event, sesuai wireframe "export to excel":
// kode soal | pertanyaan | jawaban benar | jawaban peserta | kategori pertanyaan
class HasilTestExport implements FromCollection, WithHeadings, WithMapping
{
    public function __construct(
        protected int $eventId,
        protected int $pesertaId,
    ) {}

    public function collection()
    {
        return HasilJawabanPeserta::with(['soal', 'jawabanSoal'])
            ->where('event_id', $this->eventId)
            ->where('peserta_id', $this->pesertaId)
            ->get();
    }

    public function headings(): array
    {
        return ['Kode Soal', 'Pertanyaan', 'Jawaban Benar', 'Jawaban Peserta', 'Kategori Pertanyaan'];
    }

    public function map($row): array
    {
        $jawabanBenar = $row->soal->isPg()
            ? optional($row->soal->jawabanSoals()->where('nilai', true)->first())->jawaban
            : '-';

        $jawabanPeserta = $row->soal->isPg()
            ? optional($row->jawabanSoal)->jawaban
            : $row->jawaban_esai;

        return [
            $row->soal->kode_soal,
            $row->soal->pertanyaan,
            $jawabanBenar,
            $jawabanPeserta,
            $row->soal->kategori,
        ];
    }
}
