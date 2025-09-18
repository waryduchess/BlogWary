<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inicio - BlogWary</title>
    <link rel="stylesheet" href="{{ asset('css/login.css') }}">
    <style>
        /* Estilos mínimos para el menú */
        .menu { display:flex; gap:12px; justify-content:center; padding:40px 0; }
        .menu a { text-decoration:none; padding:10px 16px; background:#6366f1; color:#fff; border-radius:6px; }
        .menu a.secondary { background:#fff; color:#6366f1; border:1px solid #6366f1; }
        .hero { text-align:center; padding:40px 16px; }
    </style>
</head>
<body>
    <div class="hero">
        <h1>Bienvenido a BlogWary</h1>
        <p>Selecciona una opción del menú para continuar.</p>
    </div>

    <nav class="menu">
        <a href="{{ route('login') }}">Iniciar sesión</a>
        <a href="{{ url('/register') }}" class="secondary">Registrar</a>
        <a href="/">Inicio</a>
    </nav>

</body>
</html>
