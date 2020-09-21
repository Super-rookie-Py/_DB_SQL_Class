# keonwoo Park 2020/09/21 [과제] MariaDB에서 SQL문 실행하기 (1)

use company;
set sql_safe_updates = 0;
show tables;

### dept_locations 테이블에 애트리뷰트 phone을 추가하기
select * from dept_locations;
alter table dept_locations add column phone char(15);
select * from dept_locations;

### dept_locations 테이블에 있는 5개 튜플의 phone 애트리뷰트 값을 임의의 값으로 수정한 후 결과 확인하기
 
#첫번째 튜플 수정문
update dept_locations
set phone = '1234-1111-333'
where dnumber = 1 and dlocation = 'Houston'; 

#두번째 튜플 수정문
update dept_locations
set phone = '1234-1234-333'
where dnumber = 4 and dlocation = 'Stafford'; 

#세번째 튜플 수정문
update dept_locations
set phone = '1111-1234-111'
where dnumber = 5 and dlocation = 'Bellaire';

#네번째 튜플 수정문
update dept_locations
set phone = '4321-1234-111'
where dnumber = 5 and dlocation = 'Houston';

#다섯번째 튜플 수정문
update dept_locations
set phone = '5555-3333-222'
where dnumber = 5 and dlocation = 'Sugraland';
select * from dept_locations;

### project 테이블에 금액 이라는 이름의 애트리뷰트를 추가하기. 데이터 타입은 int로 할 것.

select * from project;
alter table project add column price int;
select * from project;

### project 테이블에 있는 6개 튜플의 금액 애트리뷰트 값을 임의의 값으로 수정하기.

update project
set price = 20000
where pnumber = 1;

update project
set price = 25000
where pnumber = 2;

update project
set price = 30000
where pnumber = 3;

update project
set price = 50000
where pnumber = 10;

update project
set price = 60000
where pnumber = 20;

update project
set price = 70000
where pnumber = 30;

select * from project;

### department 테이블에 아래 2개의 튜플을 추가하기
insert into department values('영업부', 7, '333445555', '1990-01-01');
insert into department values('비서실', 8, '999887777', '2010-01-01');
select * from department;

### dept_locations 테이블에 7번 부서의 위치 3개를 추가하기. 애트리뷰트 값은 임의로 부여함.

select * from dept_locations;
insert into dept_locations values(7, 'String', '7123-1111-123');
insert into dept_locations values(7, 'Humble', '9876-1111-123'); 
insert into dept_locations values(7, 'Stone', '7272-4321-111');  

select * from dept_locations;

### employee 테이블에 7번 부서에 근무하는 사원 3명을 추가하기. 애트리뷰트 값은 임의로 부여함.

select * from employee;
insert into employee values('Steven','P','Jobs', '111122444','1955-02-24',
'Market St, San Francisco, CA','M',80000,'987654321', 7);
insert into employee values('Elon','R','Musk', '113333777','1971-06-28',
'University Ave, Palo Alto, CA','M',100000,'666884444', 7);
insert into employee values('Warren','E','Buffett', '123123123','1930-08-30',
'801 S 10th St, Omaha, NE','M',120000,'888665555', 7);

select * from employee;

### works_on 테이블에 튜플 5개를 추가함. 애트리뷰트 값은 참조 무결성 조건을 만족하는 임의의 값을 부여함.

insert into works_on values('111122444',3,15.0);
insert into works_on values('113333777',30, 45.0);
insert into works_on values('123123123',20, 10.0);
insert into works_on values('123123123',10, 30.0);
insert into works_on values('123123123',2, 5.0);

select * from works_on;

### 30000 이상의 salary를 받는 사원의 ssn과 이름, 생일을 검색하기.
select lname, ssn, bdate from employee where salary>=30000;

###  5번 부서에 근무하는 사람 중에서 30000 이상 salary를 받는 사원의 ssn과 이름, 생일을 검색하기.
select lname, ssn, bdate from employee where salary>=30000 and dno = 5;

### 'Research' 부서에 근무하는 사람 중에서 30000 이상 salary를 받는 사원의 ssn과 이름, 생일을 검색하기.
select lname, ssn, bdate from employee, department 
where salary>=30000 and dnumber = dno and dname = 'Research'; 

### 'Research' 부서에 근무하는 사람들의 ssn과 그 사람이 참여하는 프로젝트 번호를 검색하기.
select ssn, pno from employee, department, works_on
where dno = dnumber and dname = 'Research' and ssn = essn;

### 'Research' 부서에 근무하는 사람들의 이름과 그 사람이 참여하는 프로젝트의 이름을 검색하기.
select lname, pname from employee, department, project ,works_on
where dname = 'Research' and dnumber = dno and essn = ssn and pno = pnumber;

### department 테이블에서 '영업부'의 부서번호, 관리자 사원번호(mgr_ssn)를 검색하기.
select dnumber, mgr_ssn from department where dname = '영업부';

### '영업부'가 위치한 위치의 위치(dlocation)과 전화번호(phone)을 검색하기.
select dlocation, phone from dept_locations as dl, department as d
where dl.dnumber = d.dnumber and dname = '영업부';

### 사원의 이름(fname, lname)과 그 사원의 감독자(멘토)의 이름(fname, lname)을 검색하기.
select e.fname, e.lname, s.fname, s.lname from employee as e, employee as s
where e.super_ssn = s.ssn;

### 사원의 소속부서와 그 사원의 감독자(멘토)의 소속부서가 서로 다른 사원의 이름과 감독자(멘토)의 이름을 검색하기
select e.fname, e.lname, s.fname, s.lname from employee as e, employee as s, department as ed, department as sd 
where e.super_ssn = s.ssn and ed.dnumber = e.dno and sd.dnumber = s.dno and ed.dnumber != sd.dnumber;
