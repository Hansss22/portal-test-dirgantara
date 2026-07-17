<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TipeSoal extends Model
{
    protected $fillable = ['kode', 'nama'];

    public function soals()
    {
        return $this->hasMany(Soal::class);
    }
}
