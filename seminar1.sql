create database if not exists db1;

create table if not exists db1.student (
 name VARCHAR(50),
 course_name varchar(50),
 date_of_birth date,
 email varchar(50),
 phone_number varchar(50)
);

create table if not exists db1.teacher (
 name VARCHAR(50),
 post varchar(50),
 course_name varchar(50)
);

create table if not exists db1.course (
 name_student VARCHAR(50),
 name_teacher VARCHAR(50),
 course_name varchar(50)
);

insert into student 
values 
('Иван', 'Тестировщик','1988-01-19','ivan@mail.ru','79999599999'),
('Алексей', 'JavaScript','2000-08-19','alexey@mail.ru','79999499999'),
('Петр', 'Аналитика','2004-08-20','petr@mail.ru','79999999999');

insert into course
values 
('Иван', 'Афанасий','Тестировщик'),
('Алексей', 'Геннадий','JavaScript'),
('Петр', 'Евгений','Аналитика');

insert into teacher
values 
('Афанасий','Преподаватель','Тестировщик'),
('Геннадий','Ассистент','JavaScript'),
('Евгений','Преподаватель','Аналитика');



