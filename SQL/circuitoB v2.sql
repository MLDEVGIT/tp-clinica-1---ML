-- versión simplificando las primary keys y foreign keys

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
-- -----------------------------------------------------
-- Schema CircuitoB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `CircuitoB` ;

-- -----------------------------------------------------
-- Schema CircuitoB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CircuitoB` ;
USE `CircuitoB` ;

-- -----------------------------------------------------
-- Table `CircuitoB`.`Cobertura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Cobertura` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Cobertura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Paciente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Paciente` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Paciente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Apellido` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NULL,
  `Direccion` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Cobertura_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Paciente_Cobertura1_idx` (`Cobertura_id` ASC) VISIBLE,
  CONSTRAINT `fk_Paciente_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `CircuitoB`.`Cobertura` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Estudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Estudio` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Estudio` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`LugarDeAtencion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`LugarDeAtencion` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`LugarDeAtencion` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NULL,
  `Estudio_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_LugarDeAtencion_Estudio1_idx` (`Estudio_id` ASC) VISIBLE,
  CONSTRAINT `fk_LugarDeAtencion_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `CircuitoB`.`Estudio` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`TurnoStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`TurnoStatus` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`TurnoStatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Turno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Turno` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Turno` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `FechaHoraInicio` DATETIME NULL,
  `FechaHoraFin` DATETIME NULL,
  `LugarDeAtencion_id` INT NOT NULL,
  `LugarDeAtencion_Estudio_id` INT NOT NULL,
  `Paciente_id` INT NULL,
  `Paciente_Cobertura_id` INT NULL,
  `TurnoStatus_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Turno_LugarDeAtencion1_idx` (`LugarDeAtencion_id` ASC, `LugarDeAtencion_Estudio_id` ASC) VISIBLE,
  INDEX `fk_Turno_Paciente1_idx` (`Paciente_id` ASC, `Paciente_Cobertura_id` ASC) VISIBLE,
  INDEX `fk_Turno_TurnoStatus1_idx` (`TurnoStatus_id` ASC) VISIBLE,

  CONSTRAINT `fk_Turno_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `CircuitoB`.`Paciente` (`id`),
    CONSTRAINT `fk_Turno_LugarDeAtencion1`
    FOREIGN KEY (`LugarDeAtencion_id`)
    REFERENCES `CircuitoB`.`LugarDeAtencion` (`id`),
  CONSTRAINT `fk_Turno_TurnoStatus1`
    FOREIGN KEY (`TurnoStatus_id`)
    REFERENCES `CircuitoB`.`TurnoStatus` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`SalaDeEspera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`SalaDeEspera` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`SalaDeEspera` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `FechaHoraAcreditacion` DATETIME NULL,
  `Turno_id` INT NOT NULL,
  `Turno_LugarDeAtencion_id` INT NOT NULL,
  `Turno_LugarDeAtencion_Estudio_id` INT NOT NULL,
  `Turno_TurnoStatus_id` INT NOT NULL,
  `Prioridad` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_SalaDeEspera_Turno1_idx` (`Turno_id` ASC, `Turno_LugarDeAtencion_id` ASC, `Turno_LugarDeAtencion_Estudio_id` ASC, `Turno_TurnoStatus_id` ASC) VISIBLE,
  CONSTRAINT `fk_SalaDeEspera_Turno1`
    FOREIGN KEY (`Turno_id`)
    REFERENCES `CircuitoB`.`Turno` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`MetodoPago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`MetodoPago` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`MetodoPago` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`FacturaStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`FacturaStatus` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`FacturaStatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`Factura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`Factura` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`Factura` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Turno_id` INT NOT NULL,
  `Turno_LugarDeAtencion_id` INT NOT NULL,
  `Turno_LugarDeAtencion_Estudio_id` INT NOT NULL,
  `Turno_TurnoStatus_id` INT NOT NULL,
  `Paciente_id` INT NOT NULL,
  `Paciente_Cobertura_id` INT NOT NULL,
  `Monto` FLOAT NULL,
  `MetodoPago_id` INT NULL,
  `FacturaStatus_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Factura_Turno1_idx` (`Turno_id` ASC, `Turno_LugarDeAtencion_id` ASC, `Turno_LugarDeAtencion_Estudio_id` ASC, `Turno_TurnoStatus_id` ASC) VISIBLE,
  INDEX `fk_Factura_Paciente1_idx` (`Paciente_id` ASC, `Paciente_Cobertura_id` ASC) VISIBLE,
  INDEX `fk_Factura_MetodoPago1_idx` (`MetodoPago_id` ASC) VISIBLE,
  INDEX `fk_Factura_FacturaStatus1_idx` (`FacturaStatus_id` ASC) VISIBLE,
  CONSTRAINT `fk_Factura_Turno1`
    FOREIGN KEY (`Turno_id`)
    REFERENCES `CircuitoB`.`Turno` (`id`),
  CONSTRAINT `fk_Factura_Paciente1`
    FOREIGN KEY (`Paciente_id`)
    REFERENCES `CircuitoB`.`Paciente` (`id`),
  CONSTRAINT `fk_Factura_MetodoPago1`
    FOREIGN KEY (`MetodoPago_id`)
    REFERENCES `CircuitoB`.`MetodoPago` (`id`),
  CONSTRAINT `fk_Factura_FacturaStatus1`
    FOREIGN KEY (`FacturaStatus_id`)
    REFERENCES `CircuitoB`.`FacturaStatus` (`id`));


-- -----------------------------------------------------
-- Table `CircuitoB`.`CoberturaEstudio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `CircuitoB`.`CoberturaEstudio` ;

