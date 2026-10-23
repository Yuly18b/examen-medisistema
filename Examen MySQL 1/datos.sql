USE medisistema_db;

-- 1. Insertar Empleados (Personal no médico)
INSERT INTO empleados (nombre, apellido, cargo, telefono, email) VALUES
('Carlos', 'Pérez', 'ATS', '3101234567', 'carlos.perez@medisistema.com'),
('Ana', 'Gómez', 'auxiliar_enfermeria', '3209876543', 'ana.gomez@medisistema.com'),
('Luis', 'Rodríguez', 'celador', '3112223344', 'luis.rodriguez@medisistema.com'),
('María', 'Fernández', 'administrativo', '3154445566', 'maria.fernandez@medisistema.com');

-- 2. Insertar Médicos (Titulares, interinos y sustitutos)
INSERT INTO medicos (nombre, apellido, especialidad, tipo_medico) VALUES
('Alberto', 'Martínez', 'Cardiología', 'titular'),
('Sofia', 'López', 'Pediatría', 'titular'),
('Javier', 'Ramírez', 'Medicina General', 'interino'),
('Elena', 'Castro', 'Dermatología', 'sustituto'),
('Ricardo', 'Torres', 'Neurología', 'sustituto');

-- 3. Insertar Pacientes (Asignados a médicos específicos)
INSERT INTO pacientes (nombre, apellido, telefono, direccion, id_medico_asignado) VALUES
('Pedro', 'Suárez', '3001112233', 'Calle 10 # 5-20', 1),
('Lucía', 'Benítez', '3002223344', 'Carrera 12 # 8-45', 1),
('Mateo', 'Rojas', '3003334455', 'Barrio Fátima', 2),
('Valentina', 'Díaz', '3004445566', 'Villa Olímpica', 2),
('Jorge', 'Jiménez', '3005556677', 'Centro', 3),
('Camila', 'Vargas', '3006667788', 'El Vergel', 3);

-- 4. Insertar Horarios de Consulta
INSERT INTO horarios_consulta (id_medico, dia_semana, horas_consulta) VALUES
(1, 'Lunes', 4.50),
(1, 'Miércoles', 6.00),
(2, 'Martes', 5.00),
(2, 'Jueves', 4.00),
(3, 'Lunes', 8.00),
(4, 'Viernes', 6.50),
(5, 'Miércoles', 4.00);

-- 5. Insertar Sustituciones (Médico sustituto y médico titular/interino)
INSERT INTO sustituciones (id_medico_sustituto, id_medico_titular, fecha_inicio, fecha_fin) VALUES
(4, 1, '2026-10-01', '2026-10-15'),
(5, 2, '2026-10-10', '2026-10-25');

-- 6. Insertar Vacaciones (Planificadas y disfrutadas para empleados o médicos)
INSERT INTO vacaciones (id_empleado, id_medico, dias_planificados, dias_disfrutados, fecha_inicio, fecha_fin) VALUES
(1, NULL, 15, 12, '2026-06-01', '2026-06-16'),
(2, NULL, 10, 10, '2026-07-01', '2026-07-11'),
(NULL, 1, 15, 15, '2026-08-01', '2026-08-16'),
(NULL, 2, 20, 22, '2026-09-01', '2026-09-22');

