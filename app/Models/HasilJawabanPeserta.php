<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HasilJawabanPeserta extends Model
{
    protected $table = 'hasil_jawaban_pesertas';

    protected $fillable = [
        'event_id', 'peserta_id', 'soal_id', 'jawaban_soal_id',
        'jawaban_esai', 'is_benar', 'nilai_manual',
    ];

    public function event()
    {
        return $this->belongsTo(Event::class);
    }

    public function peserta()
    {
        return $this->belongsTo(Peserta::class);
    }

    public function soal()
    {
        return $this->belongsTo(Soal::class);
    }

    public function jawabanSoal()
    {
        return $this->belongsTo(JawabanSoal::class);
    }
}
