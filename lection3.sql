SELECT * FROM product
ORDER BY Price;

SELECT ProductName, ProductCount*Price as TotalSum FROM product
ORDER BY TotalSum;


SELECT ProductName, Price, ProductCount FROM product
ORDER BY ProductCount*Price;

SELECT * FROM product
LIMIT 3;

SELECT * FROM product
LIMIT 2, 3;

SELECT DISTINCT Manufacturer FROM product;

SELECT DISTINCT Manufacturer, ProductCount FROM product;

SELECT Manufacturer, COUNT(*) FROM product
GROUP BY Manufacturer;

SELECT Manufacturer, SUM(ProductCount) FROM product
GROUP BY Manufacturer;

SELECT AVG(PRICE) as AvgPrice FROM product;
SELECT COUNT(*) FROM product;
SELECT MIN(Price), MAX(Price) FROM product;
SELECT MIN(Price), MAX(Price) FROM product;

SELECT Manufacturer, COUNT(*) as ModelsCount FROM product
GROUP BY Manufacturer
HAVING COUNT(*)>1;

SELECT SUM(Price*ProductCount) TotalSum FROM Product;

SELECT MIN(Price) FROM product
where Manufacturer = 'Apple';

SELECT MIN(Price), MAX(Price), AVG(Price) FROM product
where Manufacturer = 'Samsung';

