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
Fee MONEY CHECK (Fee > 0) NOT NULL,
PRIMARY KEY(ClientID,TourName,EventYear,EventMonth,EventDay),
FOREIGN KEY(ClientID) REFERENCES Client,
FOREIGN KEY(TourName,EventYear,EventMonth,EventDay) REFERENCES Event);



--- Task 3 ---



--- Task 4 ---




--- Task 5 ---




--- Task 6 ---

