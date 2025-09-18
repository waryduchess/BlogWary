<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro</title>
    <link rel="stylesheet" href="{{ asset('css/login.css') }}">
</head>
<body>
    <form action="{{ route('register.store') }}" method="POST">
    @csrf
    <label>Nombre:</label>
    <input type="text" name="name" value="{{ old('name') }}" required>
    
    <label>Email:</label>
    <input type="email" name="email" value="{{ old('email') }}" required>
    
    <label>Contraseña:</label>
    <input type="password" name="password" required>
    
    <label>Bio (opcional):</label>
    <textarea name="bio">{{ old('bio') }}</textarea>
    
    <label>Avatar URL (opcional):</label>
    <input type="text" name="avatar" value="{{ old('avatar') }}">
    
    <button type="submit">Registrarse</button>
</form>

<!-- Mostrar errores de validación -->
@if ($errors->any())
    <div>
        <ul>
            @foreach ($errors->all() as $error)
                <li>{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif

</body>
</html>