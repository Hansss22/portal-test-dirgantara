<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UjianController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::middleware(['auth', 'role:peserta'])->group(function () {
    Route::get('/ujian', [UjianController::class, 'index'])->name('ujian.index');
    Route::get('/ujian/{event}', [UjianController::class, 'show'])->name('ujian.show');
    Route::post('/ujian/{event}/simpan', [UjianController::class, 'simpanJawaban'])->name('ujian.simpan');
    Route::get('/ujian/{event}/selesai', [UjianController::class, 'selesai'])->name('ujian.selesai');
    Route::get('/ujian/{event}/hasil', [UjianController::class, 'hasil'])->name('ujian.hasil');
});

Route::get('/dashboard', function () {
    return Auth::user()->role === 'admin'
        ? redirect('/admin')
        : redirect()->route('ujian.index');
})->middleware('auth')->name('dashboard');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
