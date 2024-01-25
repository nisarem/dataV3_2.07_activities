-- Lab | SQL Join (Part I)
-- In this lab, you will be using the Sakila database of movie rentals.
USE sakila;
-- 1. How many films are there for each of the categories in the category table. 
-- Use appropriate join to write this query.
SELECT * FROM category;
SELECT * FROM film_category;

SELECT c.name, COUNT(f.film_id) AS nb_of_films
FROM sakila.film_category f
JOIN sakila.category c USING (category_id)
GROUP BY c.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT concat(s.first_name,' ',s.last_name) AS name, SUM(p.amount) AS total_amount
FROM sakila.payment p
JOIN sakila.staff s USING (staff_id)
GROUP BY name;

-- 3. Which actor has appeared in the most films?
SELECT concat(a.first_name,' ',a.last_name) AS actor_name
FROM sakila.film_actor f
JOIN sakila.actor a USING (actor_id)
GROUP BY actor_name
ORDER BY COUNT(f.film_id) DESC LIMIT 1;

-- 4. Most active customer (the customer that has rented the most number of films)
SELECT concat(c.first_name,' ',c.last_name) AS customer_name
FROM sakila.customer c
JOIN sakila.rental r USING (customer_id)
GROUP BY customer_name
ORDER BY COUNT(r.rental_id) DESC LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT * FROM address;
SELECT concat(s.first_name,' ',s.last_name) AS staff_name, 
concat(a.address,' ',a.district,' ',a.postal_code) AS full_address
FROM sakila.staff s
JOIN sakila.address a USING (address_id);

-- 6. List each film and the number of actors who are listed for that film.
SELECT f.title AS title, COUNT(fa.actor_id) AS nb_of_actors
FROM sakila.film f
JOIN sakila.film_actor fa USING (film_id)
GROUP BY title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT concat(c.last_name,' ',c.first_name) AS customer_name, SUM(p.amount) AS total_paid
FROM sakila.customer c
JOIN sakila.payment p USING (customer_id)
GROUP BY c.customer_id
ORDER BY c.last_name ASC;

-- 8. List the titles of films per category.
SELECT c.name AS category_name, f.title AS title
FROM sakila.film_category fc
JOIN sakila.category c USING (category_id)
JOIN sakila.film f USING (film_id)
GROUP BY c.name, f.title, fc.film_id;
