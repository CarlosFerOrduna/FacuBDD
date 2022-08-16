/*

    Ejercicio TEORICO 1:

    Defina en sus propias palabras que realiza implica que un campo sea UNIQUE, NOT NULL y que tenga completado una DefaultExpression generada por una funcion.

*/

/*
    Cuando definimos el campo de una tabla como unique lo que estamos haciendo es decirle al campo que el dato que se ingrese no se puede repetir en ninguna de las
    siguiente inserciones de datos de esta table.
    Al definir un campo de una tabla como not null, lo que estamos haciendo es obligar a que este dato si o si lleve un dato, ya sea que venga de afuera o definiendo una defaultExpression
    la cual se asignara al dato en caso de que no se ingrese un dato desde afuera de la base de datos.
 */

/*

    Ejercicio TEORICO 2:

    Expique el funcionamiento de un indice sobre un campo numerico y cual es su utilidad.

*/

/*
    Al crear un indice sobre un campo de una tabla, lo que estamos haciendo es decirle a parte de la primary key o de la foreign key con que otro dato vamos a estar optimizando las
    consultas sql.
 */

/*

    Ejercicio PRACTICO 1:

    Esquema: ADJUNTO en formato MDJ y JPG para una universidad donde ya esta aplicado las normalizaciones en 1FN, 2FN y 3FN.

    Realize la verificacion de las condiciones que debe tener a nivel tipado de datos y elija la mejor segun su criterio fundamentandolo

    Deje en claro que relacion esta planteada entre las entidades.

    Condicion minima: 5 entidades tipadas.

    Condicion esperada: Mas de 5 entidades tipadas e implementacion usando ALTER.

*/

/*

    Ejercicio PRACTICO 2:

    Esquema: RESULTANTE de PRACTICO 1.

    Cree el script de creacion de la BBDD resultante del exquema de datos del PRACTICO 1
    respetando los nombres de los campos, los tipos y planteando las relaciones PK-FK que resultan del exquema mencionado asi como todas las restricciones implicadas.

    Condicion minima: Script sin que impacte en una sola ejecucion.

    Condicion esperada: Implementacion en una sola ejecucion usando ALTER.

*/


drop schema if exists `aerolinea`;

create schema if not exists `aerolinea` default character set utf8mb4;

use `aerolinea`;

drop table if exists `aerolinea`.`direccion`;

create table if not exists `aerolinea`.`direccion`
(
    `direccion_id` smallint unsigned not null unique auto_increment,
    `altura`       smallint unsigned not null,
    `calle`        varchar(60)       not null,
    `localidad`    varchar(50)       not null,

    primary key (`direccion_id`)
);

drop table if exists `aerolinea`.`pasaje`;

create table if not exists `aerolinea`.`pasaje`
(
    `pasaje_id` smallint unsigned     not null unique auto_increment,
    `duracion`  time                  not null,
    `destino`   varchar(60)           not null,
    `precio`    float(20, 2) unsigned not null,
    `asiento`   tinyint unsigned      not null,

    primary key (`pasaje_id`)
);

drop table if exists `aerolinea`.`vuelo`;

create table if not exists `aerolinea`.`vuelo`
(
    `vuelo_id`      smallint unsigned not null unique auto_increment,
    `pasaje_id`     smallint unsigned not null,
    `tipo_de_vuelo` enum ('primera', 'turista'),

    primary key (`vuelo_id`),

    foreign key (`pasaje_id`) references `aerolinea`.`pasaje` (`pasaje_id`),
    unique index `fk_vuelo_pasaje` (`pasaje_id` asc) visible
);

drop table if exists `aerolinea`.`persona`;

create table if not exists `aerolinea`.`persona`
(
    `persona_id`    smallint unsigned                                not null unique auto_increment,
    `direccion_id`  smallint unsigned                                not null,
    `nombre`        varchar(50)                                      not null,
    `apellido`      varchar(50)                                      not null,
    `fecha_de_nac`  date                                             not null,
    `es_empleado`   boolean                                          not null,
    `emp_sueldo`    float(20, 2) unsigned                            not null,
    `emp_categoria` enum ('fuera_de_convenio', 'dentro_de_convenio') not null,
    `es_cliente`    boolean                                          not null,
    `cli_categoria` enum ('primera', 'turista')                      not null,

    primary key (`persona_id`),

    foreign key (`direccion_id`) references `aerolinea`.`direccion` (`direccion_id`),
    index `fk_persona_direccion` (`direccion_id` asc) visible
);

drop table if exists `aerolinea`.`aerolinea`;

create table if not exists `aerolinea`.`aerolinea`
(
    `aerolinea_id`                 smallint unsigned not null unique auto_increment,
    `vuelo_id`                     smallint unsigned not null,
    `persona_cli_id`               smallint unsigned not null,
    `persona_piloto_id`            smallint unsigned not null,
    `persona_auxiliar_de_vuelo_id` smallint unsigned not null,
    `persona_copiloto_id`          smallint unsigned not null,
    `nombre`                       varchar(60)       not null unique,

    primary key (`aerolinea_id`),

    foreign key (`vuelo_id`) references `aerolinea`.`vuelo` (`vuelo_id`),
    unique index `fk_aerolinea_vuelo` (`vuelo_id` asc) visible,

    foreign key (`persona_cli_id`) references `aerolinea`.`persona` (`persona_id`),
    unique index `fk_aerolinea_persona_cliente` (`persona_cli_id` asc) visible,

    foreign key (`persona_piloto_id`) references `aerolinea`.`persona` (`persona_id`),
    unique index `fk_aerolinea_persona_piloto` (`persona_piloto_id` asc) visible,

    foreign key (`persona_auxiliar_de_vuelo_id`) references `aerolinea`.`persona` (`persona_id`),
    unique index `fk_aerolinea_auxiliar_de_viaje` (`persona_auxiliar_de_vuelo_id` asc) visible,

    foreign key (`persona_copiloto_id`) references `aerolinea`.`persona` (`persona_id`),
    unique index `fk_aerolinea_copiloto` (`persona_copiloto_id` asc) visible,

    unique index `idx_aerolinea_unique` (`nombre` asc) visible
);


drop table if exists `aerolinea`.`aeropuerto`;

create table if not exists `aerolinea`.`aeropuerto`
(
    `aeropuerto_id` smallint unsigned not null unique auto_increment,
    `aerolinea_id`  smallint unsigned not null,
    `nombre`        varchar(60)       not null unique,
    `ubicacion`     varchar(60)       not null unique,

    primary key (`aeropuerto_id`),

    foreign key (`aerolinea_id`) references `aerolinea`.`aerolinea` (`aerolinea_id`),
    index `fk_aeropuerto_aerolinea` (`aerolinea_id` asc) visible,

    unique index `idx_aeropuerto_nombre_unique` (`nombre` asc) visible
);

alter table `aerolinea`.`aeropuerto`
    add index `idx_aeropuerto_direccion_unique` (`ubicacion` asc) visible;