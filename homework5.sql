-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов

CREATE VIEW vv_cars AS
SELECT * FROM cars
WHERE Cost<25000;

-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)

ALTER VIEW vv_cars AS
SELECT * FROM cars
WHERE Cost<30000;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” (аналогично)

CREATE VIEW vv_cars_sa AS
SELECT * FROM cars
WHERE Name in ('Skoda', 'Audi');


/* 4. Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
Есть таблица анализов Analysis:
an_id — ID анализа;
an_name — название анализа;
an_cost — себестоимость анализа;
an_price — розничная цена анализа;
an_group — группа анализов.

Есть таблица групп анализов Groups:
gr_id — ID группы;
gr_name — название группы;
gr_temp — температурный режим хранения.

Есть таблица заказов Orders:
ord_id — ID заказа;
ord_datetime — дата и время заказа;
ord_an — ID анализа. */

SELECT A.an_name, O.ord_datetime 
FROM Analyses A JOIN Orders ON O.ord_an=A.an_id
AND O.ord_datetime BETWEEN '20200205' AND '20200212';

-- 5. Добавьте новый столбец под названием «время до следующей станции». 
-- Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
-- Мы можем вычислить это значение без использования оконной функции SQL, но это может быть очень сложно. 
-- Проще это сделать с помощью оконной функции LEAD . 
-- Эта функция сравнивает значения из одной строки со следующей строкой, чтобы получить результат. 
-- В этом случае функция сравнивает значения в столбце «время» для станции со станцией сразу после нее.
CREATE TABLE train (
 train_id INT NOT NULL,
 station VARCHAR(20) NOT NULL,
 station_time TIME NOT NULL
);

INSERT INTO train VALUES
(110,'San Francisco','10:00:00'),
(110,'Redwood City','10:54:00'),
(110,'Palo Alto','11:02:00'),
(110,'San Jose','12:35:00'),
(120,'San Francisco','11:00:00'),
(120,'Palo Alto','12:49:00'),
(120,'San Jose','13:30:00');

with Train AS 
(SELECT train.*,
LEAD(station_time) OVER(PARTITION BY train_id) AS next_time
FROM train)
SELECT train_id,station,station_time, 
COALESCE(TIMEDIFF(next_time,station_time),'') time_to_next_station 
FROM Train;