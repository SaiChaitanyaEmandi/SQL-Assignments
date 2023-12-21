--Q1.1
CREATE DATABASE Techshop;
use [Techshop];


--Q1.3
-- All 5 tables are in 1NF,2NF,3NF because:
	-- Every column in the tables have atomic values.
	-- All non-prime attributes are fully functional dependent on primary key.
	-- And i have also eliminated transitive dependencies.


--Q1.5
	-- I have created appropriate primary key and foreign key constraints for referential integrity while writing schemas.


--Q2.1
CREATE TABLE Customers
(
	CustomerId INT PRIMARY KEY,
	FirstName VARCHAR(30),
	LastName VARCHAR(30),
	Email VARCHAR(50),
	Phone CHAR(10),
	Address VARCHAR(50)
);

CREATE TABLE Products
(
	ProductId INT PRIMARY KEY,
	ProductName VARCHAR(30),
	Description VARCHAR(150),
	Price INT
);

CREATE TABLE Orders
(
	OrderId INT PRIMARY KEY,
	CustomerId INT FOREIGN KEY (CustomerId) REFERENCES [dbo].[Customers]([CustomerId]),
	OrderDate DATE,
	TotalAmount INT
);

CREATE TABLE OrderDetails
(
	OrderDetailId INT PRIMARY KEY,
	OrderId INT FOREIGN KEY (OrderId) REFERENCES [dbo].[Orders]([OrderId]),
	ProductId INT FOREIGN KEY (ProductId) REFERENCES [dbo].[Products]([ProductId]),
	Quantity INT
);

CREATE TABLE Inventory
(
	InventoryId INT PRIMARY KEY,
	ProductId INT FOREIGN KEY (ProductId) REFERENCES [dbo].[Products]([ProductId]),
	QuantityInStock INT,
	LastStockUpdate INT
);


--Q3.a
INSERT INTO Customers
VALUES(101,'John', 'Doe', 'john.doe@example.com','8985360207',  '123 Main St'),
    (102, 'Jane', 'Smith', 'jane.smith@example.com','7032260517', '456 Oak Ave'),
    (103, 'Bob', 'Johnson', 'bob.johnson@example.com','9491268109', '789 Pine Ln' ),
    (104, 'Alice', 'Williams', 'alice.williams@example.com','9490812289', '101 Maple Dr'),
    (105, 'Charlie', 'Brown', 'charlie.brown@example.com','6300374632', '202 Elm St' ),
    (106, 'Eva', 'Miller', 'eva.miller@example.com','9490836359', '303 Cedar Ave'),
    (107, 'David', 'Garcia', 'david.garcia@example.com','9963810207', '404 Birch Ln'),
    (108, 'Grace', 'Jones', 'grace.jones@example.com','9390826689', '505 Oak Dr'),
    (109, 'Frank', 'Lee', 'frank.lee@example.com','9966357890', '606 Pine Ct'),
    (110, 'Helen', 'Taylor', 'helen.taylor@example.com','8500933844', '707 Maple Blvd');

SELECT * FROM Customers;

INSERT INTO Products
VALUES(10, 'Laptop', 'High-performance laptop with the latest features', 50000),
  (20, 'Smartphone', 'Latest smartphone with advanced technology', 20000),
  (30, 'Coffee Maker', 'Automatic coffee maker for brewing your favorite coffee', 9000),
  (40, 'Earphones', 'Comfortable,high-quality and durable earphoes', 1500),
  (50, 'Bluetooth Speaker', 'Portable Bluetooth speaker for music on the go', 10000),
  (60, 'TV', 'Super flexible android tv', 37000),
  (70, 'Calculator', 'Advanced calculator with latest features', 2500),
  (80, 'Camera', 'Light-weight and lens adjustable camera', 60000),
  (90, 'Fitness Tracker', 'Track your fitness activities with this advanced tracker', 7000),
  (100, 'Air Conditioner', 'AC with Super cooling technology', 24000);

SELECT * FROM Products;

