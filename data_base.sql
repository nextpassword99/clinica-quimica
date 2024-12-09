/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.2-MariaDB, for Win64 (AMD64)
--
-- Host: 127.0.0.1    Database: pruebas
-- ------------------------------------------------------
-- Server version	11.4.2-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `t_citas`
--

DROP TABLE IF EXISTS `t_citas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_citas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `paciente_id` int(11) NOT NULL,
  `medico_id` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `motivo` text DEFAULT NULL,
  `estado` enum('pendiente','confirmada','cancelada') DEFAULT 'pendiente',
  `diagnostico` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `medico_id` (`medico_id`),
  KEY `paciente_id` (`paciente_id`),
  CONSTRAINT `t_citas_ibfk_1` FOREIGN KEY (`paciente_id`) REFERENCES `t_paciente` (`DNI`),
  CONSTRAINT `t_citas_ibfk_2` FOREIGN KEY (`medico_id`) REFERENCES `t_medicos` (`medico_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_citas`
--

LOCK TABLES `t_citas` WRITE;
/*!40000 ALTER TABLE `t_citas` DISABLE KEYS */;
INSERT INTO `t_citas` VALUES
(1,12345678,1,'2024-12-10 10:00:00','Chequeo general','confirmada','Todo en orden'),
(2,87654321,2,'2024-12-11 09:30:00','Control pediátrico','pendiente',NULL),
(3,11223344,3,'2024-12-12 14:15:00','Dolor de cabeza constante','pendiente',NULL),
(4,22334455,4,'2024-12-13 11:00:00','Control ginecológico','confirmada','Sin alteraciones'),
(5,33445566,5,'2024-12-14 08:45:00','Consulta por erupción cutánea','cancelada',NULL),
(6,44556677,6,'2024-12-15 15:30:00','Dolores en las rodillas','confirmada','Posible esguince'),
(7,55667788,7,'2024-12-16 16:00:00','Ansiedad y estrés','pendiente',NULL),
(8,66778899,8,'2024-12-17 13:30:00','Examen ocular','confirmada','Visión normal'),
(9,77889900,9,'2024-12-18 14:00:00','Seguimiento oncología','pendiente',NULL),
(10,88990011,10,'2024-12-19 10:30:00','Revisión dental','confirmada','Sin problemas'),
(11,12312312,1,'2024-12-10 15:00:00','Dolor estomacal','pendiente',NULL),
(12,32132132,1,'2024-12-09 12:00:00','Dolor muscular','pendiente',NULL);
/*!40000 ALTER TABLE `t_citas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_medicamentos`
--

DROP TABLE IF EXISTS `t_medicamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_medicamentos` (
  `medicamento_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `tipo_de_medicamento_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`medicamento_id`),
  KEY `idx_tipo_de_medicamento` (`tipo_de_medicamento_id`),
  CONSTRAINT `fk_tipo_de_medicamento` FOREIGN KEY (`tipo_de_medicamento_id`) REFERENCES `t_tipo_de_medicamento` (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_medicamentos`
--

