USE medisistema_db;

-- ==========================================================
-- SOLUCIÓN DE LAS 20 CONSULTAS DQL - MEDISISTEMA
-- ==========================================================

-- 1. Número de pacientes atendidos por cada médico
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, COUNT(p.id_paciente) AS total_pacientes
FROM medicos m
LEFT JOIN pacientes p ON m.id_medico = p.id_medico_asignado
GROUP BY m.id_medico, m.nombre, m.apellido;

-- 2. Total de días de vacaciones planificadas y disfrutadas por cada empleado
SELECT e.id_empleado, CONCAT(e.nombre, ' ', e.apellido) AS empleado, 
       SUM(v.dias_planificados) AS total_planificados, 
       SUM(v.dias_disfrutados) AS total_disfrutados
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido;

-- 3. Médicos con mayor cantidad de horas de consulta en la semana
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, SUM(h.horas_consulta) AS total_horas_semana
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY total_horas_semana DESC;

-- 4. Número de sustituciones realizadas por cada médico sustituto
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico_sustituto, COUNT(s.id_sustitucion) AS total_sustituciones
FROM medicos m
JOIN sustituciones s ON m.id_medico = s.id_medico_sustituto
GROUP BY m.id_medico, m.nombre, m.apellido;

-- 5. Número de médicos que están actualmente en sustitución
SELECT COUNT(DISTINCT s.id_medico_sustituto) AS medicos_en_sustitucion_actual
FROM sustituciones s
WHERE CURDATE() BETWEEN s.fecha_inicio AND s.fecha_fin;

-- 6. Horas totales de consulta por médico por día de la semana
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, h.dia_semana, SUM(h.horas_consulta) AS horas_totales
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, h.dia_semana
ORDER BY m.id_medico, h.dia_semana;

-- 7. Médico con mayor cantidad de pacientes asignados
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, COUNT(p.id_paciente) AS total_pacientes
FROM medicos m
JOIN pacientes p ON m.id_medico = p.id_medico_asignado
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY total_pacientes DESC
LIMIT 1;

-- 8. Empleados con más de 10 días de vacaciones disfrutadas
SELECT e.id_empleado, CONCAT(e.nombre, ' ', e.apellido) AS empleado, SUM(v.dias_disfrutados) AS total_disfrutados
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado
GROUP BY e.id_empleado, e.nombre, e.apellido
HAVING SUM(v.dias_disfrutados) > 10;

-- 9. Médicos que actualmente están realizando una sustitución
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, s.fecha_inicio, s.fecha_fin
FROM sustituciones s
JOIN medicos m ON s.id_medico_sustituto = m.id_medico
WHERE CURDATE() BETWEEN s.fecha_inicio AND s.fecha_fin;

-- 10. Promedio de horas de consulta por médico por día de la semana
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, h.dia_semana, AVG(h.horas_consulta) AS promedio_horas
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, h.dia_semana;

-- 11. Empleados con mayor número de pacientes (Asociación general administrativa en sistema)
SELECT e.id_empleado, CONCAT(e.nombre, ' ', e.apellido) AS empleado, COUNT(p.id_paciente) AS total_pacientes_sistema
FROM empleados e
CROSS JOIN pacientes p
GROUP BY e.id_empleado, e.nombre, e.apellido;

-- 12. Médicos con más de 5 pacientes y total de horas de consulta en la semana
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, 
       COUNT(p.id_paciente) AS total_pacientes, 
       SUM(h.horas_consulta) AS total_horas_semana
FROM medicos m
LEFT JOIN pacientes p ON m.id_medico = p.id_medico_asignado
LEFT JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido
HAVING COUNT(p.id_paciente) > 5;

-- 13. Total de días de vacaciones planificadas y disfrutadas por cada tipo de empleado
SELECT e.cargo AS tipo_empleado, 
       SUM(v.dias_planificados) AS total_planificados, 
       SUM(v.dias_disfrutados) AS total_disfrutados
FROM empleados e
JOIN vacaciones v ON e.id_empleado = v.id_empleado
GROUP BY e.cargo;

-- 14. Total de pacientes por cada tipo de médico
SELECT m.tipo_medico, COUNT(p.id_paciente) AS total_pacientes
FROM medicos m
LEFT JOIN pacientes p ON m.id_medico = p.id_medico_asignado
GROUP BY m.tipo_medico;

-- 15. Total de horas de consulta por médico y día de la semana
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, h.dia_semana, SUM(h.horas_consulta) AS total_horas
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.id_medico, m.nombre, m.apellido, h.dia_semana;

-- 16. Número de sustituciones por tipo de médico
SELECT m.tipo_medico, COUNT(s.id_sustitucion) AS total_sustituciones
FROM medicos m
JOIN sustituciones s ON m.id_medico = s.id_medico_sustituto
GROUP BY m.tipo_medico;

-- 17. Total de pacientes por médico y por especialidad
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico, m.especialidad, COUNT(p.id_paciente) AS total_pacientes
FROM medicos m
LEFT JOIN pacientes p ON m.id_medico = p.id_medico_asignado
GROUP BY m.id_medico, m.nombre, m.apellido, m.especialidad;

-- 18. Empleados y médicos con más de 20 días de vacaciones planificadas
SELECT COALESCE(e.nombre, m.nombre) AS nombre, COALESCE(e.apellido, m.apellido) AS apellido, v.dias_planificados
FROM vacaciones v
LEFT JOIN empleados e ON v.id_empleado = e.id_empleado
LEFT JOIN medicos m ON v.id_medico = m.id_medico
WHERE v.dias_planificados > 20;

-- 19. Médicos con el mayor número de pacientes actualmente en sustitución
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS medico_titular, COUNT(s.id_sustitucion) AS total_sustituciones_recibidas
FROM medicos m
JOIN sustituciones s ON m.id_medico = s.id_medico_titular
GROUP BY m.id_medico, m.nombre, m.apellido
ORDER BY total_sustituciones_recibidas DESC;

-- 20. Total de horas de consulta por especialidad y día de la semana
SELECT m.especialidad, h.dia_semana, SUM(h.horas_consulta) AS total_horas
FROM medicos m
JOIN horarios_consulta h ON m.id_medico = h.id_medico
GROUP BY m.especialidad, h.dia_semana;

