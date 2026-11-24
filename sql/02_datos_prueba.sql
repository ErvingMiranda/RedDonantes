-- Datos ficticios para desarrollo. Ejecutar conectado a bd_red_donantes, después de 01_estructura.sql.
-- Las fechas son relativas a CURRENT_DATE para que siempre haya unidades por vencer y vencidas.
-- Ninguna persona, cédula, teléfono ni correo corresponde a datos reales.

BEGIN;

INSERT INTO banco_sangre.hospital (nombre, departamento, telefono, contacto)
VALUES
    ('Hospital Central de Managua', 'Managua', '22220101', 'Lic. Carla Méndez'),
    ('Hospital Regional de León', 'León', '23110202', 'Dr. Ernesto Salgado'),
    ('Hospital Departamental de Matagalpa', 'Matagalpa', '27720303', 'Lic. Rosa Aráuz'),
    ('Hospital del Sur de Rivas', 'Rivas', '25630404', 'Dr. Julio Cerda'),
    ('Hospital Regional de Estelí', 'Estelí', '27130505', 'Lic. Patricia Zeledón'),
    ('Hospital de la Costa Caribe Sur', 'Costa Caribe Sur', '25720606', 'Dr. Marvin Hodgson');

INSERT INTO banco_sangre.campania (nombre, lugar, departamento, fecha_inicio, fecha_fin, meta_donantes, estado, descripcion)
VALUES
    ('Jornada universitaria de noviembre', 'Managua', 'Managua', CURRENT_DATE - 5, CURRENT_DATE + 10, 60, 'Activa', 'Campaña con estudiantes y personal docente.'),
    ('Campaña en el mercado de Masaya', 'Masaya', 'Masaya', CURRENT_DATE - 60, CURRENT_DATE - 58, 40, 'Finalizada', NULL),
    ('Jornada departamental en León', 'León', 'León', CURRENT_DATE + 20, CURRENT_DATE + 22, 50, 'Planificada', 'Pendiente de confirmar el local.'),
    ('Campaña en Bluefields', 'Bluefields', 'Costa Caribe Sur', CURRENT_DATE - 30, CURRENT_DATE - 29, 30, 'Cancelada', 'Cancelada por lluvias.');

INSERT INTO banco_sangre.donante
    (cedula, nombres, apellidos, sexo, fecha_nacimiento, tipo_sangre, telefono, correo,
     departamento, direccion, impedido_hasta, motivo_impedimento, activo, fecha_registro)
