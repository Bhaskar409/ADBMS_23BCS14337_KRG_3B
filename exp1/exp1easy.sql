create database clg


use clg


-- Easy-Level Problem
-- Problem Title: Author-Book Relationship Using Joins and Basic SQL Operations
-- Procedure (Step-by-Step):
-- Design two tables — one for storing author details and the other for book details.

-- Ensure a foreign key relationship from the book to its respective author.

-- Perform an INNER JOIN to link each book with its author using the common author ID.

-- Select the book title, author name, and author’s country.


-- creating table

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR(100),
    country VARCHAR(50)
)

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(150),
    author_id INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
)

-- inserting value

-- Insert authors
INSERT INTO Authors (author_id, author_name, country) VALUES
(1, 'J.K. Rowling', 'United Kingdom'),
(2, 'George R.R. Martin', 'United States'),
(3, 'Chetan Bhagat', 'India'),
(4, 'Agatha Christie', 'United Kingdom'),
(5, 'Jules Verne', 'France'),
(6, 'R. K. Narayan', 'India'),
(7, 'Dan Brown', 'United States');

-- Insert books
INSERT INTO Books (book_id, title, author_id) VALUES
(101, 'Harry Potter and the Sorcerer''s Stone', 1),
(102, 'Harry Potter and the Chamber of Secrets', 1),
(103, 'A Game of Thrones', 2),
(104, '2 States', 3),
(105, 'Murder on the Orient Express', 4),
(106, 'And Then There Were None', 4),
(107, 'Journey to the Center of the Earth', 5),
(108, 'The Da Vinci Code', 7),
(109, 'Angels and Demons', 7),
(110, 'Malgudi Days', 6);


-- join 

SELECT 
    b.title AS Book_Title,
    a.author_name AS Author_Name,
    a.country AS Author_Country
FROM Books b
INNER JOIN Authors a
ON b.author_id = a.author_id
ORDER BY a.author_name;
