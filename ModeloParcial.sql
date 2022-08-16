/*

    Ejercicio TEORICO 1:

    Defina en sus propias palabras que implican las restricciones en SQL.

*/

/*
    Las restricciones en sql se utilizan para especificar reglas para los datos de una tabla. Las mismas
    se utilizan para especificar los tipos de datos que puede incluir una tabla. Esto asegura la precicion
    y confiabilidad de los datos. De haber alguna violacion entre la restriccion y una accion de datos
    la accion se aborta.
*/

/*

    Ejercicio TEORICO 2:

    Indique cual es la diferencia entre FLOAT y DOUBLE y que tienen en común entre los subtipos.

*/

/*
    La relacion entre float y double es que ambos son datos numericos con puntos flotantes sin embargo un
    dato double puede guardar mayor cantidad de decimales, lo que nos brinda una mayor precicion.

 */

/*

    Ejercicio PRACTICO 1:

    Esquema: ADJUNTO en formato MDJ y/o JPG para una universidad donde ya esta aplicado las normalizaciones en 1FN, 2FN y 3FN.

    Realice la verificación de las condiciones que debe tener a nivel tipado de datos y elija la mejor según su criterio fundamentándolo
    Deje en claro que relacion esta planteada entre las entidades conservando el criterio de convergencia entre los campos relacionados.

*/

/*

 */

/*

    Ejercicio PRACTICO 2:

    Esquema: RESULTANTE de PRACTICO 1.

    Cree el script de creación de la BBDD resultante del exquema de datos del PRACTICO 1
    respetando los nombres de los campos, los tipos y planteando las relaciones PK-FK que resultan del exquema mencionado así como todas
    las restricciones implicadas.

*/

drop schema if exists `universidad`;

create schema if not exists `universidad` default character set utf8mb4;

use `universidad`;

drop table if exists `universidad`.`sede`;

create table if not exists `universidad`.`sede`
(
	`sede_id`   smallint    unsigned not null unique auto_increment primary key,
    `direccion` varchar(50)          not null unique,
    `localidad` varchar(20)          not null unique,

    unique index `direccion_unique` (`direccion` asc)
);

drop table if exists `universidad`.`carrera`;

create table if not exists `universidad`.`carrera`
(
	`carrera_id` smallint     unsigned not null unique auto_increment primary key,
    `sede_id`    smallint     unsigned not null unique,
    `nombre`     varchar(50)               not null unique,

    foreign key (`sede_id`) references `universidad`.`sede`(`sede_id`),
    unique index `nombre_unique` (`nombre`)
);

drop table if exists `universidad`.`aula`;

create table if not exists `universidad`.`aula`
(
	`aula_id` tinyint  unsigned not null unique auto_increment primary key,
    `sede_id` smallint unsigned not null unique,
    `piso`    tinyint           not null,

    foreign key (`sede_id`) references `universidad`.`sede`(`sede_id`)
);

drop table if exists `universidad`.`materia`;

create table if not exists `universidad`.`materia`
(
	`materia_id` smallint unsigned   not null unique auto_increment primary key,
    `carrera_id` smallint unsigned   not null unique,
    `nombre`     varchar(50)         not null,
    `horario`    varchar(8)          not null,
    `turno`      enum('m', 't', 'n') not null,
    `anio`       varchar(4)          not null,
    `cuatrimestre` varchar(10),

	foreign key (carrera_id) references `universidad`.`carrera` (carrera_id),
    unique index `materia_unique` (`nombre`)
);

drop table if exists `universidad`.`texto`;

create table if not exists `universidad`.`texto`
(
	`texto_id`       mediumint unsigned not null unique auto_increment,
    `materia_id`     smallint  unsigned not null unique,
    `cantidad_hojas` tinyint            not null,
    `nombre`         varchar(50)        not null,
    `autor`          varchar(50)        not null,
    `editorial`      varchar(50)        not null,

    foreign key (`materia_id`) references `universidad`.`materia`(`materia_id`),
    unique index `texto_unique` (`nombre`)
);

drop table if exists `universidad`.`informacion_personal`;

create table if not exists `universidad`. `informacion_personal`
(
	`info_personal_id`       mediumint unsigned not null auto_increment primary key,
    `info_personal_nombre`   varchar(50)        not null,
    `info_personal_apellido` varchar(50)        not null,
    `info_personal_dni`      varchar(20),

    unique index `info_personal_unique` (`info_personal_dni`)
);

drop table if exists `universidad`.`profesor`;

create table if not exists `universidad`.`profesor`
(
	`profesor_id`      smallint  unsigned not null auto_increment primary key,
    `info_personal_id` mediumint unsigned not null,

    foreign key (`info_personal_id`) references `universidad`.`informacion_personal`(`info_personal_id`)
);

drop table if exists `universidad`.`alumno`;

create table if not exists `universidad`.`alumno`
(
	`alumno_id`        smallint  unsigned not null auto_increment primary key,
    `info_personal_id` mediumint unsigned not null,

    foreign key (`info_personal_id`) references `universidad`.`informacion_personal`(`info_personal_id`)
);

drop table if exists `universidad`.`curso`;

create table if not exists `universidad`.`curso`
(
	`curso_id`    mediumint unsigned not null auto_increment primary key,
    `materia_id`  smallint  unsigned not null,
    `aula_id`     tinyint   unsigned not null,
    `profesor_id` smallint  unsigned not null,
    `alumno_id`   smallint  unsigned not null,

    foreign key (`materia_id`) references `universidad`.`materia`(`materia_id`),
    foreign key (`aula_id`) references `universidad`.`aula`(`aula_id`),
    foreign key (`profesor_id`) references `universidad`.`profesor`(`profesor_id`),
    foreign key (`alumno_id`) references `universidad`.`alumno`(`alumno_id`)
);