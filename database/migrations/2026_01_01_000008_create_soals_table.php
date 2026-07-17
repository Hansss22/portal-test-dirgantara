<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('soals', function (Blueprint $table) {
            $table->id();
            $table->foreignId('job_title_id')->constrained('job_titles')->cascadeOnDelete();
            $table->foreignId('tipe_soal_id')->constrained('tipe_soals')->cascadeOnDelete();
            $table->string('kode_soal'); // 001A, 001B, dst
            $table->text('pertanyaan');
            $table->string('gambar_pertanyaan')->nullable();
            $table->string('kategori')->nullable(); // contoh: Risk Management, K3LH
            $table->enum('status', ['draft', 'publish'])->default('draft');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('soals');
    }
};
