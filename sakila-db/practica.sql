select country as PAIS, country_id as ID_DE_PAIS
from sakila.country;

SELECT *
FROM sakila.country
WHERE country NOT LIKE '%arg%';

SELECT *
FROM sakila.country
WHERE NOT ((country_id > 6) AND (country_id < 10));

select *
from sakila.film
where title like 'm%'
  and length > 80;

select *
from sakila.film
where rating is null;


select film_id, title
from sakila.film
where film_id = (round(rand() * 10));

select title, film_id
from sakila.film
order by rand()
limit 1;
/*

	EJERCICIO 1:

	Obtener las peliculas de la tabla FILM que si titulo empieze con M y que el largo de la pelicula sea mayo a 80.

*/
/*

	EJERCICIO 2: 
	
	Obtener el nombre de una pelicula en base a la funcion RND() sobre el campo film_id;

*/

select film_id, title
from sakila.film
where film_id = (select floor((select min(film_id) from sakila.film) + (rand() *
                                                                        ((select max(film_id) from sakila.film) -
                                                                         (select min(film_id) from sakila.film)))));

/*

EJERCICIO 3:
BASE SAKILA:

Obtener el promedio (AVG) de los largos de de tiempo de los films (length) agrupados segun rating.
El resultado debe arrojar el ranting y el resultado de los promedios.

*/

select round(avg(length)) as PromedioDeLargo
from sakila.film
where rating = 'G'
group by rating;
-- having rating = 'G';


select *
from sakila.customer,
     sakila.payment
where payment.payment_id between 600 and 700;

select p.payment_id as ID, p.amount as Monto, p.payment_date as Fecha
from sakila.payment as p
         inner join sakila.staff as s
                    on s.staff_id = p.staff_id
where s.last_name = 'stephens';


select f.title as Titulo
from sakila.film as f
         inner join sakila.film_actor as fa
                    on f.film_id = fa.film_id
         inner join sakila.actor as a
                    on fa.actor_id = a.actor_id
where a.first_name = 'WOODY'
  and a.last_name = 'JOLIE';


select f.film_id as ID, f.title as Titulo, p.amount as Monto
from sakila.film as f
         inner join sakila.inventory as i
                    on f.film_id = i.film_id
         inner join sakila.rental as r
                    on i.inventory_id = r.inventory_id
         inner join sakila.payment as p
                    on r.rental_id = p.rental_id
where f.title = 'ACADEMY DINOSAURfilm';


select co.country
from sakila.staff as s
         inner join sakila.address as a
                    on a.address_id = s.address_id
         inner join sakila.city as ci
                    on a.city_id = ci.city_id
         inner join sakila.country as co
                    on ci.country_id = co.country_id
where s.username = 'Jon';


select *
from sakila.customer;

select *
from sakila.store;

select *
from sakila.address;


insert into sakila.customer
    (first_name, last_name, email, store_id, address_id, create_date)
VALUES ('pepe', 'pepe', 'example@example.com', 1, 1, now());

delete sakila.customer
FROM sakila.customer
where first_name = 'pepe';

insert into sakila.customer
    (store_id, first_name, last_name, address_id, create_date)
values ((select customer.store_id, customer.first_name, customer.last_name, customer.address_id, customer.create_date
         from sakila.customer
         where (select max(customer.customer_id)
                from sakila.customer)));


/*

Ejercicio 8:

BASE: SAKILA.

Realizar un INSERT sobre las entidades film_actor, actor y film para insertar un nuevo actor y asociarlo a un film.

Insertar los datos mínimos en todos los casos y colocar los insert de manera tal que la ejecución de los mismos sea sin interrupciones.

*/


insert into sakila.actor(first_name, last_name, last_update)
VALUES ('Pepe', 'Pistola', now());
insert into sakila.film(title, language_id, rental_duration,
                        rental_rate, replacement_cost, rating, last_update)
VALUES ('El despertar de la fuerza', 1, 100, 4.9, 4.99, 'G', now());
insert into sakila.film_actor(actor_id, film_id)
VALUES ((select max(actor_id) from sakila.actor), (select max(film_id) from sakila.film));



select title
from sakila.film
where title like 'el%';

select first_name, last_name
from actor;

/*

Ejercicio 9:

BASE: SAKILA.

Realizar un INSERT sobre la base de datos de manera tal de insertar un alquiler y el pago asociado al mismo.

Insertar los datos mínimos en todos los casos y colocar los insert de manera tal que la ejecución de los mismos sea sin interrupciones.

Validar que entidades utilizar según el modelo ER asociado.

*/

insert into rental(rental_date, inventory_id, customer_id, staff_id)
VALUES (now(), 1, 1, 1);
insert into payment(customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, (select max(rental_id) from rental), 4.99, now());


select amount
from sakila.payment;

/*

Ejercicio 10:

BASE: SAKILA.

Realizar un UPDATE sobre las entidades film_actor, actor y film para modificar un dato a elección realizado en el ejercicio 8 sobre las entidades implicadas en los mismos.

Validar los cambios realizados con los SELECT que muestren el antes y el después de los cambios realizados.

*/

select title
from film
where title like 'el despertar%';

