drop schema if exists `votacion`;

create schema if not exists `votacion` default character set utf8mb4;

use votacion;

drop table if exists `votacion`.`centro_votacion`;

create table if not exists `votacion`.`centro_votacion`
(
    `centro_id` smallint unsigned not null unique auto_increment,
    `nombre`    varchar(50)       not null unique,
    `direccion` varchar(50)       not null unique,
    `localidad` varchar(20)       not null unique,
    `provincia` varchar(20)       not null,

    primary key (`centro_id`),
    unique index `idx_centro_nombre` (`nombre` asc),
    unique index `idx_centro_direccion` (`direccion` asc)
);

drop table if exists `votacion`.`candidato`;

create table if not exists `votacion`.`candidato`
(
    `candidato_id` smallint unsigned not null unique auto_increment,
    `nombre`       varchar(20)       not null,
    `apellido`     varchar(20)       not null,
    `partido`      varchar(30)       not null,
    `tipo`         varchar(20),

    primary key (`candidato_id`)
);

drop table if exists `votacion`.`mesa`;

create table if not exists `votacion`.`mesa`
(
    `mesa_id`   smallint unsigned not null unique auto_increment,
    `numero`    smallint unsigned not null,
    `centro_id` smallint unsigned not null unique,

    primary key (`mesa_id`),
    foreign key (`centro_id`) references `votacion`.`centro_votacion` (`centro_id`),
    unique index `fk_mesa_centro` (`centro_id` asc),
    unique index `idx_mesa_numero` (`numero` asc)
);

drop table if exists `votacion`.`voto`;

create table if not exists `votacion`.`voto`
(
    `voto_id`      int unsigned      not null unique auto_increment,
    `cantidad`     int unsigned      not null,
    `mesa_id`      smallint unsigned not null unique,
    `candidato_id` smallint unsigned not null unique,

    primary key (`voto_id`),
    foreign key (`mesa_id`) references `votacion`.`mesa` (`mesa_id`),
    unique index `fk_voto_mesa` (`mesa_id` asc),
    foreign key (`candidato_id`) references `votacion`.`candidato` (`candidato_id`),
    unique index `fk_voto_candidato` (`candidato_id`)
);

drop table if exists `votacion`.`personal_de_mesa`;

create table if not exists `votacion`.`personal_de_mesa`
(
    `personal_id` mediumint unsigned                                  not null unique auto_increment,
    `tipo`        enum ('autoridad_de_mesa', 'auxiliar_de_autoridad') not null,
    `nombre`      varchar(20)                                         not null,
    `apellido`    varchar(20)                                         not null,
    `dni`         varchar(20)                                         not null unique,
    `mesa_id`     smallint unsigned                                   not null,

    primary key (`personal_id`),
    foreign key (`mesa_id`) references `votacion`.`mesa` (`mesa_id`),
    unique index `fk_personal_mesa` (`mesa_id` asc),
    unique index `idx_personal_dni` (`dni`)
);

drop table if exists `votacion`.`padron`;

create table if not exists `votacion`.`padron`
(
    `padron_id` int unsigned      not null unique auto_increment,
    `nombre`    varchar(20)       not null,
    `apellido`  varchar(20)       not null,
    `dni`       varchar(20)       not null unique,
    `direccion` varchar(50)       not null,
    `localidad` varchar(20)       not null,
    `mesa_id`   smallint unsigned not null,

    primary key (padron_id),
    foreign key (`mesa_id`) references `votacion`.`mesa` (`mesa_id`),
    unique index `fk_padron_mesa` (`mesa_id`),
    unique index `idx_padron_dni` (`dni`)
);