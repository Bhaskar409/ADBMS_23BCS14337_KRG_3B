
--easy question
/*
GENERATE AN EMPLOYEE RELATIN WITH ONLY A ONE ATTRIBUTE I.E, EMP_ID
TASK: DIND THE MAX EMP_ID, BUT EXCLUDING THE DUPLICATES
*/
CREATE TABLE EMPLOYEE(
EMPID INT
);
INSERT INTO EMPLOYEE(EMPID) VALUES
(1),
(1),
(2),
(2),
(5),
(5),
(6),
(7),
(8),
(8);
SELECT MAX(EMPID) AS [MAX_UNIQUE] FROM Employee WHERE EmpID IN (SELECT EmpID FROM Employee GROUP BY EmpID HAVING count(EmpID)=1);

CREATE TABLE TBL_PRODUCTS
(
	ID INT PRIMARY KEY IDENTITY,
	[NAME] NVARCHAR(50),
	[DESCRIPTION] NVARCHAR(250) 
)

CREATE TABLE TBL_PRODUCTSALES
(
	ID INT PRIMARY KEY IDENTITY,
	PRODUCTID INT FOREIGN KEY REFERENCES TBL_PRODUCTS(ID),
	UNITPRICE INT,
	QUALTITYSOLD INT
)

INSERT INTO TBL_PRODUCTS VALUES ('TV','52 INCH BLACK COLOR LCD TV')
INSERT INTO TBL_PRODUCTS VALUES ('LAPTOP','VERY THIIN BLACK COLOR ACER LAPTOP')
INSERT INTO TBL_PRODUCTS VALUES ('DESKTOP','HP HIGH PERFORMANCE DESKTOP')


INSERT INTO TBL_PRODUCTSALES VALUES (3,450,5)
INSERT INTO TBL_PRODUCTSALES VALUES (2,250,7)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,4)
INSERT INTO TBL_PRODUCTSALES VALUES (3,450,9)


SELECT *FROM TBL_PRODUCTS
SELECT *FROM TBL_PRODUCTSALES

/*
TASK:FIND THE ID, NAME ,DESCRIPTION OF PRODUCT WHICH HAS NOT BEEN SOLD FOR ONCE.
*/

SELECT ID,[NAME],[DESCRIPTION] FROM TBL_PRODUCTS WHERE ID NOT IN
(SELECT DISTINCT PRODUCTID FROM TBL_PRODUCTSALES);

--USING JOIN
SELECT T.*,P.* FROM TBL_PRODUCTS AS T LEFT JOIN
TBL_PRODUCTSALES AS P
ON T.ID=P.PRODUCTID
WHERE PRODUCTID IS NULL;

/*
TASK: FIND THE TOTAL QUANTITY SOLD FOR EACH RESPECTIVE PRODUCT
*/
SELECT T.NAME, (SELECT SUM(QUALTITYSOLD) FROM TBL_PRODUCTSALES WHERE PRODUCTID=T.ID) AS QTY_SOLD FROM TBL_PRODUCTS AS T;

create database exp4;
use exp4;
--medium
--------------------EXPERIMENT 03: (MEDIUM LEVEL)
CREATE TABLE department (
    id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
-- Create Employee Table
CREATE TABLE employee (
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
);


-- Insert into Department Table
INSERT INTO department (id, dept_name) VALUES
(1, 'IT'),
(2, 'SALES');

-- Insert into Employee Table
INSERT INTO employee (id, name, salary, department_id) VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

--main
select d.dept_name,e.name,e.salary from employee as e
inner join department as d on d.id=e.department_id
where e.salary in(
select MAX(e2.salary) 
from employee as e2
where e2.department_id=e.department_id
)
order by  dept_name;

-- group by approach
select d.dept_name,e.name,e.salary from employee as e
inner join department as d on d.id=e.department_id
where e.salary in(
select MAX(e2.salary) 
from employee as e2
group by e2.department_id
);


--Hard Question
CREATE TABLE TableA (
    Empid INT,
    Ename VARCHAR(50),
    Salary INT
);

CREATE TABLE TableB (
    Empid INT,
    Ename VARCHAR(50),
    Salary INT
);

INSERT INTO TableA VALUES (1, 'AA', 1000), (2, 'BB', 300);
INSERT INTO TableB VALUES (2, 'BB', 400), (3, 'CC', 100);

--TIP; AFF OVER NUMBER DATA ONLY IS WRONG
--TAKE FIRST LETTER OF EMPNAME WILL CONVERT IN ASCII
select empid, ename ,MIN(salary) AS salary from(
select * from tableA as a
union all
select * from tableB as b
) as INTERMIDIATE_RESULT
group by empid,ename;
