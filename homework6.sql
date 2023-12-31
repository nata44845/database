USE lesson_6;

/*1. Создайте функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '*/

drop procedure if exists get_days_hours;
delimiter //
create procedure get_days_hours
(
	num int
) 
begin 
 declare days varchar(100);
 set days=concat(FLOOR(num/(24*60*60)),' дней ',
 FLOOR(num%(24*60*60)/(60*60)),' часов ',FLOOR(num%(60*60)/60),' минут ',num%60,' секунд');
 select days;
end //

call get_days_hours(123456);

/*2. Выведите только четные числа от 1 до 10. 
Пример: 2,4,6,8,10 Данная промежуточная аттестация оценивается по системе "зачет" / "не зачет" 
"Зачет" ставится, если слушатель успешно выполнил 1 или 2 задачи 
"Незачет" ставится, если слушатель успешно выполнил 0 задач 
Критерии оценивания: 
1 - слушатель верно создал функцию, которая принимает кол-во сек и формат их в кол-во дней часов. 
2 - слушатель выведили только четные числа от 1 до 10.*/

drop procedure if exists print_num;
delimiter //
create procedure print_num
(
    num int
)
begin
declare n int; 
declare result varchar(45) default "";
set n = 2;
repeat
	set result = concat(result, n, " ");
    set n = n + 2;
    until n > num
end repeat;
select result;
end //

call print_num(30);

