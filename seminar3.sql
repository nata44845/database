use db1;

CREATE TABLE IF NOT EXISTS workers (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(50) NOT NULL,
	surname VARCHAR(50) NOT NULL,
	speciality VARCHAR(50) NOT NULL,
	seniority INT NOT NULL,
	salary INT NOT NULL,
	age INT NOT NULL
);

INSERT INTO workers (name, surname, specialty, seniority, salary, age)
VALUES
('Вася',	'Васькин',	'Начальник',	40,	100000,	60),
('Петя',	'Петькин',	'Начальник',	8,	70000,	30),
('Катя',	'Катькина',	'Инженер',	2,	70000,	25),
('Саша',	'Сашкин',	'Инженер',	12,	50000,	35),
('Иван',	'Иванов',	'Рабочий',	40,	30000,	59),
('Петр',	'Петров',	'Рабочий',	20,	25000,	40),
('Сидор',	'Сидоров',	'Рабочий',	10,	20000,	35),
('Антон',	'Антонов',	'Рабочий',	8,	19000,	28),
('Юра',	'Юркин',	'Рабочий',	5,	15000,	25),
('Максим',	'Воронин',	'Рабочий',	2,	11000,	22),
('Юра',	'Галкин',	'Рабочий',	3,	12000,	24),
('Люся',	'Люськина',	'Уборщик',	10,	10000,	49);

SELECT * FROM workers ORDER BY age;
SELECT * FROM workers ORDER BY name;

SELECT name,surname,age FROM workers 
ORDER BY name DESC;

SELECT * FROM workers 
ORDER BY name DESC, age DESC;

SELECT DISTINCT name FROM workers ORDER BY NAME;

SELECT * FROM workers LIMIT 2;

SELECT * FROM workers 
ORDER BY id
LIMIT 3 OFFSET 4;

SELECT * FROM workers 
ORDER BY id DESC
LIMIT 3 OFFSET 2;

SELECT * FROM workers 
ORDER BY id DESC
LIMIT 2, 3;

-- Задание 4
SELECT SUM(daily_typing_page) FROM employee_tbl;

SELECT id,name,SUM(daily_typing_page) FROM employee_tbl
GROUP BY id, name;

SELECT COUNT(*) FROM employee_tbl;

SELECT COUNT(DISTINCT name) FROM employee_tbl;

SELECT AVG(daily_typing_page) FROM employee_tbl
group by id;

-- Задание 5
SELECT age,SUM(salary) FROM workers
GROUP BY age
ORDER BY age;

SELECT age,MAX(salary) FROM workers
GROUP BY age
ORDER BY age;

SELECT age,MIN(salary) FROM workers
GROUP BY age
ORDER BY age;

-- Задание 6
SELECT age,SUM(salary) total FROM workers
GROUP BY age
HAVING total>=50000
ORDER BY age;

SELECT age,count(*) cnt FROM workers
GROUP BY age
HAVING cnt>=2
ORDER BY age;

SELECT age,count(*) cnt FROM workers
GROUP BY age
HAVING cnt in (2)
ORDER BY age;

