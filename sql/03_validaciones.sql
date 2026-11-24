-- Consultas de verificación. Ejecutar conectado a bd_red_donantes,
-- después de 01_estructura.sql y 02_datos_prueba.sql.
-- Las partes 1, 2 y 3 solo consultan y pueden ejecutarse completas.
-- La parte 4 contiene errores intencionales: ejecutar cada prueba por separado.


-- =========================================================
-- 1. Conteos esperados
-- =========================================================

-- Comparar los registros de cada tabla con lo cargado por 02_datos_prueba.sql.
SELECT 'hospital' AS tabla, COUNT(*) AS registros, 6 AS esperado
FROM banco_sangre.hospital
UNION ALL
SELECT 'campania', COUNT(*), 4
FROM banco_sangre.campania
UNION ALL
SELECT 'donante', COUNT(*), 30
FROM banco_sangre.donante
UNION ALL
SELECT 'solicitud', COUNT(*), 4
FROM banco_sangre.solicitud
UNION ALL
SELECT 'donacion', COUNT(*), 16
FROM banco_sangre.donacion
UNION ALL
SELECT 'unidad_sanguinea', COUNT(*), 33
FROM banco_sangre.unidad_sanguinea;


-- Contar las unidades por estado.
SELECT estado, COUNT(*) AS unidades
FROM banco_sangre.unidad_sanguinea
GROUP BY estado
ORDER BY estado;


-- =========================================================
-- 2. Relaciones entre entidades
-- =========================================================

-- Mostrar cada donación con su donante y su campaña (puede no tener campaña).
SELECT
    n.codigo,
    n.fecha_donacion,
    d.nombres || ' ' || d.apellidos AS donante,
    d.tipo_sangre,
    c.nombre AS campania
FROM banco_sangre.donacion n
INNER JOIN banco_sangre.donante d
    ON n.id_donante = d.id_donante
LEFT JOIN banco_sangre.campania c
    ON n.id_campania = c.id_campania
ORDER BY n.codigo;


-- Contar las donaciones de cada campaña, incluidas las que no tienen ninguna.
SELECT
    c.nombre,
    c.estado,
    COUNT(n.id_donacion) AS donaciones
FROM banco_sangre.campania c
LEFT JOIN banco_sangre.donacion n
    ON n.id_campania = c.id_campania
GROUP BY c.id_campania, c.nombre, c.estado
ORDER BY c.nombre;


-- Mostrar cada unidad con la donación y el donante de origen.
SELECT
    u.codigo,
    u.componente,
    u.tipo_sangre,
    u.estado,
    n.codigo AS donacion,
    d.cedula AS donante
FROM banco_sangre.unidad_sanguinea u
INNER JOIN banco_sangre.donacion n
    ON u.id_donacion = n.id_donacion
INNER JOIN banco_sangre.donante d
    ON n.id_donante = d.id_donante
ORDER BY u.codigo;


-- Mostrar cada solicitud con su hospital y las unidades asignadas.
SELECT
    s.codigo,
    h.nombre AS hospital,
    s.tipo_sangre,
    s.componente,
    s.cantidad,
    s.estado,
    COUNT(u.id_unidad) AS unidades_asignadas
FROM banco_sangre.solicitud s
INNER JOIN banco_sangre.hospital h
    ON s.id_hospital = h.id_hospital
LEFT JOIN banco_sangre.unidad_sanguinea u
    ON u.id_solicitud = s.id_solicitud
GROUP BY s.id_solicitud, s.codigo, h.nombre, s.tipo_sangre, s.componente, s.cantidad, s.estado
ORDER BY s.codigo;


-- Debe devolver 0 filas: unidades cuyo tipo de sangre no coincide con el del donante.
SELECT u.codigo, u.tipo_sangre AS tipo_unidad, d.tipo_sangre AS tipo_donante
FROM banco_sangre.unidad_sanguinea u
INNER JOIN banco_sangre.donacion n
    ON u.id_donacion = n.id_donacion
INNER JOIN banco_sangre.donante d
    ON n.id_donante = d.id_donante
WHERE u.tipo_sangre <> d.tipo_sangre;


-- Debe devolver 0 filas: donantes cuya última donación no coincide con su historial.
SELECT d.cedula, d.fecha_ultima_donacion, MAX(n.fecha_donacion) AS ultima_en_historial
FROM banco_sangre.donante d
LEFT JOIN banco_sangre.donacion n
    ON n.id_donante = d.id_donante
