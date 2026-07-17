<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('kata_pengantars', function (Blueprint $table) {
            $table->id();
            $table->foreignId('tipe_soal_id')->constrained('tipe_soals')->cascadeOnDelete();
            $table->longText('deskripsi'); // rich text, bisa mengandung gambar
            $table->enum('status', ['draft', 'publish'])->default('draft');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('kata_pengantars');
    }
};
