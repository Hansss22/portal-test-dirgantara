<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            // role: admin (mengelola data) atau peserta (mengerjakan ujian)
            $table->enum('role', ['admin', 'peserta'])->default('peserta')->after('email');
            // dipakai kalau nanti login pakai SSO (simpan id/unique identifier dari provider SSO)
            $table->string('sso_id')->nullable()->after('role');
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['role', 'sso_id']);
        });
    }
};
