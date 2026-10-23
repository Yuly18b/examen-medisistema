-- Creación de la base de datos
DROP DATABASE IF EXISTS medisistema_db;
CREATE DATABASE medisistema_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE medisistema_db;

-- 1. Tabla de Empleados (Personal no médico: ATS, auxiliares, celadores, administrativos)
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo ENUM('ATS', 'auxiliar_enfermeria', 'celador', 'administrativo') NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- 2. Tabla de Médicos (Titular, interino, sustituto)
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    tipo_medico ENUM('titular', 'interino', 'sustituto') NOT NULL
);

-- 3. Tabla de Pacientes (Relacionados con su médico asignado)
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT,
    id_medico_asignado INT,
    CONSTRAINT fk_paciente_medico FOREIGN KEY (id_medico_asignado) 
        REFERENCES medicos(id_medico) ON DELETE SET NULL
);

-- 4. Tabla de Horarios de Consulta (Por médico y día de la semana)
CREATE TABLE horarios_consulta (
    id_horario INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    dia_semana ENUM('Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo') NOT NULL,
    horas_consulta DECIMAL(4,2) NOT NULL,
    CONSTRAINT fk_horario_medico FOREIGN KEY (id_medico) 
        REFERENCES medicos(id_medico) ON DELETE CASCADE
);

-- 5. Tabla de Sustituciones (Controla qué médico sustituye a qué médico titular/interino)
CREATE TABLE sustituciones (
    id_sustitucion INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_sustituto INT NOT NULL,
    id_medico_titular INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT fk_medico_sustituto FOREIGN KEY (id_medico_sustituto) 
        REFERENCES medicos(id_medico) ON DELETE CASCADE,
    CONSTRAINT fk_medico_titular FOREIGN KEY (id_medico_titular) 
        REFERENCES medicos(id_medico) ON DELETE CASCADE
);

-- 6. Tabla de Control de Vacaciones (Planificadas y disfrutadas para médicos o empleados)
CREATE TABLE vacaciones (
    id_vacacion INT AUTO_INCREMENT PRIMARY KEY,
    id_empleado INT NULL,
    id_medico INT NULL,
    dias_planificados INT NOT NULL DEFAULT 0,
    dias_disfrutados INT NOT NULL DEFAULT 0,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    CONSTRAINT fk_vacaciones_empleado FOREIGN KEY (id_empleado) 
        REFERENCES empleados(id_empleado) ON DELETE CASCADE,
    CONSTRAINT fk_vacaciones_medico FOREIGN KEY (id_medico) 
        REFERENCES medicos(id_medico) ON DELETE CASCADE
);

