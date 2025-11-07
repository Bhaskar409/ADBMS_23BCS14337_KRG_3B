------------------------------Experiment 08-------------------------------
---------------------Hard Level Problem-----------------------------
/*
Design a robust PostgreSQL transaction system for the students table where multiple student 
records are inserted in a single transaction. 

If any insert fails due to invalid data, only that insert should be rolled back while preserving the 
previous successful inserts using savepoints. 

The system should provide clear messages for both successful and failed insertions, ensuring data integrity 
and controlled error handling.

HINT: YOU HAVE TO USE SAVEPOINTS
*/

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE,
    age INT,
    class INT
);

-- ===================== SUCCESSFUL SCENARIO =====================

DO $$
BEGIN
    -- Start main transaction block
    RAISE NOTICE '--- Starting Transaction (Successful Scenario) ---';

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Tanmay', 18, 10);
        RAISE NOTICE 'Inserted: Tanmay';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Tanmay';
    END;

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Aniket', 19, 8);
        RAISE NOTICE 'Inserted: Aniket';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Aniket';
    END;

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Jyoti', 20, 9);
        RAISE NOTICE 'Inserted: Jyoti';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Jyoti';
    END;

    RAISE NOTICE 'Transaction Completed Successfully!';
END;
$$;

SELECT * FROM students;


-- ===================== VIOLATED SCENARIO =====================

DO $$
BEGIN
    RAISE NOTICE '--- Starting Transaction (Violated Scenario) ---';

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Tanmay', 16, 8);  -- duplicate (error)
        RAISE NOTICE 'Inserted: Tanmay';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Tanmay (duplicate entry)';
    END;

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Aniket', 19, 9);  -- duplicate (error)
        RAISE NOTICE 'Inserted: Aniket';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Aniket (duplicate entry)';
    END;

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Jyoti', 17, 8);   -- duplicate (error)
        RAISE NOTICE 'Inserted: Jyoti';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Jyoti (duplicate entry)';
    END;

    BEGIN
        INSERT INTO students(name, age, class) VALUES ('Keshav', 19, 9);  -- success
        RAISE NOTICE 'Inserted: Keshav';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'Failed to insert Keshav';
    END;

    RAISE NOTICE 'Transaction Completed (Partial Success).';
END;
$$;

SELECT * FROM students;
