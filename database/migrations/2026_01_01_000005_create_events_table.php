<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('events', function (Blueprint $table) {
            $table->id();
            $table->string('kode_event')->unique(); // contoh: TA2026001
            $table->string('nama_event');
            $table->date('tanggal_event');
            $table->time('jam_mulai');
            $table->time('jam_selesai');
            $table->enum('status', ['draft', 'aktif'])->default('draft');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('events');
    }
};
