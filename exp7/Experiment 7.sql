-- ----------------EXPERIMENT 07----------------------------------


-- ----------------------MEDIUM LEVEL PROBLEM----------------------------


-- REQUIREMENTS: DESIGN A TRIGGER WHICH:
-- 1. WHENEVER THERE IS A INSERTION OR DELETION ON STUDENT TABLE THEN,
--    THE CURRENTLY INSERTED OR DELETED ROW SHOULD BE PRINTED ON THE CONSOLE.

-- create student table for testing
CREATE TABLE IF NOT EXISTS student (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER,
    class TEXT
);

-- function for student audit (prints inserted/deleted row using RAISE NOTICE)
CREATE OR REPLACE FUNCTION fn_student_audit()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        RAISE NOTICE 'Inserted Row -> ID: %, Name: %, Age: %, Class: %',
                     NEW.id, NEW.name, NEW.age, NEW.class;
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        RAISE NOTICE 'Deleted Row -> ID: %, Name: %, Age: %, Class: %',
                     OLD.id, OLD.name, OLD.age, OLD.class;
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- trigger for student table
DROP TRIGGER IF EXISTS trg_student_audit ON student;
CREATE TRIGGER trg_student_audit
AFTER INSERT OR DELETE ON student
FOR EACH ROW
EXECUTE FUNCTION fn_student_audit();


-- ----------------------HARD LEVEL PROBLEM----------------------------

/*
 Requirements: DESIGN POSTGRESQL TRIGGERS THAT:
   - Whenever a new employee is inserted in tbl_employee, a record should be added to tbl_employee_audit:
       "Employee name <emp_name> has been added at <current_time>"
   - Whenever an employee is deleted from tbl_employee, a record should be added to tbl_employee_audit:
       "Employee name <emp_name> has been deleted at <current_time>"
*/

-- Create employee tables
CREATE TABLE IF NOT EXISTS tbl_employee (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100) NOT NULL,
    emp_salary NUMERIC
);

CREATE TABLE IF NOT EXISTS tbl_employee_audit (
    sno SERIAL PRIMARY KEY,
    message TEXT
);

-- function to insert audit messages into tbl_employee_audit
CREATE OR REPLACE FUNCTION audit_employee_changes()
RETURNS TRIGGER
LANGUAGE plpgsql
AS
$$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES (
            'Employee name ' || NEW.emp_name || ' has been added at ' ||
            to_char(NOW(), 'YYYY-MM-DD HH24:MI:SS')
        );
        RETURN NEW;

    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO tbl_employee_audit(message)
        VALUES (
            'Employee name ' || OLD.emp_name || ' has been deleted at ' ||
            to_char(NOW(), 'YYYY-MM-DD HH24:MI:SS')
        );
        RETURN OLD;
    END IF;

    RETURN NULL;
END;
$$;

-- trigger for tbl_employee
DROP TRIGGER IF EXISTS trg_employee_audit ON tbl_employee;
CREATE TRIGGER trg_employee_audit
AFTER INSERT OR DELETE ON tbl_employee
FOR EACH ROW
EXECUTE FUNCTION audit_employee_changes();


-- ------------------ TESTING THE TRIGGERS --------------------

-- clear tables for a clean test (optional)
TRUNCATE TABLE tbl_employee_audit RESTART IDENTITY;
TRUNCATE TABLE tbl_employee RESTART IDENTITY;
TRUNCATE TABLE student RESTART IDENTITY;

-- Test student trigger (you should see RAISE NOTICE messages in the console)
INSERT INTO student(name, age, class) VALUES ('Aniket', 15, '10A');
INSERT INTO student(name, age, class) VALUES ('Tanmay', 16, '11B');
DELETE FROM student WHERE name = 'Aniket';

-- Test employee trigger
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Jyoti', 50000);
INSERT INTO tbl_employee(emp_name, emp_salary) VALUES ('Neha', 65000);

DELETE FROM tbl_employee WHERE emp_name = 'Jyoti';

-- Check audit logs
SELECT * FROM tbl_employee_audit ORDER BY sno;
