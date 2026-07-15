-- ============================================
-- MEMBER: Vladimir Ndayisaba
-- TABLE: Classroom
-- ============================================

CREATE TABLE Classroom (
    classroom_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    building VARCHAR(50),
    capacity INT
);

INSERT INTO Classroom (classroom_id, room_number, building, capacity)
VALUES
(1, 'A101', 'Main Building', 40),
(2, 'A102', 'Main Building', 35),
(3, 'B201', 'Innovation Hub', 30),
(4, 'B202', 'Innovation Hub', 25),
(5, 'C301', 'Learning Center', 50);

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
