<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
     public function create()
    {
        return view('auth.register'); // La vista de tu formulario
    }
    public function store(Request $request)
    {
        // Validar los datos del formulario
        $validatedData = $request->validate([
            'name'     => 'required|string|max:255',
            'email'    => 'required|string|email|max:191|unique:users',
            'password' => 'required|string|min:8',
            // Opcionales, por si en algún momento los agregas al formulario
            'bio'      => 'nullable|string',
            'avatar'   => 'nullable|string|max:255'
        ]);

        // Crear el usuario en la base de datos
        $user = User::create([
            'name'     => $validatedData['name'],
            'email'    => $validatedData['email'],
            'password' => Hash::make($validatedData['password']),
            'role'     => 'user', // Rol por defecto
            'bio'      => $validatedData['bio'] ?? null,
            'avatar'   => $validatedData['avatar'] ?? null
        ]);

        // Redirigir al login con mensaje de éxito
        return redirect()->route('login')->with('success', 'Usuario creado exitosamente');
    }
}
