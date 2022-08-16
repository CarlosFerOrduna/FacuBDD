/*

Ejercicio TEORICO 1:

Explique cual es la diferencia entre un INNER JOIN y un LEFT JOIN con sus palabras.

*/

/*

 Cuando usamos un inner join vamos a recibir la información en la cual se fucionen ambas tablas.
 En cambio al usar un left join vamos a recibir la informacion en la que las tablas se fusionan y
 ademas toda la información de la tabla perteneciente a la key que pongamos en la izquierda de la
 union dentro del script.

 */

/*

Ejercicio TEORICO 2:

Cual es el funcionamiento de la clausula UNION y cuales condiciones se deben cumplir para poder ejecutarla?

*/

/*

 El operador UNION se usa para combinar los resultados de dos o mas consultas SELECT. Estas consultas deben
 tener la misma cantidad de columnas, y las columnas deben tener un orden similar y mismos tipo de datos.

 */

/*

Ejercicio PRACTICO 1:

BASE SAKILA:

Se desea INSERTAR un nuevo FILM en un lenguaje nuevo llamado "Esperanto".
Utilizar un nombre de Film real y datos los mas reales posibles.

Realizar la asociación de al menos 3 actores al nuevo film.

Dentro de lo posible ordenar la ejecución de tal manera que se ejecute el script sin interrupciones o fallas.

*/

insert into sakila.language(name, last_update)
    VALUE ('Esperanto',
           now());

insert into sakila.film(title, language_id, original_language_id)
    VALUE ('Una nueva esperanza',
           (select max(language_id) from language),
           (select max(language_id) from language));

insert into film_actor(actor_id, film_id)
values ((select max(actor_id) from actor),
        (select max(film_id) from film));

insert into film_actor(actor_id, film_id)
values (((select max(actor_id) from actor) - 1),
        (select max(film_id) from film));

insert into film_actor(actor_id, film_id)
values (((select max(actor_id) from actor) - 2),
        (select max(film_id) from film));

/*

Ejercicio PRACTICO 2:

BASE SAKILA:

Eliminar los alquileres relacionados a un FILM de ID que sea 15 veces menos el ID máximo de la tabla.

Eliminar todos los registros relacionados en las tablas que correspondan.

Dentro de lo posible ordenar la ejecución de tal manera que se ejecute el script sin interrupciones o fallas.

*/


delete r, p
from payment as p
         inner join rental as r on p.rental_id = r.rental_id
         inner join inventory as i on r.inventory_id = i.inventory_id
         inner join film as f on i.film_id = f.film_id
where f.film_id = ((select max(film.film_id) from film) / 15);

select *
from rental;

select rental_id
from rental as r
         inner join film as f on r.last_update = f.last_update
         inner join inventory as i on r.inventory_id = i.inventory_id
where f.film_id = (1005/15);