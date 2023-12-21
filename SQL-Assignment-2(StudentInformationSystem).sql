--Q1.1
CREATE DATABASE Student_Information_System;
use Student_Information_System;


--Q1.3
-- All 5 tables are in 1NF,2NF,3NF because:
	-- Every column in the tables have atomic values.
	-- All non-prime attributes are fully functional dependent on primary key.
	-- And i have also eliminated transitive dependencies.


--Q1.5
	-- I have created appropriate primary key and foreign key constraints for referential integrity while writing schemas.


--Q2.1
CREATE TABLE Students
(
	StudentId INT PRIMARY KEY,
	FirstName VARCHAR(30),
	LastName VARCHAR(30),
	DOB DATE,
	Email VARCHAR(50),
	PhoneNumber VARCHAR(20)
);

CREATE TABLE Courses
(
	CourseId INT PRIMARY KEY,
	CourseName VARCHAR(30),
	Credits FLOAT(1),
	TeacherId INT FOREIGN KEY (TeacherId) REFERENCES [dbo].[Teacher](TeacherId)
);

CREATE TABLE Teacher
(
	TeacherId INT PRIMARY KEY,
	FirstName VARCHAR(30),
	LastName VARCHAR(30),
	Email VARCHAR(50)
);

CREATE TABLE Enrollments
(
	EnrollmentId INT PRIMARY KEY,
	StudentId INT FOREIGN KEY (StudentId) REFERENCES [dbo].[Students](StudentId),
	CourseId INT FOREIGN KEY (CourseId) REFERENCES [dbo].[Courses](CourseId),
	EnrollmentDate DATE
);

CREATE TABLE Payments
(
	PaymentId INT PRIMARY KEY,
	StudentId INT FOREIGN KEY (StudentId) REFERENCES [dbo].[Students](StudentID),
	Amount INT,
	PaymentDate DATE
);


--Q3.a
INSERT INTO Students
VALUES(1001, 'John', 'Smith', '2001-11-27', 'john.smith@email.com', '555-1234'),
(1002, 'Emily', 'Johnson', '2000-10-10', 'emily.johnson@email.com', '555-5678'),
(1003, 'Michael', 'Davis', '1998-09-01', 'michael.davis@email.com', '555-9876'),
(1004, 'Sarah', 'White', '2000-08-30', 'sarah.white@email.com', '555-4321'),
(1005, 'David', 'Miller', '2001-07-21', 'david.miller@email.com', '555-8765'),
(1006, 'Jessica', 'Brown', '2001-06-17',  'jessica.brown@email.com', '555-2345'),
(1007, 'Brian', 'Taylor', '2002-05-19', 'brian.taylor@email.com', '555-6789'),
(1008, 'Emma', 'Wilson', '1999-04-11', 'emma.wilson@email.com', '555-3456'),
(1009, 'Christopher', 'Anderson',  '2000-03-09', 'chris.anderson@email.com', '555-7890'),
(1010, 'Olivia', 'Lee', '2002-01-13', 'olivia.lee@email.com', '555-8765');

INSERT INTO Courses 
VALUES (101, 'Introduction to Programming', 3, 1),
  (102, 'Database Management', 4, 2),
  (103, 'Web Development', 3, 3),
  (104, 'Data Science Fundamentals', 4, 4),
  (105, 'Software Engineering', 4, 5),
  (106, 'Network Security', 3, 6),
  (107, 'Artificial Intelligence', 4, 7),
  (108, 'Mobile App Development', 3, 8),
  (109, 'Computer Networks', 4, 9),
  (110, 'Machine Learning', 4, 10);

INSERT INTO Enrollments 
VALUES(201, 1001, 101, '2023-01-01'),
    (202, 1002, 102, '2023-01-02'),
    (203, 1003, 103, '2023-01-03'),
    (204, 1004, 104, '2023-01-04'),
    (205, 1005, 105, '2023-01-05'),
    (206, 1006, 106, '2023-01-06'),
    (207, 1007, 107, '2023-01-07'),
    (208, 1008, 108, '2023-01-08'),
    (209, 1009, 109, '2023-01-09'),
    (210, 1010, 110, '2023-01-10');

