/*

Name: Kanishka Malikkhil
Student_ID: 103220762

*/

/*
---- TASK 1 ----

Tour(TourName, Description)
PRIMARY KEY (TourName)

Client(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)

Event(TourName,EventYear,EventMonth,EventDay,Fee)
PRIMARY KEY(TourName,EventYear,EventMonth,EventDay)
FOREIGN KEY(TourName) REFERENCES Tour

Booking(ClientID,TourName,EventYear,EventMonth,EventDay,DateBooked,Payment)
PRIMARY KEY(ClientID,TourName,EventYear,EventMonth,EventDay)
FOREIGN KEY(ClientID) REFERENCES Client
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event


*/

--- Task 2 ---

DROP TABLE IF EXISTS Tour;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Event;
DROP TABLE IF EXISTS Booking; 

CREATE TABLE Tour(
TourName NVARCHAR(100),
Description NVARCHAR(500),
PRIMARY KEY (TourName));

CREATE TABLE Client(
ClientID INT,
Surname NVARCHAR(100) NOT NULL,
GivenName NVARCHAR(100) NOT NULL,
Gender NVARCHAR(1) CHECK (Gender IN ('M','F','I')) NULL,
PRIMARY KEY(ClientID));

CREATE TABLE Event(
TourName NVARCHAR(100),
EventYear INT CHECK (len(EventYear) = 4),
EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
EventDay INT CHECK (EventDay >=1 AND EventDay <=31),
Fee MONEY CHECK (Fee > 0) NOT NULL,
PRIMARY KEY(TourName,EventYear,EventMonth,EventDay),
FOREIGN KEY(TourName) REFERENCES Tour);

CREATE TABLE Booking(
ClientID INT,
TourName NVARCHAR(100),
EventYear INT CHECK (len(EventYear) = 4),
EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec')),
EventDay INT CHECK (EventDay >=1 AND EventDay <=31),
DateBooked DATE NOT NULL,
Payment MONEY CHECK (Payment > 0) NOT NULL,
PRIMARY KEY(ClientID,TourName,EventYear,EventMonth,EventDay),
FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event);



--- Task 3 ---

INSERT INTO Tour (TourName, Description) VALUES
    ('North','Tour of wineries and outlets of the Bedigo and Castlemaine region'),
    ('South','Tour of wineries and outlets of Mornington Penisula'),
    ('West','Tour of wineries and outlets of the Geelong and Otways region');
	

INSERT INTO Client (ClientID, Surname, GivenName, Gender) VALUES
    (1,'Price','Taylor','M'),
    (2,'Gamble','Ellyse','F'),
    (3,'Tan','Tilly','F'),
	(4,'Malikkhil','Kanishka','M');
	
INSERT INTO Event (TourName,EventMonth,EventDay,EventYear,Fee) VALUES
    ('North','Jan',9,2016,200),
    ('North','Feb',13,2016,225),
    ('South','Jan',9,2016,200),
    ('South','Jan',16,2016,200),
    ('West','Jan',29,2016,225);
	
INSERT INTO Booking (ClientID,TourName,EventMonth,EventDay,EventYear,Payment,DateBooked) VALUES
    (1,'North','Jan',9,2016,200,'2015-12-10'),
    (2,'North','Jan',9,2016,200,'2015-12-16'),
    (1,'North','Feb',13,2016,225,'2016-01-08'),
    (2,'North','Feb',13,2016,125,'2016-01-14'),
    (3,'North','Feb',13,2016,225,'2016-02-03'),
    (1,'South','Jan',9,2016,200,'2015-12-10'),
    (2,'South','Jan',16,2016,200,'2015-12-18'),
    (3,'South','Jan',16,2016,200,'2016-01-09'),
    (2,'West','Jan',29,2016,225,'2015-12-17'),
    (3,'West','Jan',29,2016,200,'2015-12-18');


--- Task 4 ---

--- Query 1 ------

SELECT C.GivenName, C.Surname, T.TourName, T.DESCRIPTION, E.EventYear, E.EventMonth,E.EventDay,E.Fee, B.DateBooked, B.Payment
FROM Booking B 

INNER JOIN Client C
ON B.ClientID = C.ClientID

INNER JOIN Event E 
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay

INNER JOIN Tour T 
ON E.TourName = T.TourName;

--- Query 2 ------

SELECT B.EventMonth, B.TourName, COUNT(*) AS 'Num Bookings'
FROM Booking B 
GROUP BY B.EventMonth, B.TourName;

--- Query 3 ------

SELECT *
FROM Booking
WHERE Payment > (SELECT AVG(Payment) FROM Booking);

--- OR if we want to display some other fields as well

SELECT C.GivenName, C.Surname, T.TourName, T.DESCRIPTION, E.EventYear, E.EventMonth,E.EventDay,E.Fee, B.DateBooked, B.Payment
FROM Booking B 

INNER JOIN Client C
ON B.ClientID = C.ClientID

INNER JOIN Event E 
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay

INNER JOIN Tour T 
ON E.TourName = T.TourName

WHERE B.Payment > (SELECT AVG(B.Payment) FROM Booking B);

--- Task 5 ---

CREATE VIEW TASK5 AS

SELECT C.GivenName, C.Surname, T.TourName, T.DESCRIPTION, E.EventYear, E.EventMonth,E.EventDay,E.Fee, B.DateBooked, B.Payment
FROM Booking B 

INNER JOIN Client C
ON B.ClientID = C.ClientID

INNER JOIN Event E 
ON B.TourName = E.TourName AND B.EventYear = E.EventYear AND B.EventMonth = E.EventMonth AND B.EventDay = E.EventDay

INNER JOIN Tour T 
ON E.TourName = T.TourName;



--- Task 6 ---

---**********Testing Query 1 From Task 4*******----

--- Return same 10 rows of data as per the orginal query task 4 - Query 1
SELECT *
FROM Booking;


-- Returns Count of rows as 10 - same number of rows in the task 4 - Query 1
SELECT COUNT(*)
FROM Booking;

---- Can confirm the query result is correct which is showing 10 rows of data----


---********Testing Query 2 From Task 4******----

--- Both these test qureies provide 10 results (Rows of data) ---
SELECT * 
FROM Booking;

SELECT COUNT(*)
FROM Booking;

--- The result from the query is ---

Feb	North	3
Jan	North	2
Jan	South	3
Jan	West	2

Total = 3+2+3+2 = 10

--- The output of the queries is 10 or 10 rows of data

---********Testing Query 3 From Task 4***********----

--- The test queries below return Count 3 Rows of data with is same as the original query results at Task 4 -Query 3 ---
SELECT COUNT(Payment)
FROM Booking
WHERE Payment > (SELECT AVG(Payment) FROM Booking);

--- calculated the average as 200 from all the data and the following test query resutl is the same as Task 4 -Query 3---
SELECT *
FROM Booking
WHERE Payment > 200;



-----------------------------END-----------------------------------------------