
####Developed by Mohammed and Smita
####Created on 21st october 2020

SET SQL_SAFE_UPDATES = 0;
#SET SQL_SAFE_UPDATES = 1;

###CUSTOMERS

INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'John', 'Miller', 'john.miller@gmail.com','+1-(438)-766-6789');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Kellie', 'Jhonson', 'kellie.jhonson@gmail.com','+1-(514)-838-6678');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Brendon', 'Williams', 'brendon.williams@gmail.com','+1-(438)-838-2222');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Thomas', 'Jones', 'thomas.jones@gmail.com','+1-(438)-837-2345');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Anthony', 'Davis', 'anthony.davis@gmail.com','+1-(438)-838-5678');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Gary', 'Smith', 'gary.smith@gmail.com','+1-(514)-845-5432');
 INSERT INTO customers(first_name, last_name, email_address, phone_no)
 VALUES ( 'Jose', 'Garcia', 'jose.garcia@gmail.com','+1-(514)-998-6678');
 
 SELECT * FROM customers;
 
 ######################################################################################################
 
  ###paymethods
 INSERT INTO paymethods(method_code, method_description)
 VALUES('CC', 'credit card');
 INSERT INTO paymethods(method_code, method_description)
 VALUES('DC', 'Debit card');
 INSERT INTO paymethods(method_code, method_description)
 VALUES('PP', 'Pay Pal');
 INSERT INTO paymethods(method_code, method_description)
 VALUES('GC', 'Gift card');
 
 SELECT * FROM paymethods;
 
 ######################################################################################################
 ###customer_paymethod
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 2, 'CC', 12345611);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 1, 'CC', 12345612);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 3, 'DC', 12345613);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 4, 'CC', 12345614);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 5, 'PP', 12345615);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 7, 'CC', 12345616);
 INSERT INTO customer_paymethod(customer_id, method_code, credit_card_number)
 VALUES( 6, 'CC', 12345617);
 
 
 SELECT * FROM customer_paymethod;
 
  ######################################################################################################

 ###billing_address
 
 INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(1, 116, 'Grove street', 'Jersey city', 'NJ', 'USA');
 INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(2, 300, 'Hymus Boulevard', 'Kirkland', 'QC', 'CANADA');
 INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(3, 20, 'Rue Franklin', 'Pierre fonds', 'QC', 'CANADA');
 INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(4, 11727, 'Rue Notre Dame', 'Montreal', 'QC', 'CANADA');
  INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(5, 3708, 'Rue St Hubert', 'Montreal', 'QC', 'CANADA');
  INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(6, 4430, 'Ste Catherine', ' Montreal', 'QC', 'CANADA');
  INSERT INTO billing_address(customer_id, street_no, street_name, city, state, country)
 VALUES(7, 12225, 'Av de Saint-Castin', 'Montreal', 'QC', 'CANADA');
 
 SELECT * FROM billing_address;
   ######################################################################################################

 ###shipping_address
 
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(1, 116, 'Grove street', 'Jersey city', 'NJ', 'USA');
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(1, 325, 'Ave Seigniory', 'Pointe Claire', 'QC', 'CANADA');
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(2, 300, 'Hymus Boulevard', 'Kirkland', 'QC', 'CANADA');
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(3, 20, 'Rue Franklin', 'Pierre fonds', 'QC', 'CANADA');
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(3, 7503, 'Rue St Denis', 'Montreal', 'QC', 'CANADA');
 INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(3, 251, 'George street', 'Lasalle', 'QC', 'CANADA');
  INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(4, 11727, 'Rue Notre Dame', 'Montreal', 'QC', 'CANADA');
  INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(5, 3708, 'Rue St Hubert', 'Montreal', 'QC', 'CANADA');
  INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(6, 4430, 'Ste Catherine', ' Montreal', 'QC', 'CANADA');
  INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(6, 717, 'Charron street', 'Lasalle', 'QC', 'CANADA');
  INSERT INTO shipping_address(customer_id, street_no, street_name, city, state, country)
 VALUES(7, 12225, 'Av de Saint-Castin', 'Montreal', 'QC', 'CANADA');
 
 SELECT * FROM shipping_address;
 #we want to check how many customer addresses the customer has
 select CONCAT(c.first_name," ", c.last_name)AS cutomer_name, CONCAT_WS(" ",sa.street_no, sa.street_name, sa.city, sa.state, sa.country)AS Shipping_address
 FROM customers c JOIN shipping_address sa ON c.customer_id=sa.customer_id
 WhERE c.customer_id=3;
