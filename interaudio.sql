-- Tabla de Categorías
CREATE TABLE
    categorias (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL,
        descripcion TEXT,
        fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Proveedores
CREATE TABLE
    proveedores (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL,
        direccion VARCHAR(255),
        telefono VARCHAR(20),
        email VARCHAR(100) NOT NULL,
        fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT uc_proveedor_email UNIQUE (email),
        CONSTRAINT chk_email_valido CHECK (
            email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        )
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Productos
CREATE TABLE
    productos (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(255) NOT NULL,
        descripcion TEXT,
        precio DECIMAL(10, 2) NOT NULL CHECK (precio > 0),
        stock INT NOT NULL DEFAULT 0,
        categoria_id INT NOT NULL,
        proveedor_id INT NOT NULL,
        fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (categoria_id) REFERENCES categorias (id) ON DELETE RESTRICT,
        FOREIGN KEY (proveedor_id) REFERENCES proveedores (id) ON DELETE RESTRICT,
        INDEX idx_categoria_proveedor (categoria_id, proveedor_id)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Clientes
CREATE TABLE
    clientes (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100),
        direccion VARCHAR(255),
        telefono VARCHAR(20),
        email VARCHAR(100) UNIQUE NOT NULL,
        fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT chk_cliente_email CHECK (
            email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        ),
        INDEX idx_email (email)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Roles
CREATE TABLE
    roles (
        id INT PRIMARY KEY AUTO_INCREMENT,
        nombre VARCHAR(20) UNIQUE NOT NULL
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Usuarios
CREATE TABLE
    usuarios (
        id INT PRIMARY KEY AUTO_INCREMENT,
        username VARCHAR(50) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        rol_id INT NOT NULL,
        cliente_id INT NULL,
        fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (rol_id) REFERENCES roles (id),
        FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE SET NULL,
        CONSTRAINT chk_usuario_email CHECK (
            email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        ),
        INDEX idx_username (username)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Ventas
CREATE TABLE
    ventas (
        id INT PRIMARY KEY AUTO_INCREMENT,
        cliente_id INT NOT NULL,
        usuario_id INT NOT NULL,
        fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
        estado ENUM ('completada', 'pendiente', 'cancelada') DEFAULT 'completada',
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE RESTRICT,
        FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE RESTRICT,
        INDEX idx_fecha_venta (fecha_venta)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Detalle de Ventas
CREATE TABLE
    ventas_detalle (
        venta_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL CHECK (cantidad > 0),
        precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario > 0),
        PRIMARY KEY (venta_id, producto_id),
        FOREIGN KEY (venta_id) REFERENCES ventas (id) ON DELETE CASCADE,
        FOREIGN KEY (producto_id) REFERENCES productos (id) ON DELETE RESTRICT
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Tabla de Registro de Consultas/Solicitudes de Servicio
CREATE TABLE
    registro_consultas_servicio (
        id INT PRIMARY KEY AUTO_INCREMENT,
        cliente_id INT NOT NULL,
        usuario_asignado INT,
        descripcion TEXT NOT NULL,
        estado ENUM (
            'pendiente',
            'en_proceso',
            'resuelta',
            'cancelada'
        ) DEFAULT 'pendiente',
        fechahora_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
        fechahora_cierre DATETIME,
        notas TEXT,
        fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON DELETE CASCADE,
        FOREIGN KEY (usuario_asignado) REFERENCES usuarios (id) ON DELETE SET NULL,
        INDEX idx_estado (estado)
    ) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;