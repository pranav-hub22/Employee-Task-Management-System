-- Create database if not exists
CREATE DATABASE IF NOT EXISTS employment_management;

-- Use the created database
USE employment_management;

-- Create table for departments
CREATE TABLE IF NOT EXISTS departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE,
    department_location VARCHAR(255)
);

-- Create table for positions
CREATE TABLE IF NOT EXISTS positions (
    position_id INT AUTO_INCREMENT PRIMARY KEY,
    position_title VARCHAR(100) UNIQUE,
    position_description TEXT
);
-- Create table for employees
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_email VARCHAR(255) UNIQUE,
    employee_phone VARCHAR(20),
    employee_department_id INT,
    employee_department_name VARCHAR(100), -- Partial dependency introduced
    employee_position_id INT,
    employee_position_title VARCHAR(100), -- Partial dependency introduced
    FOREIGN KEY (employee_department_id) REFERENCES departments(department_id),
    FOREIGN KEY (employee_position_id) REFERENCES positions(position_id)
);

-- Create table for salaries
CREATE TABLE IF NOT EXISTS salaries (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    salary_amount DECIMAL(10, 2),
    salary_date DATE,
    employee_id INT,
    employee_name VARCHAR(100), -- Partial dependency introduced
    employee_email VARCHAR(255), -- Partial dependency introduced
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);
-- Create table for tasks
CREATE TABLE IF NOT EXISTS tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    task_description TEXT,
    task_due_date DATE,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create table for promotions
