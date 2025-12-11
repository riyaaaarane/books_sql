create database library;
use library;
select * from books;

ALTER TABLE books
ADD PRIMARY KEY (Book_ID);

ALTER TABLE customers
ADD PRIMARY KEY (Customer_ID);

ALTER TABLE orders
ADD FOREIGN KEY (Customer_ID) 
REFERENCES customers(Customer_ID);

ALTER TABLE orders
ADD FOREIGN KEY (Book_ID) 
REFERENCES books(Book_ID);

-- Retrive all books from fiction

select * from books 
where genre = "fiction";

-- Total revenue earned

select sum(Total_Amount) as total_revenue from orders;

-- Find books after 1950

select * from books 
where Published_Year >= 1950;

-- Authors having book more than one

select author , count(title) from books
group by author
having count(title) > 1 ;

-- Total number of books in each genre

select genre, count(title)  as no_of_books 
from books
group by genre;

-- cutomers from canada

select * from customers 
where country = 'canada';

-- show orders placed in nov 2023

select * from orders
where Order_Date between '2023-11-01' and '2023-11-30';

-- total stock of books availabe

select sum(Stock) from books;

-- most expensive book

select * from books
where price = (select max(price) from books);

select * from books order by price desc limit 1;

-- show all genres in books

select distinct genre from books;

-- total no of books sold for each genre

select books.genre, sum(orders.quantity) as totalbooks
from books
join orders
on orders.Book_ID = books.Book_ID
group by books.genre;

-- list customers who placed atleast two orders

select customers.name, count(orders.Order_ID) as orderscount from orders
join customers
on orders.Book_ID = customers.customer_ID
group by customers.Customer_ID
having orderscount >= 2;

-- find most frequently ordered book

select books.title, count(orders.Order_ID) as orderscount from orders
join books
on orders.Book_ID = books.Book_ID
group by orders.Book_ID,books.title
order by orderscount desc limit 1;

-- top 5 most selling books

select books.title , SUM(orders.quantity) AS total_sold from orders 
join books
on orders.Book_ID = books.Book_ID
group by books.title
ORDER BY total_sold  desc limit 5;

-- revenue by genre

select sum(orders.Total_Amount) as revenue_per_genre , books.Genre from orders
join books
on orders.Book_ID = books.Book_ID
group by genre;

-- books low on stock

select title, stock from books
order by stock asc limit 10;

-- repeat customers
SELECT customers.name, COUNT(DISTINCT orders.order_id) AS num_orders
FROM customers 
JOIN orders  
ON customers.customer_id = orders.customer_id
GROUP BY customers.customer_id
having num_orders > 1;

-- most famous author
select books.author , count(orders.Order_ID) as no_of_orders from books
join orders
on orders.Book_ID = books.Book_ID
group by books.author
order by no_of_orders desc limit 1



















