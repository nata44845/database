-- 1. Вывести на экран сколько машин каждого цвета для машин марок BMW и LADA

SELECT mark, COUNT(*) FROM auto
WHERE mark in ('BMW','LADA')
GROUP BY mark
ORDER BY mark;

-- 2. Вывести на экран марку авто и количество AUTO не этой марки

SELECT mark, COUNT(*) FROM auto
WHERE mark NOT in ('BMW','LADA')
GROUP BY mark
ORDER BY mark;

-- Задание 3
create table test_a (id int, data varchar(1));
create table test_b (id int);
insert into test_a(id, data) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');
insert into test_b(id) values
(10),
(30),
(50);

-- Напишите запрос, который вернет строки из таблицы test_a, 
-- id которых нет в таблице test_b, НЕ используя ключевого слова NOT.

SELECT test_a.* from test_a
LEFT JOIN test_b ON test_a.id=test_b.id
WHERE test_b.id is null;