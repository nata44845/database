  use homework4;
  
  DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    
SELECT * from teacher; 
DROP TABLE IF EXISTS lesson;
CREATE TABLE lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);

INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4),
    ("Нейронные сети", NULL); -- Учитель, который ведет данный предмет, временно отстутствует
    
-- Преподаватели у которых нет уроков
SELECT * FROM teacher T LEFT JOIN LESSON L 
ON T.id=L.teacher_id where L.id is null;

SELECT T.surname,T.salary,L.course FROM teacher T CROSS JOIN lesson L;
  
  -- Создание таблицы с товарами
   CREATE TABLE products (
     product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     category INT NULL,
     product_name VARCHAR(100) NOT NULL
   );

   -- Создание таблицы с категориями
   CREATE TABLE categories (
     category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
     category_name VARCHAR(100) NOT NULL
   );

   -- Добавление данных в таблицу с товарами
   INSERT INTO products(category, product_name)
     VALUES (1, 'Системный блок'),
            (1, 'Монитор'),
            (2, 'Холодильник'),
            (2, 'Телевизор'),
            (NULL, 'Операционная система');

   -- Добавление данных в таблицу с категориями
   INSERT INTO categories (category_name)
     VALUES ('Комплектующие компьютера'),
            ('Бытовая техника'),
            ('Мобильные устройства');

   SELECT * FROM products;
   SELECT * FROM categories;

-- Задание 2 FULL JOIN
SELECT p.product_name, c.category_name FROM products p
LEFT JOIN categories c ON p.category = c.category_id
UNION ALL
SELECT p.product_name, c.category_name FROM products p
RIGHT JOIN categories c ON p.category = c.category_id;

SELECT * FROM products CROSS JOIN categories;

-- UNION
SELECT * FROM users
UNION
SELECT * FROM clients;

SELECT * FROM users
UNION ALL
SELECT * FROM clients;

-- IN
SELECT 'A' IN ('A','B','C','D');
SELECT 'Z' IN ('A','B','C','D');
SELECT * FROM clients WHERE login IN ('mikle', 'tom', 'masha');
SELECT * FROM clients WHERE login !='mikle';

-- EXISTS
SELECT * FROM employee E WHERE EXISTS
(SELECT * from projects P where P.EmployeeId = E.Id);

SELECT EXISTS (SELECT Id FROM employee WHERE ID=1004);
