CREATE TABLE students (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	name TEXT NOT NULL,
	age INTEGER NOT NULL
);

INSERT INTO students (name, age)
VALUES('Johnathan',19);
INSERT INTO students (name, age)
VALUES('Joseph',21);
INSERT INTO students (name, age)
VALUES('Jane',24);

SELECT * FROM students;

UPDATE students
SET age = 24
WHERE id = 1;

SELECT * FROM students;

DELETE FROM students
WHERE id = 2;

SELECT * FROM students;