CREATE TABLE IF NOT EXISTS `CircuitoB`.`CoberturaEstudio` (
  `Cobertura_id` INT NOT NULL,
  `Estudio_id` INT NOT NULL,
  `Monto` INT NULL,
  PRIMARY KEY (`Cobertura_id`, `Estudio_id`),
  INDEX `fk_Cobertura_has_Estudio_Estudio1_idx` (`Estudio_id` ASC) VISIBLE,
  INDEX `fk_Cobertura_has_Estudio_Cobertura1_idx` (`Cobertura_id` ASC) VISIBLE,
  CONSTRAINT `fk_Cobertura_has_Estudio_Cobertura1`
    FOREIGN KEY (`Cobertura_id`)
    REFERENCES `CircuitoB`.`Cobertura` (`id`),
  CONSTRAINT `fk_Cobertura_has_Estudio_Estudio1`
    FOREIGN KEY (`Estudio_id`)
    REFERENCES `CircuitoB`.`Estudio` (`id`));

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
-- -----------------------------------------------------


INSERT INTO CircuitoB.Cobertura (Nombre) VALUES
('Osde'),
('Pampa Salud'),
('Swiss Medical'),
('IOMA'),
('Galeno');

INSERT INTO CircuitoB.Paciente (Nombre, Apellido, DNI, Direccion, Email, Cobertura_id) VALUES
('Juan', 'Perez', '30123456', 'Calle falsa 123', 'jperez@email.com', 1),
('Maria', 'Gonzalez', '27890123', 'Calle real 456', 'mgonzalez@email.com', 2),
('Pedro', 'Diaz', '31456789', 'Avenida siempreviva 789', 'pdiaz@email.com', 3),
('Ana', 'Lopez', '28901234', 'Calle norte 1011', 'alopez@email.com', 4),
('Luis', 'Fernandez', '32567890', 'Calle sur 1213', 'lfernandez@email.com', 5);



INSERT INTO CircuitoB.Estudio (Nombre) VALUES
('Radiografia'),
('Ecografia'),
('Analisis de Sangre'),
('Electrocardiograma'),
('Tomografia');


INSERT INTO CircuitoB.LugarDeAtencion (Nombre, Estudio_id) VALUES
('Consultorio 1', 1),
('Sala de Rayos X', 2),
('Sala de Ecografia', 3),
('Laboratorio', 4),
('Sala de Cardiologia', 5);

INSERT INTO CircuitoB.TurnoStatus (Descripcion) VALUES
('Pendiente'),
('Confirmado'),
('Atendido'),
('Cancelado'),
('En Espera');

-- Table `Turno`

INSERT INTO CircuitoB.Turno (FechaHoraInicio, FechaHoraFin, LugarDeAtencion_id, LugarDeAtencion_Estudio_id, Paciente_id, Paciente_Cobertura_id, TurnoStatus_id) VALUES
('2024-05-07 10:00:00', '2024-05-07 10:30:00', 1, 1, 1, 1, 1),
('2024-05-08 11:00:00', '2024-05-08 11:30:00', 2, 2, 2, 2, 2),
('2024-05-09 12:00:00', '2024-05-09 12:30:00', 3, 3, 3, 3, 3),
('2024-05-10 13:00:00', '2024-05-10 13:30:00', 4, 4, 4, 4, 4),
('2024-05-11 14:00:00', '2024-05-11 14:30:00', 5, 5, 5, 5, 5);

-- Table `SalaDeEspera`

INSERT INTO CircuitoB.SalaDeEspera (FechaHoraAcreditacion, Turno_id, Turno_LugarDeAtencion_id, Turno_LugarDeAtencion_Estudio_id, Turno_TurnoStatus_id, Prioridad) VALUES
('2024-05-07 09:45:00', 1, 1, 1, 1, 1),
('2024-05-08 10:45:00', 2, 2, 2, 2, 2),
('2024-05-09 11:45:00', 3, 3, 3, 3, 3),
('2024-05-10 12:45:00', 4, 4, 4, 4, 4),
('2024-05-11 13:45:00', 5, 5, 5, 5, 5);


INSERT INTO CircuitoB.MetodoPago (Descripcion) VALUES
('Efectivo'),
('Tarjeta de Débito'),
('Tarjeta de Crédito'),
('Obra Social');

INSERT INTO CircuitoB.FacturaStatus (Descripcion) VALUES
('Pendiente'),
('En Proceso'),
('Pagada'),
('Anulada');

INSERT INTO CircuitoB.Factura (Turno_id, Turno_LugarDeAtencion_id, Turno_LugarDeAtencion_Estudio_id, Turno_TurnoStatus_id, Paciente_id, Paciente_Cobertura_id, Monto, MetodoPago_id, FacturaStatus_id) VALUES
(1, 1, 1, 1, 1, 1, 1000.00, 1, 1),
(2, 2, 2, 2, 2, 2, 800.00, 2, 2),
(3, 3, 3, 3, 3, 3, 600.00, 3, 3),
(4, 4, 4, 4, 4, 4, 400.00, 4, 3),
(5, 5, 5, 5, 5, 5, 200.00, 1, 2);

INSERT INTO CircuitoB.CoberturaEstudio (Cobertura_id, Estudio_id, Monto) VALUES
(1, 1, 500),
(1, 2, 300),
(1, 3, 200),
(1, 4, 100),
(1, 5, 0),
(2, 1, 400),
(2, 2, 250),
(2, 3, 150),
(2, 4, 50),
(2, 5, 0),
(3, 1, 300),
(3, 2, 200),
(3, 3, 100),
(3, 4, 0),
(3, 5, 0),
(4, 1, 200),
(4, 2, 150),
(4, 3, 50),
(4, 4, 0),
(4, 5, 0),
(5, 1, 100),
(5, 2, 50),
(5, 3, 0),
(5, 4, 0),
(5, 5, 0);