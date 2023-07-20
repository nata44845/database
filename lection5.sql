use myfirstdb;

CREATE TABLE sales (
	sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY (sales_employee, fiscal_year)
);

INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES
	('Bob',2016,100),
    ('Bob',2017,150),
    ('Bob',2018,200),
    ('Alice',2016,150),
    ('Alice',2017,100),
    ('Alice',2018,200),
    ('John',2016,200),
    ('John',2017,150),
    ('John',2018,250);
    
    
CREATE TABLE orders (
	Date Date NOT NULL,
    Medium VARCHAR(10) NOT NULL,
    Conversations INT NOT NULL
);

INSERT INTO orders(Date, Medium, Conversations)
VALUES
('20200510', 'cpa', 1),
('20200510', 'cpc', 2),
('20200510', 'organic', 1),
('20200511', 'cpa', 1),
('20200511', 'cpc', 3),
('20200511', 'organic', 2),
('20200511', 'direct', 1),
('20200512', 'cpc', 1),
('20200512', 'organic', 2);

SELECT Date, Medium, Conversations,
SUM(Conversations) OVER() as 'Sum'
FROM orders;

SELECT Date, Medium, Conversations,
SUM(Conversations) OVER(PARTITION BY Date) as 'Sum'
FROM orders;

SELECT Date, Medium, Conversations,
SUM(Conversations) OVER(PARTITION BY Date ORDER BY Medium) as 'Sum'
FROM orders;

-- ROWS
SELECT Date, Medium, Conversations,
SUM(Conversations) OVER(PARTITION BY Date ORDER BY Conversations 
ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) as 'Sum'
FROM orders;

-- AGGREGATE
SELECT Date, Medium, Conversations,
SUM(Conversations) OVER(PARTITION BY Date) as 'Sum',
COUNT(Conversations) OVER(PARTITION BY Date) as 'Count',
AVG(Conversations) OVER(PARTITION BY Date) as 'Avg',
MAX(Conversations) OVER(PARTITION BY Date) as 'Max',
MIN(Conversations) OVER(PARTITION BY Date) as 'Min'
FROM orders;

-- RANGE
SELECT Date, Medium, Conversations,
ROW_NUMBER() OVER(PARTITION BY Date ORDER BY Conversations) as 'Row_number',
RANK() OVER(PARTITION BY Date ORDER BY Conversations) as 'Rank',
DENSE_RANK() OVER(PARTITION BY Date ORDER BY Conversations) as 'Danse_rank',
NTILE(3) OVER(PARTITION BY Date ORDER BY Conversations) as 'Ntile'
FROM orders;


-- LAG
SELECT Date, Medium, Conversations,
LAG(Conversations) OVER(PARTITION BY Date ORDER BY Date) as 'Lag',
LEAD(Conversations) OVER(PARTITION BY Date ORDER BY Date) as 'Lead',
FIRST_VALUE(Conversations) OVER(PARTITION BY Date ORDER BY Date) as 'First_value',
LAST_VALUE(Conversations) OVER(PARTITION BY Date ORDER BY Date) as 'Last_value'
FROM orders;

-- VIEW
use db1;

CREATE VIEW Londonstaff AS 
SELECT * FROM salespeople WHERE city='London';

use myfirstdb;

CREATE VIEW Copyproducts AS
SELECT Price, ProductCount, Manufacturer 
FROM products
WHERE Manufacturer = 'Apple';

DROP VIEW copyproducts;

DROP TABLE temp;

ALTER VIEW copyproducts AS
SELECT *
FROM products
WHERE Manufacturer = 'Apple';
