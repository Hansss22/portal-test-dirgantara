<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class KataPengantar extends Model
{
    protected $fillable = ['tipe_soal_id', 'deskripsi', 'status'];

    public function tipeSoal()
    {
        return $this->belongsTo(TipeSoal::class);
    }
}
