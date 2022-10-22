Use master -- switch to master database
GO

CREATE DATABASE BogartsSchedule; -- create new database

USE BogartsSchedule -- switch to newly created database
GO


-- Create required tables in the databse
CREATE TABLE VenueSchedule ( 
	BandName		VARCHAR(50)		NOT NULL PRIMARY KEY,
	DateScheduled	DATE			NULL,
	TicketsAvail	BIT				NOT NULL
);

CREATE TABLE BandInfo (
	BandName		VARCHAR(50)		NOT NULL REFERENCES VenueSchedule(BandName), -- uses BandName from VenueSchedule table as Foreign key
	MemberCount		TINYINT			NOT NULL,
	AlbumCount		TINYINT			NOT NULL,
	Followers		INT				NULL

);

CREATE TABLE BandMembers (
	MemberOf		VARCHAR(50)		NOT NULL REFERENCES VenueSchedule(BandName), -- use BandName from VenueSchedule table as Foreign key
	FirstName		VARCHAR(20)		NOT NULL,
	LastName		VARCHAR(20)		NOT NULL,
	Age				TINYINT			NOT NULL,
	BandPos			VARCHAR(20)		NOT NULL,
	FavCandy		VARCHAR(25)		NULL
);



-- instert values into each of the three tables
INSERT INTO VenueSchedule (BandName, DateScheduled, TicketsAvail)
	VALUES
		('Paramore', '10/29/22', 0),
		('The Chainsmokers', '11/12/22', 1),
		('ABBA', '12/23/22', 1),
		('X Ambassadors', '01/01/23', 0),
		('Matchbox Twenty', '02/08/23', 1),
		('Big Smile', '03/28/23', 1),
		('Group Project', '04/14/23', 1),
		('Twenty One Pilots', '05/10/23', 0),
		('Campus Rex', '06/02/23', 1),
		('The Troublemakers', '07/21/23', 1),
		('Mansionz', '08/08/23', 0)


 -- SELECT * FROM VenueSchedule


INSERT INTO BandInfo (BandName, MemberCount, AlbumCount, Followers)
	VALUES
		('Paramore', 4, 6, 5400000),
		('The Chainsmokers', 2, 4, 3300000),
		('ABBA', 4, 10, 112700),
		('X Ambassadors', 4, 4, 97300),
		('Matchbox Twenty', 4, 5, 148900),
		('Big Smile', 4, 2, 513),
		('Group Project', 3, 1, 54000),
		('Twenty One Pilots', 2, 6, 4000000),
		-- Adding more bands but not adding members to BandMembers table
		('Campus Rex', 2, 4, 12000),
		('The Troublemakers', 2, 1, 67000),
		('Mansionz', 2, 1, 212000)

-- SELECT * FROM BandInfo


INSERT INTO BandMembers (MemberOf, FirstName, LastName, Age, BandPos, FavCandy)
	VALUES
		-- Paramore Band Members
		('Paramore', 'Hayley', 'Williams', 32, 'Lead Vocals', 'Skittles'),
		('Paramore', 'Taylor', 'York', 34, 'Guitar', 'Starburst'),
		('Paramore', 'Josh', 'Farro', 38, 'Lead Guitar', 'Reese Cups'),
		('Paramore', 'Zac', 'Farro', 31, 'Drums', 'Three Musketeers'),
		-- Chainsmoker Band Members
		('The Chainsmokers', 'Andrew', 'Taggart', 24, 'Lead Vocals', 'Hershey Bar'),
		('The Chainsmokers', 'Alex', 'Pall', 28, 'Electronics', 'Mound Bar'),
		-- ABBA Band Members
		('ABBA', 'Agenetha', 'Faltskog', 54, 'Vocals', NULL),
		('ABBA', 'Anni-Frid', 'Lyngstad', 57, 'Vocals', 'Air Heads'),
		('ABBA', 'Bjorn', 'Ulvaeus', 62, 'Guitar', NULL),
		('ABBA', 'Benny', 'Andersson', 56, 'Guitar', 'Skittles'),
		-- X Ambassadors Members
		('X Ambassadors', 'Casey', 'Harris', 30, 'Vocals', 'Nerds'),
		('X Ambassadors', 'Sam', 'Harris', 27, 'Vocals', 'Three Musketeers'),
		('X Ambassadors', 'Adam', 'Levin', 19, 'Guitar', 'Air Heads'),
		('X Ambassadors', 'Noah', 'Feldshuh', 32, 'Drums', 'M&Ms'),
		-- Matchbox Twenty Members
		('Matchbox Twenty', 'Rob', 'Thomas', 49, 'Vocals', 'Chocolate'),
		('Matchbox Twenty', 'Kyle', 'Cook', 43, 'Lead Guitar', NULL),
		('Matchbox Twenty', 'Adam', 'Gaynor', 54, 'Drums', NULL),
		('Matchbox Twenty', 'Brian', 'Yale', 52, 'Bass', 'Dumbpops'),
		-- Big Smile Members
		('Big Smile', 'Scooter', 'Smith', 29, 'Vocals', 'Skittles'),
		('Big Smile', 'John', 'Morris', 32, 'Bass', 'Hershey Kiss'),
		('Big Smile', 'Noah', 'Jatczak', 26, 'Guitar', 'Starburst'),
		('Big Smile', 'Cameron', 'Hayes', 24, 'Drums', NULL),
		-- Twenty One Pilots Members
		('Twenty One Pilots', 'Josh', 'Dunn', 33, 'Drums', 'Reese Peices'),
		('Twenty One Pilots', 'Tyler', 'Joseph', 31, 'Vocals', 'Oreos')

