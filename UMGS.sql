Create database UNIVERSITY;
use UNIVERSITY;

CREATE TABLE Student (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE Course (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT
);

CREATE TABLE Result (
  id INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  grade VARCHAR(10) NOT NULL,
  FOREIGN KEY (student_id) REFERENCES Student(id),
  FOREIGN KEY (course_id) REFERENCES Course(id)
);

INSERT INTO Student (name, email) VALUES ("John Doe", "john.doe@example.com");
INSERT INTO Student (name, email) VALUES ("Jane Smith", "jane.smith@example.com");

INSERT INTO Course (name, description) VALUES ("Introduction to Programming", "A beginner-friendly course on programming fundamentals");
INSERT INTO Course (name, description) VALUES ("Database Management Systems", "Learn the concepts and practices of relational database management");

INSERT INTO Result (student_id, course_id, grade) VALUES (1, 1, "A");
INSERT INTO Result (student_id, course_id, grade) VALUES (2, 2, "B+");
INSERT INTO Result (student_id, course_id, grade) VALUES (1, 2, "B");