######################################################################################################

##ORDERS

INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-01', 2,'complete');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-01', 2,'complete');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-05', 7,'complete');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-18', 5,'pending');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-21', 6,'complete');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-09-21', 4,'complete');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-10-24', 3,'pending');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-10-25', 6,'pending');
INSERT INTO orders(order_date,customer_id,order_status)
VALUES('2020-10-25', 4,'complete');

SELECT * FROM orders;
 ######################################################################################################

#SELLER
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('West Side Merchandise', 'Patrick Holes', '+1-(438)-555-6666', '40 Hutton street', 'Kirkland','QC','CANADA');
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('Garden Tech zone', 'Franklin Jones', '+1-(438)-555-6666', '145 Griffith street', 'Laval','QC','CANADA');
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('Nexotex', ' James Taylor', '+1-(438)-555-6666', '40 Hutton street', 'Kirkland','QC','CANADA');
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('Buy smart', 'Lisa Perez', '+1-(438)-555-6666', '40 Hutton street', 'Kirkland','QC','CANADA');
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('Quickstore', 'Joseph Thomas', '+1-(438)-555-6666', '40 Hutton street', 'Kirkland','QC','CANADA');
INSERT INTO seller(company_name, contact_name,phone, address,city, state,country)
VALUES('Digital sales', 'Susan Holes', '+1-(438)-555-6666', '40 Hutton street', 'Kirkland','QC','CANADA');

SELECT * FROM seller;
 ######################################################################################################
 
#ITEMS
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(6,'iphone-8', 1000.00, 'gjhdjgkkhlhlglflf',1);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(5,'iphone case', 50.00, 'bbnsmjkjdjghd',5);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(1,'Blutooth', 60.00, 'iiiiiiiiiiikkea;fhffh',10);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(1,'Tripod', 55.00, 'opppppptjregjrigh',2);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(6,'iphone-x', 1200.00, 'vkjdlghae;ghgh',6);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(2,'Electric shaver', 80.00, 'ddfhsfldlljgl',2);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(3,'Flash light', 45.00, 'yyyyyyyyyjghdkgjdkg',7);
INSERT INTO ITEMS(seller_id,item_name, unit_price, details,total_quantity)
VALUES(4,'Power bank', 60.00, 'aannklljhhldjlsd',8);
INSERT INTO ITEMS(seller_id, item_name, unit_price, details,total_quantity)
VALUES(4,'Charger', 35.00, 'lllllllllllouyydfifjf',7);

#if we want to check how many items are added by seller 4
select count(*) from items where seller_id=4;
SELECT * FROM items;
 ######################################################################################################

#ORDER_DETAILS
INSERT INTO order_details(order_id,item_id, quantity,price, ship_address_id)
VALUES(2, 3,1, 60, 3);
INSERT INTO order_details(order_id,item_id,quantity,price,ship_address_id)
VALUES(2, 6, 2, 80,3);
INSERT INTO order_details(order_id,item_id,quantity,price,ship_address_id)
VALUES(2, 7, 1, 45,3);
INSERT INTO order_details(order_id,item_id,quantity, price,ship_address_id)
VALUES(3, 1, 1, 1000,11);
INSERT INTO order_details(order_id,item_id,quantity, price,ship_address_id)
VALUES(3, 3, 5, 60,11);
INSERT INTO order_details(order_id,item_id,quantity, price,ship_address_id)
VALUES(3, 6, 1, 60,11);
INSERT INTO order_details(order_id,item_id, quantity,price,ship_address_id)
VALUES(1, 4, 3, 55, 3);
INSERT INTO order_details(order_id,item_id,quantity, price,ship_address_id)
VALUES(4, 5, 1, 1200,7);
INSERT INTO order_details(order_id,item_id,quantity, price, ship_address_id)
VALUES(5, 3,1, 60,9);
INSERT INTO order_details(order_id,item_id,quantity, price,ship_address_id)
VALUES(5, 4,4, 55,9);