VALUES
    ('001-150392-9001A', 'María José', 'López Rivera', 'F', DATE '1992-03-15', 'O+', '88120001', 'maria.lopez@ejemplo.com',
     'Managua', 'Bello Horizonte', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('001-020788-9002B', 'Carlos Andrés', 'Pérez Somarriba', 'M', DATE '1988-07-02', 'O-', '88120002', NULL,
     'Managua', 'Villa Fontana', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('281-110595-9003C', 'Ana Lucía', 'Gutiérrez Toruño', 'F', DATE '1995-05-11', 'A+', '88120003', 'ana.gutierrez@ejemplo.com',
     'León', 'Barrio Guadalupe', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('281-230190-9004D', 'José Ramón', 'Martínez Baca', 'M', DATE '1990-01-23', 'A+', '88120004', NULL,
     'León', 'Reparto Fundeci', CURRENT_DATE + 15, 'Tatuaje reciente', TRUE, CURRENT_DATE - 200),
    ('401-080899-9005E', 'Karla Vanessa', 'Rodríguez Ñamendi', 'F', DATE '1999-08-08', 'B+', '88120005', NULL,
     'Masaya', 'Monimbó', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('401-301185-9006F', 'Luis Fernando', 'Hernández Cano', 'M', DATE '1985-11-30', 'O+', '88120006', 'luis.hernandez@ejemplo.com',
     'Masaya', 'San Jerónimo', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('441-140293-9007G', 'Sofía Alejandra', 'Castillo Dávila', 'F', DATE '1993-02-14', 'AB+', '88120007', NULL,
     'Matagalpa', 'Guanuca', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('441-190676-9008H', 'Pedro Antonio', 'Blandón Rugama', 'M', DATE '1976-06-19', 'O+', '88120008', NULL,
     'Matagalpa', 'El Tambor', CURRENT_DATE - 10, 'Gripe', TRUE, CURRENT_DATE - 200),
    ('161-050401-9009J', 'Gabriela', 'Zeledón Moncada', 'F', DATE '2001-04-05', 'A-', '88120009', 'gabriela.zeledon@ejemplo.com',
     'Estelí', 'Barrio El Rosario', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('161-271082-9010K', 'Jorge Luis', 'Rivera Olivas', 'M', DATE '1982-10-27', 'B-', '88120010', NULL,
     'Estelí', 'Villa Cuba', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('201-120997-9011L', 'Valeria', 'Chamorro Urbina', 'F', DATE '1997-09-12', 'O+', '88120011', NULL,
     'Granada', 'Calle La Calzada', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('201-030379-9012M', 'Manuel Ernesto', 'Aguilar Pineda', 'M', DATE '1979-03-03', 'A+', '88120012', NULL,
     'Granada', 'Barrio Xalteva', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('081-210694-9013N', 'Daniela', 'Montenegro Ruiz', 'F', DATE '1994-06-21', 'O-', '88120013', 'daniela.montenegro@ejemplo.com',
     'Chinandega', 'Reparto Las Brisas', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('081-091287-9014P', 'Ricardo José', 'Estrada Lacayo', 'M', DATE '1987-12-09', 'B+', '88120014', NULL,
     'Chinandega', 'Barrio San Antonio', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('561-170500-9015Q', 'Fernanda', 'Cruz Obando', 'F', DATE '2000-05-17', 'A+', '88120015', NULL,
     'Rivas', 'Barrio Santa Ana', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('561-250873-9016R', 'Óscar Danilo', 'Velásquez Mora', 'M', DATE '1973-08-25', 'O+', '88120016', NULL,
     'Rivas', 'Tola', NULL, NULL, FALSE, CURRENT_DATE - 200),
    ('001-061196-9017S', 'Camila', 'Sandoval Peralta', 'F', DATE '1996-11-06', 'AB-', '88120017', NULL,
     'Managua', 'Altamira', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('001-180591-9018T', 'Diego Alejandro', 'Lacayo Matus', 'M', DATE '1991-05-18', 'A-', '88120018', 'diego.lacayo@ejemplo.com',
     'Managua', 'Los Robles', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('361-290298-9019U', 'Paola', 'Mairena González', 'F', DATE '1998-02-28', 'B+', '88120019', NULL,
     'Jinotega', 'Barrio Sandino', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('361-111184-9020V', 'Héctor Manuel', 'Rizo Altamirano', 'M', DATE '1984-11-11', 'O+', '88120020', NULL,
     'Jinotega', 'La Fundadora', CURRENT_DATE + 30, 'Cirugía menor', TRUE, CURRENT_DATE - 200),
    ('121-040702-9021W', 'Isabel', 'Duarte Sequeira', 'F', DATE '2002-07-04', 'O+', '88120021', NULL,
     'Boaco', 'Boaco Viejo', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('121-160981-9022X', 'Francisco Javier', 'Obregón Leiva', 'M', DATE '1981-09-16', 'A+', '88120022', NULL,
     'Boaco', 'Barrio El Calvario', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('241-221093-9023Y', 'Lucía', 'Marenco Vado', 'F', DATE '1993-10-22', 'O-', '88120023', NULL,
     'Carazo', 'Jinotepe', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('241-010486-9024A', 'Mauricio', 'Calero Bermúdez', 'M', DATE '1986-04-01', 'AB+', '88120024', NULL,
     'Carazo', 'Diriamba', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('421-130899-9025B', 'Andrea', 'Sevilla Talavera', 'F', DATE '1999-08-13', 'A+', '88120025', NULL,
     'Chontales', 'Juigalpa', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('421-200378-9026C', 'Roberto Carlos', 'Arróliga Mena', 'M', DATE '1978-03-20', 'O+', '88120026', NULL,
     'Chontales', 'Acoyapa', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('321-070600-9027D', 'Natalia', 'Úbeda Picado', 'F', DATE '2000-06-07', 'B-', '88120027', NULL,
     'Madriz', 'Somoto', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('501-151089-9028E', 'Kevin Josué', 'Torres Espinoza', 'M', DATE '1989-10-15', 'O+', '88120028', NULL,
     'Río San Juan', 'San Carlos', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('601-090395-9029F', 'Shirley', 'Hodgson Forbes', 'F', DATE '1995-03-09', 'A+', '88120029', NULL,
     'Costa Caribe Sur', 'Bluefields', NULL, NULL, TRUE, CURRENT_DATE - 200),
    ('621-281187-9030G', 'Brandon', 'Waters Kingsman', 'M', DATE '1987-11-28', 'O+', '88120030', NULL,
     'Costa Caribe Norte', 'Bilwi', NULL, NULL, TRUE, CURRENT_DATE - 200);

INSERT INTO banco_sangre.solicitud
    (codigo, id_hospital, fecha_solicitud, tipo_sangre, componente, cantidad, prioridad, estado, observaciones)
VALUES
    ('SOL-2026-000001', (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital Central de Managua'),
     CURRENT_DATE, 'O-', 'Glóbulos rojos', 3, 'Urgente', 'Pendiente', 'Paciente en cirugía de emergencia.'),
    ('SOL-2026-000002', (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital Regional de León'),
     CURRENT_DATE - 1, 'A+', 'Plaquetas', 2, 'Urgente', 'Atendida parcialmente', NULL),
    ('SOL-2026-000003', (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital Departamental de Matagalpa'),
     CURRENT_DATE - 10, 'A+', 'Glóbulos rojos', 2, 'Normal', 'Atendida', NULL),
    ('SOL-2026-000004', (SELECT id_hospital FROM banco_sangre.hospital WHERE nombre = 'Hospital del Sur de Rivas'),
     CURRENT_DATE - 20, 'B+', 'Plasma', 1, 'Normal', 'Cancelada', 'El hospital resolvió con existencias propias.');

INSERT INTO banco_sangre.donacion (codigo, id_donante, id_campania, fecha_donacion, volumen_ml)
VALUES
    ('DON-2026-000001', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-150392-9001A'),
     (SELECT id_campania FROM banco_sangre.campania WHERE nombre = 'Jornada universitaria de noviembre'), CURRENT_DATE - 3, 450),
    ('DON-2026-000002', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-020788-9002B'),
     NULL, CURRENT_DATE - 40, 450),
    ('DON-2026-000003', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '281-110595-9003C'),
     (SELECT id_campania FROM banco_sangre.campania WHERE nombre = 'Jornada universitaria de noviembre'), CURRENT_DATE - 4, 450),
    ('DON-2026-000004', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '401-080899-9005E'),
     (SELECT id_campania FROM banco_sangre.campania WHERE nombre = 'Campaña en el mercado de Masaya'), CURRENT_DATE - 59, 450),
    ('DON-2026-000005', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '401-301185-9006F'),
     (SELECT id_campania FROM banco_sangre.campania WHERE nombre = 'Campaña en el mercado de Masaya'), CURRENT_DATE - 59, 450),
    ('DON-2026-000006', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '441-140293-9007G'),
     NULL, CURRENT_DATE - 100, 400),
    ('DON-2026-000007', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '441-190676-9008H'),
     NULL, CURRENT_DATE - 30, 450),
    ('DON-2026-000008', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '161-271082-9010K'),
     NULL, CURRENT_DATE - 32, 450),
    ('DON-2026-000009', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '201-120997-9011L'),
     (SELECT id_campania FROM banco_sangre.campania WHERE nombre = 'Jornada universitaria de noviembre'), CURRENT_DATE - 2, 450),
    ('DON-2026-000010', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '081-210694-9013N'),
     NULL, CURRENT_DATE - 37, 450),
    ('DON-2026-000011', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '081-091287-9014P'),
     NULL, CURRENT_DATE - 15, 450),
    ('DON-2026-000012', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '001-180591-9018T'),
     NULL, CURRENT_DATE - 120, 450),
    ('DON-2026-000013', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '121-160981-9022X'),
     NULL, CURRENT_DATE - 12, 450),
    ('DON-2026-000014', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '421-200378-9026C'),
     NULL, CURRENT_DATE - 12, 450),
    ('DON-2026-000015', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '501-151089-9028E'),
     NULL, CURRENT_DATE - 20, 450),
    ('DON-2026-000016', (SELECT id_donante FROM banco_sangre.donante WHERE cedula = '621-281187-9030G'),
     NULL, CURRENT_DATE - 1, 450);

INSERT INTO banco_sangre.unidad_sanguinea
    (codigo, id_donacion, componente, tipo_sangre, fecha_extraccion, fecha_vencimiento, estado, id_solicitud)
VALUES
    ('DON-2026-000001-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000001'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 3, CURRENT_DATE + 32, 'Disponible', NULL),
    ('DON-2026-000001-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000001'),
     'Plaquetas', 'O+', CURRENT_DATE - 3, CURRENT_DATE + 2, 'Disponible', NULL),
    ('DON-2026-000001-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000001'),
     'Plasma', 'O+', CURRENT_DATE - 3, CURRENT_DATE + 362, 'Disponible', NULL),
    ('DON-2026-000002-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000002'),
     'Glóbulos rojos', 'O-', CURRENT_DATE - 40, CURRENT_DATE - 5, 'Vencida', NULL),
    ('DON-2026-000002-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000002'),
     'Plasma', 'O-', CURRENT_DATE - 40, CURRENT_DATE + 325, 'Disponible', NULL),
    ('DON-2026-000003-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000003'),
     'Glóbulos rojos', 'A+', CURRENT_DATE - 4, CURRENT_DATE + 31, 'Disponible', NULL),
    ('DON-2026-000003-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000003'),
     'Plaquetas', 'A+', CURRENT_DATE - 4, CURRENT_DATE + 1, 'Despachada', (SELECT id_solicitud FROM banco_sangre.solicitud WHERE codigo = 'SOL-2026-000002')),
    ('DON-2026-000004-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000004'),
     'Glóbulos rojos', 'B+', CURRENT_DATE - 59, CURRENT_DATE - 24, 'Vencida', NULL),
    ('DON-2026-000004-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000004'),
     'Plasma', 'B+', CURRENT_DATE - 59, CURRENT_DATE + 306, 'Disponible', NULL),
    ('DON-2026-000005-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000005'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 59, CURRENT_DATE - 24, 'Vencida', NULL),
    ('DON-2026-000005-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000005'),
     'Plaquetas', 'O+', CURRENT_DATE - 59, CURRENT_DATE - 54, 'Vencida', NULL),
    ('DON-2026-000005-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000005'),
     'Plasma', 'O+', CURRENT_DATE - 59, CURRENT_DATE + 306, 'Disponible', NULL),
    ('DON-2026-000006-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000006'),
     'Glóbulos rojos', 'AB+', CURRENT_DATE - 100, CURRENT_DATE - 65, 'Vencida', NULL),
    ('DON-2026-000006-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000006'),
     'Plasma', 'AB+', CURRENT_DATE - 100, CURRENT_DATE + 265, 'Disponible', NULL),
    ('DON-2026-000007-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000007'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 30, CURRENT_DATE + 5, 'Disponible', NULL),
    ('DON-2026-000007-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000007'),
     'Plasma', 'O+', CURRENT_DATE - 30, CURRENT_DATE + 335, 'Disponible', NULL),
    ('DON-2026-000008-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000008'),
     'Glóbulos rojos', 'B-', CURRENT_DATE - 32, CURRENT_DATE + 3, 'Disponible', NULL),
    ('DON-2026-000009-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000009'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 2, CURRENT_DATE + 33, 'Disponible', NULL),
    ('DON-2026-000009-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000009'),
     'Plaquetas', 'O+', CURRENT_DATE - 2, CURRENT_DATE + 3, 'Disponible', NULL),
    -- Caso de prueba: vencida pero todavía Disponible; UnidadDAO.marcarVencidas debe pasarla a Vencida al abrir la aplicación.
    ('DON-2026-000010-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000010'),
     'Glóbulos rojos', 'O-', CURRENT_DATE - 37, CURRENT_DATE - 2, 'Disponible', NULL),
    ('DON-2026-000010-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000010'),
     'Plaquetas', 'O-', CURRENT_DATE - 37, CURRENT_DATE - 32, 'Vencida', NULL),
    ('DON-2026-000011-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000011'),
     'Glóbulos rojos', 'B+', CURRENT_DATE - 15, CURRENT_DATE + 20, 'Disponible', NULL),
    ('DON-2026-000011-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000011'),
     'Plasma', 'B+', CURRENT_DATE - 15, CURRENT_DATE + 350, 'Disponible', NULL),
    ('DON-2026-000012-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000012'),
     'Plasma', 'A-', CURRENT_DATE - 120, CURRENT_DATE + 245, 'Disponible', NULL),
    ('DON-2026-000013-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000013'),
     'Glóbulos rojos', 'A+', CURRENT_DATE - 12, CURRENT_DATE + 23, 'Despachada', (SELECT id_solicitud FROM banco_sangre.solicitud WHERE codigo = 'SOL-2026-000003')),
    ('DON-2026-000013-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000013'),
     'Plasma', 'A+', CURRENT_DATE - 12, CURRENT_DATE + 353, 'Disponible', NULL),
    ('DON-2026-000014-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000014'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 12, CURRENT_DATE + 23, 'Despachada', (SELECT id_solicitud FROM banco_sangre.solicitud WHERE codigo = 'SOL-2026-000003')),
    ('DON-2026-000015-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000015'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 20, CURRENT_DATE + 15, 'Disponible', NULL),
    ('DON-2026-000015-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000015'),
     'Plaquetas', 'O+', CURRENT_DATE - 20, CURRENT_DATE - 15, 'Descartada', NULL),
    ('DON-2026-000015-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000015'),
     'Plasma', 'O+', CURRENT_DATE - 20, CURRENT_DATE + 345, 'Disponible', NULL),
    ('DON-2026-000016-GR', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000016'),
     'Glóbulos rojos', 'O+', CURRENT_DATE - 1, CURRENT_DATE + 34, 'Disponible', NULL),
    ('DON-2026-000016-PQ', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000016'),
     'Plaquetas', 'O+', CURRENT_DATE - 1, CURRENT_DATE + 4, 'Disponible', NULL),
    ('DON-2026-000016-PL', (SELECT id_donacion FROM banco_sangre.donacion WHERE codigo = 'DON-2026-000016'),
     'Plasma', 'O+', CURRENT_DATE - 1, CURRENT_DATE + 364, 'Disponible', NULL);

-- Igual que hará DonacionDAO: la última donación queda guardada en el donante.
UPDATE banco_sangre.donante d
SET fecha_ultima_donacion = (
    SELECT MAX(n.fecha_donacion)
    FROM banco_sangre.donacion n
    WHERE n.id_donante = d.id_donante
);

COMMIT;
