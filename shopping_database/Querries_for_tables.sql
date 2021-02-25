

####Created on 21st october 2020

SET SQL_SAFE_UPDATES = 0;
#SET SQL_SAFE_UPDATES = 1;

SELECT * FROM customers;
SELECT * FROM paymethods;
SELECT * FROM customer_paymethod;
SELECT * FROM billing_address;
SELECT * FROM shipping_address;
SELECT * FROM orders;
SELECT * FROM seller;
SELECT * FROM order_details;
SELECT * FROM item_reviews;
SELECT * FROM seller_reviews;
SELECT * FROM items;
SELECT * FROM category;
SELECT * FROM item_category;
SELECT * FROM shopping_cart;
#===================================================================================================

#Add a new item as a seller if that does not exist 
SELECT * FROM items;
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(6,'XY Food processor', 200.00, 'ajkgjjfjdjfjfkfj',5);

#if you want to add a item which is already available in our database so we need to update the quantity
UPDATE ITEMS SET total_quantity=total_quantity+5
WHERE seller_id=5 AND item_id=2;
SELECT * FROM items;
#===================================================================================================
#Query for total number of sold item in past month
SELECT * FROM orders;
SELECT * FROM order_details;
SELECT  MONTHNAME(o.order_date) AS Order_month, SUM(od.quantity)AS Total_no_of_sold_items
FROM orders o JOIN order_details od
ON o.order_id= od.order_id
WHERE o.order_date BETWEEN '2020-09-01' AND '2020-09-30';
#===================================================================================================

#Query for total income in CAD
SELECT CONCAT(FORMAT((SUM(quantity*price)),2),'CAD')AS Total_income
FROM order_details;
 select * from order_details;
#===================================================================================================

#Add number of items to shopping cart
INSERT INTO shopping_cart(customer_id, item_id, quantity, price_perunit)
VALUES(5, 6, 2, 80.00);

SELECT * FROM shopping_cart;
#if you have a "+" button click event on which you want to add the item
UPDATE shopping_cart SET quantity=quantity+1
WHERE customer_id=2 AND item_id=6;

SELECT * FROM shopping_cart;
#===================================================================================================

#set the shipping address
INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(7, 500, 'Franklin street', 'Jersey city', 'NJ', 'USA');
 SELECT * FROM shipping_address;
 #===================================================================================================

 #set the payment method
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 7, 'CC', 12341000);
 SELECT * FROM customer_paymethod;
 
#####################################################################################################
#query for a view
#VIEW
###VIEW ON SELLER and REVIEWS AND ITEMS TABLES
#we want to see the reviews of the items as per their sellers
CREATE OR REPLACE VIEW vw_seller_reviews AS
SELECT   s.seller_id, s.company_name, count(r.review)AS Total_reviews
FROM item_reviews r JOIN items i ON i.item_id= r.item_id
JOIN seller s ON i.seller_id= s.seller_id
#WHERE s.seller_id=1;
GROUP BY s.seller_id;
 
SELECT * FROM vw_seller_reviews;

DROP view vw_seller_reviews;
#####################################################################################################
#query for a view on order_details and SHIPPING_ADDRESS
#######VIEW to see the full shipping address details for the order
SELECT * FROM order_details;
SELECT * FROM SHIPPING_ADDRESS;
#VIEW
###VIEW ON SHIPPING_ADDRESS and ORDER_DETAILS AND CUSTOMERS TABLES
#we want to see the full shipping details for our order
CREATE OR REPLACE VIEW vw_full_order_details AS
SELECT   od.order_id, i.item_name, od.quantity, (price* quantity)AS total_price, sa.street_no,sa.street_name, sa.city, sa.state, sa.country
FROM ORDER_DETAILS OD JOIN items i ON od.item_id= i.item_id
JOIN shipping_address sa ON sa.ship_address_id= od.ship_address_id
WHERE od.order_id=1;

SELECT * FROM vw_full_order_details;

DROP view vw_full_order_details;
#####################################################################################################

#TRIGGER ON ITEMS TABLE
###TEST the update trigger on items table
UPDATE items SET total_quantity=total_quantity-1
WHERE item_id=1;
SELECT * FROM items;

#####################################################################################################
-- TRIGGER before_product_insert on items table
-- -----------------------------------------------------
#TEST the trigger before_product_insert  on items table

INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(4,'ABC', -20.00, 'gjhdjgkkhlhlglflf',1);
SELECT * FROM items;
#####################################################################################################

#QUERY#########
SELECT * FROM shopping_cart;
#query to see the total price for the cart items for customer_id 2
SELECT customer_id, item_id, (price_perunit*quantity) AS Total_price 
FROM shopping_cart where customer_id=2;

#if you want to see the total price for the cart of customer_id 2 
SELECT customer_id, SUM(price_perunit*quantity) AS Total_price 
FROM shopping_cart where customer_id=2;

#JOIN QUERY for getting the reviews for each item in the database
SELECT  i.item_name, c.first_name,c.last_name, r.review
FROM items i JOIN item_reviews r ON i.item_id=r.item_id
JOIN customers c ON c.customer_id= r.customer_id;
#####################################################################################################


