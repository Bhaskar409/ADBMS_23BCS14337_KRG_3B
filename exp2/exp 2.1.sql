/*
Experiment - 2.1
Problem Title: Employee-Manager Mapping Using Self-Join

You are a Database Engineer at TalentTree Inc., an enterprise HR analytics platform that stores employee data, including their reporting relationships.

Each employee has: 
- ID
- Name
- Department
- ManagerID (who is also an employee)

Goal: Generate a report that maps employees to their managers, showing:
- Employee Name and Department
- Manager Name and Department
*/

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50),
    Department VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),
(2, 'Bob', 'HR', 1),
(3, 'Charlie', 'Finance', 1),
(4, 'David', 'Finance', 3),
(5, 'Eve', 'Tech', 2),
(6, 'Frank', 'Tech', 2);

SELECT 
    E.EmpName AS Employee_Name,
    E.Department AS Employee_Department,
    M.EmpName AS Manager_Name,
    M.Department AS Manager_Department
FROM 
    Employee E
LEFT JOIN 
    Employee M
ON 
    E.ManagerID = M.EmpID;
