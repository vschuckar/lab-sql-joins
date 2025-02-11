/*
Challenge - Joining on multiple tables
Write SQL queries to perform the following tasks using the Sakila database:
1. List the number of films per category.
2. Retrieve the store ID, city, and country for each store.
3. Calculate the total revenue generated by each store in dollars.
4. Determine the average running time of films for each category.
*/
-- 1.
SELECT c.name AS category, COUNT(fc.category_id) AS num_of_films
FROM sakila.film_category fc
JOIN sakila.category c
ON c.category_id = fc.category_id
GROUP BY category
ORDER BY num_of_films DESC;

-- 2.
SELECT s.store_id AS store_id, c.city AS city, co.country AS county
FROM sakila.store s
JOIN sakila.address a
ON s.address_id = a.address_id
JOIN sakila.city c
ON a.city_id = c.city_id
JOIN sakila.country co
ON c.country_id = co.country_id;

-- 3. 
SELECT s.store_id AS store_id, SUM(f.rental_rate) AS total_revenue
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
JOIN sakila.store s
ON i.store_id = s.store_id
GROUP BY store_id;

-- 4.
SELECT c.name AS category, ROUND(AVG(f.length)) AS average_length
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON fc.category_id = c.category_id
GROUP BY category;

/*
Bonus:
5. Identify the film categories with the longest average running time.
6. Display the top 10 most frequently rented movies in descending order.
7. Determine if "Academy Dinosaur" can be rented from Store 1.
8. Provide a list of all distinct film titles, along with their availability status in the inventory. 
Include a column indicating whether each title is 'Available' or 'NOT available.'
Note that there are 42 titles that are not in the inventory, 
and this information can be obtained using a CASE statement combined with IFNULL."
*/
-- 5. 
SELECT c.name AS category, ROUND(AVG(f.length)) AS average_length
FROM sakila.film f
JOIN sakila.film_category fc
ON f.film_id = fc.film_id
JOIN sakila.category c
ON fc.category_id = c.category_id
GROUP BY category
ORDER BY average_length DESC;

-- 6. 
SELECT f.title AS title, COUNT(r.inventory_id) AS freq_rented_movies
FROM sakila.film f 
JOIN sakila.inventory i 
ON f.film_id = i.film_id 
JOIN sakila.rental r 
ON i.inventory_id = r.inventory_id 
GROUP BY title
ORDER BY freq_rented_movies DESC
LIMIT 10;

-- 7. 
SELECT f.title AS title, i.store_id AS store, COUNT(f.film_id) AS num_movies_available
FROM sakila.film f
JOIN sakila.inventory i
ON f.film_id = i.film_id
WHERE (f.title = 'Academy Dinosaur') AND (i.store_id = 1)
GROUP BY title;

-- 8.
SELECT DISTINCT f.title AS title,
CASE 
WHEN (f.film_id) IN (i.film_id) then "Available"
ELSE "NOT available"
END AS "film_availability" 
FROM sakila.film f
LEFT JOIN sakila.inventory i
ON f.film_id = i.film_id
ORDER BY title ASC;

/*
Here are some tips to help you successfully complete the lab:

Tip 1: This lab involves joins with multiple tables, which can be challenging. Take your time and follow the steps we discussed in class:
- Make sure you understand the relationships between the tables in the database. 
This will help you determine which tables to join and which columns to use in your joins.
- Identify a common column for both tables to use in the ON section of the join. 
If there isn't a common column, you may need to add another table with a common column.
- Decide which table you want to use as the left table (immediately after FROM) and which will be the right table (immediately after JOIN).
- Determine which table you want to include all records from. 
This will help you decide which type of JOIN to use. 
If you want all records from the first table, use a LEFT JOIN. 
If you want all records from the second table, use a RIGHT JOIN. 
If you want records from both tables only where there is a match, use an INNER JOIN.
- Use table aliases to make your queries easier to read and understand.
This is especially important when working with multiple tables.
- Write the query

Tip 2: Break down the problem into smaller, more manageable parts. 
- For example, you might start by writing a query to retrieve data from just two tables before adding additional tables to the join. 
- Test your queries as you go, and check the output carefully to make sure it matches what you expect. 
This process takes time, so be patient and go step by step to build your query incrementally.
*/
