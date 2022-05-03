-- Select the first name, last name, and email address of all the customers who have rented a movie.

select distinct c.first_name, c.last_name, c.email
from rental r
left join customer c
on c.customer_id = r.customer_id;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select p.customer_id, CONCAT(c.first_name, ' ' , c.last_name) as name, avg(amount) as average_payment
from payment p
left join customer c
on p.customer_id = c.customer_id
group by customer_id ;

-- Select the name and email address of all the customers who have rented the "Action" movies.

select CONCAT(c.first_name, ' ' , c.last_name) as name, c.email
from rental p
left join customer c
on p.customer_id = c.customer_id
left join inventory i
on i.inventory_id = p.inventory_id
left join film_category fc
on fc.film_id = i.film_id
left join category cat
on fc.category_id = cat.category_id
where cat.name = 'Action';

-- Write the query using sub queries with multiple WHERE clause and IN condition

select CONCAT(c.first_name, ' ' , c.last_name) as name, c.email
from rental p
left join customer c
on p.customer_id = c.customer_id
left join inventory i
on i.inventory_id = p.inventory_id
where i.film_id in (select fc.film_id
from film_category fc
join category ca
on fc.category_id = ca.category_id
where ca.name = 'Action');

-- Verify if the above two queries produce the same results or not
#They prodcued the same amoutn of rows = 1112

-- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
select payment_id, amount,
case 
when amount between 0 and 2 then 'low'
when amount between 2 and 4 then 'medium'
else 'high'
end as value_rank
from payment;