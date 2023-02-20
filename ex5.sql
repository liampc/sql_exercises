
CREATE TABLE Pieces (
	code INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY(code)
);

CREATE TABLE Providers (
	code VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY(code)
);

CREATE TABLE Provides (
	piece INT NOT NULL,
    provider VARCHAR(100) NOT NULL,
    price INT,
    PRIMARY KEY(piece,provider),
    FOREIGN KEY(provider) REFERENCES Providers(code)
);

-- DATASET 

 INSERT INTO Providers(Code, Name) VALUES('HAL','Clarke Enterprises');
 INSERT INTO Providers(Code, Name) VALUES('RBT','Susan Calvin Corp.');
 INSERT INTO Providers(Code, Name) VALUES('TNBC','Skellington Supplies');
 
 INSERT INTO Pieces(Name) VALUES('Sprocket');
 INSERT INTO Pieces(Name) VALUES('Screw');
 INSERT INTO Pieces(Name) VALUES('Nut');
 INSERT INTO Pieces(Name) VALUES('Bolt');
 
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'HAL',10);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(1,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'HAL',20);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'RBT',15);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(2,'TNBC',14);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'RBT',50);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(3,'TNBC',45);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'HAL',5);
 INSERT INTO Provides(Piece, Provider, Price) VALUES(4,'RBT',7);
 
 
 -- QUERIES
 
 -- 1. Select the name of all the pieces.
SELECT name FROM Pieces;

-- 2. Select all the providers' data.
SELECT * FROM Providers;

-- 3. Obtain the average price of each piece (show only the piece code and the average price).
 SELECT piece, AVG(price) FROM Provides
 GROUP BY piece;

-- 4. Obtain the names of all providers who supply piece 1.
SELECT name FROM Providers
JOIN Provides ON Providers.code = Provides.provider
WHERE Provides.piece = 1;

-- 5. Select the name of pieces provided by provider with code "HAL".
SELECT Pieces.name FROM Pieces
JOIN Provides ON Pieces.code = Provides.piece
WHERE Provides.provider = 'HAL';

-- 6. For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price (note that there could be two providers who supply the same piece at the most expensive price).
## When you use GROUP BY in your SQL query, then each column in SELECT statement must be either present in 
## GROUP BY clause or occur as parameter in an aggregated function.

SELECT 
	Pieces.name,
    MAX(Providers.name) AS 'Provider',
    MAX(Provides.price) AS 'Most Expensive'
FROM Pieces
JOIN Provides ON Pieces.code = Provides.piece
JOIN Providers ON Provides.provider = Providers.code
GROUP BY Pieces.name;


-- 7. Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.

INSERT INTO Provides(piece,provider,price) VALUES (1, 'TNBC', 7);

-- 8. Increase all prices by one cent.
UPDATE Provides
SET price = price + 1;

-- 9. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM Provides
WHERE provider = 'RBT'
AND piece = 4;

-- 10. Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces (the provider should still remain in the database).
DELETE FROM Provides
WHERE provider = 'RBT';


SELECT * FROM Provides;
