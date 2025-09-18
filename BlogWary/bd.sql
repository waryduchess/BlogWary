-- Script SQL para Blog Laravel - Versión Corregida
-- Crear base de datos con configuración UTF8MB4
CREATE DATABASE IF NOT EXISTS blog_laravel 
CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE blog_laravel;

-- Configurar el modo SQL para evitar problemas
SET SQL_MODE = 'NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- ========================================
-- TABLAS PRINCIPALES
-- ========================================

-- Tabla de usuarios
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(191) UNIQUE NOT NULL,
    email_verified_at TIMESTAMP NULL DEFAULT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'author', 'user') NOT NULL DEFAULT 'user',
    avatar VARCHAR(255) NULL DEFAULT NULL,
    bio TEXT NULL DEFAULT NULL,
    remember_token VARCHAR(100) NULL DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices para optimización
    INDEX idx_users_email (email),
    INDEX idx_users_role (role),
    INDEX idx_users_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de categorías
DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(191) UNIQUE NOT NULL,
    description TEXT NULL DEFAULT NULL,
    image VARCHAR(255) NULL DEFAULT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    sort_order INT NOT NULL DEFAULT 0,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_categories_slug (slug),
    INDEX idx_categories_active (is_active),
    INDEX idx_categories_sort (sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de tags
DROP TABLE IF EXISTS tags;
CREATE TABLE tags (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(191) UNIQUE NOT NULL,
    description TEXT NULL DEFAULT NULL,
    color VARCHAR(7) NULL DEFAULT '#6B7280', -- Color hex para el tag
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_tags_slug (slug),
    INDEX idx_tags_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de posts
DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    slug VARCHAR(191) UNIQUE NOT NULL,
    content LONGTEXT NOT NULL,
    excerpt TEXT NULL DEFAULT NULL,
    featured_image VARCHAR(255) NULL DEFAULT NULL,
    meta_title VARCHAR(255) NULL DEFAULT NULL,
    meta_description TEXT NULL DEFAULT NULL,
    published BOOLEAN NOT NULL DEFAULT FALSE,
    published_at TIMESTAMP NULL DEFAULT NULL,
    views INT UNSIGNED NOT NULL DEFAULT 0,
    reading_time INT UNSIGNED NULL DEFAULT NULL, -- Tiempo estimado de lectura en minutos
    user_id BIGINT UNSIGNED NOT NULL,
    category_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices para optimización
    INDEX idx_posts_user_id (user_id),
    INDEX idx_posts_category_id (category_id),
    INDEX idx_posts_published (published),
    INDEX idx_posts_published_at (published_at),
    INDEX idx_posts_slug (slug),
    INDEX idx_posts_views (views),
    INDEX idx_posts_created_at (created_at),
    
    -- Claves foráneas
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- TABLAS DE RELACIONES
-- ========================================

-- Tabla pivot post_tag (relación muchos a muchos)
DROP TABLE IF EXISTS post_tag;
CREATE TABLE post_tag (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    post_id BIGINT UNSIGNED NOT NULL,
    tag_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices y restricciones
    UNIQUE KEY unique_post_tag (post_id, tag_id),
    INDEX idx_post_tag_post_id (post_id),
    INDEX idx_post_tag_tag_id (tag_id),
    
    -- Claves foráneas
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de comentarios
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    approved BOOLEAN NOT NULL DEFAULT FALSE,
    user_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    parent_id BIGINT UNSIGNED NULL DEFAULT NULL,
    ip_address VARCHAR(45) NULL DEFAULT NULL, -- IPv6 compatible
    user_agent TEXT NULL DEFAULT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Índices
    INDEX idx_comments_post_id (post_id),
    INDEX idx_comments_user_id (user_id),
    INDEX idx_comments_parent_id (parent_id),
    INDEX idx_comments_approved (approved),
    INDEX idx_comments_created_at (created_at),
    
    -- Claves foráneas
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (parent_id) REFERENCES comments(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de likes
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    post_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Restricciones
    UNIQUE KEY unique_user_post (user_id, post_id),
    INDEX idx_likes_post_id (post_id),
    INDEX idx_likes_user_id (user_id),
    
    -- Claves foráneas
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ========================================
-- DATOS DE EJEMPLO
-- ========================================

-- Insertar usuarios (contraseña: "password")
INSERT INTO users (name, email, password, role) VALUES
('Administrador', 'admin@blog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin'),
('Juan Pérez', 'juan.perez@blog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'author'),
('María García', 'maria.garcia@blog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'author'),
('Usuario Demo', 'usuario@blog.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'user');

-- Insertar categorías
INSERT INTO categories (name, slug, description, is_active, sort_order) VALUES
('Tecnología', 'tecnologia', 'Artículos sobre tecnología e innovación', TRUE, 1),
('Programación', 'programacion', 'Tutoriales y noticias de programación', TRUE, 2),
('Diseño Web', 'diseno-web', 'Diseño web, UI/UX y herramientas de diseño', TRUE, 3),
('Startups', 'startups', 'Emprendimiento y startups tecnológicas', TRUE, 4),
('Tutoriales', 'tutoriales', 'Guías paso a paso para desarrolladores', TRUE, 5),
('Inteligencia Artificial', 'inteligencia-artificial', 'IA, Machine Learning y tecnologías emergentes', TRUE, 6);

-- Insertar tags
INSERT INTO tags (name, slug, color) VALUES
('Laravel', 'laravel', '#FF2D20'),
('PHP', 'php', '#777BB4'),
('JavaScript', 'javascript', '#F7DF1E'),
('Vue.js', 'vuejs', '#4FC08D'),
('React', 'react', '#61DAFB'),
('CSS', 'css', '#1572B6'),
('HTML', 'html', '#E34F26'),
('MySQL', 'mysql', '#4479A1'),
('Bootstrap', 'bootstrap', '#7952B3'),
('Node.js', 'nodejs', '#339933'),
('Python', 'python', '#3776AB'),
('Git', 'git', '#F05032');

-- Insertar posts
INSERT INTO posts (title, slug, content, excerpt, meta_title, meta_description, published, published_at, user_id, category_id, reading_time) VALUES
('Introducción completa a Laravel 10', 'introduccion-laravel-10', 
'Laravel es uno de los frameworks PHP más populares y elegantes disponibles hoy en día. En este artículo exploraremos sus características principales, ventajas y cómo empezar a desarrollar con Laravel 10...\n\nLaravel ofrece una sintaxis expresiva y herramientas robustas que facilitan el desarrollo de aplicaciones web modernas. Desde su sistema de routing hasta Eloquent ORM, cada componente está diseñado para mejorar la productividad del desarrollador.',
'Descubre todo lo que necesitas saber sobre Laravel 10, el framework PHP más elegante para desarrollo web moderno.',
'Guía completa Laravel 10 - Framework PHP Moderno',
'Aprende Laravel 10 desde cero. Guía completa con ejemplos prácticos para desarrollar aplicaciones web con el mejor framework PHP.',
TRUE, NOW(), 2, 2, 8),

('JavaScript ES2023: Nuevas características', 'javascript-es2023-nuevas-caracteristicas',
'JavaScript continúa evolucionando y ES2023 trae consigo nuevas características emocionantes que harán que nuestro código sea más limpio y eficiente...\n\nEntre las nuevas características destacan Array.findLast(), Array.findLastIndex(), y mejoras en las expresiones regulares que nos permiten escribir código más expresivo.',
'Explora las nuevas características de JavaScript ES2023 y cómo pueden mejorar tu código.',
'JavaScript ES2023: Guía de Nuevas Características',
'Descubre las nuevas características de JavaScript ES2023. Guía completa con ejemplos prácticos para desarrolladores.',
TRUE, DATE_SUB(NOW(), INTERVAL 2 DAY), 3, 2, 6),

('Diseño Responsive: Guía completa 2024', 'diseno-responsive-guia-completa-2024',
'El diseño responsive ya no es opcional en el desarrollo web moderno. Con la diversidad de dispositivos actuales, es fundamental crear interfaces que se adapten perfectamente a cualquier pantalla...\n\nEn esta guía veremos técnicas avanzadas de CSS Grid, Flexbox, y media queries para crear diseños verdaderamente adaptativos.',
'Aprende a crear diseños web que se adapten perfectamente a cualquier dispositivo.',
'Diseño Responsive 2024: Guía Completa CSS Grid y Flexbox',
'Guía completa de diseño responsive 2024. Aprende CSS Grid, Flexbox y media queries para crear sitios web adaptativos.',
TRUE, DATE_SUB(NOW(), INTERVAL 5 DAY), 2, 3, 12),

('Introducción a la Inteligencia Artificial', 'introduccion-inteligencia-artificial',
'La Inteligencia Artificial está transformando la forma en que interactuamos con la tecnología. En este artículo exploraremos los conceptos fundamentales de la IA...',
'Conceptos básicos de IA para desarrolladores y entusiastas de la tecnología.',
'IA para Principiantes: Conceptos Fundamentales',
'Introducción a la Inteligencia Artificial. Aprende los conceptos básicos de IA, Machine Learning y sus aplicaciones.',
FALSE, NULL, 3, 6, 10);

-- Insertar relaciones post_tag
INSERT INTO post_tag (post_id, tag_id) VALUES
-- Post 1: Laravel
(1, 1), (1, 2), (1, 8), (1, 9),
-- Post 2: JavaScript
(2, 3), (2, 6), (2, 7),
-- Post 3: Diseño
(3, 6), (3, 7), (3, 9),
-- Post 4: IA
(4, 11), (4, 1);

-- Insertar comentarios
INSERT INTO comments (content, approved, user_id, post_id) VALUES
('Excelente artículo sobre Laravel. Me ha ayudado mucho para entender los conceptos básicos. ¿Podrías hacer un tutorial sobre Eloquent?', TRUE, 4, 1),
('Muy buena explicación. Estaba buscando exactamente esta información para mi proyecto.', TRUE, 1, 1),
('Las nuevas características de JavaScript están geniales. Especialmente Array.findLast() va a ser muy útil.', TRUE, 4, 2),
('¿Tienes ejemplos más avanzados de responsive design? Me gustaría ver casos de uso reales.', TRUE, 1, 3),
('Gran artículo, pero creo que podrías profundizar más en CSS Grid.', FALSE, 4, 3);

-- Insertar algunos likes
INSERT INTO likes (user_id, post_id) VALUES
(1, 1), (4, 1), (1, 2), (4, 2), (1, 3), (4, 3);

-- ========================================
-- VISTAS ÚTILES
-- ========================================

-- Vista para posts con información completa
CREATE OR REPLACE VIEW posts_complete AS
SELECT 
    p.id,
    p.title,
    p.slug,
    p.excerpt,
    p.published,
    p.published_at,
    p.views,
    p.reading_time,
    p.created_at,
    u.name as author_name,
    u.email as author_email,
    c.name as category_name,
    c.slug as category_slug,
    COUNT(DISTINCT co.id) as comments_count,
    COUNT(DISTINCT l.id) as likes_count
FROM posts p
LEFT JOIN users u ON p.user_id = u.id
LEFT JOIN categories c ON p.category_id = c.id
LEFT JOIN comments co ON p.id = co.post_id AND co.approved = TRUE
LEFT JOIN likes l ON p.id = l.post_id
GROUP BY p.id, p.title, p.slug, p.excerpt, p.published, p.published_at, 
         p.views, p.reading_time, p.created_at, u.name, u.email, 
         c.name, c.slug;

-- ========================================
-- PROCEDIMIENTOS ÚTILES
-- ========================================

-- Procedimiento para incrementar vistas
DELIMITER //
CREATE PROCEDURE IncrementPostViews(IN post_id BIGINT UNSIGNED)
BEGIN
    UPDATE posts 
    SET views = views + 1 
    WHERE id = post_id AND published = TRUE;
END //
DELIMITER ;

-- ========================================
-- CONFIGURACIONES FINALES
-- ========================================

-- Estadísticas iniciales
SELECT 'Script ejecutado correctamente. Estadísticas:' as mensaje;
SELECT 
    (SELECT COUNT(*) FROM users) as total_usuarios,
    (SELECT COUNT(*) FROM categories) as total_categorias,
    (SELECT COUNT(*) FROM tags) as total_tags,
    (SELECT COUNT(*) FROM posts) as total_posts,
    (SELECT COUNT(*) FROM comments) as total_comentarios,
    (SELECT COUNT(*) FROM likes) as total_likes;