INSERT INTO Orders 
VALUES(1, 101, '2023-01-15', 40000),
  (2, 102, '2023-02-02', 3000),
  (3, 103, '2023-03-10', 19000),
  (4, 104, '2023-04-18', 80000),
  (5, 105, '2023-05-05', 10000),
  (6, 106, '2023-06-20', 5000),
  (7, 107, '2023-07-08', 57000),
  (8, 108, '2023-08-15', 26000),
  (9, 109, '2023-09-23', 92000),
  (10, 110, '2023-10-30', 12000);

SELECT * FROM Orders;

INSERT INTO OrderDetails
VALUES(1001, 1, 10, 2),
  (1002, 2, 20, 1),
  (1003, 3, 30, 3),
  (1004, 4, 40, 1),
  (1005, 5, 50, 2),
  (1006, 6, 60, 1),
  (1007, 7, 70, 4),
  (1008, 8, 80, 1),
  (1009, 9, 90, 2),
  (1010, 10, 100, 1);

SELECT * FROM OrderDetails;

INSERT INTO Inventory
VALUES(1, 10, 5, 100),
  (2, 20, 2, 72),
  (3, 30, 1, 10),
  (4, 40, 3, 30),
  (5, 50, 2, 50),
  (6, 60, 1, 39),
  (7, 70, 9, 20),
  (8, 80, 3, 18),
  (9, 90, 4, 65),
  (10, 100, 2, 90);

SELECT * FROM Inventory;


--Q3.b.1
SELECT FirstName,LastName,Email from Customers;


--Q3.b.2
SELECT FirstName, LastName, OrderDate from Customers
INNER JOIN Orders on Customers.CustomerId = Orders.CustomerId;


--Q3.b.3
INSERT INTO Customers(CustomerId, FirstName, LastName, Email, Address)
VALUES(111, 'Arya', 'Stark', 'arya.stark@example.com', '369 Thomas St');


--Q3.b.4
UPDATE Products
SET Price = Price * 1.10;


--Q3.b.5
DECLARE @OrderIdToDelete INT;
SET @OrderIdToDelete = 1;

DELETE FROM OrderDetails
WHERE OrderId = @OrderIdToDelete;

DELETE FROM Orders
WHERE OrderId = @OrderIdToDelete


--Q3.b.6
INSERT INTO Orders(OrderId,CustomerId,OrderDate,TotalAmount)
VALUES(11, 110, '2023-11-21', 30000);


--Q3.b.7
DECLARE @InputCustomerId INT;
DECLARE @InputEmail VARCHAR(30);
DECLARE @InputAddress VARCHAR(30);

SET @InputCustomerId = 2;
SET @InputEmail = 'rey.mysterio@example.com';
SET @InputAddress = '678 Gandhi St';

UPDATE Customers
SET Email = @InputEmail, Address = @InputAddress
WHERE CustomerId = @InputCustomerId;


--Q3.b.8
UPDATE Orders
SET TotalAmount=(
	SELECT SUM(p.Price * od.Quantity)
	From OrderDetails AS od
	INNER JOIN Products AS P ON od.ProductId = p.ProductId
	WHERE od.OrderId = Orders.OrderId
);


--Q3.b.9
DECLARE @CustomerIdInput INT;

SET @CustomerIdInput = 103;

DELETE FROM Orders
WHERE CustomerId = @CustomerIdInput;

DELETE FROM OrderDetails 
WHERE OrderId IN (
	SELECT OrderId From Orders
	WHERE CustomerId = @CustomerIdInput
);


--Q3.b.10
INSERT INTO Products
VALUES(120, 'Smart-watch', 'Sensor equipped watch',8000); 


--Q3.b.11
ALTER TABLE Orders
ADD Status VARCHAR(20);

DECLARE @OrderIdToUpdate INT;
DECLARE @newStatus VARCHAR(20);

SET @OrderIdToUpdate = 5;
SET @newStatus = 'Shipped';

UPDATE Orders
SET Status = @newStatus
Where OrderId = @OrderIdToUpdate;


--Q3.b.12
ALTER TABLE Customers
ADD NumberOfOrders Int;

UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(OrderID)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);


--Q4.1
SELECT FirstName,LastName,OrderId,OrderDate,TotalAmount FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerId = o.CustomerId;


