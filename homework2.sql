USE db1;
-- 1
CREATE TABLE IF NOT EXISTS sales(
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_date DATE NOT NULL,
    amount decimal(10,2) NOT NULL
);

-- 2
INSERT INTO sales (order_date, amount)
VALUES ('2021-01-01', 500),
    ('2021-01-02', 200),
    ('2021-01-02', 100),
    ('2021-01-04', 400),
    ('2021-01-05', 500);

SELECT * FROM sales;

SELECT id, order_date, 
CASE WHEN amount<100 THEN 'Маленький заказ'
	 WHEN amount>=100 AND amount<=300 THEN 'Средний заказ'
     ELSE 'Большой заказ' END bucket
FROM sales;

SELECT bucket, SUM(amount) SUM_AMOUNT FROM (
SELECT CASE WHEN amount<100 THEN 'Маленький заказ'
	 WHEN amount>=100 AND amount<=300 THEN 'Средний заказ'
     ELSE 'Большой заказ' END bucket,
     amount
FROM sales) A
GROUP BY bucket;

-- 3    
CREATE TABLE IF NOT EXISTS orders(
    orderid INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    employeeid VARCHAR(10) NOT NULL,
    amount decimal(10,2) NOT NULL, 
    orderstatus VARCHAR(50) NOT NULL
);

INSERT INTO orders (employeeid, amount, orderstatus)
VALUES ('e03', 15, 'OPEN'),
    ('e01', 25.5,'OPEN'),
    ('e05', 100.7,'CLOSED'),
    ('e02', 22.19,'OPEN'),
    ('e04', 9.5, 'CANCELLED'),
	('e04', 99.99,'OPEN');
    
SELECT * FROM orders;

SELECT orderid, orderstatus, 
CASE WHEN orderstatus = 'OPEN' THEN 'Order is in open state.'
	 WHEN orderstatus = 'CLOSED' THEN 'Order is closed.'
     WHEN orderstatus = 'CANCELLED' THEN 'Order is cancelled.' END order_summary
FROM orders;

-- 4
-- NULL в отличае от 0 это ничего, проверяется сравнениями IS NULL, IS NOT NULL
-- 0 конкретное значение, проверяется сравнениями =0, !=0
 

