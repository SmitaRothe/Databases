
####Developed by Mohammed and Smita
####Created on 21st october 2020

# create a database
CREATE DATABASE IF NOT EXISTS shopping;


#start using an existing database shopping
USE shopping;

#CUSTOMERS
#now we will create the table customers if it does not exist
DROP TABLE IF EXISTS customers;
CREATE TABLE customers				
(
    customer_id INT NOT NULL AUTO_INCREMENT ,
    first_name varchar(255),
    last_name varchar(255),
    email_address varchar(255),
    phone_no VARCHAR(20),
    UNIQUE KEY (email_address),
PRIMARY KEY (customer_id)
);
DESCRIBE customers;

####################################################################################

#BILLING_ADDRESS
#now we will create the table address if it does not exist
DROP TABLE IF EXISTS billing_address;
CREATE TABLE billing_address
( 
    bil_address_id INT AUTO_INCREMENT,
	customer_id INT,
    street_no INT,
    street_name VARCHAR(50),
	city VARCHAR(50)  NOT NULL,
    state VARCHAR(4) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY(bil_address_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE billing_address;
####################################################################################

#SHIPPING_ADDRESS
#now we will create the table address if it does not exist
DROP TABLE IF EXISTS shipping_address;
CREATE TABLE shipping_address
( 
    ship_address_id INT AUTO_INCREMENT,
	customer_id INT,
    street_no INT,
    street_name VARCHAR(50),
	city VARCHAR(50)  NOT NULL,
    state VARCHAR(4) NOT NULL,
    country VARCHAR(50) NOT NULL,
    PRIMARY KEY(ship_address_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE shipping_address;
####################################################################################
#PAYMETHOD
#now we will create the table paymethods if it does not exist
DROP TABLE IF EXISTS paymethods;
CREATE TABLE paymethods				
(
    method_code VARCHAR(4) ,
    method_description VARCHAR(50) NOT NULL,
PRIMARY KEY (method_code)
);
DESCRIBE paymethods;

####################################################################################
#CUSTOMERS_PAYMETHOD
#now we will create the table customer_paymethod if it does not exist
DROP TABLE IF EXISTS customer_paymethod;
CREATE TABLE customer_paymethod				
(
    payment_id INT NOT NULL AUTO_INCREMENT ,
    customer_id INT NOT NULL,
    method_code varchar(4) NOT NULL,
    credit_card_number INT NOT NULL,
	PRIMARY KEY (payment_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (method_code) REFERENCES paymethods(method_code) ON DELETE CASCADE
);
DESCRIBE customer_paymethod;

####################################################################################

#ORDERS
#now we will create the table orders if it does not exist
DROP TABLE IF EXISTS orders;
CREATE TABLE orders
(
	order_id INT AUTO_INCREMENT,
    order_date DATE,
    customer_id INT NOT NULL,
    order_status VARCHAR(50) ,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE orders;

####################################################################################

#SELLER
#now we will create the table seller if it does not exist
DROP TABLE IF EXISTS seller;
CREATE TABLE seller
(
	seller_id INT AUTO_INCREMENT,
    company_name VARCHAR(50) NOT NULL,
    contact_name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    address VARCHAR(50),
    city VARCHAR(15),
    state VARCHAR(10),
    country VARCHAR(20),
    PRIMARY KEY(seller_id)
);
DESCRIBE seller;

#####################################################################################
#items
#now we will create the table products if it does not exist
DROP TABLE IF EXISTS items;
CREATE TABLE items
(
	item_id INT AUTO_INCREMENT,
    seller_id INT NOT NULL,
    item_name VARCHAR(255),
    unit_price FLOAT NOT NULL,
    details VARCHAR(255)NOT NULL,
    total_quantity INT NOT NULL,
    PRIMARY KEY (item_id),
    FOREIGN KEY (seller_id) REFERENCES seller(seller_id) ON DELETE CASCADE
);
DESCRIBE items;

#####################################################################################

#ORDER_DETAILS
#now we will create the table order_details if it does not exist
DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details
(
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    price FLOAT NOT NULL,
    ship_address_id INT NOT NULL,
    card_charge_time TIMESTAMP default now(),
    PRIMARY KEY(order_id,item_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE
);
DESCRIBE order_details;
####################################################################################

#ITEM_REVIEWS
#now we will create the table reviews if it does not exist
DROP TABLE IF EXISTS item_reviews;
CREATE TABLE item_reviews
(
	item_id INT  NOT NULL ,
    customer_id INT NOT NULL,
    review VARCHAR(255),
    FOREIGN KEY(item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE item_reviews;
#####################################################################################

#SELLER_REVIEWS
#now we will create the table reviews if it does not exist
DROP TABLE IF EXISTS seller_reviews;
CREATE TABLE seller_reviews
(
	seller_id INT  NOT NULL ,
    customer_id INT NOT NULL,
    review VARCHAR(255),
    FOREIGN KEY(seller_id) REFERENCES seller(seller_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE seller_reviews;
#####################################################################################

#CATEGORY
#now we will create the table category if it does not exist
DROP TABLE IF EXISTS category;
CREATE TABLE category
(
	category_id INT AUTO_INCREMENT,
    category_name VARCHAR(255),
    PRIMARY KEY(category_id)
);
DESCRIBE category;
#####################################################################################
use shopping;
#ITEM_CATEGORY
#now we will create the table item_category if it does not exist
DROP TABLE IF EXISTS item_category;
CREATE TABLE item_category
(
	item_id INT,
    category_id INT,
    FOREIGN KEY(item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES category(category_id) ON DELETE CASCADE
);
DESCRIBE item_category;
#####################################################################################

#SHOPPING_CART
#now we will create the table seller if it does not exist
DROP TABLE IF EXISTS shopping_cart;
CREATE TABLE shopping_cart
(
    customer_id INT,
    item_id INT,
    quantity INT,
    price_perunit FLOAT,
    PRIMARY KEY(customer_id,item_id),
    FOREIGN KEY(item_id) REFERENCES items(item_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);
DESCRIBE shopping_cart;
#####################################################################################

############################ END OF TABLE CREATIONS ##########################################


#TRIGGER ON ITEMS TABLE
#####################################################################################################
#TRIGGER to send the message about the item is out of stock if the quantity goes less than 0
#(we can do the same using applying the check constraint on the column total_quantity)
SELECT * FROM items;
DROP TRIGGER IF EXISTS trg_before_items_update;

DELIMITER $$
CREATE TRIGGER trg_before_items_update
  BEFORE UPDATE ON items FOR EACH ROW
     BEGIN
         DECLARE errorMessage VARCHAR(50);
         SET errorMessage= 'The item is out of stock';
         
         IF new.total_quantity< 0 THEN 
            SIGNAL SQLSTATE '45000'
              SET message_text= errorMessage;
		 END IF;
     END $$
DELIMITER ;

#TRIGGER ON ITEMS TABLE
#####################################################################################################
-- TRIGGER before_product_insert on items table
-- -----------------------------------------------------
# BEFORE INSERT
SELECT * FROM items;
DROP TRIGGER IF EXISTS trg_before_item_insert;

DELIMITER $$
CREATE TRIGGER trg_before_item_insert
BEFORE INSERT ON items
FOR EACH ROW
BEGIN 
    IF NEW.unit_price < 0 THEN 
        SET NEW.unit_price = 0; 
    END IF; 
END $$
DELIMITER ;
#####################################################################################################

