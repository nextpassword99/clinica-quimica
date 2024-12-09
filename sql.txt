
CREATE TABLE t_paciente
(
    DNI              INT PRIMARY KEY,
    nombre           VARCHAR(50)     NOT NULL,
    apellido         VARCHAR(50)     NOT NULL,
    fecha_nacimiento DATE            NOT NULL,
    sexo             ENUM ('M', 'F') NOT NULL,
    telefono         varchar(15),
    nivel_emoglobina INT,
    hematocrito      INT,
    peso             INT,
    talla            INT,
    fecha_registro   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);




CREATE TABLE t_especialdades
(
    especialidad_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(50) NOT NULL
);

CREATE TABLE t_medicos
(
    DNI              INT PRIMARY KEY,
    nombre           VARCHAR(50) NOT NULL,
    apellido         VARCHAR(50) NOT NULL,
    telefono         varchar(15),
    especialidad_id  INT         NOT NULL,
    fecha_contracion DATE,
    FOREIGN KEY (especialidad_id) REFERENCES t_especialdades (especialidad_id)
);



CREATE TABLE t_citas
(
    id          INT AUTO_INCREMENT PRIMARY KEY,
    paciente_id INT      NOT NULL,
    medico_id   INT      NOT NULL,
    fecha_hora  DATETIME NOT NULL,
    mottivo     TEXT,
    estado      ENUM ('pendiente', 'confirmada', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (paciente_id) REFERENCES t_paciente (DNI),
    FOREIGN KEY (medico_id) REFERENCES t_medicos (DNI)
);

CREATE TABLE t_tratamientos
(
    id                INT AUTO_INCREMENT PRIMARY KEY,
    cita_id           INT  NOT NULL,
    descripcion       TEXT NOT NULL,
    costo             DECIMAL(10, 2),
    fecha_tratamiento DATE,
    FOREIGN KEY (cita_id) REFERENCES t_citas (id)
);



INSERT INTO t_especialdades (nombre)
VALUES ('Medicina General'),
       ('Cardiología'),
       ('Dermatología'),
       ('Ginecología'),
       ('Pediatría'),
       ('Neurología'),
       ('Oftalmología'),
       ('Otorrinolaringología'),
       ('Urología'),
       ('Endocrinología'),
       ('Traumatología'),
       ('Oncología'),
       ('Psiquiatría'),
       ('Radiología'),
       ('Cirugía General'),
       ('Cirugía Plástica'),
       ('Nefrología'),
       ('Reumatología'),
       ('Medicina Interna'),
       ('Anestesiología'),
       ('Odontología'),
       ('Ortopedia'),
       ('Pneumología'),
       ('Gastroenterología'),
       ('Hematología'),
       ('Infectología'),
       ('Alergología'),
       ('Medicina Estética'),
       ('Medicina del Deporte'),
       ('Fisioterapia'),
       ('Terapia Ocupacional'),
       ('Genética Médica'),
       ('Neumología'),
       ('Endocrinología Pediátrica'),
       ('Nefrología Pediátrica'),
       ('Neurocirugía'),
       ('Cirugía Cardiaca'),
       ('Geriatría'),
       ('Medicina Preventiva'),
       ('Medicina Deportiva'),
       ('Toxicología'),
       ('Bioquímica Clínica'),
       ('Inmunología'),
       ('Cirugía Oncológica'),
       ('Gineco-Obstetricia'),
       ('Cirugía Endoscópica'),
       ('Cirugía Vascular'),
       ('Medicina Forense'),
       ('Cardiología Intervencionista'),
       ('Rehabilitación Cardiaca'),
       ('Terapia Intensiva'),
       ('Cuidadores de Salud'),
       ('Nutrición Clínica'),
       ('Dietética y Nutrición'),
       ('Cirugía Maxilofacial'),
       ('Medicina Nuclear'),
       ('Estomatología'),
       ('Cirugía Robótica'),
       ('Oftalmología Pediátrica'),
       ('Hematología Oncológica'),
       ('Pediatría Intensiva'),
       ('Análisis Clínicos'),
       ('Microbiología Médica'),
       ('Fisiología Médica'),
       ('Medicina Tropical'),
       ('Medicina Familiar'),
       ('Endoscopia Digestiva'),
       ('Cirugía Bariátrica'),
       ('Pediatría Neumológica'),
       ('Cirugía Plástica Estética'),
       ('Medicina Estética Dermatológica'),
       ('Medicina Alternativa'),
       ('Medicina Integrativa'),
       ('Homeopatía'),
       ('Acupuntura'),
       ('Quiropráctica'),
       ('Rehabilitación Neurológica'),
       ('Psicología Clínica'),
       ('Psicoterapia'),
       ('Psicopedagogía'),
       ('Neurología Pediátrica'),
       ('Neuropediatría'),
       ('Reumatología Pediátrica'),
       ('Medicina de Urgencias'),
       ('Medicina Intensiva Pediátrica'),
       ('Medicina Paliativa'),
       ('Investigación Médica'),
       ('Medicina Regenerativa'),
       ('Cuidados Paliativos'),
       ('Hematología Pediátrica'),
       ('Médico Cirujano'),
       ('Pediatría General'),
       ('Cirugía de Columna Vertebral'),
       ('Medicina Vascular'),
       ('Cirugía de Hombro y Codo'),
       ('Cirugía de Mano'),
       ('Cirugía de Rodilla'),
       ('Rehabilitación Deportiva'),
       ('Medicina del Sueño'),
       ('Endocrinología y Metabolismo'),
       ('Medicina Cardiovascular'),
       ('Gastroenterología Pediátrica'),
       ('Neuropsicología'),
       ('Terapia Geriátrica'),
       ('Patología Clínica'),
       ('Medicina Familiar Pediátrica'),
       ('Cirugía Bariátrica Pediátrica'),
       ('Odontología Pediátrica');


INSERT INTO t_medicos (DNI, nombre, apellido, telefono, especialidad_id, fecha_contracion)
VALUES (12345678, 'Juan', 'Pérez', '555-1234', 1, '2015-03-20'),      -- Medicina General
       (23456789, 'Ana', 'Gómez', '555-5678', 2, '2017-06-15'),       -- Cardiología
       (34567890, 'Luis', 'Sánchez', '555-9876', 3, '2019-09-10'),    -- Dermatología
       (45678901, 'María', 'Rodríguez', '555-4321', 4, '2016-02-10'), -- Ginecología
       (56789012, 'Carlos', 'López', '555-8765', 5, '2018-08-25'),    -- Pediatría
       (67890123, 'Lucía', 'Martínez', '555-3456', 6, '2020-05-30'),  -- Neurología
       (78901234, 'Pedro', 'Hernández', '555-6543', 7, '2021-11-12'), -- Oftalmología
       (89012345, 'Sofía', 'García', '555-2345', 8, '2019-12-01'),    -- Otorrinolaringología
       (90123456, 'Miguel', 'Álvarez', '555-6789', 9, '2017-07-10'),  -- Urología
       (11223344, 'Elena', 'Fernández', '555-3456', 10, '2018-01-21'); -- Endocrinología


INSERT INTO t_paciente (DNI, nombre, apellido, fecha_nacimiento, sexo, telefono, nivel_emoglobina, hematocrito)
VALUES (10000001, 'Juan', 'Pérez', '1985-01-01', 'M', '555-1001', 14, 45),
       (10000002, 'Ana', 'Gómez', '1990-02-15', 'F', '555-1002', 13, 42),
       (10000003, 'Luis', 'Sánchez', '1982-03-20', 'M', '555-1003', 15, 48),
       (10000004, 'María', 'Rodríguez', '1995-04-25', 'F', '555-1004', 12, 40),
       (10000005, 'Carlos', 'López', '1988-05-30', 'M', '555-1005', 14, 44),
       (10000006, 'Lucía', 'Martínez', '1992-06-15', 'F', '555-1006', 13, 41),
       (10000007, 'Pedro', 'Hernández', '1975-07-10', 'M', '555-1007', 16, 47),
       (10000008, 'Sofía', 'García', '1980-08-05', 'F', '555-1008', 12, 39),
       (10000009, 'Miguel', 'Álvarez', '1998-09-11', 'M', '555-1009', 14, 45),
       (10000010, 'Elena', 'Fernández', '1993-10-20', 'F', '555-1010', 13, 42),
       (10000011, 'Raúl', 'Martínez', '1987-11-25', 'M', '555-1011', 15, 46),
       (10000012, 'Claudia', 'López', '1996-12-30', 'F', '555-1012', 12, 40),
       (10000013, 'Fernando', 'García', '1978-01-13', 'M', '555-1013', 16, 49),
       (10000014, 'Paula', 'Ramírez', '1994-02-08', 'F', '555-1014', 13, 43),
       (10000015, 'Tomás', 'Vega', '1984-03-03', 'M', '555-1015', 14, 44),
       (10000016, 'Beatriz', 'Díaz', '1990-04-22', 'F', '555-1016', 12, 41),
       (10000017, 'David', 'Jiménez', '1992-05-18', 'M', '555-1017', 13, 42),
       (10000018, 'Carla', 'Torres', '1986-06-12', 'F', '555-1018', 15, 47),
       (10000019, 'Javier', 'Serrano', '1997-07-28', 'M', '555-1019', 14, 45),
       (10000020, 'Gabriela', 'Hernández', '1983-08-10', 'F', '555-1020', 12, 40),
       (10000021, 'Antonio', 'González', '1991-09-17', 'M', '555-1021', 13, 43),
       (10000022, 'Mónica', 'Vázquez', '1999-10-25', 'F', '555-1022', 14, 44),
       (10000023, 'José', 'Martín', '1980-11-09', 'M', '555-1023', 15, 46),
       (10000024, 'Teresa', 'Morales', '1995-12-19', 'F', '555-1024', 12, 41),
       (10000025, 'Álvaro', 'Cabrera', '1989-01-22', 'M', '555-1025', 14, 45),
       (10000026, 'Laura', 'Soto', '1993-02-16', 'F', '555-1026', 13, 42),
       (10000027, 'Manuel', 'Ramírez', '1982-03-01', 'M', '555-1027', 15, 47),
       (10000028, 'Inés', 'Herrera', '1998-04-18', 'F', '555-1028', 12, 39),
       (10000029, 'Luis', 'Gil', '1996-05-09', 'M', '555-1029', 13, 41),
       (10000030, 'Marta', 'González', '1991-06-13', 'F', '555-1030', 14, 45),
       (10000031, 'Raúl', 'Serrano', '1984-07-07', 'M', '555-1031', 15, 46),
       (10000032, 'Patricia', 'Muñoz', '1987-08-12', 'F', '555-1032', 12, 42),
       (10000033, 'Juan', 'Romero', '1993-09-20', 'M', '555-1033', 14, 43),
       (10000034, 'Silvia', 'Castro', '1999-10-11', 'F', '555-1034', 13, 41),
       (10000035, 'Carlos', 'Ferrer', '1990-11-17', 'M', '555-1035', 16, 48),
       (10000036, 'Paola', 'Mendoza', '1985-12-25', 'F', '555-1036', 12, 40),
       (10000037, 'Ricardo', 'Pérez', '1979-01-17', 'M', '555-1037', 13, 42),
       (10000038, 'Berta', 'Jiménez', '1982-02-14', 'F', '555-1038', 14, 44),
       (10000039, 'Santiago', 'Villar', '1994-03-23', 'M', '555-1039', 15, 47),
       (10000040, 'Isabel', 'García', '1990-04-08', 'F', '555-1040', 12, 41),
       (10000041, 'Juan', 'Pérez', '1981-05-01', 'M', '555-1041', 14, 44),
       (10000042, 'Ana', 'Fernández', '1986-06-20', 'F', '555-1042', 13, 43),
       (10000043, 'Luis', 'Moreno', '1992-07-13', 'M', '555-1043', 15, 46),
       (10000044, 'María', 'Ramírez', '1994-08-29', 'F', '555-1044', 12, 40),
       (10000045, 'Raúl', 'Rodríguez', '1988-09-22', 'M', '555-1045', 13, 42),
       (10000046, 'Carla', 'Álvarez', '1996-10-17', 'F', '555-1046', 14, 44),
       (10000047, 'Javier', 'Gómez', '1980-11-30', 'M', '555-1047', 15, 47),
       (10000048, 'María', 'Vázquez', '1993-12-12', 'F', '555-1048', 12, 40),
       (10000049, 'Antonio', 'López', '1991-01-27', 'M', '555-1049', 13, 42),
       (10000050, 'Sofía', 'Hernández', '1989-02-14', 'F', '555-1050', 14, 44),
       (10000051, 'Fernando', 'Sánchez', '1995-03-30', 'M', '555-1051', 15, 45),
       (10000052, 'Lucía', 'González', '1990-04-22', 'F', '555-1052', 12, 41),
       (10000053, 'Miguel', 'Pérez', '1992-05-15', 'M', '555-1053', 13, 42),
       (10000054, 'Beatriz', 'Martínez', '1984-06-10', 'F', '555-1054', 14, 44),
       (10000055, 'David', 'Fernández', '1987-07-25', 'M', '555-1055', 15, 46),
       (10000056, 'José', 'Torres', '1991-08-08', 'M', '555-1056', 12, 39),
       (10000057, 'Claudia', 'Vega', '1996-09-16', 'F', '555-1057', 13, 41),
       (10000058, 'Paula', 'Serrano', '1985-10-20', 'F', '555-1058', 14, 45),
       (10000059, 'Tomás', 'García', '1993-11-05', 'M', '555-1059', 15, 47),
       (10000060, 'Andrea', 'Hernández', '1997-12-18', 'F', '555-1060', 12, 40),
       (10000061, 'Juan', 'Díaz', '1989-01-14', 'M', '555-1061', 13, 42),
       (10000062, 'Laura', 'López', '1992-02-22', 'F', '555-1062', 14, 44),
       (10000063, 'Ricardo', 'Ramírez', '1983-03-11', 'M', '555-1063', 15, 46),
       (10000064, 'Marta', 'Jiménez', '1990-04-04', 'F', '555-1064', 12, 41),
       (10000065, 'Carlos', 'Martín', '1988-05-13', 'M', '555-1065', 13, 43),
       (10000066, 'Patricia', 'Gómez', '1997-06-15', 'F', '555-1066', 14, 45),
       (10000067, 'Santiago', 'González', '1980-07-25', 'M', '555-1067', 15, 47),
       (10000068, 'Isabel', 'Morales', '1984-08-30', 'F', '555-1068', 12, 40),
       (10000069, 'José', 'Ramírez', '1993-09-02', 'M', '555-1069', 13, 42),
       (10000070, 'Raquel', 'Torres', '1987-10-16', 'F', '555-1070', 14, 44),
       (10000071, 'Antonio', 'Vázquez', '1995-11-14', 'M', '555-1071', 15, 46),
       (10000072, 'Claudia', 'González', '1999-12-21', 'F', '555-1072', 12, 39),
       (10000073, 'Javier', 'Martínez', '1986-01-22', 'M', '555-1073', 13, 41),
       (10000074, 'Lucía', 'Rodríguez', '1991-02-25', 'F', '555-1074', 14, 44),
       (10000075, 'Carlos', 'Pérez', '1989-03-15', 'M', '555-1075', 15, 47),
       (10000076, 'David', 'Sánchez', '1994-04-20', 'M', '555-1076', 12, 40),
       (10000077, 'José', 'Serrano', '1980-05-02', 'M', '555-1077', 13, 42),
       (10000078, 'Antonio', 'Fernández', '1988-06-10', 'M', '555-1078', 14, 44),
       (10000079, 'Patricia', 'Serrano', '1991-07-22', 'F', '555-1079', 15, 46),
       (10000080, 'Raúl', 'Torres', '1992-08-14', 'M', '555-1080', 12, 39),
       (10000081, 'María', 'Serrano', '1999-09-30', 'F', '555-1081', 13, 41),
       (10000082, 'Miguel', 'Torres', '1987-10-05', 'M', '555-1082', 14, 44),
       (10000083, 'José', 'González', '1983-11-12', 'M', '555-1083', 15, 46),
       (10000084, 'Carlos', 'Díaz', '1992-12-19', 'M', '555-1084', 12, 40),
       (10000085, 'Sofía', 'Vega', '1990-01-25', 'F', '555-1085', 13, 42),
       (10000086, 'José', 'Morales', '1996-02-15', 'M', '555-1086', 14, 45),
       (10000087, 'Javier', 'Pérez', '1984-03-10', 'M', '555-1087', 15, 47),
       (10000088, 'Isabel', 'González', '1989-04-17', 'F', '555-1088', 12, 40),
       (10000089, 'Carlos', 'Sánchez', '1992-05-09', 'M', '555-1089', 13, 42),
       (10000090, 'Lucía', 'Morales', '1987-06-25', 'F', '555-1090', 14, 44),
       (10000091, 'Marta', 'López', '1990-07-02', 'F', '555-1091', 15, 46),
       (10000092, 'Patricia', 'Pérez', '1995-08-13', 'F', '555-1092', 12, 39),
       (10000093, 'Juan', 'Hernández', '1997-09-24', 'M', '555-1093', 13, 41),
       (10000094, 'Fernando', 'Vázquez', '1991-10-08', 'M', '555-1094', 14, 43),
       (10000095, 'Paula', 'Ramírez', '1983-11-21', 'F', '555-1095', 15, 45),
       (10000096, 'Raúl', 'González', '1989-12-14', 'M', '555-1096', 12, 40),
       (10000097, 'Antonio', 'Serrano', '1997-01-18', 'M', '555-1097', 13, 42),
       (10000098, 'Javier', 'Gómez', '1990-02-07', 'M', '555-1098', 14, 44),
       (10000099, 'David', 'López', '1994-03-15', 'M', '555-1099', 15, 46),
       (10000100, 'María', 'Torres', '1987-04-11', 'F', '555-1100', 12, 40);


SELECT DNI,
       nombre,
       TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) AS edad
FROM t_paciente;
#
# ALTER DATABASE pruebas CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# ALTER TABLE t_paciente
#     CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

SELECT DNI,
       peso / ((talla / 100) * (talla / 100)) AS imc, # de cm a m
       CASE
           WHEN peso / ((talla / 100) * (talla / 100)) < 18.5 THEN 'Bajo peso'
           WHEN peso / ((talla / 100) * (talla / 100)) BETWEEN 18.5 AND 24.9 THEN 'Normal'
           WHEN peso / ((talla / 100) * (talla / 100)) BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
           ELSE 'Obseidad'
           END                                AS clasificacion_imc
FROM t_paciente
WHERE DNI = 10000001;

SELECT talla, peso, nombre  FROM t_paciente;

INSERT INTO t_paciente (DNI, nombre) VALUES (10000001, 'Antonio');