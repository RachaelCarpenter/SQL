/*Shows the total inventory valuation of the superstore.*/ 
SELECT Round(Sum(price), 2) AS inventory_valuation 
FROM   superstore; 

/*Shows inventory valuation by category.*/ 
SELECT category, 
       Round(Sum(price), 2) AS inventory_valuation 
FROM   superstore 
GROUP  BY category; 

/*Shows the average ratings in the Electronics category from highest to lowest in relation to price.*/ 
SELECT item_name, 
       average_rating, 
       price 
FROM   superstore 
WHERE  category = 'Electronics' 
ORDER  BY average_rating DESC; 

/*Shows the item with the most in stock.*/ 
SELECT item_name, 
       Max(stock_quantity) AS most_in_stock 
FROM   superstore; 

/*Shows how many different types of appliances are available for purchase.*/ 
SELECT category, 
       Count(item_name) AS different_items 
FROM   superstore 
WHERE  category = 'Appliances'; 


/*The above analysis utilizes the following mock superstore data:*/ 
CREATE TABLE superstore 
  ( 
     item_id        INTEGER PRIMARY KEY, 
     item_name      TEXT, 
     category       TEXT, 
     price          DECIMAL(10, 2), 
     stock_quantity INTEGER, 
     average_rating DECIMAL(3, 2) 
  ); 

INSERT INTO superstore 
            (item_id, 
             item_name, 
             category, 
             price, 
             stock_quantity, 
             average_rating) 
VALUES      ( 1, 
              'Stainless Steel Cookware Set', 
              'Kitchen Supplies', 
              89.99, 
              50, 
              4.6 ), 
            ( 2, 
              'Memory Foam Mattress', 
              'Furnishings', 
              499.99, 
              30, 
              4.8 ), 
            ( 3, 
              'Smart LED TV', 
              'Electronics', 
              549.00, 
              20, 
              4.5 ), 
            ( 4, 
              'Robot Vacuum Cleaner', 
              'Appliances', 
              199.50, 
              40, 
              4.3 ), 
            ( 5, 
              'Wireless Bluetooth Speaker', 
              'Electronics', 
              39.99, 
              60, 
              4.2 ), 
            ( 6, 
              'Non-Stick Baking Set', 
              'Kitchen Supplies', 
              29.95, 
              80, 
              4.4 ), 
            ( 7, 
              'Cotton Bedding Set', 
              'Furnishings', 
              89.00, 
              25, 
              4.7 ), 
            ( 8, 
              'Smart Home Security Camera', 
              'Electronics', 
              79.95, 
              15, 
              4.1 ), 
            ( 9, 
              'Air Purifier', 
              'Appliances', 
              129.50, 
              35, 
              4.6 ), 
            ( 10, 
              'Premium Coffee Maker', 
              'Kitchen Supplies', 
              79.99, 
              50, 
              4.9 ), 
            ( 11, 
              'Ergonomic Office Chair', 
              'Furnishings', 
              189.00, 
              20, 
              4.5 ), 
            ( 12, 
              'Wireless Earbuds', 
              'Electronics', 
              49.99, 
              75, 
              4.3 ), 
            ( 13, 
              'Slow Cooker', 
              'Appliances', 
              49.95, 
              30, 
              4.7 ), 
            ( 14, 
              'Cutlery Set', 
              'Kitchen Supplies', 
              34.50, 
              40, 
              4.4 ), 
            ( 15, 
              'Cozy Throw Blanket', 
              'Furnishings', 
              24.99, 
              100, 
              4.2 );