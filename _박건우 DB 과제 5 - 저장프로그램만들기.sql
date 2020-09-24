# 과제 저장프로그램 만들기
-- keonwoo Park 2020/09/24

use company;
show tables;

### 부서 이름을 입력 파라메터로 받아서, 그 부서에 근무하는 (소속된) 사원들의 급여의 평균을 
### 전달하는 저장 프로시저를 작성하시오.
drop procedure if exists getSalaryAvg;
delimiter $$
create procedure getSalaryAvg(in dn varchar(15) char set 'utf8' collate 'utf8_bin' , out avg_sal decimal(10,2))
begin
	declare sal int;
    declare total_sal int;
    declare cnt int;
    declare endOfRow boolean default false;
    declare cur1 cursor for
		(select salary from employee where dno in
			(select dnumber from department where dname = dn));
	declare continue handler for not found set endOfRow = true;
    set total_sal = 0;
    set cnt = 0;
    set avg_sal = 0;
    open cur1;
    cursor_loop: loop
			fetch cur1 into sal;
            if endOfRow then leave cursor_loop; end if;
            set total_sal = total_sal + sal;
            set cnt = cnt + 1;
	end loop cursor_loop;
    set avg_sal = total_sal / cnt;
    close cur1;
end $$
delimiter ;

### 위 프로시저를 호출하는 호출문 및 전달받은 결과 값을 출력하는 문장을 3개 이상 작성하시오.

call getSalaryAvg('Research', @avg_sal);
select @avg_sal;
call getSalaryAvg('영업부', @avg_sal);
select @avg_sal;
call getSalaryAvg('Administration', @avg_sal);
select @avg_sal;

### 위 프로시저를 저장 함수로 바꾸서 작성하시오.

drop function if exists getSalaryAvgFunc;
delimiter $$
create function getSalaryAvgFunc(dn varchar(15) char set 'utf8' collate 'utf8_bin')
	returns decimal(10,2)
begin
	declare avg_sal decimal(10,2);
    select avg(salary) into avg_sal from employee where dno in
		(select dnumber from department where dname = dn)
        group by dno;
        return avg_sal;
end $$
delimiter ;

### 위 저장 함수를 호출하는 문장을 3개 이상 작성하시오.

select getSalaryAvgFunc('Research');
select getSalaryAvgFunc('영업부');
select getSalaryAvgFunc('Administration');