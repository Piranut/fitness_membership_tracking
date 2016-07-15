-- Table Drops and Metadata Creation
-- Drop table statements

	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Attendance')
	DROP TABLE Attendance;

	GO

	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Members')
	DROP TABLE Members;

	GO

	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Classes')
	DROP TABLE Classes;

	GO

	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='MemberShipTypes')
	DROP TABLE MemberShipTypes;

	GO

	IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Instructors')
	DROP TABLE Instructors;




-- Create table statements

	CREATE TABLE MemberShipTypes (
		MembershipTypeID int IDENTITY(1,1) not null,
		MembershipTypeDescription varchar(30) not null
	);

	CREATE TABLE Instructors (
		InstructorID int IDENTITY(1,1) not null,
		InstructorFirstName varchar(30) not null,
		InstructorLastName varchar(30) not null
	);

	CREATE TABLE Members (
		MemberID int IDENTITY(1,1) not null,
		MemberFirstName varchar(30) not null,
		MemberLastName varchar(30) not null,
		MemberPhone varchar(30) not null,
		MemberEmail varchar(30) not null,
		MemberDOB datetime not null,
		MemberAge AS DATEDIFF(hour,MemberDOB,GETDATE())/8766,
		MemberMemberShipTypeID int not null
	);

	CREATE TABLE Classes (
		ClassID int IDENTITY(1,1) not null,
		ClassName varchar(50) not null,
		ClassInstructorID int not null,
		ClassDateTime datetime not null,
		ClassDurationMinutes int DEFAULT 60 not null
	);

	CREATE TABLE Attendance (
		AttendanceID int IDENTITY(1,1) not null,
		AttendanceSignIn datetime not null,
		AttendanceMemberID int not null,
		AttendanceClassID int not null,
		PerformanceNotes varchar(80) null
	);


-- Table Constraints
-- Alter table statements


	ALTER TABLE MemberShipTypes
			ADD CONSTRAINT pk_membershiptype PRIMARY KEY (MembershipTypeID);


	ALTER TABLE Instructors
			ADD CONSTRAINT pk_instructor PRIMARY KEY (InstructorID);

	ALTER TABLE Members
			ADD CONSTRAINT pk_member PRIMARY KEY (MemberID),
				CONSTRAINT fk_membermembershiptype FOREIGN KEY (MemberMemberShipTypeID)
				REFERENCES MemberShipTypes(MembershipTypeID);

	ALTER TABLE Classes
			ADD CONSTRAINT pk_class PRIMARY KEY (ClassID),
				CONSTRAINT fk_classinstructor FOREIGN KEY (ClassInstructorID)
				REFERENCES Instructors(InstructorID);

	ALTER TABLE Attendance
			ADD CONSTRAINT pk_attendance PRIMARY KEY (AttendanceID),
				CONSTRAINT fk_attendancemember FOREIGN KEY (AttendanceMemberID)
				REFERENCES Members(MemberID),
				CONSTRAINT fk_attendanceclass FOREIGN KEY (AttendanceClassID)
				REFERENCES Classes(ClassID),
				CONSTRAINT uq_attendance UNIQUE (AttendanceMemberID, AttendanceClassID);


-- Insert Base Data


			INSERT INTO MemberShipTypes (
					MembershipTypeDescription
					) VALUES
					('3day'),
					('Family'),
					('Single');

			INSERT INTO Members (
					MemberFirstName,
					MemberLastName,
					MemberPhone,
					MemberEmail,
					MemberDOB,
					MemberMemberShipTypeID
					) VALUES
					('Matt','Sorum','202-555-0140','Matt.Sorum@lookout.net','1993-03-15',1),
					('Tim','Alexander','202-555-0120','Tim.Alexander@geemail.com','1994-07-12',2),
					('Charlie','Benante','202-555-0166','Charlie.Benante@yaywho.com','1984-08-16',1),
					('Clive','Burr','202-555-0134','Clive.Burr@lookout.net','1982-10-16',3),
					('Nikko','McBrain','202-555-0136','Nikko.McBrain@yaywho.com','1986-09-07',1),
					('Adrienne','Davies','202-555-0120','Adrienne.Davies@geemail.com','1972-02-05',3),
					('Ginger','Fish','202-555-0146','Ginger.Fish@yaywho.com','1993-08-03',3),
					('Morgan','Lander','202-555-0154','Morgan.Lander@geemail.com','1975-05-23',2),
					('Mercedes','Lander','202-555-0106','Mercedes.Lander@lookout.net','1977-09-05',3),
					('Tara','McLeod','202-555-0178','Tara.McLeod@yaywho.com','1980-12-03',2),
					('Trish','Doan','202-555-0181','Trish.Doan@yaywho.com','1989-09-15',2);



			INSERT INTO Instructors (
					InstructorFirstName,
					InstructorLastName
					) VALUES
					('Yeshua','Osbert'),
					('Kerry','King'),
					('Lita','Ford'),
					('Cristina','Scabbia');


			INSERT INTO Classes (
					ClassName,
					ClassInstructorID,
					ClassDateTime,
					ClassDurationMinutes
					) VALUES
					('Pedal to the Metal',1,'3/6/2016 4:30PM',60),
					('Pedal to the Metal',2,'3/6/2016 6:00PM',60),
					('Pedal to the Metal',1,'3/9/2016 4:30PM',60),
					('Pedal to the Metal',2,'3/9/2016 6:00PM',60),
					('Pedal to the Metal',3,'3/10/2016 2:30PM',45),
					('Total Carnage',4,'3/6/2016 6:00PM',90),
					('Total Carnage',4,'3/9/2016 6:00PM',90);



			INSERT INTO Attendance (
						AttendanceSignIn,
						AttendanceMemberID,
						AttendanceClassID
						) VALUES
						('3/6/2016 4:30PM',1,1), -- 3/6/2016 4:30PM   Pedal to the Metal
						('3/6/2016 4:30PM',2,1),
						('3/6/2016 4:30PM',3,1),
						('3/6/2016 4:30PM',4,1),
						('3/6/2016 6:00PM',8,2), -- 3/6/2016 6:00PM
						('3/6/2016 6:00PM',9,2),
						('3/6/2016 6:00PM',10,2),
						('3/6/2016 6:00PM',11,2),
						('3/9/2016 4:30PM',1,3), -- 3/9/2016 4:30PM
						('3/9/2016 4:30PM',2,3),
						('3/9/2016 4:30PM',3,3),
						('3/9/2016 4:30PM',4,3),
						('3/9/2016 6:00PM',8,4), -- 3/9/2016 6:00PM
						('3/9/2016 6:00PM',9,4),
						('3/9/2016 6:00PM',10,4),
						('3/9/2016 6:00PM',11,4),
						('3/10/2016 2:30PM',1,5), -- 3/10/2016 2:30PM
						('3/10/2016 2:30PM',2,5),
						('3/10/2016 2:30PM',3,5),
						('3/10/2016 2:30PM',4,5),
						('3/6/2016 6:00PM',1,6),   -- 3/6/2016 6:00PM Total Carnage 1,5,6,7,8,9
						('3/6/2016 6:00PM',5,6),
						('3/6/2016 6:00PM',6,6),
						('3/6/2016 6:00PM',7,6),
						('3/6/2016 6:00PM',8,6),
						('3/6/2016 6:00PM',9,6),
						('3/9/2016 6:00PM',7,7), -- 3/9/2016 6:00PM  7,8,9,1
						('3/9/2016 6:00PM',8,7),
						('3/9/2016 6:00PM',9,7),
						('3/9/2016 6:00PM',1,7);




