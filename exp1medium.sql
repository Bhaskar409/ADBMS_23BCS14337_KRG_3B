use clg;


--Tables
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);


CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


-- Insert
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical Engineering'),
(3, 'Electrical Engineering'),
(4, 'Civil Engineering'),
(5, 'Mathematics'),
(6, 'Physics');

INSERT INTO Courses (course_id, course_name, dept_id) VALUES
(101, 'Data Structures', 1),
(102, 'Database Systems', 1),
(103, 'Operating Systems', 1),

(104, 'Thermodynamics', 2),
(105, 'Fluid Mechanics', 2),

(106, 'Circuits Analysis', 3),
(107, 'Power Systems', 3),

(108, 'Structural Engineering', 4),
(109, 'Geotechnical Engineering', 4),

(110, 'Linear Algebra', 5),
(111, 'Calculus', 5),

(112, 'Quantum Mechanics', 6);



SELECT dept_name
FROM Departments
WHERE dept_id IN (
    SELECT dept_id
    FROM Courses
    GROUP BY dept_id
    HAVING COUNT(course_id) > 2
);


-- Create user 
CREATE LOGIN bhaskar WITH PASSWORD = 'password123';

CREATE USER bhaskar FOR LOGIN bhaskar;

GRANT SELECT ON dbo.Courses TO bhaskar;
GO

