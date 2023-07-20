USE myfirstdb;

SELECT 1, 2 UNION SELECT 'a', 'b';

CREATE TABLE Customers (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    AccountSum DECIMAL
);

CREATE TABLE Employees (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL
);

INSERT INTO Customers (FirstName, LastName, AccountSum)
VALUES
('Tom','Smith',2000),
('Sam','Brown',3000),
('Mark','Adams',2500),
('Paul','Ins',4200),
('John','Smith',2800),
('Tim','Cook',2800);

INSERT INTO Employees (FirstName, LastName)
VALUES
('Homer','Simpson'),
('Tom','Smith'),
('Mark','Adams'),
('Nick','Svensson');

SELECT FirstName, LastName FROM Customers 
UNION
SELECT FirstName, LastName FROM Employees;

SELECT FirstName, LastName FROM Customers 
UNION
SELECT FirstName, LastName FROM Employees
ORDER BY FirstName DESC;

SELECT FirstName, LastName FROM Customers 
UNION ALL
SELECT FirstName, LastName FROM Employees
ORDER BY FirstName;

SELECT FirstName, LastName, AccountSum*1.1 TotalSum FROM Customers WHERE AccountSum<3000  
UNION ALL
SELECT FirstName, LastName, AccountSum*1.3 TotalSum FROM Customers WHERE AccountSum>=3000;

-- JOIN
CREATE TABLE Products (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL NOT NULL
);

CREATE TABLE Orders (
	Id INT PRIMARY KEY AUTO_INCREMENT,
    ProductId INT NOT NULL,
    CustomerId INT NOT NULL,
    CreatedAt INT NOT NULL,
    ProductCount INT DEFAULT 1,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id) ON DELETE CASCADE
);

SELECT Orders.CreatedAt, Orders.ProductCount, Products.ProductName
FROM Orders JOIN Products ON Orders.ProductId = Products.Id;

SELECT O.CreatedAt, O.ProductCount, P.ProductName
FROM Orders O JOIN Products P ON O.ProductId = P.Id;

-- OUTER JOIN
SELECT C.FirstName, CreatedAt, ProductCount, Price
FROM Orders O LEFT JOIN Customers C ON ProductId = C.Id;

SELECT C.FirstName, CreatedAt, ProductCount, Price
FROM Orders O RIGHT JOIN Customers C ON ProductId = C.Id;

-- FULL JOIN
SELECT C.FirstName, CreatedAt, ProductCount, Price
FROM Orders O LEFT JOIN Customers C ON ProductId = C.Id
UNION
SELECT C.FirstName, CreatedAt, ProductCount, Price
FROM Orders O RIGHT JOIN Customers C ON ProductId = C.Id;

-- CROSS JOIN
SELECT C.FirstName, CreatedAt, ProductCount, Price
FROM Orders O CROSS JOIN Customers C;

-- IN
SELECT * FROM Products
WHERE Id IN (SELECT ProductId FROM Orders);

SELECT * FROM Products
WHERE Id NOT IN  (SELECT ProductId FROM Orders);

-- EXISTS
SELECT * FROM Products WHERE EXISTS
(SELECT * FROM Orders WHERE Orders.ProductId = Products.Id);

SELECT * FROM Products WHERE NOT EXISTS
(SELECT * FROM Orders WHERE Orders.ProductId = Products.Id);
