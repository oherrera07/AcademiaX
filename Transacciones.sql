-- Eliminamos la tabla si existe
DROP TABLE IF EXISTS cuentas_bancarias;

-- Creación de la tabla cuentas_bancarias
CREATE TABLE cuentas_bancarias (
    cuenta_id SERIAL PRIMARY KEY,
    nombre_cliente VARCHAR(100) NOT NULL,
    saldo DECIMAL(10, 2) NOT NULL
);

-- Inserción de algunos datos iniciales
INSERT INTO cuentas_bancarias (nombre_cliente, saldo) VALUES
('Cliente A', 1000.00),
('Cliente B', 500.00),
('Cliente C', 2000.00);

-- Inicia una transacción (BEGIN) y realiza una transferencia entre las cuentas A y B.
BEGIN;
UPDATE cuentas_bancarias
SET saldo = saldo - 200
WHERE nombre_cliente = 'Cliente A';
UPDATE cuentas_bancarias
SET saldo = saldo + 200
WHERE nombre_cliente = 'Cliente B';

-- Simula un problema de concurrencia al intentar realizar otra transferencia entre las cuentas B y C dentro de la 
-- misma transacción. Aquí crea un punto de guardado (SAVEPOINT) antes de la segunda operación de transferencia.
SAVEPOINT concurrencia;
UPDATE cuentas_bancarias
SET saldo = saldo - 800
WHERE nombre_cliente = 'Cliente B';
UPDATE cuentas_bancarias
SET saldo = saldo + 800
WHERE nombre_cliente = 'Cliente C';
-- Revierte la segunda transacción (ROLLBACK TO) debido al problema de concurrencia.
ROLLBACK TO concurrencia;

-- Confirma la primera transacción (COMMIT), y muestra el estado final de las cuentas.
COMMIT;
SELECT * FROM cuentas_bancarias;