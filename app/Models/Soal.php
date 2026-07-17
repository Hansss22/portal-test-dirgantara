<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Soal extends Model
{
    protected $fillable = [
        'job_title_id', 'tipe_soal_id', 'kode_soal', 'pertanyaan',
        'gambar_pertanyaan', 'kategori', 'status',
    ];

    public function jobTitle()
    {
        return $this->belongsTo(JobTitle::class);
    }

    public function tipeSoal()
    {
        return $this->belongsTo(TipeSoal::class);
    }

    public function jawabanSoals()
    {
        return $this->hasMany(JawabanSoal::class)->orderBy('urutan');
    }

    public function isPg(): bool
    {
        return $this->tipeSoal?->kode === 'pg';
    }
}
