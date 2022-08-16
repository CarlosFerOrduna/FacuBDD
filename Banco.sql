drop schema if exists `banco`;

create schema `banco` default character set utf8mb4;

use `banco`;

drop table if exists `banco`.`sucursal`;

create table if not exists `banco`.`sucursal`
(
    `sucursal_id`          mediumint unsigned not null unique auto_increment,
    `nombre`               varchar(50)        not null,
    `capacidad_maxima_per` tinyint            not null,
    `capacidad_de_cajas`   tinyint            not null,
    `persona_id_gerente`   mediumint unsigned not null unique,
    `persona_id_tesorero`  mediumint unsigned not null unique,
    `persona_id_jefeop`    mediumint unsigned not null unique,
    primary key (`sucursal_id`),
    unique index `nombre_unique` (`nombre` asc)
);

drop table if exists `banco`.`cuenta`;

create table if not exists `banco`.`cuenta`
(
    `cuenta_id`           mediumint unsigned not null unique auto_increment,
    `tipo`                enum ('CA', 'CC')  not null,
    `persona_id` mediumint unsigned not null unique,
    `sucursal_id`         mediumint unsigned not null unique,
    `saldo`               double(30, 20)     not null default 0,
    `cbu`                 varchar(44)        not null unique,
    `alias`               varchar(40)        not null unique,
    `moneda_id`           smallint unsigned  not null unique,
    primary key (`cuenta_id`),
    unique index `alias_unique` (`alias` asc),
    unique index `cbu_unique` (`cbu` asc)
);

drop table if exists `banco`.`moneda`;

create table if not exists `banco`.`moneda`
(
    `moneda_id`          smallint unsigned not null unique auto_increment,
    `descripcion_moneda` varchar(50)       not null unique,
    `pais_id`            smallint unsigned not null unique,
    primary key (`moneda_id`),
    unique index `descripcion_unique` (`descripcion_moneda` asc)
);

drop table if exists `banco`.`pais`;

create table if not exists `banco`.`pais`
(
    `pais_id` smallint unsigned not null unique auto_increment,
    `nombre`  varchar(50)       not null unique,
    primary key (`pais_id`),
    unique index `nombre_unique` (`nombre` asc)
);

drop table if exists `banco`.`caja`;

create table if not exists `banco`.`caja`
(
    `caja_id`      smallint unsigned  not null unique auto_increment,
    persona_id_emp   mediumint unsigned not null unique,
    `sucursal_id`  mediumint unsigned not null unique,
    `balance_caja` double(30, 20)     not null,
    primary key (`caja_id`)
);

drop table if exists `banco`.`persona`;

create table if not exists `banco`.`persona`
(
    `persona_id`       mediumint unsigned not null unique auto_increment,
    `nombre`           varchar(50)        not null,
    `apellido`         varchar(50)        not null,
    `fecha_nacimiento` date               not null,
    `direccion_id`     bigint unsigned    not null unique,
    `es_empleado`      boolean            not null,
    `emp_sucursal`     mediumint unsigned not null unique,
    `emp_puesto`       varchar(20)        not null,
    `es_cliente`       boolean            not null,
    `cli_sucursal`     mediumint unsigned not null unique,
    `cli_puesto`       varchar(20)        not null,
    primary key (`persona_id`)
);

drop table if exists `banco`.`direccion`;

create table if not exists `banco`.`direccion`
(
    `direccion_id` bigint unsigned not null unique auto_increment,
    `calle`        varchar(50)     not null,
    `altura`       smallint        not null,
    primary key (`direccion_id`)
);


alter table `banco`.`moneda`
    add index `idx_moneda_pais` (`pais_id` asc);

alter table `banco`.`moneda`
    add constraint `fk_moneda_pais`
        foreign key (`pais_id`)
            references `banco`.`pais` (`pais_id`)
            on delete no action
            on update no action;

alter table `banco`.`cuenta`
    add index `idx_cuenta_moneda` (`moneda_id` asc);

alter table `banco`.`cuenta`
    add constraint `fk_cuenta_moneda`
        foreign key (`moneda_id`)
            references `banco`.`moneda` (`moneda_id`)
            on delete no action
            on update no action;

alter table `banco`.`cuenta`
    add index `idx_cuenta_sucursal` (`sucursal_id` asc);

alter table `banco`.`cuenta`
    add constraint `fk_cuenta_sucursal`
        foreign key (`sucursal_id`)
            references `banco`.`sucursal` (`sucursal_id`)
            on delete no action
            on update no action;

alter table `banco`.`caja`
    add index `idx_caja_sucursal` (`sucursal_id` asc);

alter table `banco`.`caja`
    add constraint `fk_caja_sucursal`
        foreign key (`sucursal_id`)
            references `banco`.`sucursal` (`sucursal_id`)
            on delete no action
            on update no action;

alter table `banco`.`caja`
    add index `idx_caja_persona` (persona_id_emp asc);

alter table `banco`.`caja`
    add constraint `fk_caja_persona`
        foreign key (persona_id_emp)
            references `banco`.`persona` (`emp_sucursal`)
            on delete no action
            on update no action;

alter table `banco`.`sucursal`
    add index `idx_sucursal_persona` (`persona_id_gerente` asc);

alter table `banco`.`sucursal`
    add constraint `fk_sucursal_persona_gerente`
        foreign key (`persona_id_gerente`)
            references `banco`.`persona` (`persona_id`)
            on delete no action
            on update no action;

alter table `banco`.`sucursal`
    add index `idx_sucursal_persona_tesorero` (`persona_id_tesorero` asc);

alter table `banco`.`sucursal`
    add constraint `fk_sucursal_persona_tesorero`
        foreign key (`persona_id_tesorero`)
            references `banco`.`persona` (`persona_id`)
            on delete no action
            on update no action;

alter table `banco`.`sucursal`
    add index `idx_sucursal_persona_jefeop` (`persona_id_jefeop` asc);

alter table `banco`.`sucursal`
    add constraint `fk_sucursal_persona_jefeop`
        foreign key (`persona_id_jefeop`)
            references `banco`.`persona` (`persona_id`)
            on delete no action
            on update no action;

alter table `banco`.`persona`
    add index `idx_cliente_sucursal` (`cli_sucursal` asc);

alter table `banco`.`persona`
    add constraint `fk_cliente_sucursal`
        foreign key (`cli_sucursal`)
            references `banco`.`sucursal` (`sucursal_id`)
            on delete no action
            on update no action;

alter table `banco`.`persona`
    add index `idx_empleado_sucursal` (`emp_sucursal` asc);

alter table `banco`.`persona`
    add constraint `fk_empleado_sucursal`
        foreign key (`emp_sucursal`)
            references `banco`.`sucursal` (`sucursal_id`)
            on delete no action
            on update no action;

alter table `banco`.`cuenta`
    add index `idx_cuenta_persona` (`persona_id` asc);

alter table `banco`.`cuenta`
    add constraint `fk_cuenta_persona`
        foreign key (`persona_id`)
            references `banco`.`persona` (`persona_id`)
            on delete no action
            on update no action;

alter table `banco`.`persona`
    add index `idx_persona_direccion` (`direccion_id` asc);

alter table `banco`.`persona`
    add constraint `fk_persona_direccion`
        foreign key (`direccion_id`)
            references `banco`.`direccion` (`direccion_id`)
            on delete no action
            on update no action;