-- SELECT * FROM BandMembers

-- Add new column to BandInfo table
ALTER TABLE BandInfo
	ADD FormedIn DATE;

-- Delete the newly added column from the BandInfo table
ALTER TABLE BandInfo 
	DROP COLUMN FormedIn;

-- Select MemberCount in ascending order
SELECT * FROM BandInfo
	ORDER BY MemberCount ASC;	-- You might want to know how many supplies to provide the band based of their amount of members

-- Select everything from BandInfo table and sort by follower is descending order
SELECT * FROM BandInfo
	ORDER BY Followers DESC;	-- You might want to know how popular a band is before they play

-- Select Top 10 bands based of their follower count
SELECT TOP(10) * FROM BandInfo
	ORDER BY Followers DESC;

-- Select shows that don't have ticket available using the IN Operator
SELECT * FROM VenueSchedule
	WHERE TicketsAvail IN (0);

-- Select bands with a follower count between 1000000 and 6000000
SELECT * FROM BandInfo	
	WHERE Followers BETWEEN 1000000 AND 6000000;

-- Inner join
SELECT BandInfo.BandName, BandMembers.MemberOf FROM BandInfo
	INNER JOIN BandMembers ON BandInfo.BandName = BandMembers.MemberOf;

-- Left join
SELECT BandInfo.BandName, BandMembers.MemberOf FROM BandMembers
	LEFT JOIN BandInfo ON BandInfo.BandName = BandMembers.MemberOf;

-- Right join
SELECT BandMembers.MemberOf, BandInfo.BandName FROM BandInfo
	RIGHT JOIN BandMembers ON BandMembers.MemberOf = BandInfo.BandName;

-- Insert a new band member with a null value for their favorite candy
INSERT INTO BandMembers (MemberOf, FirstName, LastName, Age, BandPos, FavCandy)
	VALUES
		('Mansionz', 'Mike', 'Posner', 33, 'Vocals', NULL);

-- Calculate the sum of the followers column from the BandInfo table
SELECT SUM(Followers) AS AllBandFollows FROM BandInfo;

-- Calculate the total amount of bands scheduled to play at the venue
SELECT COUNT(BandName) AS TotalBands FROM VenueSchedule;

-- Calculate the total amount of different types of candy band members like (can be NULL)
SELECT COUNT(FavCandy) AS TotalCandyTypes FROM BandMembers;

-- Calculate the average amount of members per band
SELECT AVG(MemberCount) AS AvgMemberCount FROM BandInfo;

/* These results could be useful to the venue for various reason
		1. Understand the popularity of each band before they arrive
		2. Use total follower count to get more advertisers/sponsers
		3. Knowing the average size of the bands that play helps you prepare the sets and greenrooms for future bands.
*/

-- Select statement using GROUP BY
SELECT BandName, MemberCount FROM BandInfo
GROUP BY BandName;

-- Requirement #19 / you might want to print a list of each artist and their favorite candy to buy for them
SELECT FirstName + ' ' + LastName + '- ' + FavCandy AS ArtistCandy FROM BandMembers
	WHERE MemberOf = 'Paramore';

-- Get the full name of band members using CONCAT
SELECT CONCAT(FirstName, ' ', LastName) FROM BandMembers
	WHERE MemberOf = 'Mansionz';

-- Get the full name of band members without using CONCAT
SELECT FirstName + ' ' + LastName FROM BandMembers
	WHERE MemberOf = 'Mansionz';