<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Event extends Model
{
    protected $fillable = [
        'kode_event', 'nama_event', 'tanggal_event', 'jam_mulai', 'jam_selesai', 'status',
    ];

    protected $casts = [
        'tanggal_event' => 'date',
    ];

    public function pesertas()
    {
        return $this->belongsToMany(Peserta::class, 'event_peserta')
            ->withPivot(['waktu_mulai', 'waktu_selesai', 'status_pengerjaan', 'skor_pg', 'skor_esai_manual', 'id'])
            ->withTimestamps();
    }

    public function hasilJawaban()
    {
        return $this->hasMany(HasilJawabanPeserta::class);
    }

    // Sesuai catatan di kertas: "soal terbuka kalau waktu dan tanggal tepat"
    public function sedangBerlangsung(): bool
    {
        if ($this->status !== 'aktif') {
            return false;
        }

        $now = Carbon::now();
        $mulai = Carbon::parse($this->tanggal_event->format('Y-m-d') . ' ' . $this->jam_mulai);
        $selesai = Carbon::parse($this->tanggal_event->format('Y-m-d') . ' ' . $this->jam_selesai);

        return $now->between($mulai, $selesai);
    }
}
