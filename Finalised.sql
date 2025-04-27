

drop table if EXISTS StudentEnrollCourseOffering;
drop table if EXISTS CourseOfferingToPrivilege;
drop table if EXISTS CourseOffering;
drop table if EXISTS StaffPrivilege;
drop table if EXISTS Privilege;
drop table IF EXISTS Reservation;
drop table if EXISTS Loan;
drop table if EXISTS Immovable;
drop table if EXISTS Movable;
drop table if EXISTS Acquisition;
drop table if EXISTS Category;
drop table if EXISTS Resource;
drop table if EXISTS Student;
drop table if EXISTS Staff;
drop table if EXISTS Member;


CREATE TABLE Member (
  memberID VARCHAR(255) PRIMARY KEY ,
  name VARCHAR(255) NOT NULL,
  address TEXT,
  phone VARCHAR(20),
  email VARCHAR(255),
  status VARCHAR(50) NOT NULL,
  comments TEXT
);
CREATE TABLE CourseOffering (
  offerID VARCHAR(255) PRIMARY KEY,
  cid VARCHAR(255) NOT NULL,
  course VARCHAR(255) NOT NULL,
  semester VARCHAR(50) NOT NULL,
  year INT NOT NULL,
  dateBegin DATE NOT NULL,
  dateEnd DATE NOT NULL
);

CREATE TABLE Resource (
  resourceID VARCHAR(255) PRIMARY KEY NOT NULL,
  name VARCHAR(255) NOT NULL,
  status VARCHAR(50) NOT NULL
);

CREATE TABLE Category (
  Code VARCHAR(255) PRIMARY KEY NOT NULL,
  ResourceID VARCHAR(255),
  name VARCHAR(255) NOT NULL,
  description TEXT,
  durationDays INT,
  durationHours INT,
  FOREIGN KEY (ResourceID) REFERENCES Resource(resourceID) 
);

CREATE Table Privilege
(
  privilID VARCHAR(255) PRIMARY KEY NOT NULL,
  Code VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  maxItems INT,
  FOREIGN KEY (Code) REFERENCES Category(Code)
);