CREATE TABLE IF NOT EXISTS promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    promotion_date DATE,
    old_position_id INT,
    new_position_id INT,
    employee_id INT,
    FOREIGN KEY (old_position_id) REFERENCES positions(position_id),
    FOREIGN KEY (new_position_id) REFERENCES positions(position_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create table for projects
CREATE TABLE IF NOT EXISTS projects (
    project_id INT AUTO_INCREMENT PRIMARY KEY,
    project_name VARCHAR(100) UNIQUE,
    project_description TEXT,
    project_start_date DATE,
    project_end_date DATE
);

-- Create table for project assignments
CREATE TABLE IF NOT EXISTS project_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    project_id INT,
    employee_id INT,
    assignment_start_date DATE,
    assignment_end_date DATE,
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create table for meetings
CREATE TABLE IF NOT EXISTS meetings (
    meeting_id INT AUTO_INCREMENT PRIMARY KEY,
    meeting_name VARCHAR(100),
    meeting_date DATE,
    meeting_location VARCHAR(255)
);

-- Create table for meeting attendance
CREATE TABLE IF NOT EXISTS meeting_attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    meeting_id INT,
    employee_id INT,
    FOREIGN KEY (meeting_id) REFERENCES meetings(meeting_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Create table for employee skills
CREATE TABLE IF NOT EXISTS employee_skills (
    skill_id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) UNIQUE
);

-- Create table for employee skill proficiency
CREATE TABLE IF NOT EXISTS employee_skill_proficiency (
    proficiency_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    skill_id INT,
    proficiency_level ENUM('Beginner', 'Intermediate', 'Advanced'),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (skill_id) REFERENCES employee_skills(skill_id)
);

-- Insert sample data into departments table
INSERT INTO departments (department_name, department_location) VALUES
('IT Department', '123 Main St, City'),
('Human Resources', '456 Elm St, Town'),
('Finance Department', '789 Oak St, City');

-- Insert sample data into positions table
INSERT INTO positions (position_title, position_description) VALUES
('Software Engineer', 'Develops software applications'),
('HR Manager', 'Oversees human resources activities'),
('Financial Analyst', 'Analyzes financial data');

-- Insert sample data into employees table with partial dependencies
INSERT INTO employees (employee_name, employee_email, employee_phone, employee_department_id, employee_department_name, employee_position_id, employee_position_title) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890', 1, 'IT Department', 1, 'Software Engineer'),
('Alice Smith', 'alice.smith@example.com', '987-654-3210', 2, 'Human Resources', 2, 'HR Manager'),
('Bob Johnson', 'bob.johnson@example.com', '555-444-3333', 3, 'Finance Department', 3, 'Financial Analyst');


-- Insert sample data into salaries table with partial dependencies
INSERT INTO salaries (salary_amount, salary_date, employee_id, employee_name, employee_email) VALUES
(5000.00, '2024-03-01', 1, 'John Doe', 'john.doe@example.com'),
(6000.00, '2024-03-01', 2, 'Alice Smith', 'alice.smith@example.com'),
(7000.00, '2024-03-01', 3, 'Bob Johnson', 'bob.johnson@example.com');

-- Insert sample data into tasks table
INSERT INTO tasks (task_description, task_due_date, employee_id) VALUES
('Develop new feature', '2024-04-30', 1),
('Recruit new employees', '2024-04-15', 2),
('Analyze financial data', '2024-05-15', 3);

-- Insert sample data into promotions table
INSERT INTO promotions (promotion_date, old_position_id, new_position_id, employee_id) VALUES
('2024-04-01', 1, 2, 1),
('2024-04-01', 1, 2, 2),
('2024-04-01', 1, 2, 3);

-- Insert sample data into projects table
INSERT INTO projects (project_name, project_description, project_start_date, project_end_date) VALUES
('Website Redesign', 'Redesign company website for improved user experience', '2024-04-01', '2024-06-30'),
('New Product Development', 'Develop a new software product for launch', '2024-05-01', '2024-08-31');

-- Insert sample data into project assignments table
INSERT INTO project_assignments (project_id, employee_id, assignment_start_date, assignment_end_date) VALUES
(1, 1, '2024-04-01', '2024-06-30'),
(2, 2, '2024-05-01', '2024-08-31');

-- Insert sample data into meetings table
INSERT INTO meetings (meeting_name, meeting_date, meeting_location) VALUES
('Project Kickoff Meeting', '2024-04-01', 'Conference Room A'),
('Weekly Status Meeting', '2024-04-08', 'Conference Room B');

-- Insert sample data into meeting attendance table
INSERT INTO meeting_attendance (meeting_id, employee_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2);

-- Insert sample data into employee skills table
INSERT INTO employee_skills (skill_name) VALUES
('Programming'),
('Project Management'),
('Data Analysis');

-- Insert sample data into employee skill proficiency table
INSERT INTO employee_skill_proficiency (employee_id, skill_id, proficiency_level) VALUES
(1, 1, 'Advanced'),
(1, 2, 'Intermediate'),
(2, 2, 'Advanced'),
(2, 3, 'Intermediate');

-- Create table for employee details
CREATE TABLE IF NOT EXISTS employee_details (
    employee_id INT PRIMARY KEY,
    employee_department_name VARCHAR(100),
    employee_position_title VARCHAR(100),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- Populate the employee_details table
INSERT INTO employee_details (employee_id, employee_department_name, employee_position_title)
SELECT employee_id, employee_department_name, employee_position_title FROM employees;



-- Display employee details
SELECT ed.employee_id, e.employee_name, ed.employee_department_name, ed.employee_position_title
FROM employee_details ed
JOIN employees e ON ed.employee_id = e.employee_id;

SELECT e.employee_name, d.department_name, p.position_title
FROM employees e
JOIN departments d ON e.employee_department_id = d.department_id
JOIN positions p ON e.employee_position_id = p.position_id;

SELECT d.department_name, SUM(s.salary_amount) AS total_salary
FROM employees e
JOIN departments d ON e.employee_department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;

SELECT e.employee_name
FROM employees e
LEFT JOIN project_assignments pa ON e.employee_id = pa.employee_id
WHERE pa.employee_id IS NULL;

SELECT d.department_name, AVG(s.salary_amount) AS average_salary
FROM employees e
JOIN departments d ON e.employee_department_id = d.department_id
JOIN salaries s ON e.employee_id = s.employee_id
GROUP BY d.department_name;

SELECT es.skill_name, e.employee_name, esp.proficiency_level
FROM employee_skills es
JOIN employee_skill_proficiency esp ON es.skill_id = esp.skill_id
JOIN employees e ON esp.employee_id = e.employee_id
WHERE (esp.skill_id, esp.proficiency_level) IN (
    SELECT esp.skill_id, MAX(esp.proficiency_level)
    FROM employee_skill_proficiency esp
    GROUP BY esp.skill_id
);

SELECT e.employee_name
FROM employees e
WHERE NOT EXISTS (
    SELECT m.meeting_id
    FROM meetings m
    WHERE NOT EXISTS (
        SELECT ma.attendance_id
        FROM meeting_attendance ma
        WHERE ma.employee_id = e.employee_id
        AND ma.meeting_id = m.meeting_id
    )
);
CREATE TRIGGER update_salary_date
BEFORE INSERT ON salaries
FOR EACH ROW
SET NEW.salary_date = NOW();

DELIMITER //

CREATE TRIGGER update_project_end_date 
AFTER INSERT ON project_assignments 
FOR EACH ROW 
BEGIN
    UPDATE projects 
    SET project_end_date = (
        SELECT MAX(assignment_end_date) 
        FROM project_assignments 
        WHERE project_id = NEW.project_id
    ) 
    WHERE project_id = NEW.project_id;
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER prevent_delete_employee 
BEFORE DELETE ON employees 
FOR EACH ROW 
BEGIN 
    DECLARE has_assignments INT;
    SELECT COUNT(*) INTO has_assignments FROM project_assignments WHERE employee_id = OLD.employee_id;
    IF has_assignments > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot delete employee with active project assignments';
    END IF;
END//

DELIMITER ;










