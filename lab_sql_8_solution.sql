use sakila;

-- Write a query to display for each store its store ID, city, and country
select sto.store_id, city, country
from store sto
join address ad
on sto.address_id = ad.address_id
join city ci
on ad.city_id = ci.city_id
join country co
on ci.country_id = co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.
select sta.store_id, concat('$ ', sum(pa.amount)) as sales
from staff sta
join payment pa 
on pa.staff_id = sta.staff_id
group by sta.store_id;

-- Which film categories are longest?
select ca.name, sum(f.length) as total_length
from category ca
join film_category fc
on ca.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
group by ca.name
order by total_length DESC
limit 1;

-- Display the most frequently rented movies in descending order.
select f.title, count(rental_id) as rental_count
from rental r
join inventory i 
on r.inventory_id = i.inventory_id
join film f
on i.film_id = f.film_id
group by f.title
having rental_count > 20
order by rental_count desc;

-- List the top five genres in gross revenue in descending order.
select ca.name as genre, sum(pa.amount) as gross_revenue
from category ca
join film_category fc on ca.category_id = fc.category_id
join inventory i on fc.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment pa on r.rental_id = pa.rental_id
group by genre
order by gross_revenue DESC
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
select f.title, i.store_id, count(f.film_id) as available_number
from film f
join inventory i on f.film_id = i.film_id
where title like '%Academy Dinosaur%' and store_id =1
group by i.film_id;

-- Get all pairs of actors that worked together.
SELECT CONCAT(a1.first_name, ' ', a1.last_name) AS actor1, CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM film_actor fa1
INNER JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
INNER JOIN actor a1 ON fa1.actor_id = a1.actor_id
INNER JOIN actor a2 ON fa2.actor_id = a2.actor_id;
