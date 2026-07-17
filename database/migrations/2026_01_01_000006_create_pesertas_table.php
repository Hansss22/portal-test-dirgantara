<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('pesertas', function (Blueprint $table) {
            $table->id();
            $table->string('nik')->unique();
            $table->string('nama');
            $table->string('organisasi')->nullable();
            $table->string('email')->unique();
            $table->foreignId('job_title_id')->nullable()->constrained('job_titles')->nullOnDelete();
            $table->foreignId('user_id')->nullable()->constrained('users')->nullOnDelete();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pesertas');
    }
};
