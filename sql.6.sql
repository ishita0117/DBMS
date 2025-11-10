create database Employeedb;
use Employeedb;

create table employee(empno int, ename varchar(20), mgr_no int, hiredate date, sal int, deptno int, primary key(empno));

insert into employee values(100, "koko", 1, "2005-01-17", 5500, 3);
insert into employee values(101, "toko", 2, "2005-01-18", 5000, 4);
insert into employee values(102, "boko", 3, "2005-01-19", 6500, 5);
insert into employee values(103, "moko", 4, "2005-01-12", 6000, 6);
insert into employee values(104, "poko", 5, "2005-01-13", 8500, 7);

select * from employee;

create table incentives(empno int, incentive_date date, incentive_amount int, primary key(incentive_date), foreign key(empno) references employee (empno));

insert into incentives values(100, "2009-06-12", 10000);
insert into incentives values(101, "2009-06-22", 6000);
select * from incentives;

create table dept(deptno int primary key, dname varchar(20), dloc varchar(30));

insert into dept values (200, "tomo", "cr-07");
insert into dept values (201, "yomo", "cr-08");
insert into dept values (202, "lomo", "cr-09");
insert into dept values (203, "pomo", "cr-10");
insert into dept values (204, "domo", "cr-11");

select * from dept;

create table project(pno int primary key, ploc varchar(30), pname varchar(20));

insert into project values(33, "pr-112", "data visuals");
insert into project values(34, "pr-113", "codelocks");
insert into project values(35, "pr-114", "cloud infra");
insert into project values(36, "pr-115", "mobile app redesign");
insert into project values(37, "pr-116", "api integration");
select * from project;


create table assi(empno int, pno int, job_role varchar(30), foreign key(empno) references employee(empno), foreign key(pno) references project(pno));

INSERT INTO assi VALUES(102, 34, 'Project Manager');
INSERT INTO assi VALUES(103, 33, 'Lead Developer');
INSERT INTO assi VALUES(104, 35, 'UX Designer');
INSERT INTO assi VALUES(100, 36, 'QA Tester');
INSERT INTO assi VALUES(101, 37, 'Database Admin');

SELECT * FROM assi;

SELECT
    M.ename AS Manager_Name,
    COUNT(E.empno) AS Number_of_Employees
FROM
    employee E
INNER JOIN
    employee M 
ON
    E.mgr_no = M.empno
GROUP BY
    M.ename
ORDER BY
    Number_of_Employees DESC
LIMIT 1;

WITH SubordinateAvgSalary AS (
    
    SELECT
        mgr_no,
        AVG(sal) AS Avg_Subordinate_Salary
    FROM
        employee
    WHERE
        mgr_no IS NOT NULL 
    GROUP BY
        mgr_no
)

SELECT
    M.ename AS Manager_Name
FROM
    employee M 
INNER JOIN
    SubordinateAvgSalary SAS ON M.empno = SAS.mgr_no 
WHERE
    M.sal > SAS.Avg_Subordinate_Salary; 
    

WITH SubordinateAvgSalary AS (
    SELECT
        mgr_no,
        AVG(sal) AS Avg_Subordinate_Salary
    FROM
        employee
    WHERE
        mgr_no IS NOT NULL
    GROUP BY
        mgr_no
)
SELECT
    M.ename AS Manager_Name
FROM
    employee M
INNER JOIN
    SubordinateAvgSalary SAS ON M.empno = SAS.mgr_no
WHERE
    M.sal > SAS.Avg_Subordinate_Salary;
    
    SELECT
    E.empno,
    E.ename,
    I.incentive_amount,
    I.incentive_date
FROM
    employee E
JOIN
    incentives I ON E.empno = I.empno
WHERE
    -- Filter for the specific month/year, if data existed
    I.incentive_date BETWEEN '2019-01-01' AND '2019-01-31'
ORDER BY
    I.incentive_amount DESC
LIMIT 1 OFFSET 1;


SELECT
    E.ename AS Employee_Name,
    M.ename AS Manager_Name,
    E.deptno AS Department_Number
FROM
    employee E -- E represents the Employee (Subordinate)
JOIN
    employee M ON E.mgr_no = M.empno -- M represents the Manager
WHERE
    E.deptno = M.deptno; -- Condition: Employee's deptno equals Manager's deptno