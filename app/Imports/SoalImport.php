<?php

namespace App\Imports;

use App\Models\JawabanSoal;
use App\Models\JobTitle;
use App\Models\Soal;
use App\Models\TipeSoal;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Illuminate\Support\Str;

/**
 * Format kolom Excel (baris pertama = header), sesuai catatan di wireframe:
 * job_title | kode_soal | tipe_soal | pertanyaan | kategori
 * jawaban_1 | nilai_1 | jawaban_2 | nilai_2 | jawaban_3 | nilai_3 | jawaban_4 | nilai_4
 *
 * - tipe_soal diisi "pg" atau "esai"
 * - nilai_x diisi 1 untuk kunci jawaban benar, 0 untuk salah (kosongkan kalau tipe = esai)
 * - kolom gambar tidak diisi lewat Excel, upload manual lewat form edit soal setelah import
 */
class SoalImport implements ToModel, WithHeadingRow, WithValidation
{
    public function model(array $row)
    {
        $jobTitle = JobTitle::firstOrCreate(['nama_jobtitle' => trim($row['job_title'])]);

        $kodeTipe = strtolower(trim($row['tipe_soal'])) === 'esai' ? 'esai' : 'pg';
        $tipeSoal = TipeSoal::firstOrCreate(
            ['kode' => $kodeTipe],
            ['nama' => $kodeTipe === 'pg' ? 'Pilihan Ganda' : 'Esai']
        );

        $soal = Soal::updateOrCreate(
            ['kode_soal' => trim($row['kode_soal'])],
            [
                'job_title_id' => $jobTitle->id,
                'tipe_soal_id' => $tipeSoal->id,
                'pertanyaan' => $row['pertanyaan'],
                'kategori' => $row['kategori'] ?? null,
                'status' => 'draft', // admin publish manual setelah dicek
            ]
        );

        if ($kodeTipe === 'pg') {
            $soal->jawabanSoals()->delete();
            foreach ([1, 2, 3, 4] as $i) {
                if (! empty($row['jawaban_' . $i])) {
                    JawabanSoal::create([
                        'soal_id' => $soal->id,
                        'jawaban' => $row['jawaban_' . $i],
                        'nilai' => (bool) ($row['nilai_' . $i] ?? false),
                        'urutan' => $i,
                    ]);
                }
            }
        }

        return null; // model soal sudah disimpan manual di atas
    }

    public function rules(): array
    {
        return [
            'job_title' => 'required',
            'kode_soal' => 'required',
            'tipe_soal' => 'required',
            'pertanyaan' => 'required',
        ];
    }
}
