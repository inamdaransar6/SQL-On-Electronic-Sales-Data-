Create database electronics;
Use electronics;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO Customers (customer_id, customer_name, email) VALUES
(1, 'Alice Smith', 'alice.smith@example.com'),
(2, 'Bob Johnson', 'bob.j@example.com'),
(3, 'Charlie Brown', 'charlie.b@example.com');

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO Products (product_id, product_name, price) VALUES
(101, 'Laptop', 1200.00),
(102, 'Mouse', 25.50),
(103, 'Keyboard', 75.00);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Orders (order_id, customer_id, product_id, order_date, quantity) VALUES
(1001, 1, 101, '2025-10-20', 1),
(1002, 2, 102, '2025-10-21', 2),
(1003, 1, 103, '2025-10-22', 1),
(1004, 3, 101, '2025-10-23', 1);


-- 1.Select the product_name and price of all products that cost more than $100.00.
Select product_name,price from products
where price>100.00;

-- 2. Find total number of orders.
select count(*) from orders;

-- 3. Show only the names and emails of all customers.
select customer_name,email from customers;

-- 4. List all products with their prices.
select product_name,price from products;

-- 5. Find all orders placed after October 21, 2025.
select * from orders 
where order_date>'2025-10-21';

-- 6. Show customer details whose name starts with the letter ‘A’.
select * from customers
where customer_name like "A%";

-- 7. List all customers along with the products they ordered and their order date.
select c.customer_name,c.customer_id,
o.product_id,o.order_date
from customers as c
join Orders as o
using(customer_id);

-- 8. Display customer names who ordered “Laptop”.
select c.customer_name,o.product_id
from customers as c
join orders as o
where o.product_id=101
group by c.customer_name;

-- 9. Find the average price of each products.
select product_name,avg(price)
from products
group by product_name;

-- 10. Count how many orders each customer has made.
select o.customer_id,count(o.order_id) as total_orders
from orders as o
group by customer_id;

-- 11. Find customers who ordered the most expensive product.
select customer_id,product_name,price from orders
join products
using(product_id)
where products.price=(select max(price) from products);

-- 12. Update laptop price to 1500 and do other update and rollback it.
update products set price = 1500
where product_id=101;
savepoint s1;

update orders set quantity=2
where order_id=1003;
savepoint s2;

rollback to s2;
update orders set quantity = 3
where order_id=1003;
commit;

select * from customers
left join orders
using(customer_id);


select * from customers
inner join orders
using(customer_id);






