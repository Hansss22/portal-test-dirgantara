<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JobTitle extends Model
{
    protected $fillable = ['nama_jobtitle'];

    public function soals()
    {
        return $this->hasMany(Soal::class);
    }

    public function pesertas()
    {
        return $this->hasMany(Peserta::class);
    }
}
