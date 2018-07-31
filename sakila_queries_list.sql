
-- 1a. 

SELECT first_name, last_name 
FROM actor;

-- 1b.

ALTER TABLE actor
ADD COLUMN actor_name VARCHAR(50);

UPDATE actor SET actor_name = CONCAT(first_name, ' ', last_name);
SELECT * FROM actor;

-- 2a. 

SELECT first_name, last_name FROM actor
WHERE first_name = 'Joe';

-- 2b. 

SELECT first_name, last_name FROM actor
WHERE last_name LIKE "%Gen%";

-- 2c. modify column order 

SELECT last_name, first_name FROM actor
WHERE last_name LIKE "%Li%"
ORDER BY last_name;

-- 2d. 

SELECT country_id, country
FROM country 
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a. 
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b. 

ALTER TABLE actor DROP COLUMN description;

-- 4a. 

SELECT last_name, COUNT(last_name) 
FROM actor
GROUP BY last_name;

-- 4b. 

SELECT last_name, COUNT(*) AS cnt
FROM actor
GROUP BY last_name
HAVING cnt >  1;

-- 4c. 

UPDATE actor SET first_name = 'HARPO'
WHERE actor_id = 172;

-- 4d. 

UPDATE actor SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO'

-- 5a. 

SHOW CREATE TABLE address;

-- 6a.

SELECT staff.first_name, staff.last_name, address.address
FROM staff
INNER JOIN address ON address.address_id = staff.address_id;

-- 6b. 

SELECT staff.staff_id, staff.first_name, staff.last_name, payment.payment_date, SUM(payment.amount) 
FROM staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "%2005-08%"
GROUP BY staff.staff_id;

-- 6c. 

SELECT film_id, staff.first_name, staff.last_name, payment.payment_date, SUM(payment.amount) 
FROM staff
INNER JOIN payment ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "%2005-08%"
GROUP BY staff.staff_id;

-- 6d. 

SELECT film_id, COUNT(*) AS cnt
FROM inventory
WHERE film_id = 439;

-- 6e.

SELECT customer.last_name, customer.first_name, SUM(payment.amount)
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY customer.last_name;

-- 7a. 

SELECT title 
FROM film
WHERE title LIKE 'K%' 
OR title LIKE 'Q%'  
AND language_id IN
(
	SELECT language_id
	FROM language
	WHERE name = 'English'
);

-- 7b. 

SELECT first_name, last_name
FROM actor
WHERE actor_id IN
(
  SELECT actor_id
  FROM film_actor
  WHERE film_id IN
  (
   SELECT film_id
   FROM film
   WHERE title = 'Alone Trip'
  )
);

-- 7c. 

SELECT customer.last_name, customer.first_name, customer.email, address.address 
FROM customer 
INNER JOIN address ON customer.address_id = address.address_id 
INNER JOIN city ON address.city_id = city.city_id
WHERE city.country_id = 20;

-- 7d.

SELECT film.title
FROM film
LEFT JOIN film_category
ON film.film_id = film_category.film_id WHERE film_category.category_id = 8;

-- 7e.  
    
SELECT title, COUNT(title)
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON(inventory.inventory_id = rental.inventory_id) 
GROUP BY film.title
ORDER BY COUNT(title) DESC; 

-- 7f. 

SELECT store.store_id, SUM(payment.amount) AS 'total sales' 
FROM store 
JOIN inventory ON store.store_id = inventory.store_id
JOIN rental ON rental.inventory_id = inventory.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY store.store_id;

-- 7g. 

SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id 
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

-- 7h. 

SELECT category.name, SUM(payment.amount) AS 'gross_revenue'
FROM category
JOIN film_category ON category.category_id = film_category.category_id 
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id 
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8a. 

CREATE VIEW top_five_grossing_genres AS
SELECT category.name, SUM(payment.amount) AS 'gross_revenue'
FROM category
JOIN film_category ON category.category_id = film_category.category_id 
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON payment.rental_id = rental.rental_id 
GROUP BY category.name
ORDER BY gross_revenue DESC
LIMIT 5;

-- 8b. 

SELECT * FROM `top_five_grossing_genres`;

-- 8c. 

DROP VIEW `top_five_grossing_genres`;


