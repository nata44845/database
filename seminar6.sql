CREATE DATABASE IF NOT EXISTS lesson_6;

USE lesson_6;

CREATE TABLE staff ( 
 id INT PRIMARY KEY AUTO_INCREMENT,
 firstname VARCHAR(45) NOT NULL,
 lastname VARCHAR(45) NOT NULL,
 post VARCHAR(45) NOT NULL,
 seniority INT,
 salary DECIMAL(8,2),
 age INT
);
-- 4. Заполнение таблицы данных
INSERT INTO staff (firstname,lastname,post,seniority,salary,age)
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
('Люся','Люськина',	'Уборщик',	10,	10000,	49);

drop procedure if exists get_status;
delimiter //
create procedure get_status
(
in staff_number int,
out staff_status varchar(45)
) 
begin 
 declare staff_salary int;
 select salary into staff_salary
 from staff
 where staff_number = id;
 if staff_salary between 0 and 49999
	then set staff_status = 'Средняя ЗП';
 elseif staff_salary between 50000 and 69999
	then set staff_status = 'ЗП выше средней';
 elseif staff_salary >= 70000
    then set staff_status = 'Высокая ЗП';
 end if;
 
 end //
 
 call get_status(8, @res_out);
 
 select * from staff where id = 8;
 
 select @res_out;
 
 declare @date = (select date from table limit 1)
 
 
 
 DROP FUNCTION IF EXISTS get_age;
DELIMITER //
CREATE FUNCTION get_age
(
	date_bith DATE, -- 'yyyy-mm-dd': '2023-06-04'
    current_t DATETIME -- 2023-06-04 10:55:05 'yyyy-mm-dd hh:mm:ss'
)
RETURNS INT 
DETERMINISTIC 
    RETURN (YEAR(current_t) - YEAR(date_bith));
//



drop procedure if exists print_num;
delimiter //
create procedure print_num
(
input_num  int
)
begin
declare n int; 
declare result varchar(45) default "";
set n = input_num;
repeat
	set result = concat(result, n, " ");
    set n = n - 1;
    until n <= 0
    end repeat;
    select result;
 end //
 
 call print_num(10)
 
 
create table employees
 (
 id int primary key auto_increment,
 name varchar(50),
 salary decimal (10,2),
 last_updated timestamp 
 )

 delimiter //
 create trigger last_upd
 before update on employees
 for each row
 begin 
 set new.last_updated = now();
 end //


delimiter //

create procedure hello()
begin
case 
when curtime() between '06:00:00' and '12:00:00'
then select 'Доброе утро';
when curtime() between '12:00:00' and '18:00:00'
then select 'Добрый день';
when curtime() between '18:00:00' and '00:00:00'
then select 'Добрый вечер';
else select 'Доброй ночи';
end case;
end //