INSERT INTO Teacher 
VALUES (1, 'John', 'Doe', 'john.doe@email.com'),
  (2, 'Jane', 'Smith', 'jane.smith@email.com'),
  (3, 'Bob', 'Johnson', 'bob.johnson@email.com'),
  (4, 'Alice', 'Williams', 'alice.williams@email.com'),
  (5, 'Charlie', 'Brown', 'charlie.brown@email.com'),
  (6, 'Emily', 'Davis', 'emily.davis@email.com'),
  (7, 'David', 'Miller', 'david.miller@email.com'),
  (8, 'Grace', 'Anderson', 'grace.anderson@email.com'),
  (9, 'Samuel', 'Thomas', 'samuel.thomas@email.com'),
  (10, 'Olivia', 'White', 'olivia.white@email.com');

  INSERT INTO Payments 
VALUES (1, 1001, 500, '2023-12-02'),
    (2, 1002, 750, '2023-12-03'),
    (3, 1003, 600, '2023-12-04'),
    (4, 1004, 800, '2023-12-05'),
    (5, 1005, 550, '2023-12-06'),
    (6, 1006, 700, '2023-12-07'),
    (7, 1007, 900, '2023-12-08'),
    (8, 1008, 650, '2023-12-09'),
    (9, 1009, 750, '2023-12-10'),
    (10, 1010, 850, '2023-12-11');


--Q3.b.1
INSERT INTO Students
VALUES(1011,'John', 'Doe', '1995-08-15', 'john.doe@example.com', '1234567890');


--Q3.b.2
INSERT INTO Enrollments
VALUES(211, 1002, 106, '2023-01-11');


--Q3.b.3
UPDATE Teacher
SET Email = 'white.olivia@email.com'
WHERE TeacherId = 10;


--Q3.b.4
DELETE FROM Enrollments
WHERE StudentId = 1009 AND CourseId = 109; 


--Q3.b.5
UPDATE Courses
SET TeacherId = 9
WHERE CourseName = 'Network Security';


--Q3.b.6
DELETE FROM Enrollments
WHERE StudentId = (
	SELECT StudentId FROM Students
	WHERE FirstName = 'David'
);

DELETE FROM Payments
WHERE StudentId = (
	SELECT StudentId FROM Students
	WHERE FirstName = 'David'
);

DELETE FROM Students
WHERE FirstName = 'David';


--Q3.b.7
DECLARE @InputPaymentId INT;
SET @InputPaymentId = 4;

UPDATE Payments
SET Amount = 1000
WHERE PaymentId = @InputPaymentId;


--Q4.1
SELECT  S.StudentId, S.FirstName, S.LastName, SUM(Amount) AS TotalPayments FROM Students AS S
JOIN Payments AS P ON S.StudentId = P.StudentId
WHERE S.StudentId = 1010
GROUP BY S.StudentId, S.FirstName, S.LastName;


--Q4.2
SELECT C.CourseName, COUNT(StudentId) As NumberOfStudents FROM Courses As C
JOIN Enrollments AS E ON C.CourseId = E.CourseId
GROUP BY C.CourseName;


--Q4.3
SELECT S.FirstName, S.LastName FROM Students AS S
LEFT JOIN Enrollments AS E ON S.StudentId = E.StudentId
WHERE E.StudentId IS NULL
GROUP BY S.FirstName, S.LastName;


--Q4.4
SELECT FirstName, LastName, CourseName FROM Students as S
JOIN Enrollments AS E ON E.StudentId = S.StudentId
JOIN Courses As C ON E.CourseId = C.CourseId;


--Q4.5
SELECT FirstName, LastName, CourseName FROM Teacher
JOIN Courses ON Teacher.TeacherId = Courses.TeacherId;


--Q4.6
SELECT S.FirstName, S.LastName, E.EnrollmentDate FROM Students AS S
JOIN Enrollments AS E ON E.StudentId = S.StudentId
JOIN Courses As C ON E.CourseId = C.CourseId
WHERE C.CourseName = 'Network Security'
GROUP BY S.FirstName, S.LastName, E.EnrollmentDate;


--Q4.7
SELECT FirstName, LastName FROM Students AS S
LEFT JOIN Payments AS P ON S.StudentId = P.StudentId
WHERE P.PaymentId IS NULL
GROUP BY S.FirstName, S.LastName;


