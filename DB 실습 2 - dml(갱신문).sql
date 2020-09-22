show databases;
use company;
show tables;

insert into department values 
('Research', 5, '333445555', '1988-05-22');
select * from department;
insert into department values 
('Administration', 4, '987654321', '1995-01-01');
insert into department values 
('Headquarters', 1, '888665555', '1981-06-19');
insert into department values
('Finance', 6, '123456789','1999-01-02');

insert into employee values ('John', 'B','Smith','123456789',
'1965-01-09','731 Fondrein, Houston, TX', 'M', 30000,'333445555',5);
insert into employee values ('Franklin', 'T','Wong','333445555',
'1955-12-08','648 Voss, Houston, TX', 'M', 40000,'888665555',5);
insert into employee values ('Alicia', 'J','Zelaya','999887777',
'1968-01-19','3321 Castle, Spring, TX', 'F', 25000,'987654321',4);
insert into employee values ('Jeniifer', 'S','Wallace','987654321',
'1941-06-20','291 Berry, Bellair, TX', 'F', 43000,'888665555',4);
insert into employee values ('Ramesh', 'K','Narayan','666884445',
'1962-09-15','975 Fire Oak, Humble, TX', 'M', 38000,'333445555',5);
Update employee
set ssn = '666884444'
where ssn = '666884445';
insert into employee values ('Joyce', 'A','English','453453453',
'1972-07-31','5631 Rice, Houston, TX', 'F', 25000,'333445555',5);
insert into employee values ('Ahmed', 'V','Jabbar','987987987',
'1969-03-29','980 Dollas, Houston, TX', 'M', 25000,'987654321',4);
insert into employee values ('James', 'E','Borg','888665555',
'1937-11-10','450 Stone, Houston, TX', 'M', 55000, null,1);
select * from employee;

insert into dept_locations values(1, 'Houston');
insert into dept_locations values(4, 'Stafford');
insert into dept_locations values(5, 'Bellair');
update dept_locations
set dlocation = "Bellaire"
where dlocation = "Bellair" and dnumber = 5;
insert into dept_locations values(5, 'Sugraland');
insert into dept_locations values(5, 'Houston');
select * from dept_locations;

insert into project values ('productX', 1, 'Bellaire', 5);
insert into project values ('productY', 2, 'Sugarland', 5);
insert into project values ('productZ', 3, 'Houston', 5);
insert into project values ('Computerization', 10, 'Stafford', 4);
insert into project values ('Reorganization', 20, 'Houston', 1);
insert into project values ('Newbenefits', 30, 'Stafford', 4);
select * from project;

insert into works_on values('123456789' , 1, 32.5);
insert into works_on values('123456789' , 2, 15);
insert into works_on values('666884444' , 3, 40.0);
insert into works_on values('453453453' , 1, 20.0);
insert into works_on values('453453453' , 2, 20.0);
select * from works_on;
insert into works_on values('333445555', 2, 10.0);
insert into works_on values('333445555', 3, 10.0);
insert into works_on values('333445555', 10, 10.0);
insert into works_on values('333445555', 20, 10.0);
insert into works_on values('999887777', 30, 30.0);
insert into works_on values('999887777', 10, 10.0);
insert into works_on values('987987987', 10, 35.0);
insert into works_on values('987987987', 30, 5.0);
insert into works_on values('987654321', 30, 20.0);
insert into works_on values('987654321', 20, 15.0);
insert into works_on values('888665555', 20, 20.0);

insert into dependent values
('333445555','Alice', 'F','1986-04-05','Daughter');
insert into dependent values
('333445555','Theodore', 'M','1983-10-25','Son');
insert into dependent values
('333445555','Joy', 'F','1958-05-03','Spouse');
insert into dependent values
('987654321','Abner', 'M','1942-02-28','Spouse');
insert into dependent values
('123456789','Michael', 'M','1988-01-04','Son');
insert into dependent values
('123456789','Alice', 'F','1988-12-30','Daughter');
insert into dependent values
('123456789','Elizabeth', 'F','1967-05-05','Spouse');
select * from dependent;