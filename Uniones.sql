-- Eliminamos las tablas si existen
DROP TABLE IF EXISTS usuarios, productos, ventas;

-- Creación de la tabla usuarios
CREATE TABLE usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Inserción de algunos datos iniciales
INSERT INTO usuarios (nombre, email) VALUES
('Juan Pérez', 'juan@example.com'),
('María Gómez', 'maria@example.com'),
('Carlos Rodríguez', 'carlos@example.com');

-- Creación de la tabla productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Inserción de algunos datos iniciales
INSERT INTO productos (nombre_producto, precio) VALUES
('Laptop', 1200.00),
('Teléfono', 500.00),
('Tablet', 300.00);

-- Creación de la tabla ventas
CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    usuario_id INTEGER REFERENCES usuarios(usuario_id),
    producto_id INTEGER REFERENCES productos(producto_id),
    cantidad INTEGER NOT NULL,
    fecha_venta DATE NOT NULL
);

-- Inserción de algunos datos iniciales

INSERT INTO ventas (usuario_id, producto_id, cantidad, fecha_venta) VALUES
(1, 1, 2, '2023-01-10'),
(2, 2, 1, '2023-01-11'),
(3, NULL, 3, '2023-01-12'),
(NULL, 3, 1, '2023-01-13');

--Obtén solo las filas que tienen coincidencias en ambas tablas (ventas con información de usuario y producto).
select u.nombre as usuario, p.nombre_producto as producto, v.cantidad, v.fecha_venta
from ventas v
	inner join productos p
		on v.producto_id = p.producto_id
			inner join usuarios u
				on v.usuario_id=u.usuario_id;

-- Muestra todas las ventas, incluso si no tienen información de usuario o producto
select u.nombre as usuario, p.nombre_producto as producto, v.cantidad, v.fecha_venta
from ventas v
	left join productos p
		on v.producto_id = p.producto_id
			left join usuarios u
				on v.usuario_id=u.usuario_id;

-- Muestra todos los usuarios y productos, incluso si no están asociados con ventas.
select u.nombre as usuario, p.nombre_producto as producto, v.cantidad, v.fecha_venta
from ventas v
	right join usuarios u
		on u.usuario_id = v.usuario_id
			full join productos p
				on v.producto_id = p.producto_id;

-- Muestra todas las ventas, usuarios y productos, incluso si no están asociados.
select u.nombre as usuario, p.nombre_producto as producto, v.cantidad, v.fecha_venta
from ventas v
	full join usuarios u
		on u.usuario_id = v.usuario_id
			full join productos p
				on v.producto_id = p.producto_id;