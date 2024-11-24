create database assignment_9;
use assignment_9;
CREATE TABLE Worker (
    Worker_Id INT PRIMARY KEY,
    FirstName CHAR(25),
    LastName CHAR(25),
    Salary INT(15),
    JoiningDate DATETIME,
    Department CHAR(25)
);
INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department) VALUES
(1, 'John', 'Doe', 50000, '2020-01-15 09:00:00', 'HR'),
(2, 'Jane', 'Smith', 60000, '2019-03-21 10:30:00', 'Finance'),
(3, 'Mike', 'Brown', 55000, '2021-06-10 11:45:00', 'IT'),
(4, 'Emily', 'Davis', 70000, '2018-09-12 08:20:00', 'Marketing'),
(5, 'David', 'Wilson', 48000, '2022-02-05 12:15:00', 'HR'),
(6, 'Sarah', 'Taylor', 52000, '2020-07-25 14:30:00', 'Finance'),
(7, 'Chris', 'Johnson', 67000, '2019-11-11 16:00:00', 'IT'),
(8, 'Emma', 'White', 75000, '2017-12-05 09:30:00', 'Marketing'),
(9, 'Daniel', 'Moore', 59000, '2021-04-20 13:00:00', 'HR'),
(10, 'Sophia', 'Clark', 63000, '2020-05-30 15:45:00', 'Finance');

select * from worker;

DELIMITER //

CREATE PROCEDURE AddWorker(
    IN p_Worker_Id INT,
    IN p_FirstName CHAR(25),
    IN p_LastName CHAR(25),
    IN p_Salary INT(15),
    IN p_JoiningDate DATETIME,
    IN p_Department CHAR(25)
)
BEGIN
    INSERT INTO Worker (Worker_Id, FirstName, LastName, Salary, JoiningDate, Department)
    VALUES (p_Worker_Id, p_FirstName, p_LastName, p_Salary, p_JoiningDate, p_Department);
END //

DELIMITER ;
CALL AddWorker(11, 'John', 'Doe', 50000, '2024-11-01 10:00:00', 'HR');
select * from worker;

DELIMITER //

CREATE PROCEDURE GetSalary(
    IN p_Worker_Id INT,
    OUT p_Salary INT
)
BEGIN
    SELECT Salary INTO p_Salary
    FROM Worker
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;
CALL GetSalary(3, @Salary);
SELECT @Salary AS WorkerSalary;
SELECT * FROM Worker WHERE Worker_Id = 3;
select * from worker;

CALL GetSalary(1, @Salary);
SELECT @Salary AS WorkerSalary;

DELIMITER //

DELIMITER //

CREATE PROCEDURE UpdateDepartment(
    IN p_Worker_Id INT,
    IN p_Department CHAR(25)
)
BEGIN
    UPDATE Worker
    SET Department = p_Department
    WHERE Worker_Id = p_Worker_Id;
END //

DELIMITER ;

CALL UpdateDepartment(1, 'Finance');
SELECT * 
FROM Worker 
WHERE Worker_Id = 1;
DELIMITER //

CREATE PROCEDURE GetWorkerCount(
    IN p_Department CHAR(25),
    OUT p_WorkerCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_WorkerCount
    FROM Worker
    WHERE Department = p_Department;
END //

DELIMITER ;
CALL GetWorkerCount('Finance', @WorkerCount);
SELECT @WorkerCount AS WorkerCount;
CALL GetWorkerCount('IT', @WorkerCount);
SELECT @WorkerCount AS WorkerCount;
DELIMITER //

CREATE PROCEDURE GetAverageSalary(
    IN p_Department CHAR(25),
    OUT p_avgSalary DECIMAL(10,2)
)
BEGIN
    SELECT AVG(Salary) INTO p_avgSalary
    FROM Worker
    WHERE Department = p_Department;
END //

DELIMITER ;
CALL GetAverageSalary('Finance', @AverageSalary);
SELECT @AverageSalary AS AverageSalary;

