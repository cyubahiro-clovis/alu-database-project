-- ============================================================
-- ALU DATABASE - GROUP PROJECT
-- Team: Clovis, Nziza, Vladimir, Achol, Nissi, Christian
-- Integration and assembly: Clovis
-- ============================================================

-- ------------------------------------------------------------
-- SECTION 0: DATABASE  |  Clovis
-- ------------------------------------------------------------
-- DROP makes the script safe to re-run while testing.
DROP DATABASE IF EXISTS alu_db;
CREATE DATABASE alu_db;
USE alu_db;

-- ============================================================
-- SECTION 1: CREATE TABLES (dependency order: parents first)
-- ============================================================

-- Member B: Vladimir - Classroom
CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    building VARCHAR(50),
    capacity INT
);

-- Member C: Achol - Faculty
CREATE TABLE Faculty (
    faculty_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    department    VARCHAR(100),
    hire_date     DATE NOT NULL
) ENGINE=InnoDB;

-- Member A: Nziza - Students (requires Classroom to exist)
CREATE TABLE Students (
    student_id      INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    classroom_id    INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
) ENGINE=InnoDB;

-- Member D: Nissi - Courses (requires Faculty and Classroom)
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

-- Member E: Christian - Extra_Curricular_Activities (requires Faculty)
CREATE TABLE Extra_Curricular_Activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    faculty_advisor_id INT,
    FOREIGN KEY (faculty_advisor_id) REFERENCES Faculty(faculty_id)
) ENGINE=InnoDB;

-- Member E: Christian - Junction tables (many-to-many links)
CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
) ENGINE=InnoDB;

CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,
    PRIMARY KEY (student_id, activity_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (activity_id) REFERENCES Extra_Curricular_Activities(activity_id)
) ENGINE=InnoDB;

-- ============================================================
-- SECTION 2: INSERT SAMPLE DATA (same order as the tables)
-- ============================================================

-- Member B: Vladimir - Classroom data
INSERT INTO Classroom (classroom_id, room_number, building, capacity)
VALUES
(1, 'A101', 'Main Building', 40),
(2, 'A102', 'Main Building', 35),
(3, 'B201', 'Innovation Hub', 30),
(4, 'B202', 'Innovation Hub', 25),
(5, 'C301', 'Learning Center', 50);

-- Member C: Achol - Faculty data
INSERT INTO Faculty (name, email, department, hire_date) VALUES
('Eric Habimana',      'eric.habimana@alu.edu',      'Computer Science', '2020-01-15'),
('Aline Mukamana',     'aline.mukamana@alu.edu',     'Mathematics',      '2019-08-22'),
('Patrick Ndayisenga', 'patrick.ndayisenga@alu.edu', 'Health Sciences',  '2021-03-10'),
('Okello Denis',       'okello.denis@alu.edu',       'Business',         '2018-05-30'),
('Ajak Deng',          'ajak.deng@alu.edu',          'Engineering',      '2022-02-14');

-- Member A: Nziza - Students data
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Amara Uwase',    'amara.uwase@alu.edu',    1, '2025-09-01'),
('Jean Baptiste',  'jean.baptiste@alu.edu',  1, '2025-09-01'),
('Grace Iradukunda','grace.iradukunda@alu.edu', 2, '2025-09-02'),
('Kevin Mugisha',  'kevin.mugisha@alu.edu',  2, '2025-09-02'),
('Diane Umutoni',  'diane.umutoni@alu.edu',  3, '2025-09-03');

-- Member D: Nissi - Courses data
INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id) VALUES
(1, 'Python and Databases', 4, 1, 2),
(2, 'Linux and Shell scripting', 3, 2, 4),
(3, 'Self Leadership and Team Dynamics', 3, 3, 1),
(4, 'Machine Learning', 4, 1, 5),
(5, 'Web development', 2, 2, 3);

-- Member E: Christian - Activities data
INSERT INTO Extra_Curricular_Activities
(activity_name, category, faculty_advisor_id)
VALUES
('Football Club', 'Sports', 1),
('Coding Club', 'Technology', 2),
('Debate Club', 'Academic', 3),
('Music Club', 'Arts', 1),
('Basketball Club', 'Sports', 2);

-- Member E: Christian - Junction data
-- Integration note (Clovis): two rows redirected away from student 5
-- and activity 5, because Section 3 deletes Diane (student 5) and
-- Basketball Club (activity 5); the foreign keys would otherwise
-- block those DELETE statements.
INSERT INTO Student_Courses
(student_id, course_id)
VALUES
(1,1),
(1,2),
(2,2),
(3,3),
(4,1),
(3,4);

