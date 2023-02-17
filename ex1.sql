CREATE DATABASE sql_exercises;
USE sql_exercises;

CREATE TABLE Manufacturers (
	code INT,
    name VARCHAR(255) NOT NULL,
    PRIMARY KEY(Code)
);

CREATE TABLE Products (
	code INT,
    name VARCHAR(255) NOT NULL,
    price DECIMAL NOT NULL,
    manufacturer INT NOT NULL,
    PRIMARY KEY(code),
    FOREIGN KEY (manufacturer) REFERENCES Manufacturers(code)
);

INSERT INTO Manufacturers(code,name) VALUES (1,'Sony');
INSERT INTO Manufacturers(code,name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(code,name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(code,name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(code,name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(code,name) VALUES(6,'Winchester');


INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);


SELECT * FROM products;

#Questions:

-- 1.1 Select the names of all the products in the store.
SELECT name FROM products;

-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, price FROM products;

-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name, price FROM products
WHERE price <= 200;

-- 1.4 Select all the products with a price between $60 and $120.
SELECT name, price FROM products
WHERE price BETWEEN 60 AND 120;

-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, price*100  FROM products;

-- 1.6 Compute the average price of all the products.
SELECT AVG(price) FROM products;

-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) FROM products
WHERE manufacturer = 2;

-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) FROM products
WHERE price >= 180;

-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name,price FROM products
WHERE price >= 180
ORDER BY price DESC,name ASC;

-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products
JOIN Manufacturers ON Products.manufacturer = Manufacturers.code;

-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT 
	Products.name AS 'Product', 
    Products.price AS 'Price', 
    Manufacturers.name AS 'Manufacturer'
FROM Products 
JOIN Manufacturers ON Products.manufacturer = Manufacturers.code;

-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT 
	Products.manufacturer AS 'Manufacturer Code',
    AVG(Products.price) AS 'Average Price'
FROM Products
GROUP BY Products.manufacturer;

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT 
	M.name AS 'Manufacturer',
    AVG(P.price) AS 'Average Price'
FROM Manufacturers AS M
JOIN Products AS P ON M.code = P.manufacturer
GROUP BY P.manufacturer;

-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT 
	M.name AS 'Manufacturer',
    AVG(P.price) AS 'Avg Price'
FROM Manufacturers AS M
JOIN Products AS P ON M.code = P.manufacturer
GROUP BY P.manufacturer
HAVING AVG(P.price) >= 150;

-- 1.15 Select the name and price of the cheapest product.
SELECT name, price
FROM Products
ORDER BY price
LIMIT 1;

-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT 
	P.name AS 'Product',
    P.price,
    M.name AS 'Manufacturer'
FROM Products AS P
INNER JOIN Manufacturers AS M -- Inner join will select records that have matching values in both tables
ON P.manufacturer = M.code
AND P.price = 
	(
		SELECT MAX(IP.price)
        FROM Products AS IP
        WHERE IP.Manufacturer = M.code
    );


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
SELECT * FROM Products;

INSERT INTO Products (code, name,price,manufacturer) VALUES (11,'Loudspeakers',70,2);

-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE Products
SET name = 'Laser Printer'
WHERE code = 8;

-- 1.19 Apply a 10% discount to all products.
SET SQL_SAFE_UPDATES = 0; -- turn off safe updates to alter data, if not will return 'error'

UPDATE Products
set Products.price = Products.price * 0.9;

SET SQL_SAFE_UPDATES = 1; -- turn on safe updates again

-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
SET SQL_SAFE_UPDATES = 0; -- turn off safe updates to alter data, if not will return 'error'

UPDATE Products
SET price = price * 0.9
WHERE price >= 120;

SET SQL_SAFE_UPDATES = 1; -- turn on safe updates again
