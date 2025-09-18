<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController; // Importa el controlador correcto

Route::get('/', function () {
    return view('inicio');
});

Route::get('/inicio', function () {
    return view('inicio');
});

Route::get('/login', function () {
    return view('login');
})->name('login');

Route::get('/register', function () {
    return view('register');
})->name('register');


Route::get('/register', [UserController::class, 'create'])->name('register'); // Mostrar formulario
Route::post('/register', [UserController::class, 'store'])->name('register.store'); // Guardar datos
