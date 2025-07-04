-- Creación de la tabla productos2
CREATE TABLE productos2 (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INTEGER NOT NULL
);

-- Inserción de algunos datos iniciales
INSERT INTO productos2 (nombre, descripcion, precio, stock) VALUES
('Laptop', 'Portátil de última generación', 1200.50, 50),
('Teléfono', 'Teléfono inteligente con cámara de alta resolución', 450.75, 100),
('Tablet', 'Tableta ligera y versátil', 300.20, 30);

-- Crea una nueva tabla llamada productos_copia y copia los datos de productos a la nueva tabla.
CREATE TABLE productos_copia (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    stock INTEGER NOT NULL
);
INSERT INTO productos_copia
SELECT * FROM productos2;

--  Añade una nueva columna llamada marca a la tabla productos, 
-- cambia el tipo de datos de la columna precio y elimina la columna descripcion.
ALTER TABLE productos2 ADD COLUMN marca VARCHAR(50);
ALTER TABLE productos2 ALTER COLUMN precio TYPE DECIMAL(12,2), DROP COLUMN descripcion;