--Q4.2
SELECT P.ProductId, P.ProductName, SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM Products AS P
JOIN OrderDetails AS OD ON P.ProductId = OD.ProductId
GROUP BY P.ProductId, P.ProductName;


--Q4.3
SELECT FirstName,LastName,Email,Address From Customers AS c
LEFT JOIN Orders AS o ON c.CustomerId = o.CustomerId; 


--Q4.4
SELECT TOP 1  ProductName, Quantity FROM Products AS p
JOIN OrderDetails AS od ON p.ProductId = od.ProductId
ORDER BY 2 DESC;


--Q4.5
	--There is no cateorgy table provided in the input.


--Q4.6
SELECT C.CustomerId, C.FirstName,C.LastName, AVG(OD.Quantity * P.Price) AS AverageOrderValue
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductId = P.ProductId
GROUP BY C.CustomerID, C.FirstName,C.LastName;


--Q4.7
SELECT TOP 1  O.OrderID, C.CustomerID, C.FirstName,C.LastName, SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM Orders AS O
JOIN Customers AS C ON O.CustomerID = C.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductId =P.ProductId
GROUP BY O.OrderID, C.CustomerID, C.FirstName,C.LastName
ORDER BY TotalRevenue DESC;


--Q4.8
SELECT P.ProductID, P.ProductName, COUNT(OD.OrderDetailID) AS TimesOrdered
FROM Products AS P
LEFT JOIN OrderDetails AS OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID, P.ProductName
ORDER BY TimesOrdered DESC;


--Q4.9
DECLARE @ProductNameInput VARCHAR(30);
SET @ProductNameInput = 'Calculator';

SELECT C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone, C.Address
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID
WHERE P.ProductName = @ProductNameInput;


--Q4.10
DECLARE @InputStartDate DATE;
DECLARE @InputEndDate DATE;

SET @InputStartDate = '2023-03-07';
SET @InputEndDate = '2023-07-29';

SELECT SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM Orders AS O
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID
WHERE O.OrderDate >= @InputStartDate AND O.OrderDate <= @InputEndDate;


--Q5.1
SELECT C.CustomerID, C.FirstName, C.LastName, C.Email, C.Phone, C.Address
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;


--Q5.2
SELECT COUNT(*) AS TotalProducts
FROM Products;


--Q5.3
SELECT SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM Orders AS O
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID;


--Q5.4
-- THIS CANNOT BE SOLVED BECAUSE WE DON'T HAVE CATEGORY IN THE PROVIDED INPUT TABLE.


--Q5.5
DECLARE @CustomerIdForRevenue INT;
SET @CustomerIdForRevenue = 105;

SELECT SUM(OD.Quantity * P.Price) AS TotalRevenue
FROM Orders AS O
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID
WHERE O.CustomerID = @CustomerIdForRevenue;


--Q5.6
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS NumberOfOrders
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY NumberOfOrders DESC;


--Q5.7
--  WE DON'T HAVE PRODUCT CATEGORY INPUT. 


-- Q5.8
SELECT TOP 1 C.FirstName, C.LastName, SUM(OD.Quantity * P.Price) AS TotalSpending
FROM Customers AS C
JOIN Orders AS O ON C.CustomerID = O.CustomerID
JOIN OrderDetails AS OD ON O.OrderID = OD.OrderID
JOIN Products AS P ON OD.ProductID = P.ProductID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpending DESC;


--Q5.9
SELECT C.FirstName,C.LastName, SUM(OD.Quantity*P.Price)/ COUNT(O.OrderId) AS AverageOrderValue 
FROM Customers AS C
JOIN Orders AS O ON O.CustomerId = C.CustomerId
JOIN OrderDetails AS OD ON O.OrderId = OD.OrderId
JOIN Products AS P ON OD.ProductId = P.ProductId
GROUP BY C.FirstName, C.LastName;


--Q5.10
SELECT C.FirstName, C.LastName, COUNT(O.OrderID) AS OrderCount
FROM Customers AS C
LEFT JOIN Orders AS O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY OrderCount DESC;