LOCK TABLES `t_medicamentos` WRITE;
/*!40000 ALTER TABLE `t_medicamentos` DISABLE KEYS */;
INSERT INTO `t_medicamentos` VALUES
(1,'Amoxicilina','Antibiótico usado para tratar infecciones bacterianas.',1,500.00,'2024-12-09 02:01:48'),
(2,'Ibuprofeno','Analgésico y antiinflamatorio para reducir el dolor y la fiebre.',2,200.00,'2024-12-09 02:01:48'),
(3,'Paracetamol','Antipirético y analgésico utilizado para aliviar el dolor y reducir la fiebre.',4,150.00,'2024-12-09 02:01:48'),
(4,'Dexametasona','Corticosteroide usado para reducir inflamación y tratar reacciones alérgicas.',3,50.00,'2024-12-09 02:01:48'),
(5,'Loratadina','Antihistamínico utilizado para aliviar alergias.',5,100.00,'2024-12-09 02:01:48'),
(6,'Sertralina','Antidepresivo utilizado para tratar la depresión y la ansiedad.',6,30.00,'2024-12-09 02:01:48'),
(7,'Risperidona','Antipsicótico utilizado para tratar trastornos psicóticos y otros problemas mentales.',7,100.00,'2024-12-09 02:01:48'),
(8,'Lactulosa','Laxante utilizado para tratar el estreñimiento.',8,150.00,'2024-12-09 02:01:48'),
(9,'Metformina','Medicamento utilizado para controlar el nivel de glucosa en la sangre en pacientes con diabetes tipo 2.',9,200.00,'2024-12-09 02:01:48'),
(10,'Vitamina C','Suplemento vitamínico utilizado para mejorar el sistema inmunológico y prevenir resfriados.',10,500.00,'2024-12-09 02:01:48');
/*!40000 ALTER TABLE `t_medicamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_medicos`
--

DROP TABLE IF EXISTS `t_medicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_medicos` (
  `medico_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `fecha_contratacion` date DEFAULT NULL,
  PRIMARY KEY (`medico_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_medicos`
--

LOCK TABLES `t_medicos` WRITE;
/*!40000 ALTER TABLE `t_medicos` DISABLE KEYS */;
INSERT INTO `t_medicos` VALUES
(1,'Carlos','Ramirez','5551234567','Cardiología','2015-06-01'),
(2,'Lucía','Gómez','5552345678','Pediatría','2017-03-15'),
(3,'Miguel','Lopez','5553456789','Neurología','2018-08-20'),
(4,'Ana','Martínez','5554567890','Ginecología','2016-04-10'),
(5,'Pedro','Sánchez','5555678901','Dermatología','2019-02-25'),
(6,'María','Rodríguez','5556789012','Traumatología','2020-01-30'),
(7,'Javier','Fernández','5557890123','Psiquiatría','2015-11-05'),
(8,'Elena','Hernández','5558901234','Oftalmología','2018-06-18'),
(9,'José','Pérez','5559012345','Oncología','2017-07-22'),
(10,'Raquel','García','5550123456','Odontología','2014-12-13');
/*!40000 ALTER TABLE `t_medicos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_paciente`
--

DROP TABLE IF EXISTS `t_paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_paciente` (
  `DNI` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `sexo` enum('M','F') NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `nivel_emoglobina` int(11) DEFAULT NULL,
  `hematocrito` int(11) DEFAULT NULL,
  `fecha_registro` timestamp NULL DEFAULT current_timestamp(),
  `peso` decimal(10,2) DEFAULT NULL,
  `talla` decimal(10,2) DEFAULT NULL,
  `ubicacion_geografica` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_paciente`
--

LOCK TABLES `t_paciente` WRITE;
/*!40000 ALTER TABLE `t_paciente` DISABLE KEYS */;
INSERT INTO `t_paciente` VALUES
(11010102,'Ana','Cabrera','1985-07-22','F','987654322',13,41,'2024-12-08 15:05:00',60.20,162.50,'Arequipa'),
(11010103,'Luis','Torres','1992-10-11','M','987654323',16,46,'2024-12-08 15:10:00',85.00,180.00,'Trujillo'),
(11010104,'Maria','Sánchez','1980-02-05','F','987654324',12,39,'2024-12-08 15:15:00',58.00,160.00,'Cusco'),
(11010105,'José','González','1988-01-20','M','987654325',15,45,'2024-12-08 15:20:00',79.40,178.20,'Piura'),
(11010106,'Fernanda','Ramírez','1995-05-17','F','987654326',13,40,'2024-12-08 15:25:00',63.70,164.80,'Chiclayo'),
(11010107,'Ricardo','Gutiérrez','1987-08-03','M','987654327',14,43,'2024-12-08 15:30:00',82.10,177.60,'Lima'),
(11010108,'Lucía','Pérez','1993-09-29','F','987654328',12,38,'2024-12-08 15:35:00',55.60,158.30,'Arequipa'),
(11010109,'Juan','Ramírez','1982-11-18','M','987654329',14,44,'2024-12-08 15:40:00',74.80,172.90,'Tacna'),
(11010110,'Sofía','Martínez','1991-04-12','F','987654330',13,42,'2024-12-08 15:45:00',68.30,165.00,'Cajamarca'),
(11010111,'José','Hernández','1989-02-02','M','987654331',15,47,'2024-12-08 15:50:00',88.20,182.00,'Ayacucho'),
(11010112,'Carolina','Fernández','1997-06-13','F','987654332',14,41,'2024-12-08 15:55:00',70.00,168.40,'Iquitos'),
(11010113,'Andrés','Álvarez','1990-09-04','M','987654333',12,40,'2024-12-08 16:00:00',78.50,176.20,'Puno'),
(11010114,'Gabriela','López','1994-12-25','F','987654334',14,43,'2024-12-08 16:05:00',64.90,161.00,'Huancayo'),
(11010115,'Pedro','Díaz','1983-01-30','M','987654335',16,48,'2024-12-08 16:10:00',90.30,179.50,'Sullana'),
(11010116,'Isabel','García','1992-04-09','F','987654336',13,42,'2024-12-08 16:15:00',67.50,170.00,'Junín'),
(11010117,'Carlos','Martín','1986-12-04','M','987654337',14,45,'2024-12-08 16:20:00',80.20,174.50,'Chimbote'),
(11010118,'Patricia','Vásquez','1993-07-18','F','987654338',13,41,'2024-12-08 16:25:00',71.40,165.50,'Lima'),
(11010119,'Diego','Ríos','1990-06-14','M','987654339',15,46,'2024-12-08 16:30:00',76.90,178.90,'Arequipa'),
(11010120,'Mariana','Morales','1995-11-02','F','987654340',12,39,'2024-12-08 16:35:00',62.30,160.70,'Cusco'),
(11010121,'Ricardo','Santos','1987-10-01','M','987654341',14,44,'2024-12-08 16:40:00',81.10,177.00,'Trujillo'),
(11010122,'Mónica','Chávez','1994-05-22','F','987654342',13,42,'2024-12-08 16:45:00',69.80,163.20,'Piura'),
(11010123,'Luis','Silva','1990-03-13','M','987654343',15,45,'2024-12-08 16:50:00',86.00,180.00,'Chiclayo'),
(11010124,'Rosa','Moreno','1984-08-30','F','987654344',12,38,'2024-12-08 16:55:00',57.20,159.80,'Lima'),
(11010125,'Enrique','Vega','1991-10-17','M','987654345',14,43,'2024-12-08 17:00:00',75.00,173.50,'Huancayo'),
(11010126,'Sofía','Castillo','1996-01-06','F','987654346',13,41,'2024-12-08 17:05:00',64.00,162.10,'Iquitos'),
(11010127,'Mario','Gómez','1988-04-14','M','987654347',16,46,'2024-12-08 17:10:00',87.30,179.00,'Lima'),
(11010128,'Alicia','Ruiz','1992-06-25','F','987654348',12,39,'2024-12-08 17:15:00',61.80,160.50,'Arequipa'),
(11010129,'José','Reyes','1989-12-19','M','987654349',15,44,'2024-12-08 17:20:00',79.20,177.80,'Trujillo'),
(11010130,'Verónica','Vargas','1997-02-03','F','987654350',13,40,'2024-12-08 17:25:00',66.50,164.00,'Puno'),
(11010131,'Juan','Flores','1985-09-11','M','987654351',14,42,'2024-12-08 17:30:00',72.10,173.00,'Tacna'),
(11010132,'Cecilia','Fernández','1991-01-14','F','987654352',12,38,'2024-12-08 17:35:00',59.90,161.20,'Sullana'),
(11010133,'Carlos','Luna','1988-10-24','M','987654353',14,45,'2024-12-08 17:40:00',80.50,175.00,'Chiclayo'),
(11010134,'Ana','Jiménez','1994-07-21','F','987654354',13,40,'2024-12-08 17:45:00',65.20,162.50,'Piura'),
(11010135,'Marco','Cordero','1996-11-08','M','987654355',16,47,'2024-12-08 17:50:00',88.00,180.00,'Lima'),
(11010136,'Laura','Ruiz','1990-12-09','F','987654356',12,39,'2024-12-08 17:55:00',70.50,164.00,'Arequipa'),
(11010137,'Fernando','Sánchez','1982-02-12','M','987654357',14,44,'2024-12-08 18:00:00',76.00,172.30,'Huancayo'),
(11010138,'Susana','Ortiz','1993-09-17','F','987654358',12,41,'2024-12-08 18:05:00',65.00,163.00,'Cusco'),
(11010139,'Ricardo','Vásquez','1994-06-02','M','987654359',13,40,'2024-12-08 18:10:00',73.80,174.00,'Piura'),
(11010140,'Karina','Bermúdez','1987-05-21','F','987654360',12,39,'2024-12-08 18:15:00',60.00,161.50,'Chiclayo'),
(11010141,'Santiago','Benavides','1992-02-14','M','987654361',14,43,'2024-12-08 18:20:00',79.40,178.00,'Lima'),
(11010142,'Bárbara','Hernández','1995-10-25','F','987654362',13,40,'2024-12-08 18:25:00',69.20,163.50,'Piura'),
(11010143,'Luis','Cabrera','1986-06-08','M','987654363',15,45,'2024-12-08 18:30:00',83.50,180.50,'Trujillo'),
(11010144,'María','Vega','1990-07-27','F','987654364',12,39,'2024-12-08 18:35:00',61.40,160.90,'Ayacucho'),
(11010145,'Víctor','Rodríguez','1983-11-19','M','987654365',16,48,'2024-12-08 18:40:00',89.10,182.50,'Lima'),
(11010146,'Carla','Castillo','1997-05-01','F','987654366',14,42,'2024-12-08 18:45:00',74.60,167.80,'Chiclayo'),
(11010147,'Javier','Chavez','1992-08-30','M','987654367',13,41,'2024-12-08 18:50:00',78.50,175.40,'Puno'),
(11010148,'Lucía','Vargas','1989-07-16','F','987654368',12,38,'2024-12-08 18:55:00',60.70,162.20,'Tacna'),
(11010149,'Gabriel','Morales','1994-05-10','M','987654369',14,46,'2024-12-08 19:00:00',82.30,179.00,'Piura'),
(11010150,'Patricia','Vega','1996-10-02','F','987654370',13,42,'2024-12-08 19:05:00',65.80,162.60,'Lima'),
(11223344,'Carlos','Gómez','1982-08-10','M','5552456789',13,44,'2024-12-09 02:01:48',80.00,180.00,'Tacna'),
(12312312,'Edison','Pontecil Paniura','2005-08-15','M','917138548',12,12,'2024-12-09 14:49:42',56.00,167.00,'Cusco'),
(12345678,'Juan','Pérez','1985-04-15','M','5550234567',14,45,'2024-12-09 02:01:48',70.50,175.00,'Chiclayo'),
(22334455,'Lucía','Martínez','1978-06-20','F','5553567890',11,38,'2024-12-09 02:01:48',65.00,165.00,'Apurimac'),
(32132132,'Rogelio','Gomez Bolaños','2006-11-03','M',NULL,NULL,NULL,'2024-12-09 18:02:00',60.00,180.00,'Cusco'),
(33445566,'José','Fernández','1995-11-01','M','5554678901',16,47,'2024-12-09 02:01:48',72.00,170.00,'Huancayo'),
(44556677,'Ana','Rodríguez','2000-03-14','F','5555789012',15,43,'2024-12-09 02:01:48',55.50,162.00,'Lima'),
(55667788,'Javier','Sánchez','1988-05-22','M','5556890123',14,42,'2024-12-09 02:01:48',77.50,178.00,'Piura'),
(66778899,'Raquel','García','1992-09-10','F','5557901234',13,41,'2024-12-09 02:01:48',63.00,162.00,'Cusco'),
(77889900,'Pedro','Hernández','1997-07-03','M','5558012345',12,39,'2024-12-09 02:01:48',79.00,173.00,'Cusco'),
(87654321,'María','López','1990-02-28','F','5551345678',12,40,'2024-12-09 02:01:48',58.00,160.00,'Piura'),
(88990011,'Elena','Gómez','1984-12-25','F','5559123456',14,46,'2024-12-09 02:01:48',68.00,167.00,'Puno'),
(91010101,'Carlos','Mendoza','1990-03-15','M','987654321',14,42,'2024-12-08 15:00:00',75.50,175.30,'Lima');
/*!40000 ALTER TABLE `t_paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_tipo_de_medicamento`
--

DROP TABLE IF EXISTS `t_tipo_de_medicamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_tipo_de_medicamento` (
  `tipo_id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`tipo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tipo_de_medicamento`
--

LOCK TABLES `t_tipo_de_medicamento` WRITE;
/*!40000 ALTER TABLE `t_tipo_de_medicamento` DISABLE KEYS */;
INSERT INTO `t_tipo_de_medicamento` VALUES
(1,'Antibiótico'),
(2,'Analgésico'),
(3,'Antiinflamatorio'),
(4,'Antipirético'),
(5,'Antihistamínico'),
(6,'Antidepresivo'),
(7,'Antipsicótico'),
(8,'Laxante'),
(9,'Antidiabético'),
(10,'Vitamina');
/*!40000 ALTER TABLE `t_tipo_de_medicamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_tratamientos`
--

DROP TABLE IF EXISTS `t_tratamientos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_tratamientos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cita_id` int(11) NOT NULL,
  `medicamento_id` int(11) NOT NULL,
  `cantidad` decimal(10,2) DEFAULT NULL,
  `descripcion` text NOT NULL,
  `costo` decimal(10,2) DEFAULT NULL,
  `fecha_tratamiento` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_medicamento` (`medicamento_id`),
  KEY `cita_id` (`cita_id`),
  CONSTRAINT `fk_cita` FOREIGN KEY (`cita_id`) REFERENCES `t_citas` (`id`),
  CONSTRAINT `fk_medicamento` FOREIGN KEY (`medicamento_id`) REFERENCES `t_medicamentos` (`medicamento_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_tratamientos`
--

LOCK TABLES `t_tratamientos` WRITE;
/*!40000 ALTER TABLE `t_tratamientos` DISABLE KEYS */;
INSERT INTO `t_tratamientos` VALUES
(1,1,1,500.00,'Tratamiento para infección bacteriana',10.00,'2024-12-10'),
(2,2,2,200.00,'Tratamiento analgésico para dolor leve',5.00,'2024-12-11'),
(3,3,3,150.00,'Tratamiento para aliviar fiebre',3.50,'2024-12-12'),
(4,4,4,50.00,'Tratamiento para reducir inflamación',8.00,'2024-12-13'),
(5,5,5,100.00,'Tratamiento para alergias cutáneas',6.50,'2024-12-14'),
(6,6,6,30.00,'Tratamiento para aliviar síntomas de depresión',12.00,'2024-12-15'),
(7,7,7,100.00,'Tratamiento para ansiedad',15.00,'2024-12-16'),
(8,8,8,150.00,'Tratamiento ocular preventivo',20.00,'2024-12-17'),
(9,9,9,200.00,'Tratamiento para control de diabetes',25.00,'2024-12-18'),
(10,10,10,500.00,'Suplemento vitamínico para el sistema inmune',5.00,'2024-12-19'),
(11,11,10,5.00,'Evitar dolor de huesos',15.80,'2024-12-09'),
(12,12,10,5.00,'Reduce el dolor muscular',50.00,'2024-12-09');
/*!40000 ALTER TABLE `t_tratamientos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2024-12-09 14:55:43