update actor, film_actor, film
set title      = 'La amenaza fantasma',
    first_name = 'Mark Hamill'
where title like 'el despertar%';

select title
from film
where title like 'la amenaza%';


/*

Ejercicio 11:

BASE: SAKILA.

Realizar una actualización sobre el pago y el alquiler realizado en el Ejercicio 9 sobre campos que impliquen relaciones FK-PK.

Verificar las entidades implicadas en el mencionado ejercicio.

*/

select max(rental_id)
from rental;

update sakila.rental, sakila.payment
set sakila.payment.rental_id = 16052,
    sakila.rental.rental_id  = 16052
where rental.rental_id = 16051;

select max(rental_id)
from rental;


/*

Ejercicio 12:

BASE: SAKILA.

Realizar una eliminación sobre el listado de alquileres cuando el nombre del cliente comience con la letra G.

Validar los cambios realizados con los SELECT que muestren el antes y el después de los cambios realizados.

*/

select *
from rental;

delete sakila.rental
from rental as r
         inner join customer as c on r.customer_id = c.customer_id
where first_name like 'g%';

select *
from rental r
         inner JOIN customer c on r.customer_id = c.customer_id
where first_name like 'g%';

/*

Ejercicio 13:

BASE: SAKILA.

Realizar una eliminación de los actores cuyo apellido comience con CH y quitar los registros sobre la entidades film_actor.

Validar los cambios realizados con los SELECT que muestren el antes y el después de los cambios realizados.

*/

set foreign_key_checks = 0;

delete fa, a
from actor a
         inner join film_actor fa
                    on fa.actor_id = a.actor_id
where last_name like 'd%';


set foreign_key_checks = 1;


select *
from sakila.actor a
         inner join film_actor fa on a.actor_id = fa.actor_id
where last_name like 'c%';

select actor_id
from actor
where last_name like '';

select *
from film_actor
where actor_id = 81;

/*

EJERCICIO 14:
BASE SAKILA:

Se desea eliminar un registro de cliente (CUSTOMER) e insertar uno nuevo con los mismos datos pero con distinto ID.
Se debe colocar el parámetro active en 0 y volver a relacionar los registros de las tablas donde estén implicado dicho
customer con el nuevo customer_id.


*/


select *
from customer
where first_name = 'MARY'
  AND LAST_NAME = 'SMITH';



insert into customer (store_id, first_name, last_name, email, active, address_id, create_date, last_update)
select store_id,
       first_name,
       last_name,
       email,
       0,
       address_id,
       create_date,
       last_update
from customer
where first_name = 'MARY'
  AND LAST_NAME = 'SMITH';

delete
from customer
where customer_id = 1;



update rental
set customer_id = (select max(customer_id) from customer)
where customer_id = (select customer_id
                     from customer
                     where first_name = 'MARY'
                       AND LAST_NAME = 'SMITH');

/*

EJERCICIO 15:
BASE SAKILA:

Actualizar todos los pagos (PAYMENT) que se cobraron para un rango de fechas particular (a discreción) para un empleado (STAFF)
de (staff_id = 2) a 50 en el monto de los pagos.

Dentro de lo posible ordenar la ejecución de tal manera que se ejecute el script sin interrupciones o fallas.


*/

select *
from payment
where payment_id between ((select max(payment_id) from payment) - 2) and (select max(payment_id) from payment);

update payment
set amount = 50
where staff_id = 2
  and payment_date between (select payment_date
                            from payment
                            where payment_id = (((select max(payment_id) from payment) - 2)))
    and (select payment_date
         from payment
         where payment_id = (select max(payment_id) from payment));

/*

EJERCICIO 16:
BASE WORLD:

Realizar la inserción de una ciudad (con los datos mínimos y a criterio) con los datos mínimos con un ID = 1000 (campo PK) y
luego eliminarlo.

En un segundo paso restablecer contador de AUTO INCREMENTO al numero siguiente al numero máximo que tenga ingresado en la tabla.

Verificar con un nuevo INSERT (luego de ello) que el cambio realizado se tomo correctamente y los nuevos INSERTS no fallan.

Dentro de lo posible ordenar la ejecución de tal manera que se ejecute el script sin interrupciones o fallas.


*/

insert into city (city_id, city, country_id)
values (1000, 'Rojas', (select country.country_id
                        from country
                        where country like 'arg%'));

delete city
from city
where city_id = 1002;

select *
from city;

alter table city
    auto_increment = 1;

insert into city (city, country_id)
values ('Pergamino', (select country.country_id
                      from country
                      where country like 'arg%'));


/*

Ejercicio TEORICO 17:

Indique las sentencias para restablecer un campo que es auto incremental.

*/

alter table city
    auto_increment = 1;

/*

Ejercicio TEORICO 18:

Indique en sus palabras que implica que un campo sea UNIQUE.
*/
alter table country
    add unique (country);



show create table address;


CREATE TABLE `address` (
  `address_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `address` varchar(50) NOT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `district` varchar(20) NOT NULL,
  `city_id` smallint(5) unsigned NOT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`address_id`),
  KEY `idx_fk_city_id` (`city_id`),
  CONSTRAINT `fk_address_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`city_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=utf8mb4
