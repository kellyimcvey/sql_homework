use sakila;

select first_name, last_name
from actor;

select * from actor;

select upper(concat(first_name, ' ', last_name)) as 'Actor Name'
from actor;

select actor_id, first_name, last_name
from actor
where first_name = "Joe";

select actor_id, first_name, last_name
from actor
where last_name like '%GEN';

select actor_id, last_name, first_name
from actor
where last_name like '%LI%';

select country_id, country
from country
where country IN
('Afghanistan', 'Bangladesh', 'China');

alter table actor
add column middle_name VARCHAR(20)
after first_name;

alter table actor
MODIFY column middle_name blob;

alter table actor
drop column middle_name;

select last_name, count(*) as 'Number of Actors'
from actor group by last_name;

SELECT last_name, COUNT(last_name) AS 'name_count'
FROM actor
GROUP BY last_name 
HAVING name_count >= 2;

update actor
set first_name = 'Harpo'
where first_name = "Groucho" and last_name = "Williams";


select * from actor;

update actor
set first_name = 'Groucho'
where actor_id = 172;

describe sakila.address;

select first_name, last_name, address
from staff s
inner join address a
on s.address_id = a.address_id;

select payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
from staff inner join payment on
staff.staff_id = payment.staff_id and payment_date like '2005-08%';

select f.title as 'film title', count(fa.actor_id) as 'Number of Actors'
from film_actor fa
inner join film f
on fa.film_id = f.film_id
group by f.title;

select title, (
select count(*) from inventory
where film.film_id = inventory.film_id
) as 'number of copies'
from film
where title = "Hunchback Impossible";

select c.first_name, c.last_name, sum(p.amount) as 'Total Paid'
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.last_name;

select title 
from film where title like 'K%' or title like 'Q%'
and title in 
(
select title
from film
where language_id = 1
);

select first_name, last_name
from actor
where actor_id in
(
select actor_id
from film_actor
where film_id in
(
select film_id
from film
where title = 'Alone Trip'
));

select country, last_name, first_name, email
from country c
left join customer cu
on c.country_id = cu.customer_id
where country = 'Canada';

select title, description from film
where film_id in
(
select film_id from film_category
where category_id in
(
select category_id from category
where name = "Family"
));

select f.title, count(rental_id) as 'Times Rented'
from rental r
inner join inventory i
on (r.inventory_id = i.inventory_id)
inner join film f
on (i.film_id = f.film_id)
group by f.title
order by 'Times Rented' DESC;

select s.store_id, sum(p.amount) 
from payment p
inner join staff s on (p.staff_id = s.staff_id)
group by store_id;

select s.store_id, city, country
from store s
inner join customer cu
on s.store_id = cu.store_id
inner join staff st
on s.store_id = st.store_id
inner join address a
on cu.address_id = a.address_id
inner join city ci
on a.city_id = ci.city_id
inner join country coun
on ci.country_id = coun.country_id;

SELECT name, SUM(p.amount) AS gross_revenue
FROM category c
INNER JOIN film_category fc ON fc.category_id = c.category_id
INNER JOIN inventory i ON i.film_id = fc.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
RIGHT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;



CREATE VIEW top_five_genres AS

SELECT name, SUM(p.amount) AS gross_revenue
FROM category c INNER JOIN film_category fc ON fc.category_id = c.category_id
INNER JOIN inventory i ON i.film_id = fc.film_id
INNER JOIN rental r ON r.inventory_id = i.inventory_id
RIGHT JOIN payment p ON p.rental_id = r.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;
  	
SELECT * FROM top_five_genres;

DROP VIEW top_five_genres;














































