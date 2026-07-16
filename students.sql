-- Member: Ephrem — Students table

-- Requires Classroom table to already exist (FK dependency)
CREATE TABLE Students (
    student_id      INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL UNIQUE,
    classroom_id    INT,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (classroom_id) REFERENCES Classroom(classroom_id)
) ENGINE=InnoDB;

-- Sample data (5 rows)
INSERT INTO Students (name, email, classroom_id, enrollment_date) VALUES
('Amara Uwase',    'amara.uwase@alu.edu',    1, '2025-09-01'),
('Jean Baptiste',  'jean.baptiste@alu.edu',  1, '2025-09-01'),
('Grace Iradukunda','grace.iradukunda@alu.edu', 2, '2025-09-02'),
('Kevin Mugisha',  'kevin.mugisha@alu.edu',  2, '2025-09-02'),
('Diane Umutoni',  'diane.umutoni@alu.edu',  3, '2025-09-03');

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
