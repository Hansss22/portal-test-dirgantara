<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('jawaban_soals', function (Blueprint $table) {
            $table->id();
            $table->foreignId('soal_id')->constrained('soals')->cascadeOnDelete();
            $table->text('jawaban')->nullable();
            $table->string('gambar_jawaban')->nullable();
            $table->boolean('nilai')->default(false); // 1 = kunci jawaban benar
            $table->unsignedInteger('urutan')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('jawaban_soals');
    }
};
