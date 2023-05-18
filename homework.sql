-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE district = 'Texas';
-- Answer: Jennifer Davis, Kim Cruz, Richard Mccrary, Bryan Hardison, Ian Still


-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE amount > 6.99;
-- Answer: Douglas Graf - 919.67, Mary Smith - 478.86, Alfredo Mcadams - 74.94, etc...


-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING SUM(amount) > 175
);
-- Answer: Mary Smith, Peter Menard


-- 4. List all customers that live in Nepal (use the city table)
SELECT customer.first_name, customer.last_name, city
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
WHERE city = 'Nepal';
-- Answer: No Data


-- 5. Which staff member had the most transactions?
SELECT staff.first_name, staff.last_name, COUNT(rental_id)
FROM staff
INNER JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id;
-- Answer: Mike Hillyer


-- 6. How many movies of each rating are there?
SELECT DISTINCT rating, COUNT(rating)
from film
INNER JOIN inventory
ON film.film_id = inventory.film_id
GROUP BY rating;
-- Answer: G - 791, PG - 924, PG-13 - 1018, R - 908, NC-17 - 940


-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT first_name, last_name
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM payment
    WHERE amount > 6.99
);
-- Answer: Mary Smith, Peter Menard, Douglas Graf, Alvin Deloach, Alfredo Mcadams


-- 8. How many free rentals did our stores give away?

SELECT COUNT(DISTINCT store_id), COUNT(amount)
FROM inventory
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY amount
HAVING amount <= 0;
-- Answer: Store 1 - 15, Store 2 - 14554
