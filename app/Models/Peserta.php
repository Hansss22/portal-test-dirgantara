<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Peserta extends Model
{
    protected $fillable = ['nik', 'nama', 'organisasi', 'email', 'job_title_id', 'user_id'];

    public function jobTitle()
    {
        return $this->belongsTo(JobTitle::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function events()
    {
        return $this->belongsToMany(Event::class, 'event_peserta')
            ->withPivot(['waktu_mulai', 'waktu_selesai', 'status_pengerjaan', 'skor_pg', 'skor_esai_manual', 'id'])
            ->withTimestamps();
    }
}