GROUP BY d.id_donante, d.cedula, d.fecha_ultima_donacion
HAVING d.fecha_ultima_donacion IS DISTINCT FROM MAX(n.fecha_donacion);


-- =========================================================
-- 3. Datos registrados
-- =========================================================

-- Inventario disponible por tipo de sangre y componente.
SELECT tipo_sangre, componente, COUNT(*) AS disponibles
FROM banco_sangre.unidad_sanguinea
WHERE estado = 'Disponible'
  AND fecha_vencimiento >= CURRENT_DATE
GROUP BY tipo_sangre, componente
ORDER BY tipo_sangre, componente;


-- Unidades disponibles que vencen en los próximos 7 días.
SELECT codigo, tipo_sangre, componente, fecha_vencimiento
FROM banco_sangre.unidad_sanguinea
WHERE estado = 'Disponible'
  AND fecha_vencimiento BETWEEN CURRENT_DATE AND CURRENT_DATE + 7
ORDER BY fecha_vencimiento;


-- Debe devolver 1 fila (DON-2026-000010-GR): vencida pero todavía Disponible.
SELECT codigo, fecha_vencimiento, estado
FROM banco_sangre.unidad_sanguinea
WHERE estado = 'Disponible'
  AND fecha_vencimiento < CURRENT_DATE;


-- Donantes con impedimento vigente.
SELECT cedula, nombres, apellidos, impedido_hasta, motivo_impedimento
FROM banco_sangre.donante
WHERE impedido_hasta >= CURRENT_DATE
ORDER BY impedido_hasta;


-- Donantes inactivos.
SELECT cedula, nombres, apellidos
FROM banco_sangre.donante
WHERE activo = FALSE;


-- =========================================================
-- 4. Pruebas de restricciones (errores intencionales)
-- =========================================================
-- Seleccionar UNA prueba, desde BEGIN hasta ROLLBACK, y ejecutarla.
-- El INSERT, UPDATE o DELETE debe fallar con el error indicado.
-- El ROLLBACK final garantiza que nada quede guardado.
-- Si pgAdmin muestra "current transaction is aborted", ejecutar ROLLBACK; antes de seguir.


-- ---------- UNIQUE ----------

-- Prueba 4.1: Se registra otro donante con la cédula de María José López.
-- Cada cédula identifica a una sola persona, así que no puede repetirse.
-- Error esperado: uq_donante_cedula.
BEGIN;
INSERT INTO banco_sangre.donante
    (cedula, nombres, apellidos, sexo, fecha_nacimiento, tipo_sangre, telefono, departamento)
VALUES
    ('001-150392-9001A', 'Prueba', 'Duplicada', 'F', DATE '1990-01-01', 'O+', '88000000', 'Managua');
ROLLBACK;


-- Prueba 4.2: Se registra de nuevo el Hospital Central de Managua.
-- Dos hospitales con el mismo nombre no podrían distinguirse al atender solicitudes.
-- Error esperado: uq_hospital_nombre.
BEGIN;
INSERT INTO banco_sangre.hospital (nombre, departamento)
VALUES ('Hospital Central de Managua', 'Managua');
ROLLBACK;


-- Prueba 4.3: Se crea otra solicitud con el código SOL-2026-000001.
-- El código identifica la solicitud ante el hospital y debe ser único.
-- Error esperado: uq_solicitud_codigo.
BEGIN;
INSERT INTO banco_sangre.solicitud
    (codigo, id_hospital, tipo_sangre, componente, cantidad, prioridad)
