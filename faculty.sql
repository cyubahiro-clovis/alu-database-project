-- ============================================
-- MEMBER: Achol — Faculty table
-- No FK dependency (Faculty is a parent table)
-- ============================================
CREATE TABLE Faculty (
    faculty_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) NOT NULL UNIQUE,
    department    VARCHAR(100),
    hire_date     DATE NOT NULL
) ENGINE=InnoDB;

-- Sample data (5 rows)
INSERT INTO Faculty (name, email, department, hire_date) VALUES
('Eric Habimana',      'eric.habimana@alu.edu',      'Computer Science', '2020-01-15'),
('Aline Mukamana',     'aline.mukamana@alu.edu',     'Mathematics',      '2019-08-22'),
('Patrick Ndayisenga', 'patrick.ndayisenga@alu.edu', 'Health Sciences',  '2021-03-10'),
('Okello Denis',       'okello.denis@alu.edu',       'Business',         '2018-05-30'),
('Ajak Deng',          'ajak.deng@alu.edu',          'Engineering',      '2022-02-14');

-- UPDATE: move a faculty member to a new department
UPDATE Faculty
SET department = 'Data Science'
WHERE email = 'eric.habimana@alu.edu';

-- DELETE: remove a faculty member who has left
DELETE FROM Faculty
WHERE email = 'okello.denis@alu.edu';

-- SELECT with WHERE
SELECT name, department, hire_date
FROM Faculty
WHERE department = 'Computer Science';
