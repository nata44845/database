use db1;

CREATE TABLE IF NOT EXISTS salespeople (
	snum INT PRIMARY KEY NOT NULL,
    sname VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    comm DECIMAL(3,2) NOT NULL
);

INSERT INTO salespeople (snum, sname, city, comm) 
VALUES (1001 , "Peel", "London", 0.12),
(1002, "Serres", "San Jose", 0.13),
(1004, "Motika", "London", 0.11),
(1007, "Rifkin", "Barcelona", 0.15),
(1003, "Axelrod", "New York", 0.10);

CREATE TABLE IF NOT EXISTS customers (
	cnum INT PRIMARY KEY NOT NULL,
    cname VARCHAR(20) NOT NULL,
    city VARCHAR(20) NOT NULL,
    rating INT NOT NULL,
    snum INT NOT NULL
);

INSERT INTO customers (cnum, cname, city, rating, snum) 
VALUES (2001, "Hoffman", "London", 100 , 1001),
(2002, "Giovanni", "Rome", 200 , 1003),
(2003, "Liu", "SanJose", 200 , 1002),
(2004, "Grass", "Berlin", 300 , 1002),
(2006, "Clemens", "London", 100 , 1001),
(2008, "Cisneros", "SanJose", 300 , 1007),
(2007, "Pereira", "Rome", 100 , 1004);

CREATE TABLE IF NOT EXISTS orders (
	onum INT PRIMARY KEY NOT NULL,
    amt DECIMAL(10,2) NOT NULL,
    odate DATE NOT NULL,
    cnum INT NOT NULL,
    snum INT NOT NULL
);

INSERT INTO orders (onum, amt, odate, cnum, snum) 
VALUES (3001 , 18.69 , "1990-03-10", 2008 , 1007),
(3003 , 767.19 ,  "1990-03-10", 2001 , 1001),
(3002 , 1900.10 ,  "1990-03-10", 2007 , 1004),
(3005 , 5160.45 ,  "1990-03-10", 2003 , 1002),
(3006 , 1098.16 ,  "1990-03-10", 2008 , 1007),
(3009 , 1713.23 ,  "1990-04-10", 2002 , 1003),
(3007 , 75.75 ,  "1990-04-10", 2004 , 1002),
(3008 , 4723.00 ,  "1990-05-10", 2006 , 1001),
(3010 , 1309.95 ,  "1990-05-10", 2004 , 1002),
(3011 , 9891.88 ,  "1990-06-10", 2006 , 1001);

-- 1. Напишите запрос который вывел бы таблицу со столбцами в следующем порядке: 
-- city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
SELECT city, sname, snum, comm FROM salespeople;

-- 2. Напишите команду SELECT, которая вывела бы оценку(rating), 
-- сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
SELECT rating, cname FROM customers
WHERE city = "SanJose";

-- 3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов 
-- без каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)
SELECT DISTINCT snum FROM orders;

-- 4*. Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. 
-- Используется оператор "LIKE": (“заказчики”)
SELECT * FROM customers
WHERE cname LIKE "G%";

-- 5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. 
-- (“Заказы”, “amt” - сумма)
SELECT * FROM orders
WHERE amt > 1000;

-- 6. Напишите запрос который выбрал бы наименьшую сумму заказа.
-- (Из поля “amt” - сумма в табличке “Заказы” выбрать наименьшее значение)
SELECT MIN(amt) FROM orders;

-- 7. Напишите запрос к табличке “Заказчики”, который может показать всех заказчиков, 
-- у которых рейтинг больше 100 и они находятся не в Риме.
SELECT * FROM customers
WHERE rating>100 and city!="Rome";

-- Таблица workers:
-- Отсортируйте поле “зарплата” в порядке убывания и возрастания
SELECT * FROM workers 
ORDER BY salary;

SELECT * FROM workers 
ORDER BY salary DESC;

-- Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой
SELECT * FROM workers 
ORDER BY salary
LIMIT 5 OFFSET 7;

-- Выполните группировку всех сотрудников по специальности , 
-- суммарная зарплата которых превышает 100000
SELECT speciality,SUM(salary) FROM workers 
GROUP BY speciality
HAVING SUM(salary)>100000;



