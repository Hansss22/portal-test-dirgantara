<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('hasil_jawaban_pesertas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('event_id')->constrained('events')->cascadeOnDelete();
            $table->foreignId('peserta_id')->constrained('pesertas')->cascadeOnDelete();
            $table->foreignId('soal_id')->constrained('soals')->cascadeOnDelete();
            $table->foreignId('jawaban_soal_id')->nullable()->constrained('jawaban_soals')->nullOnDelete();
            $table->longText('jawaban_esai')->nullable();
            $table->boolean('is_benar')->nullable();
            $table->unsignedInteger('nilai_manual')->nullable();
            $table->timestamps();
            $table->unique(['event_id', 'peserta_id', 'soal_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('hasil_jawaban_pesertas');
    }
};