CREATE TABLE Student (
  StudentID VARCHAR(255) PRIMARY KEY NOT NULL,
  PointEearned INT DEFAULT 12,
  major VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  address TEXT,
  phone VARCHAR(20),
  email VARCHAR(255),
  status VARCHAR(50) NOT NULL,
  comments TEXT,
  FOREIGN KEY (StudentID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Staff (
  StaffID VARCHAR(255) PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  name VARCHAR(255) NOT NULL,
  address TEXT,
  phone VARCHAR(20),
  email VARCHAR(255),
  status VARCHAR(50) NOT NULL,
  comments TEXT
  FOREIGN KEY (StaffID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE CourseOfferingToPrivilege (
  StudentID VARCHAR(255),
  offerID VARCHAR(255),
  privilID VARCHAR(255),
  FOREIGN KEY (studentID) REFERENCES Student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE, 
  FOREIGN KEY (offerID) REFERENCES CourseOffering(offerID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (privilID) REFERENCES Privilege(privilID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE StudentEnrollCourseOffering (
  StudentID VARCHAR(255),
  offerID VARCHAR(255),
  PRIMARY KEY (StudentID, offerID),
  FOREIGN KEY (StudentID) REFERENCES Student(StudentID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (offerID) REFERENCES CourseOffering(offerID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE StaffPrivilege
(
  StaffID VARCHAR(255), 
  privilID VARCHAR(255),
  PRIMARY KEY (StaffID, privilID),
  FOREIGN KEY (StaffID) REFERENCES Member(memberID) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (privilID) REFERENCES Privilege(privilID)
);


CREATE TABLE Acquisition (
  acqID VARCHAR(255) PRIMARY KEY NOT NULL,
  memberID VARCHAR(255) NOT NULL,
  vendorCode VARCHAR(255) NOT NULL,
  resourceID VARCHAR(255) NOT NULL,
  price DECIMAL(5,2) NOT NULL,
  dateTimeReceived DATETIME NOT NULL,
  notes TEXT,
  FOREIGN KEY (memberID) REFERENCES Member(memberID),
  FOREIGN KEY (resourceID) REFERENCES Resource(resourceID)
);

CREATE TABLE Loan (
  LoanID VARCHAR(255) PRIMARY KEY NOT NULL,
  memberID VARCHAR(255) NOT NULL,
  resourceID VARCHAR(255) NOT NULL,
  dateTimeBorrowed DATETIME NOT NULL,
  dateTimeReturned DATETIME DEFAULT NULL,
  dateTimeDue DATETIME NOT NULL,
  FOREIGN KEY (memberID) REFERENCES Member(memberID) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reservation (
  ReservationID VARCHAR(255) PRIMARY KEY NOT NULL,
  memberID VARCHAR(255) NOT NULL,
  resourceID VARCHAR(255) NOT NULL,
  dateTimeReserved DATETIME NOT NULL,
  dateTimeDue DATETIME NOT NULL,
  FOREIGN KEY (memberID) REFERENCES Member(memberID),
  FOREIGN KEY (resourceID) REFERENCES Resource(resourceID)
);

CREATE TABLE Movable (
  resourceID VARCHAR(255) PRIMARY KEY NOT NULL,
  manufacturer VARCHAR(255),
  model VARCHAR(255),
  year INT,
  assetValue DECIMAL(10,2) NOT NULL,
  CONSTRAINT FK_Movable_Resource FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Immovable (
  resourceID VARCHAR(255) PRIMARY KEY NOT NULL,
  capacity INT,
  room VARCHAR(255),
  building VARCHAR(255),
  campus VARCHAR(255),
  CONSTRAINT FK_Immovable_Resource FOREIGN KEY (resourceID) REFERENCES Resource(resourceID) ON DELETE CASCADE ON UPDATE CASCADE
);


-- ADD DATA
-- Insert data into the Member table
INSERT INTO Member (memberID, name, address, phone, email, status, comments)
VALUES ('STUDENT1', 'John Doe', '123 Main St, Anytown, USA', '555-1234', 'johndoe@example.com', 'Active', 'No comments'),
       ('STUDENT2', 'Jane Smith', '456 Elm St, Anytown, USA', '555-5678', 'Janesmith@example.com', 'Active', 'No comments'),
       ('STUDENT3', 'Jim Brown', '789 Oak St, Anytown, USA', '555-9012', 'jimbrown@gmail.com', 'Active', 'No comments'),
       ('STUDENT4', 'Jill White', '101 Pine St, Anytown, USA', '555-3456', 'jillwhite@gmail.com', 'Active', 'No comments'),
       ('STUDENT5', 'Jack Black', '111 Maple St, Anytown, USA', '555-7890', 'Jackblack@example.com', 'Active', 'No comments'),
       ('STAFF1', 'Sue Johnson', '123 Main St, Anytown, USA', '555-1234', 'Suejohnson@uon.edu.au', 'Active', 'No comments'),
       ('STAFF2', 'Tom Brown', '456 Elm St, Anytown, USA', '555-5678', 'Tombrown@uon.edu.au', 'Active', 'No comments'),
       ('STAFF3', 'Mary White', '789 Oak St, Anytown, USA', '555-9012', 'Marywhite@uon.edu.au', 'Active', 'No comments'),
       ('STAFF4', 'Joe Black', '101 Pine St, Anytown, USA', '555-3456', 'Joeblack@uon.edu.au', 'Active', 'No comments'),
       ('STAFF5', 'Sally Green', '111 Maple St, Anytown, USA', '555-7890', 'Sallygreen@uon.edu.au', 'Active', 'No comments');
-- Insert data into the Student table
INSERT INTO Student (studentID, major, name, address, phone, email, status, comments)
VALUES ('STUDENT1','Computer Science', 'John Doe', '123 Main St, Anytown, USA', '555-1234', 'johndoe@example.com', 'Active', 'No comments'),
        ('STUDENT2', 'Mathematics', 'Jane Smith', '456 Elm St, Anytown, USA', '555-5678', 'Janesmith@example.com', 'Active', 'No comments'),
        ('STUDENT3', 'Physics', 'Jim Brown', '789 Oak St, Anytown, USA', '555-9012', 'jimbrown@gmail.com', 'Active', 'No comments'),
        ('STUDENT4', 'Biology', 'Jill White', '101 Pine St, Anytown, USA', '555-3456', 'jillwhite@gmail.com', 'Active', 'No comments'),
        ('STUDENT5', 'Chemistry', 'Jack Black', '111 Maple St, Anytown, USA', '555-7890', 'Jackblack@example.com', 'Active', 'No comments');

INSERT INTO Staff (staffID, title, name, address, phone, email, status, comments)
VALUES ('STAFF1', 'Librarian', 'Sue Johnson', '123 Main St, Anytown, USA', '555-1234', 'Suejohnson@uon.edu.au', 'Active', 'No comments'),
       ('STAFF2', 'Library Assistant', 'Tom Brown', '456 Elm St, Anytown, USA', '555-5678', 'Tombrown@uon.edu.au', 'Active', 'No comments'),
       ('STAFF3', 'Library Assistant', 'Mary White', '789 Oak St, Anytown, USA', '555-9012', 'Marywhite@uon.edu.au', 'Active', 'No comments'),
       ('STAFF4', 'Library Assistant', 'Joe Black', '101 Pine St, Anytown, USA', '555-3456', 'Joeblack@uon.edu.au', 'Active', 'No comments'),
       ('STAFF5', 'Library Assistant', 'Sally Green', '111 Maple St, Anytown, USA', '555-7890', 'Sallygreen@uon.edu.au', 'Active', 'No comments');

INSERT INTO CourseOffering (offerID, cid, course, semester, year, dateBegin, dateEnd)
VALUES ('CO1', 'CSC101', 'Introduction to Computer Science', 'Spring', 2023, '2023-01-01', '2027-05-01'),
       ('CO2', 'MAT101', 'Introduction to Mathematics', 'Spring', 2024, '2024-01-01', '2026-05-01'),
       ('CO3', 'PHY101', 'Introduction to Physics', 'Spring', 2022, '2022-01-01', '2025-05-01'),
       ('CO4', 'BIO101', 'Introduction to Biology', 'Spring', 2023, '2023-01-01', '2024-05-01'),
       ('CO5', 'CHE101', 'Introduction to Chemistry', 'Spring', 2020, '2020-01-01', '2025-05-01');
INSERT INTO Resource (resourceID, name, status)
VALUES ('RES1', 'Book', 'Available'),
       ('RES2', 'Journal', 'Available'),
       ('RES3', 'DVD', 'Available'),
       ('RES4', 'Laptop', 'Available'),
       ('RES5', 'Camera', 'Available'),
        ('RES6', 'Book', 'Available'),
        ('RES7', 'Journal', 'Available'),
        ('RES8', 'DVD', 'Available'),
        ('RES9', 'Laptop', 'Available'),
        ('RES10', 'Speaker', 'Available'),
        ('RES11', 'Book', 'Available'),
        ('RES12', 'Journal', 'Available'),
        ('RES13', 'DVD', 'Available'),
        ('RES14', 'Speaker', 'Available'),
        ('RES15', 'Camera', 'Available'),
        ('RES16', 'Room', 'Available'),
        ('RES17', 'Room', 'Available'),
        ('RES18', 'Room', 'Available'),
        ('RES19', 'Room', 'Available'),
        ('RES20', 'Room', 'Available');

INSERT INTO Movable (resourceID, manufacturer, model, year, assetValue)
VALUES ('RES1', 'Apple', 'MacBook Pro', 2020, 1000.00),
       ('RES2', 'Dell', 'Inspiron', 2021, 800.00),
       ('RES3', 'HP', 'Pavilion', 2019, 700.00),
       ('RES4', 'Lenovo', 'ThinkPad', 2018, 600.00),
       ('RES5', 'Canon', 'EOS 5D Mark IV', 2017, 500.00),
       ('RES6', 'Apple', 'MacBook Pro', 2020, 1000.00),
       ('RES7', 'Dell', 'Inspiron', 2021, 800.00),
       ('RES8', 'HP', 'Pavilion', 2019, 700.00),
       ('RES9', 'Lenovo', 'ThinkPad', 2018, 600.00),
       ('RES10', 'Canon', 'EOS 5D Mark IV', 2017, 500.00),
       ('RES11', 'Apple', 'MacBook Pro', 2020, 1000.00),
       ('RES12', 'Dell', 'Inspiron', 2021, 800.00),
       ('RES13', 'HP', 'Pavilion', 2019, 700.00),
       ('RES14', 'Lenovo', 'ThinkPad', 2018, 600.00),
       ('RES15', 'Canon', 'EOS 5D Mark IV', 2017, 500.00);

INSERT INTO Immovable (resourceID, capacity, room, building, campus)
VALUES ('RES16', 50, 'Room 1', 'Building A', 'Campus 1'),
       ('RES17', 100, 'Room 1', 'Building B', 'Campus 2'),
       ('RES18', 150, 'Room 1', 'Building C', 'Campus 3'),
       ('RES19', 200, 'Room 2', 'Building D', 'Campus 4'),
       ('RES20', 250, 'Room 3', 'Building E', 'Campus 5');

Insert INTO Acquisition (acqID, memberID, vendorCode, resourceID, price, dateTimeReceived, notes)
VALUES ('ACQ1', 'STUDENT1', 'VENDOR1', 'RES1', 50.00, '2023-01-01', 'No notes'),
       ('ACQ2', 'STUDENT2', 'VENDOR2', 'RES2', 60.00, '2024-01-01', 'No notes'),
       ('ACQ3', 'STUDENT3', 'VENDOR3', 'RES3', 70.00, '2022-01-01', 'No notes'),
       ('ACQ4', 'STUDENT4', 'VENDOR4', 'RES4', 80.00, '2023-01-01', 'No notes'),
       ('ACQ5', 'STUDENT5', 'VENDOR5', 'RES5', 90.00, '2020-01-01', 'No notes'),
       ('ACQ6', 'STAFF1', 'VENDOR1', 'RES6', 50.00, '2023-01-01', 'No notes'),
       ('ACQ7', 'STAFF2', 'VENDOR2', 'RES7', 60.00, '2024-01-01', 'No notes'),
       ('ACQ8', 'STAFF3', 'VENDOR3', 'RES8', 70.00, '2022-01-01', 'No notes'),
       ('ACQ9', 'STAFF4', 'VENDOR4', 'RES9', 80.00, '2023-01-01', 'No notes'),
       ('ACQ10', 'STAFF5', 'VENDOR5', 'RES10', 90.00, '2020-01-01', 'No notes'),
       ('ACQ11', 'STUDENT1', 'VENDOR1', 'RES11', 50.00, '2023-01-01', 'No notes'),
       ('ACQ12', 'STUDENT2', 'VENDOR2', 'RES12', 60.00, '2024-01-01', 'No notes'),
       ('ACQ13', 'STUDENT3', 'VENDOR3', 'RES13', 70.00, '2022-01-01', 'No notes');

INSERT INTO Category (Code, ResourceID, name, description, durationDays, durationHours)
VALUES ('CAT1', 'RES1', 'Speaker', 'Book Category', 30, 0),
       ('CAT2', 'RES2', 'Speaker', 'Journal Category', 30, 0),
       ('CAT3', 'RES3', 'DVD', 'DVD Category', 30, 0),
       ('CAT4', 'RES4', 'Laptop', 'Laptop Category', 30, 0),
       ('CAT5', 'RES5', 'Camera', 'Camera Category', 30, 0),
       ('CAT6', 'RES6', 'Book', 'Book Category', 30, 0),
       ('CAT7', 'RES7', 'Journal', 'Journal Category', 30, 0),
       ('CAT8', 'RES8', 'DVD', 'DVD Category', 30, 0),
       ('CAT9', 'RES9', 'Laptop', 'Laptop Category', 30, 0),
       ('CAT10', 'RES10', 'Speaker', 'Speaker Category', 30, 0),
       ('CAT11', 'RES11', 'Book', 'Book Category', 30, 0),
       ('CAT12', 'RES12', 'Journal', 'Journal Category', 30, 0),
       ('CAT13', 'RES13', 'DVD', 'DVD Category', 30, 0),
       ('CAT14', 'RES14', 'Speaker', 'Speaker Category', 30, 0),
       ('CAT15', 'RES15', 'Camera', 'Camera Category', 30, 0),
       ('CAT16', 'RES16', 'Room', 'Room Category', 30, 0),
       ('CAT17', 'RES17', 'Room', 'Room Category', 30, 0),
       ('CAT18', 'RES18', 'Room', 'Room Category', 30, 0),
       ('CAT19', 'RES19', 'Room', 'Room Category', 30, 0),
       ('CAT20', 'RES20', 'Room', 'Room Category', 30, 0);
INSERT INTO Privilege (privilID, Code, name, description, maxItems)
VALUES ('PRIV1', 'CAT1', 'Student', 'Student Privilege', 5),
       ('PRIV2', 'CAT2', 'Staff', 'Staff Privilege', 10),
       ('PRIV3', 'CAT3', 'Student', 'Student Privilege', 5),
       ('PRIV4', 'CAT4', 'Staff', 'Staff Privilege', 10),
       ('PRIV5', 'CAT5', 'Student', 'Student Privilege', 5),
       ('PRIV6', 'CAT6', 'Staff', 'Staff Privilege', 10),
       ('PRIV7', 'CAT7', 'Student', 'Student Privilege', 5),
       ('PRIV8', 'CAT8', 'Staff', 'Staff Privilege', 10),
       ('PRIV9', 'CAT9', 'Student', 'Student Privilege', 5),
       ('PRIV10', 'CAT10', 'Staff', 'Staff Privilege', 10),
       ('PRIV11', 'CAT11', 'Student', 'Student Privilege', 5),
       ('PRIV12', 'CAT12', 'Staff', 'Staff Privilege', 10),
       ('PRIV13', 'CAT13', 'Student', 'Student Privilege', 5),
        ('PRIV14', 'CAT14', 'Staff', 'Staff Privilege', 10),
        ('PRIV15', 'CAT15', 'Student', 'Student Privilege', 5),
        ('PRIV16', 'CAT16', 'Staff', 'Staff Privilege', 10),
        ('PRIV17', 'CAT17', 'Student', 'Student Privilege', 5),
        ('PRIV18', 'CAT18', 'Staff', 'Staff Privilege', 10),
        ('PRIV19', 'CAT19', 'Student', 'Student Privilege', 5),
        ('PRIV20', 'CAT20', 'Staff', 'Staff Privilege', 10);



INSERT INTO CourseOfferingToPrivilege (studentID, offerID, privilID)
VALUES ('STUDENT1', 'CO1', 'PRIV1'),
       ('STUDENT2', 'CO2', 'PRIV3'),
       ('STUDENT3', 'CO3', 'PRIV5'),
       ('STUDENT4', 'CO4', 'PRIV7'),
       ('STUDENT5', 'CO5', 'PRIV9');

INSERT INTO STUDentEnrollCourseOffering (studentID, offerID)
VALUES ('STUDENT1', 'CO1'),
       ('STUDENT2', 'CO2'),
       ('STUDENT3', 'CO3'),
       ('STUDENT4', 'CO4'),
       ('STUDENT5', 'CO5');

INSERT INTO Loan(LoanID, memberID, resourceID, dateTimeBorrowed, dateTimeReturned, dateTimeDue)
VALUES ('LOAN1', 'STUDENT1', 'RES1', '2023-01-01', '2023-01-15', '2023-01-15'),
       ('LOAN2', 'STUDENT2', 'RES2', '2024-01-01', '2024-01-15', '2024-01-15'),
       ('LOAN3', 'STUDENT3', 'RES3', '2022-01-01', '2022-01-15', '2022-01-15'),
       ('LOAN4', 'STUDENT4', 'RES4', '2023-01-01', '2023-01-15', '2023-01-15'),
       ('LOAN5', 'STUDENT5', 'RES5', '2020-01-01', '2020-01-15', '2020-01-15'),
       ('LOAN6', 'STAFF1', 'RES6', '2023-01-01', '2023-01-15', '2023-01-15'),
       ('LOAN7', 'STAFF2', 'RES7', '2024-01-01', '2024-01-15', '2024-01-15'),
       ('LOAN8', 'STAFF3', 'RES8', '2022-01-01', '2022-01-15', '2022-01-15'),
       ('LOAN9', 'STAFF4', 'RES9', '2023-01-01', '2023-01-15', '2023-01-15'),
       ('LOAN10', 'STAFF5', 'RES10', '2020-01-01', '2020-01-15', '2020-01-15'),
       ('LOAN11', 'STUDENT1', 'RES11', '2023-01-01', '2023-01-15', '2023-01-15'),
       ('LOAN12', 'STUDENT2', 'RES12', '2024-01-01', '2024-01-15', '2024-01-15'),
       ('LOAN13', 'STUDENT3', 'RES13', '2022-01-01', '2022-01-15', '2022-01-15'),
        ('LOAN14', 'STUDENT4', 'RES14', '2023-01-01', '2023-01-15', '2023-01-15'),
        ('LOAN15', 'STUDENT5', 'RES15', '2024-01-01', '2024-01-30', '2024-01-30'),
        ('LOAN16', 'STAFF1', 'RES16', '2024-05-01', '2023-05-10', '2023-01-15'),
        ('LOAN17', 'STAFF2', 'RES17', '2024-06-05', '2024-06-10', '2024-01-15'),
        ('LOAN18', 'STAFF3', 'RES18', '2022-09-19', '2022-09-30', '2022-01-15'),
        ('LOAN19', 'STAFF4', 'RES19', '2023-01-01', '2023-01-15', '2023-01-15'),
        ('LOAN20', 'STAFF5', 'RES20', '2020-01-01', '2020-01-15', '2020-01-15');

INSERT INTO Reservation (ReservationID, memberID, resourceID, dateTimeReserved, dateTimeDue)
VALUES ('RESV1', 'STUDENT1', 'RES1', '2023-01-01', '2023-01-15'),
       ('RESV2', 'STUDENT2', 'RES2', '2024-01-01', '2024-01-15'),
       ('RESV3', 'STUDENT3', 'RES3', '2022-01-01', '2022-01-15'),
       ('RESV4', 'STUDENT4', 'RES4', '2023-01-01', '2023-01-15'),
       ('RESV5', 'STUDENT5', 'RES5', '2020-01-01', '2020-01-15'),
       ('RESV6', 'STAFF1', 'RES6', '2022-01-01', '2022-01-15'),
       ('RESV7', 'STAFF2', 'RES7', '2024-01-01', '2024-01-15'),
       ('RESV8', 'STAFF3', 'RES8', '2022-01-01', '2022-01-15'),
       ('RESV9', 'STAFF4', 'RES9', '2023-01-01', '2023-01-15'),
       ('RESV10', 'STAFF5', 'RES10', '2020-01-01', '2020-01-15'),
       ('RESV11', 'STUDENT1', 'RES11', '2023-01-01', '2023-01-15'),
       ('RESV12', 'STUDENT2', 'RES12', '2024-01-01', '2024-01-15'),
       ('RESV13', 'STUDENT3', 'RES13', '2022-01-01', '2022-01-15'),
        ('RESV14', 'STUDENT4', 'RES14', '2023-01-01', '2023-01-15'),
        ('RESV15', 'STUDENT5', 'RES15', '2024-01-01', '2024-01-30'),
        ('RESV16', 'STAFF1', 'RES16', '2024-05-01', '2023-05-10'),
        ('RESV17', 'STAFF2', 'RES17', '2024-06-05', '2024-06-10'),
        ('RESV18', 'STAFF3', 'RES18', '2024-09-19', '2024-09-30'),
        ('RESV19', 'STAFF4', 'RES19', '2023-01-01', '2023-01-15'),
        ('RESV20', 'STAFF5', 'RES20', '2020-01-01', '2020-01-15');

--Q1
SELECT s.name
FROM Student s
JOIN CourseOfferingToPrivilege cp ON s.studentID = cp.StudentID
JOIN CourseOffering c ON cp.offerID = c.offerID
WHERE c.cid = 'CSC101';

--Q2
SELECT p.maxItems AS MaxSpeakers
from Privilege p
join CourseOfferingToPrivilege cp on cp.privilID = p.privilID
join CourseOffering co on cp.offerID = co.offerID
join Student s on s.StudentID = cp.StudentID
join Category c on c.Code = p.Code
where co.cid='CSC101' and s.name ='John Doe' and c.name ='Speaker'

--Q3 -- done
SELECT m.name, m.phone, COUNT(*) AS TotalReservations
FROM Member m
JOIN Reservation r ON m.memberID = r.memberID
WHERE m.memberID = 'STAFF1' AND YEAR(r.dateTimeReserved) = 2022
GROUP BY m.name, m.phone;



--Q4 -- 
SELECT s.name
FROM student s
JOIN loan l ON s.studentID = l.memberID
JOIN resource r ON l.resourceID = r.resourceID
JOIN movable mov ON r.resourceID = mov.resourceID
JOIN category c ON r.resourceID = c.resourceID
WHERE c.name = 'camera' AND mov.model = 'EOS 5D Mark IV' AND YEAR(l.dateTimeBorrowed)= YEAR(CURRENT_TIMESTAMP);
	
--Q5 -- 
SELECT TOP 1 r.resourceID, r.name
FROM Reservation res
JOIN Movable mov ON res.resourceID = mov.resourceID
JOIN Resource r ON mov.resourceID = r.resourceID
WHERE YEAR(res.dateTimeReserved) = YEAR(GETDATE())
GROUP BY r.resourceID, r.name
ORDER BY COUNT(res.resourceID) DESC;

-- Q6 
SELECT CONVERT(date, r.dateTimeReserved) AS Date, ro.room AS RoomName, COUNT(r.ReservationID) AS TotalReservations
FROM Reservation r
JOIN Immovable ro ON r.resourceID = ro.resourceID
WHERE ro.room = 'Room 1' AND CONVERT(date, r.dateTimeReserved) IN ('2024-05-01', '2024-06-05', '2024-09-19')
GROUP BY CONVERT(date, r.dateTimeReserved), ro.room;


