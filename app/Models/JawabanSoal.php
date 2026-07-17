<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JawabanSoal extends Model
{
    protected $fillable = ['soal_id', 'jawaban', 'gambar_jawaban', 'nilai', 'urutan'];

    protected $casts = [
        'nilai' => 'boolean',
    ];

    public function soal()
    {
        return $this->belongsTo(Soal::class);
    }
}
