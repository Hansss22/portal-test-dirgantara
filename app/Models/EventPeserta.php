<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

// Model untuk tabel pivot event_peserta, dipakai khusus untuk halaman Report Hasil Test
class EventPeserta extends Model
{
    protected $table = 'event_peserta';

    protected $fillable = [
        'event_id', 'peserta_id', 'waktu_mulai', 'waktu_selesai',
        'status_pengerjaan', 'skor_pg', 'skor_esai_manual',
    ];

    public function event()
    {
        return $this->belongsTo(Event::class);
    }

    public function peserta()
    {
        return $this->belongsTo(Peserta::class);
    }

    // Jawaban esai peserta ini pada event ini (untuk dinilai manual)
    public function jawabanEsai()
    {
        return HasilJawabanPeserta::query()
            ->where('event_id', $this->event_id)
            ->where('peserta_id', $this->peserta_id)
            ->whereNotNull('jawaban_esai');
    }

    // Total skor gabungan: PG (otomatis) + esai (setelah dinilai manual admin)
    public function getSkorTotalAttribute(): ?int
    {
        if (is_null($this->skor_pg) && is_null($this->skor_esai_manual)) {
            return null;
        }
        return ($this->skor_pg ?? 0) + ($this->skor_esai_manual ?? 0);
    }
}
