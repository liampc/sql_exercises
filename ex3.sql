CREATE DATABASE sql_exercises;
USE sql_exercises;

SET SQL_SAFE_UPDATES = 0; -- RUN to turn off safe updates to update/alter data
SET SQL_SAFE_UPDATES = 1; -- RUN to turn on safe updates again


CREATE TABLE Warehouses (
	code INT NOT NULL AUTO_INCREMENT,
    location VARCHAR(100),
    capacity INT,
    PRIMARY KEY(code)
);

CREATE TABLE Boxes (
	code VARCHAR(10) NOT NULL,
    contents VARCHAR(50), 
    value REAL,
    warehouse INT,
    PRIMARY KEY(code),
    FOREIGN KEY(warehouse) REFERENCES Warehouses(code)
);

-- DATASET
 INSERT INTO Warehouses(Location,Capacity) VALUES('Chicago',3);
 INSERT INTO Warehouses(Location,Capacity) VALUES('Chicago',4);
 INSERT INTO Warehouses(Location,Capacity) VALUES('New York',7);
 INSERT INTO Warehouses(Location,Capacity) VALUES('Los Angeles',2);
 INSERT INTO Warehouses(Location,Capacity) VALUES('San Francisco',8);
 
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
 INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);

-- 1. Select all warehouses.
SELECT * FROM Warehouses;

-- 2. Select all boxes with a value larger than $150.
SELECT * FROM Boxes
WHERE value > 150;

-- 3. Select all distinct contents in all the boxes.
SELECT DISTINCT(contents) FROM Boxes;

-- 4. Select the average value of all the boxes.
SELECT AVG(value) FROM Boxes;

-- 5. Select the warehouse code and the average value of the boxes in each warehouse.
SELECT Warehouse, AVG(value) FROM Boxes
GROUP BY Warehouse;

-- 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.
SELECT Warehouse, AVG(value) FROM Boxes
GROUP BY Warehouse
HAVING AVG(value) > 150;

-- 7. Select the code of each box, along with the name of the city the box is located in.
SELECT B.code, W.location FROM Boxes AS B
JOIN Warehouses AS W;

-- 8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).
SELECT warehouse, COUNT(contents) FROM Boxes
GROUP BY warehouse;

SELECT W.code, COUNT(B.code) FROM Warehouses AS W
LEFT JOIN Boxes AS B 
ON W.code = B.warehouse
GROUP BY W.code;

-- 9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).
SELECT 
	W.code
FROM Warehouses AS W
JOIN Boxes AS B ON W.code = B.warehouse
GROUP BY W.code, W.capacity -- Group by two values, 
HAVING COUNT(B.contents) > W.capacity;

#Alternative
SELECT code FROM Warehouses
WHERE capacity < (
	SELECT COUNT(*) FROM Boxes
    WHERE warehouse = Warehouses.code
);

-- 10. Select the codes of all the boxes located in Chicago.
SELECT code FROM Boxes
WHERE warehouse IN (
	SELECT code FROM Warehouses
    WHERE location = 'Chicago'    
);

-- 11. Create a new warehouse in New York with a capacity for 3 boxes.
INSERT INTO Warehouses(location,capacity) VALUES('New York', 3);

-- 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.
INSERT INTO Boxes(code,contents,value, warehouse) VALUES ('H5RT','Papers',200,2);

-- 13. Reduce the value of all boxes by 15%.
UPDATE Boxes
SET value = value*0.85;

-- 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.

UPDATE Boxes 
SET Boxes.value = Boxes.value * 0.8 
WHERE Boxes.code IN (
	SELECT * FROM (
		SELECT Bx.code FROM Boxes AS Bx
        WHERE Bx.value > (SELECT AVG(B.value) FROM Boxes AS B)
    ) AS Bxs -- -> When updating data, every subquery must have an alias name for the table. Bxs is to envelop the 1st subquery
);



-- 15. Remove all boxes with a value lower than $100.
DELETE FROM Boxes
WHERE Boxes.value < 100;

-- 16. Remove all boxes from saturated warehouses.

  DELETE FROM Boxes 
  WHERE Warehouse IN 
  (SELECT * FROM 
   (SELECT Code
	FROM Warehouses
	WHERE Capacity <
       (SELECT COUNT(*)
		FROM Boxes
		WHERE Warehouse = Warehouses.Code)
	) AS Bxs
   );
   
   
   
   