-- Data Verification via Queries

-- Query 1:  All fields from the Members table and the class names of any classes they have attended.

			SELECT DISTINCT MemberID,
				   MemberFirstName,
				   MemberLastName,
				   MemberPhone,
				   MemberEmail,
				   MemberDOB,
				   MemberAge ,
				   MemberMemberShipTypeID,
				   ClassName FROM Members
							 LEFT JOIN Attendance ON AttendanceMemberID = MemberID
							  JOIN Classes ON AttendanceClassID = ClassID;



-- 	Query 2: Members who sign up for a 3-day membership are allowed to
--           attend 3 classes per week at most. Names and phone numbers of any members with a 3-day membership
--           who have attended more than 3 classes in 1 week.

			SELECT  MemberFirstName, MemberLastName, MemberPhone FROM Members
					JOIN Attendance ON MemberID = AttendanceMemberID
					WHERE MemberMemberShipTypeID = 1
					GROUP BY MemberFirstName, MemberLastName, MemberPhone
					HAVING COUNT(MemberID) > 3;


-- 	Query 3: 	The current monthly cost for a Family membership is $100 per
--          	month. The increase in yearly revenue if
--          	the club owners raise the price to $110 per month:

			SELECT (SELECT COUNT(*) FROM Members WHERE MemberMemberShipTypeID = 2) * 120 AS IncreaseInRevenue;



-- 	Query 4:   Ginger Fish would like to upgrade her membership to a Family
--             membership type. UPDATE her
--             membership type to Family. Select statement
--             to confirm the new membership type for Ginger Fish.

			UPDATE Members SET  MemberMemberShipTypeID = 2
				WHERE MemberID = 7

			SELECT * FROM Members WHERE MemberID = 7;



-- 	Query 5: 	Instructor Cristina Scabbia had to travel to Italy with her
--          	band in March, so Wendy Williams actually led her 3/9 Total
--          	Carnage class. Adding Wendy Williams to the
--          	instructors table and update the InstructorID for the 3/9 Total
--          	Carnage class to Wendy’s ID

				INSERT INTO Instructors (
					InstructorFirstName,
					InstructorLastName
					) VALUES
					('Wendy','Williams')

				UPDATE Classes
					SET ClassInstructorID = 5
					WHERE ClassDateTime = '3/9/2016 6:00PM' AND ClassName = 'Total Carnage'





-- Query 6: The average age of members who have taken at least 1 Pedal to the Metal class:

			SELECT AVG(MemberAge) FROM Members
				JOIN Attendance ON MemberID = AttendanceMemberID
				JOIN Classes ON AttendanceClassID = ClassID
				WHERE   ClassName = 'Pedal to the Metal'
				HAVING COUNT(MemberID) > 1;



-- Query 7: Adding a field to the
--          Attendance table so members can record their results for each class
--          they attend.

			ALTER TABLE Attendance
				ADD Results int;



-- Query 8: Number of people in the 3/6 Total Carnage Class:

			SELECT COUNT(*) FROM Attendance JOIN Classes ON AttendanceClassID = ClassID
				WHERE ClassName = 'Total Carnage' AND DAY(AttendanceSignIn) = 6;



-- Query 9: 2 members with the same phone number.

			SELECT MemberFirstName, MemberLastName FROM Members
				WHERE MemberPhone IN (
						 SELECT MemberPhone FROM Members GROUP BY MemberPhone HAVING COUNT(MemberID) > 1
						 );

-- Query 10: Nikko McBrain’s phone number:

			SELECT MemberPhone FROM Members WHERE MemberID = 5;


