# keonwoo Park 2020/09/22
-- 추가적인 SELECT 문

use company;
select * from department;
select dname as dept_name, mgr_ssn as manager_ssn from department;
-- 오류 select * from department as d(dn, dnum, m_ssn, m_date) where dno = 5;

select salary from employee where dno = 5
union
select salary from employee where dno = 4;

select * from employee where super_ssn is null;
select * from employee where super_ssn is not null
order by lname desc, fname asc;

-- 중첩 질의

select fname, lname from employee, department 
where dname = 'Research' and dno = dnumber;

select fname, lname from employee
where dno in (select dnumber from department where dname = 'Research');

select fname, lname from employee as e
where exists (select * from department as d where dname = 'Research' and
d.dnumber = e.dno);

select essn from works_on where pno = 2;
select ssn from employee
where ssn not in (select essn from works_on where pno = 2);

select ssn from employee as e
where not exists ( select * from works_on as w where pno=2 and w.essn = e.ssn);

select * from dependent;
select fname, lname, dependent_name from employee, dependent
where ssn = essn;

select fname, lname from employee where ssn not in
(select essn from dependent);

select fname, lname from employee where not exists
(select * from dependent where ssn = essn);


-- 조인된 테이블

select fname, lname, address from employee, department
where dname = 'Research' and dno= dnumber;

select fname, lname, address 
from employee join department on dno = dnumber
where dname = 'Research';

select fname, lname from employee, works_on, project
where pname = 'ProductX' and pnumber = pno and essn = ssn;

select fname, lname from (employee join works_on on ssn=essn)
join project on pnumber = pno
where pname = 'ProductX';

select dname, dlocation from department as d, dept_locations as l
where d.dnumber = l.dnumber and d.dname = 'Research';

select * from department as d join dept_locations as l
on d.dnumber = l.dnumber;

select * from department natural join dept_locations;

select fname, lname, dependent_name, relationship
from employee, dependent where ssn=essn;

select fname, lname dependent_name, relationship
from employee left outer join dependent on ssn = essn;


-- 집계함수 및 추가기능

select * from employee;
select sum(salary), max(salary), min(salary), avg(salary)
from employee;

select dno, sum(salary), max(salary), min(salary), avg(salary)
from employee group by dno;

select dname, count(*), sum(salary), avg(salary)
from employee, department where dno= dnumber
group by dname;

select * from works_on;
select essn, count(*), sum(hours) from works_on
group by essn having count(*) >=3;

select pno, count(*), sum(hours) from works_on
group by pno having count(*) >= 3;

create view works_on1
as select fname, lname, pname, hours from employee, project, works_on
where ssn=essn and pnumber = pno;

select * from works_on1;
select * from works_on1 where pname = 'ProductX';
select pname, count(*), sum(hours) from works_on1
group by pname;