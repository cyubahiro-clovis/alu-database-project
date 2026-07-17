ALU DATABASE - GROUP PROJECT
Team: Clovis, Nziza, Vladimir, Achol, Nissi, Christian


SECTION 0: DATABASE
 
DROP makes the script safe to re-run while testing.
DROP DATABASE IF EXISTS alu_db;
CREATE DATABASE alu_db;
USE alu_db


SECTION 1: CREATE TABLES (dependency order: parents first)


Member B: Vladimir - Classroom (add your CREATE TABLE here)

Member C: Achol - Faculty (add your CREATE TABLE here)

Member A: Nziza - Students (add your CREATE TABLE here)

-- Member D: Nissi - Courses (add your CREATE TABLE here)

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    credits INT,
    faculty_id INT,
    classroom_id INT,
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id),
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
);

--Member E: Christian - Extra_Curricular_Activities + junction tables (add here)

CREATE TABLE Extra_Curricular_Activities (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    activity_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    faculty_advisor_id INT,

    FOREIGN KEY (faculty_advisor_id)
    REFERENCES Faculty(faculty_id)
) ENGINE=InnoDB;

CREATE TABLE Student_Courses (
    student_id INT,
    course_id INT,

    PRIMARY KEY (student_id, course_id),

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),


    PRIMARY KEY (student_id, course_id),


    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),


    FOREIGN KEY (course_id)
    REFERENCES Courses(course_id)
) ENGINE=InnoDB;


CREATE TABLE Student_Activities (
    student_id INT,
    activity_id INT,

    PRIMARY KEY (student_id, activity_id),

    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),


    PRIMARY KEY (student_id, activity_id),


    FOREIGN KEY (student_id)
    REFERENCES Students(student_id),


    FOREIGN KEY (activity_id)
    REFERENCES Extra_Curricular_Activities(activity_id)
) ENGINE=InnoDB;


SECTION 2: INSERT SAMPLE DATA (same order as the tables)


Member B: Vladimir - Classroom data (add here)

Member C: Achol - Faculty data (add here)

Member A: Nziza - Students data (add here)

-- Member D: Nissi - Courses data (add here)

INSERT INTO Courses (course_id, course_name, credits, faculty_id, classroom_id) VALUES
(1, 'Python and Databases', 4, 1, 2),
(2, 'Linux and Shell scripting', 3, 2, 4),
(3, 'Self Leadership and Team Dynamics', 3, 3, 1),
(4, 'Machine Learning', 4, 1, 5),
(5, 'Web development', 2, 2, 3);

--Member E: Christian - Activities + junction data (add here)

INSERT INTO Extra_Curricular_Activities
(activity_name, category, faculty_advisor_id)
VALUES
('Football Club', 'Sports', 1),
('Coding Club', 'Technology', 2),
('Debate Club', 'Academic', 3),
('Music Club', 'Arts', 1),
('Basketball Club', 'Sports', 2);


INSERT INTO Student_Courses
(student_id, course_id)
VALUES
(1,1),
(1,2),
(2,2),
(3,3),
(4,1),
(5,4);


INSERT INTO Student_Activities
(student_id, activity_id)
VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);


SECTION 3: INDIVIDUAL QUERIES (UPDATE, DELETE, SELECT)

Member A: Nziza (add here)

Member B: Vladimir (add here)

Member C: Achol (add here)

-- Member D: Nissi (add here)

-- UPDATE I want to increase credits for Machine Learning
UPDATE Courses SET credits = 5 WHERE course_id = 4;

-- Deleting a course COMMENT
DELETE FROM Courses WHERE course_id = 5;

-- what courses have more than 3 credits
SELECT course_name, credits FROM Courses WHERE credits >= 3;


--Member E: Christian (add here)



SECTION 4: GROUP TASKS (joins, aggregate, normalization)
Committed by: Clovis after the group session