SELECT * FROM order_details;

 ######################################################################################################

 #ITEM_REVIEWS
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(4,6, 'Awesome selfie stick. I was able to connect and use the wireless
           selfie stick without looking at the instructions. I love the chargeable remote and the tripod.');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(1, 3,'Pretty much what I expected at a good price. 256GB was the key for me.');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(3,3, 'Love the product. I as exactly as described. Very fast shipping');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(4, 2,'I use this case with my work phone. It is rugged and looks good. And it is lite weight.');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(5,5, 'Excellent product, fast shipping');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(7, 2,'I love everything about this flashlight! The brightness and battery life are incredible. I’d definitely buy this flashlight again.');
 INSERT INTO item_reviews(item_id, customer_id,review)
 VALUES(6, 2,'The product itself works great, very simple to recharge, to wash and to use. I recommend it.');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(6,3, 'Great shaver!!! Fitting to the hand very nicely, light weight.');
 INSERT INTO item_reviews(item_id,customer_id, review)
 VALUES(3,2, 'Exactly what I needed. Great Quality on sounds, packaging and durability.');
 
 SELECT * FROM item_reviews;
 
 
  ######################################################################################################

#SELLER_REVIEWS
 INSERT INTO seller_reviews(seller_id,customer_id, review)
 VALUES(4,6, 'Good quality. Wonderful packaging.');
 INSERT INTO seller_reviews(seller_id,customer_id, review)
 VALUES(1, 3,'Very quick dispatch. First-rate service."');
 INSERT INTO seller_reviews(seller_id,customer_id, review)
 VALUES(3,3, '"Notably wonderful packaging. Very fast shipping');
 INSERT INTO seller_reviews(seller_id,customer_id, review)
 VALUES(4, 2,'Good quality. Wonderful packaging.');
 INSERT INTO seller_reviews(seller_id,customer_id, review)
 VALUES(5, 2,'Delivery was fantastic. Would buy from again.');
 
 SELECT * FROM seller_reviews;
 
  ######################################################################################################

#CATEGORY
INSERT INTO category(category_name)
VALUES('phones');
INSERT INTO category(category_name)
VALUES('books');
INSERT INTO category(category_name)
VALUES('transport');
INSERT INTO category(category_name)
VALUES('accessories');
INSERT INTO category(category_name)
VALUES('clothing');
INSERT INTO category(category_name)
VALUES('electronics');

SELECT * FROM category;
 ######################################################################################################

#ITEM_CATEGORY
INSERT INTO item_category(item_id, category_id)
VALUES(1, 1);
INSERT INTO item_category(item_id, category_id)
VALUES(2, 4);
INSERT INTO item_category(item_id, category_id)
VALUES(3, 4);
INSERT INTO item_category(item_id, category_id)
VALUES(4, 6);
INSERT INTO item_category(item_id, category_id)
VALUES(5, 1);
INSERT INTO item_category(item_id, category_id)
VALUES(6, 6);
INSERT INTO item_category(item_id, category_id)
VALUES(7, 4);
INSERT INTO item_category(item_id, category_id)
VALUES(8, 6 );
INSERT INTO item_category(item_id, category_id)
VALUES(9, 4);

SELECT * FROM item_category;
 ########################################################################################
 
 #shopping_cart
INSERT INTO shopping_cart(customer_id, item_id,quantity, price_perunit)
VALUES(2, 3, 1, 60);
INSERT INTO shopping_cart(customer_id, item_id,quantity,price_perunit)
VALUES(2, 6, 2, 80);
INSERT INTO shopping_cart(customer_id, item_id,quantity, price_perunit)
VALUES(2, 7, 1, 45);
INSERT INTO shopping_cart(customer_id, item_id,quantity,price_perunit)
VALUES(1, 4, 3, 55);
INSERT INTO shopping_cart(customer_id, item_id,quantity,price_perunit)
VALUES(3, 3, 5, 60);

SELECT * FROM shopping_cart;

 ######################################################################################################
 
 
 