--Q4.8
SELECT CourseName FROM Courses AS C
LEFT JOIN Enrollments AS E ON C.CourseId = E.CourseId
WHERE E.EnrollmentId IS NULL;


--Q4.9
SELECT e1.StudentId, COUNT(e1.CourseId) AS NumOfCoursesEnrolled FROM Enrollments e1
JOIN Enrollments e2 ON e1.StudentId = e2.StudentId AND e1.CourseId <> e2.CourseId
GROUP BY e1.StudentId
HAVING COUNT(e1.CourseId) > 1;


--Q4.10
SELECT FirstName, LastName FROM Teacher AS T
LEFT JOIN Courses AS C ON T.TeacherId = C.TeacherId
WHERE C.TeacherId IS NULL;


--Q5.1
SELECT C.CourseId, C.CourseName, AVG(NumOfStudents) AS AverageStudentsEnrolled FROM Courses AS C
JOIN (
	SELECT CourseId, COUNT(DISTINCT StudentId) AS NumOfStudents FROM Enrollments
	GROUP BY CourseId
) AS E ON C.CourseId = E.CourseId
GROUP BY C.CourseId, C.CourseName;


--Q5.2
SELECT S.StudentId, FirstName, LastName FROM Students AS S
JOIN Payments AS P ON S.StudentId = P.StudentId
WHERE P.Amount=(
	SELECT MAX(Amount) FROM Payments
);


--Q5.3
SELECT  CourseName, COUNT(E.EnrollmentId) FROM Courses AS C
JOIN Enrollments AS E ON C.CourseId = E.CourseId
GROUP BY CourseName;


--Q5.4
SELECT t.TeacherId, t.FirstName, t.LastName, SUM(p.Amount) AS TotalPayments
FROM Teacher t
JOIN Courses c ON t.TeacherId = c.TeacherId
JOIN Enrollments e ON c.CourseId = e.CourseId
JOIN Payments p ON e.StudentId = p.StudentId
GROUP BY t.TeacherId, t.FirstName, t.LastName;


--Q5.5
SELECT StudentId, FirstName, LastName FROM Students
WHERE (
        SELECT COUNT(DISTINCT CourseId) FROM Enrollments
        ) = (
        SELECT  COUNT(DISTINCT CourseId) FROM Enrollments e
        WHERE Students.StudentId = e.StudentId
);

--Q5.6
SELECT TeacherId, FirstName, LastName FROM Teacher
WHERE TeacherID NOT IN(
	SELECT t.TeacherId FROM Teacher t
	JOIN Courses c ON t.TeacherId = c.TeacherId
);


--Q5.7
SELECT StudentAges.StudentId, AVG(StudentAge) AS AverageAge 
FROM (
	SELECT StudentId, DATEDIFF(YEAR, DOB, GETDATE()) AS StudentAge FROM Students
) As StudentAges
GROUP BY StudentAges.StudentId;

--Q5.8
SELECT CourseId, CourseName FROM Courses
WHERE CourseId NOT IN(
	SELECT C.CourseId From Courses C
	JOIN Enrollments E on c.CourseId = E.CourseId
);


--Q5.9
SELECT S.FirstName, S.LastName, SUM(Amount) AS TotalPayments FROM Students S
JOIN Enrollments E ON S.StudentId = E.StudentId
JOIN Courses C ON E.CourseId = C.CourseId
JOIN Payments P ON E.StudentId = P.StudentId
GROUP BY S.FirstName, S.LastName;


--Q5.10
SELECT S.FirstName, S.LastName FROM Students S 
WHERE StudentId IN (
	SELECT StudentId From Payments
	GROUP BY StudentId
	HAVING COUNT(*)>1
);


--Q5.11
SELECT S.FirstName, S.LastName, SUM(Amount) AS TotalPayments FROM Students S
JOIN Payments P ON S.StudentId = P.StudentId
GROUP BY S.FirstName, S.LastName;


--Q5.12
SELECT CourseName, COUNT(EnrollmentId) FROM Courses C
JOIN Enrollments E ON C.CourseId = E.CourseId
GROUP BY CourseName;

--Q5.13
SELECT  S.FirstName, S.LastName, AVG(Amount) From Students S
JOIN Payments P ON S.StudentId = P.StudentId
GROUP BY S.FirstName, S.LastName;