INSERT INTO Student_Activities
(student_id, activity_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(4,1);

-- ============================================================
-- SECTION 3: INDIVIDUAL QUERIES (UPDATE, DELETE, SELECT)
-- ============================================================

-- Member A: Nziza
-- UPDATE: correct a student's classroom assignment
UPDATE Students
SET classroom_id = 3
WHERE email = 'jean.baptiste@alu.edu';

-- DELETE: remove a student record
DELETE FROM Students
WHERE email = 'diane.umutoni@alu.edu';

-- SELECT with WHERE
SELECT name, email, enrollment_date
FROM Students
WHERE classroom_id = 1;

-- Member B: Vladimir
UPDATE Classroom
SET capacity = 45
WHERE classroom_id = 1;

INSERT INTO Classroom (classroom_id, room_number, building, capacity)
VALUES (6, 'D401', 'Temporary Building', 20);

DELETE FROM Classroom
WHERE classroom_id = 6;

SELECT *
FROM Classroom
WHERE capacity >= 30;

-- Member C: Achol
UPDATE Faculty
SET department = 'Data Science'
WHERE email = 'eric.habimana@alu.edu';

DELETE FROM Faculty
WHERE email = 'okello.denis@alu.edu';

SELECT name, department, hire_date
FROM Faculty
WHERE department = 'Computer Science';

-- Member D: Nissi
-- UPDATE: increase credits for Machine Learning
UPDATE Courses SET credits = 5 WHERE course_id = 4;

-- DELETE: remove a course
DELETE FROM Courses WHERE course_id = 5;

-- SELECT: which courses have 3 or more credits
SELECT course_name, credits FROM Courses WHERE credits >= 3;

-- Member E: Christian
-- UPDATE: change the category of Coding Club to STEM
UPDATE Extra_Curricular_Activities
SET category='STEM'
WHERE activity_name='Coding Club';

-- DELETE: remove the Basketball Club activity
DELETE FROM Extra_Curricular_Activities
WHERE activity_name='Basketball Club';

-- SELECT: all activities in the Sports category
SELECT *
FROM Extra_Curricular_Activities
WHERE category='Sports';

-- ============================================================
-- SECTION 4: GROUP TASKS (joins, aggregate, normalization)
-- ============================================================

-- Join 1 (Vladimir): student, course, teacher, classroom
SELECT CONCAT(
    s.name,
    ' is enrolled in ',
    c.course_name,
    ', taught by ',
    f.name,
    ', in classroom ',
    cl.room_number,
    '.'
) AS student_course_information
FROM Students s
JOIN Student_Courses sc
    ON s.student_id = sc.student_id
JOIN Courses c
    ON sc.course_id = c.course_id
JOIN Faculty f
    ON c.faculty_id = f.faculty_id
JOIN Classroom cl
    ON c.classroom_id = cl.classroom_id;

-- Join 2 (Vladimir): student, activity, faculty advisor
SELECT CONCAT(
    s.name,
    ' participates in ',
    a.activity_name,
    ', advised by ',
    f.name,
    '.'
) AS student_activity_information
FROM Students s
JOIN Student_Activities sa
    ON s.student_id = sa.student_id
JOIN Extra_Curricular_Activities a
    ON sa.activity_id = a.activity_id
JOIN Faculty f
    ON a.faculty_advisor_id = f.faculty_id;

-- Join 3 (Vladimir): student and their home classroom
SELECT CONCAT(
    s.name,
    ' is assigned to classroom ',
    cl.room_number,
    ' in ',
    cl.building,
    '.'
) AS student_classroom_information
FROM Students s
JOIN Classroom cl
    ON s.classroom_id = cl.classroom_id;

-- Aggregate (Clovis): how many students are enrolled in each course
-- LEFT JOIN keeps courses with zero students visible (count 0).
SELECT c.course_name, COUNT(sc.student_id) AS enrolled_students
FROM Courses c
LEFT JOIN Student_Courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_name
ORDER BY enrolled_students DESC;

-- ============================================================
-- NORMALIZATION CHECK (group answer)
-- ============================================================
-- Our schema stores each fact exactly once and connects tables with
-- keys instead of repeating data. Classroom details (room number,
-- building, capacity) live only in the Classroom table; Students and
-- Courses store just a classroom_id, so changing a room updates it
-- everywhere at once. Faculty information is likewise stored once and
-- referenced by faculty_id from Courses and by faculty_advisor_id
-- from Extra_Curricular_Activities. The two many-to-many
-- relationships (students to courses, students to activities) are
-- resolved by the junction tables Student_Courses and
-- Student_Activities, whose composite primary keys prevent duplicate
-- enrollments; without them we would repeat a student's name and
-- email once per course or activity. Every non-key column depends
-- only on its table's primary key, so there are no partial or
-- transitive dependencies and the design is in third normal form.
