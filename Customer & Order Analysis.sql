/*In the following queries, I'm utilizing a database with multiple tables to quantify customer and order data statistics after cleaning the orderID column.*/ 

/*Shows how many customers ordered more than two products at a time in February and what the average amount spent for those customers was.*/ 
SELECT Count(DISTINCT acctnum)         AS customer_count, 
       Round(Avg(quantity * price), 2) AS avg_amnt_spent 
FROM   febsales 
       LEFT JOIN customers 
              ON febsales.orderid = customers.order_id 
WHERE  quantity > 2 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Shows how many orders were placed in January.*/ 
SELECT Count(orderid) AS order_count 
FROM   jansales 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Builds on the previous query by showing how many of those orders were for iPhones.*/ 
SELECT Count(orderid) AS iphone_count 
FROM   jansales 
WHERE  product = 'iPhone' 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Lists the customer account numbers for all the orders placed in February.*/ 
SELECT DISTINCT acctnum 
FROM   customers 
       JOIN febsales 
         ON customers.order_id = febsales.orderid 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Shows the total revenue for each product sold in January.*/ 
SELECT product, 
       Round(Sum(quantity * price), 2) AS revenue 
FROM   jansales 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY product; 

/*Shows products that were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what the total revenue was.*/ 
SELECT product, 
       Sum(quantity)         AS total_product_sold, 
       Sum(quantity * price) AS revenue 
FROM   febsales 
WHERE  location = '548 Lincoln St, Seattle, WA 98101' 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY product; 

/*Shows the price of the cheapest product sold in January.*/ 
SELECT product, 
       price 
FROM   jansales 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID' 
ORDER  BY price 
LIMIT  1; 

/*Lists all products sold in Los Angeles in February and how many of each were sold.*/ 
SELECT product, 
       Sum(quantity) AS total_quantity 
FROM   febsales 
WHERE  location LIKE '%Los Angeles%' 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY product; 

/*Shows locations in New York that received at least three orders in January and how many orders they received.*/ 
SELECT location, 
       Count(orderid) AS total_orders 
FROM   jansales 
WHERE  location LIKE '%NY%' 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY location 
HAVING total_orders >= 3; 

/*Shows how many of each type of headphones were sold in February.*/ 
SELECT product, 
       Sum(quantity) AS total_sold 
FROM   febsales 
WHERE  product LIKE '%Headphones%' 
       AND Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY product; 

/*Shows the average amount spent in February per account.*/ 
SELECT Round(( Sum(quantity * price) / Count(DISTINCT acctnum) ), 2) AS 
       avg_amnt_spent 
FROM   febsales 
       LEFT JOIN customers 
              ON febsales.orderid = customers.order_id 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Shows the average quantity purchased in February per account.*/ 
SELECT Round(( Sum(quantity) / Count(DISTINCT acctnum) ), 0) AS avg_quantity 
FROM   febsales 
       LEFT JOIN customers 
              ON febsales.orderid = customers.order_id 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID'; 

/*Shows which product brought in the most revenue in January and the total revenue.*/ 
SELECT product, 
       Sum(quantity * price) AS revenue 
FROM   jansales 
WHERE  Length(orderid) = 6 
       AND orderid <> 'Order ID' 
GROUP  BY product 
ORDER  BY revenue DESC 
LIMIT  1;
