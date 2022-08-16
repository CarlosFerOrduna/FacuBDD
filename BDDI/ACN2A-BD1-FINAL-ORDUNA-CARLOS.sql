-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ACN2A_G6
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `ACN2A_G6` ;

-- -----------------------------------------------------
-- Schema ACN2A_G6
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ACN2A_G6` DEFAULT CHARACTER SET utf8 ;
USE `ACN2A_G6` ;

-- -----------------------------------------------------
-- Table `profesor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `profesor` ;

CREATE TABLE IF NOT EXISTS `profesor` (
  `id_profesor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_profesor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso` ;

CREATE TABLE IF NOT EXISTS `curso` (
  `id_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `duracion` TIME NOT NULL,
  `id_profesor` INT NOT NULL,
  PRIMARY KEY (`id_curso`),
  CONSTRAINT `fk_curso_profesor1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `profesor` (`id_profesor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `material` ;

CREATE TABLE IF NOT EXISTS `material` (
  `id_material` INT NOT NULL,
  `herramienta` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_material`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `carrera` ;

CREATE TABLE IF NOT EXISTS `carrera` (
  `id_carrera` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_carrera`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seleccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seleccion` ;

CREATE TABLE IF NOT EXISTS `seleccion` (
  `id_seleccion` INT NOT NULL AUTO_INCREMENT,
  `id_carrera` INT NOT NULL,
  `id_curso` INT NOT NULL,
  `seleccion_col` VARCHAR(45) NULL,
  PRIMARY KEY (`id_seleccion`),
  CONSTRAINT `fk_seleccion_carrera1`
    FOREIGN KEY (`id_carrera`)
    REFERENCES `carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seleccion_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pais` ;

CREATE TABLE IF NOT EXISTS `pais` (
  `id_pais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ciudad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ciudad` ;

CREATE TABLE IF NOT EXISTS `ciudad` (
  `id_ciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_pais` INT NOT NULL,
  PRIMARY KEY (`id_ciudad`),
  CONSTRAINT `fk_ciudad_pais1`
    FOREIGN KEY (`id_pais`)
    REFERENCES `pais` (`id_pais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `direccion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `direccion` ;

CREATE TABLE IF NOT EXISTS `direccion` (
  `id_direccion` INT NOT NULL AUTO_INCREMENT,
  `nombre_calle` VARCHAR(45) NOT NULL,
  `altura` INT NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `piso` VARCHAR(45) NULL,
  `id_ciudad` INT NOT NULL,
  PRIMARY KEY (`id_direccion`),
  CONSTRAINT `fk_direccion_ciudad1`
    FOREIGN KEY (`id_ciudad`)
    REFERENCES `ciudad` (`id_ciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estudiante`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estudiante` ;

CREATE TABLE IF NOT EXISTS `estudiante` (
  `id_estudiante` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `edad` INT NOT NULL,
  `dni` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `telefono` INT NOT NULL,
  `id_direccion` INT NOT NULL,
  PRIMARY KEY (`id_estudiante`),
  CONSTRAINT `fk_estudiante_direccion1`
    FOREIGN KEY (`id_direccion`)
    REFERENCES `direccion` (`id_direccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estudiante_curso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estudiante_curso` ;

CREATE TABLE IF NOT EXISTS `estudiante_curso` (
  `id_estudiante_curso` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_estudiante` INT NOT NULL,
  PRIMARY KEY (`id_estudiante_curso`),
  CONSTRAINT `fk_estudiante_curso_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiante_curso_estudiante1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `estudiante_carrera`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `estudiante_carrera` ;

CREATE TABLE IF NOT EXISTS `estudiante_carrera` (
  `id_estudiante_carrera` INT NOT NULL AUTO_INCREMENT,
  `id_carrera` INT NOT NULL,
  `id_estudiante` INT NOT NULL,
  PRIMARY KEY (`id_estudiante_carrera`),
  CONSTRAINT `fk_estudiante_carrera_estudiante1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiante` (`id_estudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudiante_carrera_carrera1`
    FOREIGN KEY (`id_carrera`)
    REFERENCES `carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `avance`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `avance` ;

CREATE TABLE IF NOT EXISTS `avance` (
  `id_avance` INT NOT NULL AUTO_INCREMENT,
  `progreso` DECIMAL(5,2) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  `id_estudiante_carrera` INT NULL,
  `id_estudiante_curso` INT NULL,
  PRIMARY KEY (`id_avance`),
  CONSTRAINT `fk_avance_curso_estudiante_curso1`
    FOREIGN KEY (`id_estudiante_curso`)
    REFERENCES `estudiante_curso` (`id_estudiante_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avance_curso_estudiante_carrera1`
    FOREIGN KEY (`id_estudiante_carrera`)
    REFERENCES `estudiante_carrera` (`id_estudiante_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `idioma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `idioma` ;

CREATE TABLE IF NOT EXISTS `idioma` (
  `id_idioma` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_idioma`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso_idioma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso_idioma` ;

CREATE TABLE IF NOT EXISTS `curso_idioma` (
  `id_curso_idioma` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_idioma` INT NOT NULL,
  PRIMARY KEY (`id_curso_idioma`),
  CONSTRAINT `fk_curso_idioma_curso2`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_idioma_idioma2`
    FOREIGN KEY (`id_idioma`)
    REFERENCES `idioma` (`id_idioma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso_material`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso_material` ;

CREATE TABLE IF NOT EXISTS `curso_material` (
  `id_curso_material` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_material` INT NOT NULL,
  PRIMARY KEY (`id_curso_material`),
  CONSTRAINT `fk_curso_material_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_curso_material_material1`
    FOREIGN KEY (`id_material`)
    REFERENCES `material` (`id_material`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tema` ;

CREATE TABLE IF NOT EXISTS `tema` (
  `id_tema` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tema`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso_tema`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso_tema` ;

CREATE TABLE IF NOT EXISTS `curso_tema` (
  `id_curso_tema` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_tema` INT NOT NULL,
  PRIMARY KEY (`id_curso_tema`),
  CONSTRAINT `fk_tema_curso_curso2`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tema_curso_tema2`
    FOREIGN KEY (`id_tema`)
    REFERENCES `tema` (`id_tema`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nivel` ;

CREATE TABLE IF NOT EXISTS `nivel` (
  `id_nivel` INT NOT NULL AUTO_INCREMENT,
  `dificultad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_nivel`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso_nivel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso_nivel` ;

CREATE TABLE IF NOT EXISTS `curso_nivel` (
  `id_curso_nivel` INT NOT NULL AUTO_INCREMENT,
  `id_curso` INT NOT NULL,
  `id_nivel` INT NOT NULL,
  PRIMARY KEY (`id_curso_nivel`),
  CONSTRAINT `fk_nivel_curso_curso2`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nivel_curso_nivel2`
    FOREIGN KEY (`id_nivel`)
    REFERENCES `nivel` (`id_nivel`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `precio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `precio` ;

CREATE TABLE IF NOT EXISTS `precio` (
  `id_precio` INT NOT NULL AUTO_INCREMENT,
  `precio` DECIMAL(6,2) NOT NULL,
  `condiciones` VARCHAR(45) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `fecha_fin` DATE NULL,
  PRIMARY KEY (`id_precio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `carrera_precio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `carrera_precio` ;

CREATE TABLE IF NOT EXISTS `carrera_precio` (
  `id_carrera_precio` INT NOT NULL AUTO_INCREMENT,
  `id_carrera` INT NOT NULL,
  `id_precio` INT NOT NULL,
  PRIMARY KEY (`id_carrera_precio`),
  CONSTRAINT `fk_precio_carrera_carrera1`
    FOREIGN KEY (`id_carrera`)
    REFERENCES `carrera` (`id_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_precio_carrera_precio1`
    FOREIGN KEY (`id_precio`)
    REFERENCES `precio` (`id_precio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `curso_precio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `curso_precio` ;

CREATE TABLE IF NOT EXISTS `curso_precio` (
  `id_curso_precio` INT NOT NULL AUTO_INCREMENT,
  `id_precio` INT NOT NULL,
  `id_curso` INT NOT NULL,
  PRIMARY KEY (`id_curso_precio`),
  CONSTRAINT `fk_precio_curso_precio1`
    FOREIGN KEY (`id_precio`)
    REFERENCES `precio` (`id_precio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_precio_curso_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `valoracion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `valoracion` ;

CREATE TABLE IF NOT EXISTS `valoracion` (
  `id_valoracion` INT NOT NULL AUTO_INCREMENT,
  `valoracion` VARCHAR(45) NULL,
  `valoracion_profesor` VARCHAR(45) NULL,
  `id_estudiante_carrera` INT NULL,
  `id_estudiante_curso` INT NULL,
  PRIMARY KEY (`id_valoracion`),
  CONSTRAINT `fk_valoracion_estudiante_carrera1`
    FOREIGN KEY (`id_estudiante_carrera`)
    REFERENCES `estudiante_carrera` (`id_estudiante_carrera`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_valoracion_estudiante_curso1`
    FOREIGN KEY (`id_estudiante_curso`)
    REFERENCES `estudiante_curso` (`id_estudiante_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `profesor`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (1, 'Leandro', 'Cocchi');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (2, 'Hernan', 'Roldan');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (3, 'Pablo', 'Kuguel');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (4, 'Julio', 'Casares');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (5, 'Adrian', 'De Nicola');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (6, 'Astrid', 'Olivera');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (7, 'Juan', 'Miraglia');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (8, 'Adrian', 'Fenocci');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (9, 'Cristian', 'Manini');
INSERT INTO `profesor` (`id_profesor`, `nombre`, `apellido`) VALUES (10, 'Mailen', 'Alsina');

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (1, 'HTML y CSS desde cero', '10:50:00', 1);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (2, 'Bootstrap', '6:20:00', 2);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (3, 'Programacion PHP', '14:10:00', 2);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (4, 'Base de datos', '16:00:00', 3);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (5, 'Photoshop', '15:00:00', 5);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (6, 'Javascrip desde cero', '20:00:00', 7);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (7, 'Javascrip avanzado', '12:30:00', 7);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (8, 'Experiencia de usuario', '9:00:00', 4);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (9, 'Produccion multimedia', '8:00:00', 8);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (10, 'Excel de principiante a avanzado', '13:45:00', 9);
INSERT INTO `curso` (`id_curso`, `nombre`, `duracion`, `id_profesor`) VALUES (11, 'Acciones en la bolsa', '5:00:30', 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `material`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (1, 'Editor de texto');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (2, 'IDE');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (3, 'XAMPP');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (4, 'MySQL');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (5, 'Photoshop');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (6, 'Illustrator');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (7, 'Adobe XD');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (8, 'Excell');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (9, 'Git y Github');
INSERT INTO `material` (`id_material`, `herramienta`) VALUES (10, 'Firebase');

COMMIT;


-- -----------------------------------------------------
-- Data for table `carrera`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (1, 'Desarrollo full stack');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (2, 'Ciencia de datos');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (3, 'Desarrollo Frontend React');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (4, 'Desarrollador UX/UI');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (5, 'Desarrollo Frontend Angular');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (6, 'Desarrollo Frontend Vue');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (7, 'Dessarrollo de Aplicaciones');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (8, 'Desarrollo Backend');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (9, 'Marketing Digital');
INSERT INTO `carrera` (`id_carrera`, `nombre`) VALUES (10, 'Diseño UX Writing');

COMMIT;


-- -----------------------------------------------------
-- Data for table `seleccion`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (1, 1, 1, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (2, 1, 3, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (3, 1, 4, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (4, 2, 4, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (5, 3, 1, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (6, 3, 5, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (7, 4, 7, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (8, 5, 6, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (9, 6, 6, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (10, 7, 8, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (11, 8, 10, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (12, 9, 9, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (13, 10, 2, NULL);
INSERT INTO `seleccion` (`id_seleccion`, `id_carrera`, `id_curso`, `seleccion_col`) VALUES (14, 10, 7, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (1, 'Argentina');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (2, 'Colombia');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (3, 'Suiza');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (4, 'España');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (5, 'Mexico');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (6, 'Peru');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (7, 'Brazil');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (8, 'Alemania');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (9, 'Noruega');
INSERT INTO `pais` (`id_pais`, `nombre`) VALUES (10, 'China');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ciudad`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (1, 'Ciudad Evita', 1);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (2, 'Cali', 2);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (3, 'Lausanne', 3);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (4, 'Madrid', 4);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (5, 'Tijuana', 5);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (6, 'Lima', 6);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (7, 'Brasilia', 7);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (8, 'Berlin', 8);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (9, 'Oslo', 9);
INSERT INTO `ciudad` (`id_ciudad`, `nombre`, `id_pais`) VALUES (10, 'Pekin', 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `direccion`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (1, 'calle 802', 324, '1245', NULL, 1);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (2, 'carrera 101', 4531, '5732', '6', 2);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (3, 'calle falsa', 123, '4432', NULL, 3);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (4, 'el charrua', 472, '3221', '3', 1);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (5, 'Alfonsin', 2022, '5532', NULL, 4);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (6, 'siempre viva', 1111, '2013', '1', 6);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (7, 'calle 500', 900, '900', NULL, 6);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (8, '17 de marzo', 3001, '1200', NULL, 7);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (9, 'beruti', 4646, '674', '1', 5);
INSERT INTO `direccion` (`id_direccion`, `nombre_calle`, `altura`, `codigo_postal`, `piso`, `id_ciudad`) VALUES (10, 'maipu', 1758, '1604', '10', 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `estudiante`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (1, 'Nazareno', 'Nieva', 26, '12345678', 'naza@gmail.com', 112233456, 1);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (2, 'Melisa', 'Monje', 25, '12345679', 'meli@gmail.com', 112233457, 2);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (3, 'Kevin', 'Foster', 26, '12345680', 'kevin@gmail.com', 112233458, 3);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (4, 'Carlos', 'Orduna', 26, '12345532', 'carlos@gmail.com', 112453532, 4);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (5, 'Ezequiel', 'Nieva', 20, '11442214', 'ezequiel@gmail.com', 115532521, 1);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (6, 'Raul', 'Lopez', 18, '11738353', 'raul@gmail.com', 115553346, 5);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (7, 'Renzo', 'Mendez', 28, '13115124', 'renzo@gmail.com', 153352353, 6);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (8, 'Pedro', 'Mendez', 22, '13422512', 'pedro@gmail.com', 152334213, 6);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (9, 'Tito', 'Puentes', 17, '12444251', 'tito@gmail.com', 124442535, 7);
INSERT INTO `estudiante` (`id_estudiante`, `nombre`, `apellido`, `edad`, `dni`, `email`, `telefono`, `id_direccion`) VALUES (10, 'Rocky', 'Marciano', 30, '11049285', 'rocky@gmail.com', 112455353, 8);

COMMIT;


-- -----------------------------------------------------
-- Data for table `estudiante_curso`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (1, 1, 1);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (2, 3, 2);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (3, 1, 3);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (4, 4, 1);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (5, 4, 2);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (6, 4, 3);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (7, 5, 4);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (8, 6, 5);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (9, 7, 6);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (10, 8, 7);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (11, 9, 8);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (12, 10, 8);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (13, 7, 9);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (14, 5, 9);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (15, 4, 10);
INSERT INTO `estudiante_curso` (`id_estudiante_curso`, `id_curso`, `id_estudiante`) VALUES (16, 6, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `estudiante_carrera`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (1, 1, 1);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (2, 1, 2);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (3, 1, 3);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (4, 2, 1);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (5, 2, 2);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (6, 2, 3);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (7, 3, 4);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (8, 4, 5);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (9, 5, 6);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (10, 6, 7);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (11, 7, 8);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (12, 8, 9);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (13, 9, 10);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (14, 5, 6);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (15, 7, 10);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (16, 8, 9);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (17, 5, 8);
INSERT INTO `estudiante_carrera` (`id_estudiante_carrera`, `id_carrera`, `id_estudiante`) VALUES (18, 6, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `avance`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (1, 30, '2021-10-09', NULL, NULL, 1);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (2, 49, '2021-07-01', NULL, 1, NULL);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (3, 55.03, '2020-08-02', NULL, 3, NULL);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (4, 100.00, '2019-03-08', '2021-01-02', NULL, 5);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (5, 100.00, '2020-06-09', '2021-11-11', NULL, 2);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (6, 100.00, '2018-08-21', '2020-12-03', 2, NULL);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (7, 15, '2021-10-20', NULL, NULL, 3);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (8, 18.77, '2021-12-21', NULL, NULL, 4);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (9, 100.00, '2020-11-10', '2021-11-10', 4, NULL);
INSERT INTO `avance` (`id_avance`, `progreso`, `fecha_inicio`, `fecha_fin`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (10, 77.77, '2021-01-20', NULL, 5, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `idioma`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (1, 'Espeañol');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (2, 'Ingles');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (3, 'Chino');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (4, 'Portugues');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (5, 'Coreano');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (6, 'Frances');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (7, 'Suizo');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (8, 'Aleman');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (9, 'Noruego');
INSERT INTO `idioma` (`id_idioma`, `nombre`) VALUES (10, 'Bengali');

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso_idioma`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (1, 1, 1);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (2, 1, 2);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (3, 1, 3);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (4, 2, 1);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (5, 2, 2);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (6, 2, 3);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (7, 3, 1);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (8, 3, 2);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (9, 3, 3);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (10, 4, 1);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (11, 4, 2);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (12, 4, 3);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (13, 5, 4);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (14, 6, 5);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (15, 7, 6);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (16, 8, 7);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (17, 9, 8);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (18, 9, 9);
INSERT INTO `curso_idioma` (`id_curso_idioma`, `id_curso`, `id_idioma`) VALUES (19, 10, 10);

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso_material`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (1, 1, 1);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (2, 1, 2);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (3, 1, 3);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (4, 1, 4);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (5, 2, 1);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (6, 2, 2);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (7, 2, 3);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (8, 2, 4);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (9, 3, 1);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (10, 3, 2);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (11, 3, 3);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (12, 3, 4);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (13, 4, 1);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (14, 4, 2);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (15, 4, 3);
INSERT INTO `curso_material` (`id_curso_material`, `id_curso`, `id_material`) VALUES (16, 4, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `tema`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (1, 'Desarrollo web');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (2, 'Desarrollo backend');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (3, 'Ciencia de la informacion');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (4, 'Diseño UX/UI');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (5, 'Marketing Digital');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (6, 'Negocios');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (7, 'Finanzas y Contabilidad');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (8, 'Desarrollo Personal');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (9, 'Productividad en la Oficina');
INSERT INTO `tema` (`id_tema`, `nombre`) VALUES (10, 'Fotografia y video');

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso_tema`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (1, 1, 1);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (2, 1, 2);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (3, 1, 3);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (4, 2, 1);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (5, 2, 2);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (6, 2, 3);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (7, 3, 1);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (8, 3, 2);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (9, 3, 3);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (10, 4, 1);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (11, 4, 2);
INSERT INTO `curso_tema` (`id_curso_tema`, `id_curso`, `id_tema`) VALUES (12, 4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nivel`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `nivel` (`id_nivel`, `dificultad`) VALUES (1, 'Principiante');
INSERT INTO `nivel` (`id_nivel`, `dificultad`) VALUES (2, 'Medio');
INSERT INTO `nivel` (`id_nivel`, `dificultad`) VALUES (3, 'Avanzado');

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso_nivel`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (1, 1, 1);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (2, 1, 2);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (3, 1, 3);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (4, 2, 1);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (5, 2, 2);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (6, 2, 3);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (7, 3, 1);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (8, 3, 2);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (9, 3, 3);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (10, 4, 1);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (11, 4, 2);
INSERT INTO `curso_nivel` (`id_curso_nivel`, `id_curso`, `id_nivel`) VALUES (12, 4, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `precio`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (1, 20, 'Precio base', '2021-10-01', NULL);
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (2, 15, 'Promocion', '2021-10-01', NULL);
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (3, 50, 'Paquete', '2021-06-01', NULL);
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (4, 200, 'Inicio de clases', '2022-01-20', '2022-03-20');
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (5, 110, 'Vacaciones de verano', '2021-12-21', '2022-03-20');
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (6, 150, 'Vacaciones de invierno', '2022-06-21', '2022-08-20');
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (7, 80, 'Matricula', '2022-02-10', NULL);
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (8, 10, 'Black friday', '2021-11-10', '2021-12-10');
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (9, 60, 'Dia sin IVA', '2021-12-03', '2021-12-04');
INSERT INTO `precio` (`id_precio`, `precio`, `condiciones`, `fecha_inicio`, `fecha_fin`) VALUES (10, 188, 'Cyber week', '2021-11-10', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `carrera_precio`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (1, 1, 1);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (2, 1, 2);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (3, 1, 3);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (4, 2, 1);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (5, 2, 2);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (6, 2, 3);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (7, 3, 6);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (8, 4, 7);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (9, 5, 9);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (10, 6, 10);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (11, 7, 8);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (12, 8, 9);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (13, 9, 5);
INSERT INTO `carrera_precio` (`id_carrera_precio`, `id_carrera`, `id_precio`) VALUES (14, 10, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `curso_precio`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (1, 1, 1);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (2, 1, 2);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (3, 1, 3);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (4, 1, 4);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (5, 2, 1);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (6, 2, 2);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (7, 2, 3);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (8, 2, 4);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (9, 3, 1);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (10, 3, 2);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (11, 3, 3);
INSERT INTO `curso_precio` (`id_curso_precio`, `id_precio`, `id_curso`) VALUES (12, 3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `valoracion`
-- -----------------------------------------------------
START TRANSACTION;
USE `ACN2A_G6`;
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (1, 'bueno', 'medio', 1, NULL);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (2, 'malo', 'malo', 2, NULL);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (3, 'medio', 'malo', 3, NULL);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (4, 'medio', 'bueno', NULL, 3);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (5, 'malo', 'bueno', 4, NULL);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (6, 'bueno', 'medio', NULL, 5);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (7, 'malo', 'medio', 5, NULL);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (8, 'medio', 'malo', NULL, 1);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (9, 'bueno', 'medio', NULL, 2);
INSERT INTO `valoracion` (`id_valoracion`, `valoracion`, `valoracion_profesor`, `id_estudiante_carrera`, `id_estudiante_curso`) VALUES (10, 'bueno', 'bueno', NULL, 4);

COMMIT;

USE ACN2A_G6;

select * from estudiante;

select * from profesor order by nombre;

select * from precio where precio < 100;

select * from curso where duracion < '10:00:00' order by id_profesor;

select count(*) from idioma;

select count(*) from estudiante where edad < 25;

select * from ciudad 
inner join pais on ciudad.id_pais = pais.id_pais;

select * from curso
inner join curso_material on curso.id_curso = curso_material.id_curso
inner join material on curso_material.id_material = material.id_material;

select * from carrera
inner join seleccion on carrera.id_carrera = seleccion.id_carrera
inner join curso on seleccion.id_curso = curso.id_curso
where id_profesor = 7;

select count(*) from curso
inner join curso_idioma on curso.id_curso = curso_idioma.id_curso
inner join idioma on curso_idioma.id_idioma = idioma.id_idioma
where idioma.nombre = "Bengali";