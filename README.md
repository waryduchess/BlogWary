# Guía de Instalación - Proyecto Laravel

```
╔══════════════════════════════════════════════════════════════╗
║                    PROYECTO LARAVEL                          ║
║                                                              ║
║  ██╗      █████╗ ██████╗  █████╗ ██╗   ██╗███████╗██╗       ║
║  ██║     ██╔══██╗██╔══██╗██╔══██╗██║   ██║██╔════╝██║       ║
║  ██║     ███████║██████╔╝███████║██║   ██║█████╗  ██║       ║
║  ██║     ██╔══██║██╔══██╗██╔══██║╚██╗ ██╔╝██╔══╝  ██║       ║
║  ███████╗██║  ██║██║  ██║██║  ██║ ╚████╔╝ ███████╗███████╗  ║
║  ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚══════╝  ║
╚══════════════════════════════════════════════════════════════╝
```

## Requisitos del Sistema

```
┌─────────────────────────────────────────┐
│ • PHP >= 8.1                           │
│ • Composer >= 2.0                      │
│ • Node.js >= 16.x                      │
│ • NPM o Yarn                           │
│ • MySQL >= 8.0 o PostgreSQL >= 13     │
│ • Git                                  │
└─────────────────────────────────────────┘
```

### Extensiones PHP Requeridas:
```
▪ OpenSSL PHP Extension
▪ PDO PHP Extension  
▪ Mbstring PHP Extension
▪ Tokenizer PHP Extension
▪ XML PHP Extension
▪ Ctype PHP Extension
▪ JSON PHP Extension
```

---

## Guía de Instalación

### ◆ Paso 1: Clonar el Repositorio

```bash
git clone <url-del-repositorio>
cd <carpeta-del-proyecto>
```

### ◆ Paso 2: Instalar Dependencias de PHP

```bash
composer install
```

### ◆ Paso 3: Instalar Dependencias de JavaScript

```bash
npm install
# o si prefieres yarn
yarn install
```

### ◆ Paso 4: Configurar Variables de Entorno

Copiar el archivo de ejemplo .env:

```bash
# Linux / macOS
cp .env.example .env

# Windows PowerShell
copy .env.example .env
```

Editar el archivo `.env` con las credenciales de la base de datos:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=nombre_base_datos
DB_USERNAME=root
DB_PASSWORD=
```

### ◆ Paso 5: Generar la Clave de la Aplicación

```bash
php artisan key:generate
```

### ◆ Paso 6: Ejecutar Migraciones y Seeders

Ejecutar las migraciones para crear las tablas de la base de datos:

```bash
php artisan migrate
```

Si necesitas datos de prueba, ejecuta los seeders:

```bash
php artisan db:seed
```

### ◆ Paso 7: Configurar Almacenamiento

```bash
php artisan storage:link
```



### ◆ Paso 8: Levantar el Servidor de Laravel

```bash
php artisan serve
```

```
┌───────────────────────────────────────────┐
│  ✓ Servidor iniciado correctamente       │
│                                           │
│  → http://localhost:8000                  │
│                                           │
│  Presiona Ctrl+C para detener            │
└───────────────────────────────────────────┘
```

---

## Comandos Útiles

### • Limpiar Cache
```bash
php artisan config:clear
php artisan cache:clear
php artisan view:clear
```

### • Optimizar para Producción
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### • Solución de Problemas de Permisos
```bash
chmod -R 775 storage bootstrap/cache
```

---

## Estructura Básica del Proyecto

```
proyecto-laravel/
├── app/
│   ├── Http/Controllers/
│   ├── Models/
│   └── Middleware/
├── database/
│   ├── migrations/
│   └── seeders/
├── resources/
│   ├── views/
│   ├── js/
│   └── css/
├── routes/
│   ├── web.php
│   └── api.php
├── storage/
├── tests/
└── .env
```

```
╔═══════════════════════════════════════════════════════════════╗
║                    INSTALACIÓN COMPLETADA                    ║
║                                                               ║
║  ¡Tu proyecto Laravel está listo para usar!                  ║
║                                                               ║
║  Visita: http://localhost:8000                                ║
╚═══════════════════════════════════════════════════════════════╝
```
