#![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Lab | SQL Join (Part I)
#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.

### Instructions
USE sakila;

#1. How many films are there for each of the categories in the category table.
#Use appropriate join to write this query.
SELECT c.name AS category, COUNT(f.film_id) AS number_of_films
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;

#2. Display the total amount rung up by each staff member in August of 2005.
SELECT *
FROM payment;

SELECT s.staff_id, SUM(p.amount) AS total_amount, CONCAT(s.first_name, ' ', s.last_name) AS staff_name
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
WHERE YEAR(p.payment_date) = 2005 AND MONTH(p.payment_date) = 8
GROUP BY s.staff_id, staff_name;

#3. Which actor has appeared in the most films?

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor_name, a.actor_id, COUNT(fa.actor_id) AS 'film_count'
FROM sakila.actor AS a
JOIN sakila.film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY film_count DESC
LIMIT 1;

#4. Most active customer (the customer that has rented the most number of films)
SELECT c.first_name, c.last_name, COUNT(r.rental_id) 
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY COUNT(r.rental_id)  DESC
LIMIT 1;



#5. Display the first and last names, as well as the address, of each staff member.
SELECT s.first_name, s.last_name, a.address
FROM staff s
JOIN address a ON s.address_id = a.address_id;


#6. List each film and the number of actors who are listed for that film.
SELECT f.title, COUNT(fa.actor_id) AS actor_count
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title;




#7. Using the tables `payment` and `customer` and the JOIN command, list the total paid by each customer.
#List the customers alphabetically by last name.
SELECT c.customer_id,  CONCAT(c.first_name, ' ', c.last_name) AS customer_name, SUM(p.amount) AS total_paid
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY customer_name;


#8. List the titles of films per `category`.
SELECT c.name AS category, f.title
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name;
