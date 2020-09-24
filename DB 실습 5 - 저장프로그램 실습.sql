# 저장프로그램 작성 예제
-- keonwoo Park 2020/09/24

use company;
show tables;
select * from employee;
select * from project;

drop procedure if exists getDnum;
delimiter $$
create procedure getDnum (in pid int, out dn int)
begin
	select dnum into dn from project where pnumber = pid;
end $$
delimiter ;

call getDnum(1, @dd);
select @dd;
call getDnum(10, @dd);
select @dd;
call getDnum(30, @dd);
select @dd;

select * from project;

drop procedure if exists getPname;
delimiter $$
create procedure getPname(in pid int, out pn varchar(15))
begin
	select pname into pn from project where pnumber = pid;
end $$
delimiter ;

call getPname(1, @pp);
select @pp;
call getPname(2, @pn);
select @pn;

-- employee 테이블에는 한글이 없어서 department 테이블로 대체

select * from department;

drop procedure if exists getDname;
delimiter $$
create procedure getDname (in dno int(11), out dna varchar(15), out mgr char(9) )
begin
	select dname, mgr_ssn into dna, mgr from department where dnumber = dno;
end $$
delimiter ;

call getDname(1, @dname, @mgr);
select @dname, @mgr;
call getDname(5, @dname, @mgr);
select @dname, @mgr;
call getDname(7, @dname, @mgr);

drop procedure if exists getDname2;
delimiter $$
create procedure getDname2 (in dno int(11),
out dna varchar(15) character set 'utf8' collate 'utf8_bin', out mgr char(9) )
begin
	select dname, mgr_ssn into dna, mgr from department where dnumber = dno;
end $$
delimiter ;

call getDname2(1, @dname, @mgr);
select @dname, @mgr;
call getDname2(7, @dname, @mgr);
select @dname, @mgr;
call getDname2(8, @dname, @mgr);
select @dname, @mgr;

drop function if exists getEnameFunc;
delimiter $$
create function getEnameFunc (sn char(9))
		returns varchar(15) character set 'utf8' collate 'utf8_bin'
begin
		declare ln varchar(15) character set 'utf8' collate 'utf8_bin';
		select lname into ln from employee where ssn = sn;
		return ln;
end $$
delimiter ;

select getEnameFunc('123456789');
select getEnameFunc('987654321');

### 커서의 사용 실습
drop procedure if exists getSalarySsn;
delimiter $$
create procedure getSalarySsn(in sn char(9), out inc_sal int)
begin
	declare sal int;
    select salary into sal from employee where ssn= sn;
    set inc_sal = sal * 1.1;
end $$
delimiter ;

call getSalarySsn('123456789', @inc_salary);
select @inc_salary;
call getSalarySsn('987654321', @inc_salary);
select @inc_salary;
select * from employee;

drop procedure if exists getSalaryDno;
delimiter $$
create procedure getSalaryDno(in dn int, out inc_sal int)
begin
	declare sal int;
    select salary into sal from employee where dno= dn;
    set inc_sal = sal * 1.1;
end $$
delimiter ;

call getSalaryDno (5, @inc_salary);

drop procedure if exists getSalaryDnoCur;
delimiter $$
create procedure getSalaryDnoCur( in dn int, out total_sal int ,out cnt int)
begin
	declare sal int;
    declare endOfRow boolean default false;
    declare cur1 cursor for
		select salary from employee where dno=dn;
    declare continue handler for not found set endOfRow = True;
    
    set total_sal = 0;
    set cnt = 0;
    
    open cur1;
    
    cursor_loop: Loop
		fetch cur1 into sal;
		if endOfRow then leave cursor_loop; end if;
		set total_sal = total_sal + sal;
		set cnt = cnt + 1;
	end loop cursor_loop;
    close cur1;
end $$
delimiter ;

call getSalaryDnoCur(5, @total_sal, @cnt);
select @total_sal, @cnt;
call getSalaryDnoCur(1, @total_sal, @cnt);
select @total_sal, @cnt;
call getSalaryDnoCur(4, @total_sal, @cnt);
select @total_sal, @cnt;
call getSalaryDnoCur(7, @total_sal, @cnt);
select @total_sal, @cnt;