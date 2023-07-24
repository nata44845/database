use homework4;

-- Рекурсия

WITH RECURSIVE sequence(n) AS
	(SELECT 0
    UNION ALL
    SELECT n+1 FROM sequence WHERE n+1<=100
    )
SELECT n FROM sequence;

WITH RECURSIVE sequence (c) AS
(
SELECT 'A'
UNION ALL
SELECT CHAR(ORD(c) + 1) FROM sequence
WHERE CHAR(ORD(c) + 1) <= 'Z'
)
SELECT c FROM sequence;

/* Задача 1
В этой задаче мы распределяем места в некоем зале (театральном). Для целей бизнеса
требуется каждому месту присваивать так называемую «группировку» (grouping) —
дополнительный номер, представляющий его. Вот алгоритм определения значения
группировки:

1. начинаем с 0 и верхнего левого места;
2. если есть пустующее место между текущим и предшествующим или это новый ряд,
то прибавляем 2 к прошлому значению (если это не абсолютно первое место), в
противном случае — увеличиваем значение на 1;
3. присваиваем группировку месту;
4. переходим к новому месту в том же ряду или к следующему ряду (если
предыдущий закончился) и повторяем с пункта 2; продолжаем всё до тех пор, пока
места не закончатся*/

CREATE TABLE seats
(
id INT AUTO_INCREMENT PRIMARY KEY,
venue_id INT,
y INT,
x INT,
`row` VARCHAR(16),
number INT,
`grouping` INT,
UNIQUE venue_id_y_x (venue_id, y, x)
);

INSERT INTO seats(venue_id, y, x, `row`, number)
WITH RECURSIVE venue_ids (id) AS (
SELECT 0
UNION ALL
SELECT id + 1 FROM venue_ids WHERE id + 1 < 200
)
SELECT /*+ SET_VAR(cte_max_recursion_depth = 1M) */
v.id, c.y, c.x, CHAR (ORD ('A') + FLOOR (RAND() *3) USING ASCII) `row`,
FLOOR (RAND() * 3) `number`
FROM venue_ids v
JOIN
(VALUES ROW(0,0),ROW(0,1),ROW(1,0),ROW(1,2),ROW(2,0)) c (y, x);

SELECT * FROM seats;

-- Оконные функции
CREATE TABLE people(
gender VARCHAR(1) NOT NULL, 
name VARCHAR(20) NOT NULL
);

INSERT INTO people (gender, name)
VALUES 
	('М','Александр'),
    ('М','Федор'),
    ('М','Алексей'),
    ('Ж','Мария'),
    ('Ж','Александра');

WITH man AS (SELECT gender AS man, name AS man_name, row_number() OVER() id FROM people WHERE gender = 'М'),
	 woman AS (SELECT gender AS woman, name AS woman_name, row_number() OVER() id FROM people WHERE gender = 'Ж')
SELECT * FROM man LEFT JOIN woman ON man.id=woman.id;      

-- Оконные функции 2
CREATE TABLE bank (
 TB VARCHAR(1) NOT NULL,
 ID_CLIENT INT NOT NULL,
 ID_DOG INT NOT NULL,
 OSZ INT NOT NULL,
 PROCENT_RATE INT NOT NULL,
 RATING INT NOT NULL,
 SEGMENT VARCHAR(10) NOT NULL
);

INSERT INTO bank 
VALUES 
 ('A',2,333,50,9,15,'MMB'),
 ('A',1,111,100,6,10,'SREDN'),
 ('A',1,222,150,6,10,'SREDN'),
 ('B',3,555,1000,5,16,'CIB'),
 ('B',4,666,500,10,20,'CIB'),
 ('B',4,777,10,12,17,'MMB'),
 ('B',1,444,200,7,10,'SREDN'),
 ('C',5,888,20,11,21,'MMB'),
 ('C',5,999,200,9,13,'SREDN');
 
--  Максимальная задолженность в разбивке по банка
-- Средняя процентная ставка в разрезе банка и сегмента
-- Всего договоров во всех банках

SELECT bank.*,
MAX(OSZ) OVER(PARTITION BY TB) max_osz,
AVG(PROCENT_RATE) OVER(PARTITION BY TB,SEGMENT) avg_pr,
count(*) OVER() count_all
from bank;

-- Оконные функции 3
CREATE TABLE revisions (
 TB VARCHAR(1) NOT NULL,
 DEP VARCHAR(20) NOT NULL,
 COUNT_REVISIONS INT NOT NULL);
 
INSERT INTO revisions
VALUES 
 ('A','Corp',100),
 ('A','Rozn',47),
 ('A','IT',86),
 ('B','Corp',70),
 ('B','Rozn',65),
 ('B','IT',58),
 ('C','Corp',42),
 ('C','Rozn',40),
 ('C','IT',63),
 ('D','Corp',95),
 ('D','Rozn',120),
 ('D','IT',85),
 ('E','Corp',70),
 ('E','Rozn',72),
 ('E','IT',80),
 ('F','Corp',66),
 ('F','Rozn',111),
 ('F','IT',33);
 
-- Найти второй отдел во всех банках по количеству ревизий.

SELECT r.*,
row_number() OVER(ORDER BY count_revisions desc) id,
rank() OVER(ORDER BY count_revisions desc) rnk,
dense_rank() OVER(ORDER BY count_revisions desc) drnk,
NTILE(5) OVER(ORDER BY count_revisions desc) ntl
FROM revisions r;

With T_R as
(SELECT * , DENSE_RANK() OVER(PARTITION BY tb ORDER BY count_revisions desc) ds
FROM revisions)
SELECT tb,dep,count_revisions FROM T_R WHERE ds=2;

-- Оконные функции смещения
CREATE TABLE task (
 id_task INT NOT NULL,
 event VARCHAR(20) NOT NULL,
 date_event DATE NOT NULL
);

INSERT INTO TASK 
VALUES 
 (1,'Open','20200201'),
 (1,'To_1_Line','20200202'),
 (1,'To_2_Line','20200203'),
 (1,'Successful','20200204'),
 (1,'Closed','20200205'),
 (2,'Open','20200301'),
 (2,'To_1_Line','20200302'),
 (2,'Denied','20200303'),
 (3,'Open','20200401'),
 (3,'To_1_Line','20200402'),
 (3,'To_2_Line','20200403');
 
SELECT t.*,
LAG(event,1,'BEGIN') OVER(partition by id_task) pre,
LEAD(event,1,'END') OVER(partition by id_task) nxt
FROM task t;