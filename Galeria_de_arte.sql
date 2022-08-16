drop schema if exists `galeria`;

create schema if not exists `galeria` default character set utf8mb4;

use `galeria`;

drop table if exists `galeria`.`cliente`;

create table if not exists `galeria`.`cliente`
(
    `cliente_id` smallint unsigned not null unique auto_increment,
    `nombre`     varchar(20)       not null,
    `apellido`   varchar(20)       not null,
    `dni`        varchar(20)       not null unique,
    `direccion`  varchar(50)       not null,
    `localidad`  varchar(20)       not null,

    primary key (`cliente_id`),
    unique index `idx_cliente` (`dni` asc)
);

drop table if exists `galeria`.`galeria`;

create table if not exists `galeria`.`galeria`
(
    `galeria_id` smallint unsigned not null unique auto_increment,
    `nombre`     varchar(50)       not null unique,
    `direccion`  varchar(50)       not null unique,
    `localidad`  varchar(20)       not null,
    `provincia`  varchar(20)       not null,
    `pais`       varchar(20)       not null,

    primary key (`galeria_id`),
    unique index `idx_galeria_nombre` (`nombre` asc),
    unique index `idx_galeria_direccion` (`direccion` asc)
);

drop table if exists `galeria`.`autor`;

create table if not exists `galeria`.`autor`
(
    `autor_id`     smallint unsigned not null unique auto_increment,
    `nombre`       varchar(20)       not null,
    `apellido`     varchar(20)       not null,
    `nacionalidad` varchar(20),

    primary key (`autor_id`)
);

drop table if exists `galeria`.`subasta`;

create table if not exists `galeria`.`subasta`
(
    `subasta_id`    smallint unsigned      not null unique auto_increment,
    `dia`           date                   not null,
    `horario`       time                   not null,
    `precio_minimo` double(15, 2) unsigned not null,
    `galeria_id`    smallint unsigned      not null unique,

    primary key (`subasta_id`),
    foreign key (`galeria_id`) references `galeria`.`galeria` (`galeria_id`),
    unique index `idx_galeria_subasta` (`galeria_id` asc)
);

drop table if exists `galeria`.`obra`;

create table if not exists `galeria`.`obra`
(
    `obra_id`      smallint unsigned      not null unique auto_increment,
    `nombre`       varchar(50)            not null unique,
    `tecnica`      varchar(50)            not null,
    `dimension`    varchar(60)            not null,
    `importe_base` double(15, 2) unsigned not null,
    `subasta_id`   smallint unsigned      not null unique,
    `autor_id`     smallint unsigned      not null unique,

    primary key (`obra_id`),
    foreign key (`subasta_id`) references `galeria`.`subasta` (`subasta_id`),
    unique index `idx_obra_subasta` (`subasta_id`),
    foreign key (`autor_id`) references `galeria`.`autor` (`autor_id`),
    unique index `idx_obra_autor` (`autor_id`)
);

drop table if exists `galeria`.`compra`;

create table if not exists `galeria`.`compra`
(
    `compra_id`  smallint unsigned      not null unique auto_increment,
    `importe`    double(15, 2) unsigned not null,
    `subasta_id` smallint unsigned      not null unique,
    `cliente_id` smallint unsigned      not null unique,
    `obra_id`    smallint unsigned      not null unique,

    primary key (`compra_id`),
    foreign key (`subasta_id`) references `galeria`.`subasta` (`subasta_id`),
    unique index `idx_compra_subasta` (`subasta_id`),
    foreign key (`cliente_id`) references `galeria`.`cliente` (`cliente_id`),
    unique index `idx_compra_cliente` (`cliente_id`),
    foreign key (`obra_id`) references `galeria`.`obra` (`obra_id`),
    unique index `idx_compra_obra` (`obra_id`)
);
