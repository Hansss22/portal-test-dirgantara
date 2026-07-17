<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('event_peserta', function (Blueprint $table) {
            $table->id();
            $table->foreignId('event_id')->constrained('events')->cascadeOnDelete();
            $table->foreignId('peserta_id')->constrained('pesertas')->cascadeOnDelete();
            $table->timestamp('waktu_mulai')->nullable();
            $table->timestamp('waktu_selesai')->nullable();
            $table->enum('status_pengerjaan', ['belum', 'berlangsung', 'selesai'])->default('belum');
            $table->unsignedInteger('skor_pg')->nullable();
            $table->unsignedInteger('skor_esai_manual')->nullable();
            $table->timestamps();
            $table->unique(['event_id', 'peserta_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('event_peserta');
    }
};
