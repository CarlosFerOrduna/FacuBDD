select country as PAIS, country_id as ID_DE_PAIS 
	from sakila.country;

SELECT *
	FROM sakila.country
	WHERE country NOT LIKE"%arg%";
    
SELECT *
	FROM sakila.country
    WHERE NOT ((country_id > 6) AND (country_id < 10));
    
select * 
	from sakila.film
    where title like "m%" and length > 80;
    
select *
	from sakila.film
    where rating is null;
    
    
select film_id, title
	from sakila.film
    where film_id = (round(rand()*10));
    
select title, film_id
	from sakila.film
		order by rand() limit 1;
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
    where film_id = (select floor((select min(film_id) from sakila.film) + (rand() * ((select max(film_id) from sakila.film) - (select min(film_id) from sakila.film)))));
    
    /*

    EJERCICIO 3:
    BASE SAKILA:
   
    Obtener el promedio (AVG) de los largos de de tiempo de los films (length) agrupados segun rating.
    El resultado debe arrojar el ranting y el resultado de los promedios.

*/

select round(avg(length)) as PromedioDeLargo
	from sakila.film
		-- where rating = 'G'
		group by rating
        having rating = 'G';


select * 
	from customer, payment
		where payment.payment_id between 600 and 700;
        
select p.payment_id as ID, p.amount as Monto, p.payment_date as Fecha
	from sakila.payment as p inner join sakila.staff as s
	on s.staff_id = p.staff_id
    where s.last_name = "stephens";
    
select f.title as Titulo
	from sakila.film as f inner join sakila.film_actor as fa
		on f.film_id = fa.film_id 
		inner join sakila.actor as a
		on fa.actor_id = a.actor_id
			where a.first_name = "WOODY" and a.last_name = "JOLIE";
    
select f.film_id as ID, f.title as Titulo, p.amount as Monto
	from sakila.film as f inner join sakila.inventory as i
		on f.film_id = i.film_id
		inner join sakila.rental as r 
		on i.inventory_id = r.inventory_id
		inner join sakila.payment as p
		on r.rental_id = p.rental_id
			where f.title = "ACADEMY DINOSAUR";
            
select co.country
	from sakila.staff as s inner join sakila.address as a
		on a.address_id = s.address_id
		inner join sakila.city as ci
		on a.city_id = ci.city_id
		inner join sakila.country as co
		on ci.country_id = co.country_id
			where s.username = "Jon";

