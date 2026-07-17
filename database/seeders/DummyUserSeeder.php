<?php

namespace Database\Seeders;

use App\Models\Event;
use App\Models\JobTitle;
use App\Models\KataPengantar;
use App\Models\Peserta;
use App\Models\TipeSoal;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

// Seeder ini membuat akun contoh untuk demo (SEBELUM SSO aktif).
// Jalankan: php artisan db:seed --class=DummyUserSeeder
class DummyUserSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Akun admin contoh
        User::firstOrCreate(
            ['email' => 'admin@dirgantara-indonesia.com'],
            [
                'name' => 'Admin Portal Test',
                'password' => Hash::make('password123'),
                'role' => 'admin',
            ]
        );

        // 2. Referensi tipe soal
        $tipePg = TipeSoal::firstOrCreate(['kode' => 'pg'], ['nama' => 'Pilihan Ganda']);
        TipeSoal::firstOrCreate(['kode' => 'esai'], ['nama' => 'Esai']);

        // 3. Kata pengantar contoh
        KataPengantar::firstOrCreate(
            ['tipe_soal_id' => $tipePg->id],
            ['deskripsi' => '<p>Jawablah seluruh pertanyaan berikut dengan jujur dan teliti.</p>', 'status' => 'publish']
        );

        // 4. Job title contoh
        $jobTitle = JobTitle::firstOrCreate(['nama_jobtitle' => 'Staff K3LH']);

        // 5. Peserta contoh + akun login-nya
        $peserta = Peserta::firstOrCreate(
            ['nik' => '3201010101010001'],
            [
                'nama' => 'Budi Santoso',
                'organisasi' => 'PT Dirgantara Indonesia',
                'email' => 'budi.santoso@dirgantara-indonesia.com',
                'job_title_id' => $jobTitle->id,
            ]
        );

        $userPeserta = User::firstOrCreate(
            ['email' => $peserta->email],
            [
                'name' => $peserta->nama,
                'password' => Hash::make('password123'),
                'role' => 'peserta',
            ]
        );

        $peserta->update(['user_id' => $userPeserta->id]);

        // 6. Event contoh yang sedang aktif hari ini (biar bisa langsung dites)
        $event = Event::firstOrCreate(
            ['kode_event' => 'TA2026DEMO'],
            [
                'nama_event' => 'Demo Tes Assessment K3LH',
                'tanggal_event' => now()->toDateString(),
                'jam_mulai' => now()->subHour()->format('H:i'),
                'jam_selesai' => now()->addHours(3)->format('H:i'),
                'status' => 'aktif',
            ]
        );

        $event->pesertas()->syncWithoutDetaching([$peserta->id]);

        $this->command->info('Akun demo dibuat:');
        $this->command->info('Admin  -> admin@dirgantara-indonesia.com / password123');
        $this->command->info('Peserta -> budi.santoso@dirgantara-indonesia.com / password123');
    }
}
