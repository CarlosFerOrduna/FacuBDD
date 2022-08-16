/*

    Ejercicio TEORICO 1:
    Defina en sus propias palabras que implica que un campo sea UNIQUE, NOT NULL y que tenga completado una DefaultExpression generada por una funcion.
    
	Respuesta:
    Cuando un campo es UNIQUE se rfiere a que tiene un identificador único.
    Un campo NOT NULL refiere a que esa columna no acepta valores Nulos.
	Cuando un campo tiene un DefaultExpression lo que sucede es que si no se proporciona valor al realizar un insert, el mismo se asigna un valor por defeecto.
    
    Entonces, un campo UNIQUE, NOT NULL y con DefaultExpression es aquel que tiene un identificador único (sin duplicados), no se acepta que contenga valores nulos
    y sino se le proporciona información luego del insert, se le asigna un valor por defecto.

*/


/*

    Ejercicio TEORICO 2:
    Expique el funcionamiento de un indice sobre un campo numerico y cual es su utilidad.
    
	Respuesta:
    Los índices se utilizan para apuntar a la ubicación de un registro determinado en una tabla. Usando un índice, al buscar un registro por un campo indexado 
    se hace de manera rápida y eficaz.
  */


/*

    Ejercicio PRACTICO 1:

    Esquema: ADJUNTO en formato MDJ y JPG para una universidad donde ya esta aplicado las normalizaciones en 1FN, 2FN y 3FN.
    Realice la verificacion de las condiciones que debe tener a nivel tipado de datos y elija la mejor segun su criterio fundamentándolo
    Deje en claro que relacion esta planteada entre las entidades.
    Condicion minima: 5 entidades tipadas.
    Condicion esperada: Mas de 5 entidades tipadas e implementacion usando ALTER.
    
    Respuesta:
    Ver Adjunto.

*/

/*

    Ejercicio PRACTICO 2:
    Esquema: RESULTANTE de PRACTICO 1.
   
    Cree el script de creacion de la BBDD resultante del exquema de datos del PRACTICO 1
    respetando los nombres de los campos, los tipos y planteando las relaciones PK-FK que resultan del exquema mencionado asi como todas las restricciones implicadas.
    Condicion minima: Script sin que impacte en una sola ejecucion.
    Condicion esperada: Implementacion en una sola ejecucion usando ALTER.

*/

drop schema `aerolineas`;

CREATE SCHEMA `aerolineas` DEFAULT CHARACTER SET utf8mb4;

CREATE TABLE `aerolineas`.`aeropuerto`
(
    `id_aeropuerto` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `id_aerolinea`  SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (`id_aeropuerto`)
);

CREATE TABLE `aerolineas`.`aerolinea`
(
    `id_aerolinea` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id_aerolinea`)
);

CREATE TABLE `aerolineas`.`vuelo`
(
    `id_vuelo` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id_vuelo`)
);

CREATE TABLE `aerolineas`.`pasaje`
(
    `id_pasaje` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id_pasaje`)
);

CREATE TABLE `aerolineas`.`persona`
(
    `id_persona` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id_persona`)
);

CREATE TABLE `aerolineas`.`direccion`
(
    `id_direccion` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (`id_direccion`)
);

ALTER TABLE `aerolineas`.`aeropuerto`
    ADD COLUMN `nombre`    VARCHAR(60) NOT NULL,
    ADD COLUMN `ubicacion` DECIMAL     NOT NULL,
    ADD CONSTRAINT `id_aerolinea` FOREIGN KEY (`id_aerolinea`) REFERENCES `aerolineas`.`aerolinea` (`id_aerolinea`);

ALTER TABLE `aerolineas`.`aerolinea`
    ADD COLUMN `nombre` VARCHAR(60) NOT NULL,
    ADD CONSTRAINT `id_vuelo` FOREIGN KEY (`id_vuelo`) REFERENCES `aerolineas`.`vuelo` (`id_vuelo`),
    ADD CONSTRAINT `id_persona` FOREIGN KEY (`id_persona`) REFERENCES `aerolineas`.`persona` (`id_persona`),
    ADD CONSTRAINT `id_persona_piloto` FOREIGN KEY (`id_persona_piloto`) REFERENCES `aerolineas`.`persona` (`id_persona_piloto`),
    ADD CONSTRAINT `id_persona_auxiliar_de_vuelo` FOREIGN KEY (`id_persona_auxiliar_de_vuelo`) REFERENCES `aerolineas`.`persona` (`id_persona_auxiliar_de_vuelo`),
    ADD CONSTRAINT `id_persona_copiloto` FOREIGN KEY (`id_persona_copiloto`) REFERENCES `aerolineas`.`persona` (`id_persona_copiloto`);

ALTER TABLE `aerolineas`.`vuelo`
    ADD COLUMN `tipo_de_vuelo` VARCHAR(30) NOT NULL,
    ADD CONSTRAINT `id_pasaje` FOREIGN KEY (`id_pasaje`) REFERENCES `aerolineas`.`pasaje` (`id_pasaje`);

ALTER TABLE `aerolineas`.`pasaje`
    ADD COLUMN `duracion` TIME             NOT NULL,
    ADD COLUMN `destino`  VARCHAR(60)      NOT NULL,
    ADD COLUMN `precio`   DECIMAL UNSIGNED NOT NULL,
    ADD COLUMN `asiento`  VARCHAR(10)      NOT NULL;

ALTER TABLE `aerolineas`.`persona`
    ADD COLUMN `nombre`        VARCHAR(30) NOT NULL,
    ADD COLUMN `apellido`      VARCHAR(30) NOT NULL,
    ADD COLUMN `fecha_de_nac`  DATE        NOT NULL,
    ADD COLUMN `es_empleado`   BOOL        NOT NULL,
    ADD COLUMN `emp_sueldo`    FLOAT,
    ADD COLUMN `emp_categoria` VARCHAR(30),
    ADD COLUMN `es_cliente`    BOOL        NOT NULL,
    ADD COLUMN `cli_categoria` VARCHAR(30),
    ADD CONSTRAINT `id_direccion` FOREIGN KEY (`id_direccion`) REFERENCES `aerolineas`.`direccion` (`id_direccion`);

ALTER TABLE `aerolineas`.`direccion`
    ADD COLUMN `altura`    SMALLINT UNSIGNED,
    ADD COLUMN `calle`     VARCHAR(30),
    ADD COLUMN `localidad` VARCHAR(30);