VALUES
    ('SOL-2026-000001',
     (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital Central de Managua'),
     'O+', 'Plasma', 1, 'Normal');
ROLLBACK;


-- Prueba 4.4: Se registra otra donación con el código DON-2026-000001, de un donante distinto.
-- El código identifica la donación y sus unidades, así que no puede repetirse.
-- Error esperado: uq_donacion_codigo.
BEGIN;
INSERT INTO banco_sangre.donacion (codigo, id_donante, fecha_donacion, volumen_ml)
VALUES
    ('DON-2026-000001',
     (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-061196-9017S'),
     CURRENT_DATE, 450);
ROLLBACK;


-- Prueba 4.5: Se agrega otra unidad de glóbulos rojos a DON-2026-000001, con un código nuevo.
-- Cada donación se separa una sola vez por componente; el código distinto no lo evita.
-- Error esperado: uq_unidad_donacion_componente.
BEGIN;
INSERT INTO banco_sangre.unidad_sanguinea
    (codigo, id_donacion, componente, tipo_sangre, fecha_extraccion, fecha_vencimiento)
VALUES
    ('DON-2026-000001-GR2',
     (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000001'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 3, CURRENT_DATE + 32);
ROLLBACK;


-- ---------- CHECK ----------

-- Prueba 4.6: Se registra un donante con sexo 'X'.
-- Solo se admiten 'M' y 'F'.
-- Error esperado: chk_donante_sexo.
BEGIN;
INSERT INTO banco_sangre.donante
    (cedula, nombres, apellidos, sexo, fecha_nacimiento, tipo_sangre, telefono, departamento)
VALUES
    ('001-010190-9999Z', 'Prueba', 'Sexo', 'X', DATE '1990-01-01', 'O+', '88000000', 'Managua');
ROLLBACK;


-- Prueba 4.7: Se registra un donante con tipo de sangre 'C+'.
-- Solo existen los grupos O, A, B y AB, cada uno con Rh positivo o negativo.
-- Error esperado: chk_donante_tipo_sangre.
BEGIN;
INSERT INTO banco_sangre.donante
    (cedula, nombres, apellidos, sexo, fecha_nacimiento, tipo_sangre, telefono, departamento)
VALUES
    ('001-010190-9999Z', 'Prueba', 'Tipo', 'M', DATE '1990-01-01', 'C+', '88000000', 'Managua');
ROLLBACK;


-- Prueba 4.8: A María José López se le asigna un impedimento hasta dentro de 10 días sin motivo.
-- Un donante no puede quedar impedido sin que se registre la causa del impedimento.
-- Error esperado: chk_donante_impedimento.
BEGIN;
UPDATE banco_sangre.donante
SET impedido_hasta = CURRENT_DATE + 10,
    motivo_impedimento = NULL
WHERE cedula = '001-150392-9001A';
ROLLBACK;


-- Prueba 4.9: Se crea una campaña cuya fecha de fin es anterior a la de inicio.
-- Una campaña no puede terminar antes de comenzar.
-- Error esperado: chk_campania_fechas.
BEGIN;
INSERT INTO banco_sangre.campania
    (nombre, lugar, departamento, fecha_inicio, fecha_fin, meta_donantes)
VALUES
    ('Campaña de prueba', 'Managua', 'Managua', CURRENT_DATE, CURRENT_DATE - 1, 20);
ROLLBACK;


-- Prueba 4.10: Se crea una campaña con meta de 0 donantes.
-- Toda campaña debe aspirar a captar al menos un donante.
-- Error esperado: chk_campania_meta.
BEGIN;
INSERT INTO banco_sangre.campania
    (nombre, lugar, departamento, fecha_inicio, fecha_fin, meta_donantes)
VALUES
    ('Campaña de prueba', 'Managua', 'Managua', CURRENT_DATE, CURRENT_DATE + 1, 0);
ROLLBACK;


-- Prueba 4.11: La jornada universitaria pasa al estado 'Suspendida'.
-- Ese estado no existe: solo Planificada, Activa, Finalizada o Cancelada.
-- Error esperado: chk_campania_estado.
BEGIN;
UPDATE banco_sangre.campania
SET estado = 'Suspendida'
WHERE nombre = 'Jornada universitaria de noviembre';
ROLLBACK;


-- Prueba 4.12: Un hospital pide 25 unidades en una sola solicitud.
-- Cada solicitud admite entre 1 y 20 unidades.
-- Error esperado: chk_solicitud_cantidad.
BEGIN;
INSERT INTO banco_sangre.solicitud
    (codigo, id_hospital, tipo_sangre, componente, cantidad, prioridad)
VALUES
    ('SOL-PRUEBA-0001',
     (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital Central de Managua'),
     'O+', 'Plasma', 25, 'Normal');
ROLLBACK;


-- Prueba 4.13: Se registra una donación de 600 ml.
-- Una extracción válida está entre 300 y 500 ml; más volumen pondría en riesgo al donante.
-- Error esperado: chk_donacion_volumen.
BEGIN;
INSERT INTO banco_sangre.donacion (codigo, id_donante, fecha_donacion, volumen_ml)
VALUES
    ('DON-PRUEBA-0001',
     (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-061196-9017S'),
     CURRENT_DATE, 600);
ROLLBACK;


-- Prueba 4.14: Se agrega una unidad de plasma con extracción y vencimiento en la misma fecha.
-- El vencimiento debe ser posterior a la extracción; si no, la unidad nacería vencida.
-- Error esperado: chk_unidad_vencimiento.
BEGIN;
INSERT INTO banco_sangre.unidad_sanguinea
    (codigo, id_donacion, componente, tipo_sangre, fecha_extraccion, fecha_vencimiento)
VALUES
    ('DON-2026-000008-PL',
     (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000008'),
     'Plasma', 'B-', CURRENT_DATE, CURRENT_DATE);
ROLLBACK;


-- Prueba 4.15: Una unidad pasa al estado 'Perdida'.
-- Ese estado no existe: solo Disponible, Reservada, Despachada, Vencida o Descartada.
-- Error esperado: chk_unidad_estado.
BEGIN;
UPDATE banco_sangre.unidad_sanguinea
SET estado = 'Perdida'
WHERE codigo = 'DON-2026-000001-GR';
ROLLBACK;


-- ---------- FOREIGN KEY ----------

-- Prueba 4.16: Se registra una donación para el donante con id -1.
-- Toda donación debe pertenecer a un donante registrado.
-- Error esperado: fk_donacion_donante.
BEGIN;
INSERT INTO banco_sangre.donacion (codigo, id_donante, fecha_donacion, volumen_ml)
VALUES ('DON-PRUEBA-0002', -1, CURRENT_DATE, 450);
ROLLBACK;


-- Prueba 4.17: Se registra una donación en la campaña con id -1.
-- La campaña es opcional, pero si se indica debe existir.
-- Error esperado: fk_donacion_campania.
BEGIN;
INSERT INTO banco_sangre.donacion (codigo, id_donante, id_campania, fecha_donacion, volumen_ml)
VALUES
    ('DON-PRUEBA-0003',
     (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-061196-9017S'),
     -1, CURRENT_DATE, 450);
ROLLBACK;


-- Prueba 4.18: Se crea una solicitud para el hospital con id -1.
-- Solo un hospital registrado puede solicitar unidades.
-- Error esperado: fk_solicitud_hospital.
BEGIN;
INSERT INTO banco_sangre.solicitud
    (codigo, id_hospital, tipo_sangre, componente, cantidad, prioridad)
VALUES ('SOL-PRUEBA-0002', -1, 'O+', 'Plasma', 1, 'Normal');
ROLLBACK;


-- Prueba 4.19: La unidad DON-2026-000001-GR se asigna a la solicitud con id -1.
-- Una unidad solo puede reservarse o despacharse para una solicitud existente.
-- Error esperado: fk_unidad_solicitud.
BEGIN;
UPDATE banco_sangre.unidad_sanguinea
SET id_solicitud = -1
WHERE codigo = 'DON-2026-000001-GR';
ROLLBACK;


-- Prueba 4.20: Se elimina el Hospital Central de Managua, que tiene la solicitud SOL-2026-000001.
-- Borrarlo dejaría esa solicitud sin hospital.
-- Error esperado: fk_solicitud_hospital.
BEGIN;
DELETE FROM banco_sangre.hospital
WHERE nombre = 'Hospital Central de Managua';
ROLLBACK;


-- Prueba 4.21: Se elimina la donación DON-2026-000001, de la que salieron tres unidades.
-- Borrarla dejaría esas unidades sin origen conocido.
-- Error esperado: fk_unidad_donacion.
BEGIN;
DELETE FROM banco_sangre.donacion
WHERE codigo = 'DON-2026-000001';
ROLLBACK;


-- Comprobar al final que los conteos siguen iguales a los de la parte 1.
SELECT
    (SELECT COUNT(*) FROM banco_sangre.hospital) AS hospitales,
    (SELECT COUNT(*) FROM banco_sangre.campania) AS campanias,
    (SELECT COUNT(*) FROM banco_sangre.donante) AS donantes,
    (SELECT COUNT(*) FROM banco_sangre.solicitud) AS solicitudes,
    (SELECT COUNT(*) FROM banco_sangre.donacion) AS donaciones,
    (SELECT COUNT(*) FROM banco_sangre.unidad_sanguinea) AS unidades;
