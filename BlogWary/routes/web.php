<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;

Route::get('/', function () {
    return view('inicio');
});

Route::get('/inicio', function () {
    return view('inicio');
});

Route::get('/login', function () {
    return view('login');
})->name('login');

// Solo una ruta para registro, usando el controlador
Route::get('/register', function () {
    return view('register');
})->name('register');

Route::post('/register', [UserController::class, 'store'])->name('register.store');
