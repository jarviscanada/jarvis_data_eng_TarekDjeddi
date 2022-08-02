###### Create cd.members
CREATE TABLE IF NOT EXISTS cd.members(
    memid INTEGER NOT NULL,
    surname VARCHAR(200) NOT NULL,
    firstname VARCHAR(200) NOT NULL,
    address VARCHAR(300) NOT NULL,
    zipcode INTEGER NOT NULL,
    telephone VARCHAR(20) NOT NULL,
    recommendedby INTEGER,
    joindate TIMESTAMP NOT NULL,
    CONSTRAINT memid_primary PRIMARY KEY(memid),
    CONSTRAINT recommendedby_foreign FOREIGN KEY(recommendedby)
        REFERENCES cd.members ON DELETE SET NULL
    );

###### Create cd.bookings
CREATE TABLE IF NOT EXISTS cd.bookings(
    facid INTEGER NOT NULL,
    memid INTEGER NOT NULL,
    starttime TIMESTAMP NOT NULL,
    slots INTEGER NOT NULL,
    CONSTRAINT facid_primary PRIMARY KEY(facid),
    CONSTRAINT memid_foreign FOREIGN KEY(memid) REFERENCES cd.members(memid)
    );

###### Create cd.facilities
CREATE TABLE IF NOT EXISTS cd.facilities(
    facid INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    membercost NUMERIC NOT NULL,
    guestcost NUMERIC NOT NULL,
    initialoutlay NUMERIC NOT NULL,
    monthlymaintenance NUMERIC NOT NULL,
    CONSTRAINT facid_primary PRIMARY KEY(facid)
    );
###### Question 1: Insert Spa data into a facilities table
INSERT INTO cd.facilities
	VALUES(9,'Spa',20,30,100000,800)

###### Questions 2: Insert calculated data into a facilities table
INSERT INTO cd.facilities 
	SELECT (SELECT MAX(facid) FROM cd.facilities) +1, 'Spa', 20, 30, 100000,800;

###### Questions 3: Update the data for the second tennis court.
UPDATE cd.facilities
	SET initialoutlay=10000 
	WHERE name='Tennis Court 2';

###### Questions 4: Update the data for the second tennis court based on the price of the first tennis court.
UPDATE cd.facilities
	SET
		membercost= (SELECT membercost * 1.1 
	    		     FROM cd.facilities 
			     WHERE name='Tennis Court 1'),		 
		guestcost= (SELECT guestcost * 1.1 
		   	    FROM cd.facilities 
			    WHERE name='Tennis Court 1')
	WHERE name='Tennis Court 2';

###### Questions 5: Delete all records from bookings table.
DELETE FROM cd.bookings;

###### Questions 6: Delete member number 37 members table.
DELETE FROM cd.members 
WHERE memid=37;

###### Questions 7: label facilities table as 'cheap' or 'expensive' depending on if their monthly maintenance cost is more than $100.
SELECT name,
       CASE
       	    WHEN monthlymaintenance > 100 THEN 'expensive'
            ELSE 'cheap'      
       END AS cost
FROM cd.facilities;

###### Questions 8: Combine list of all surnames and all facility names.
SELECT surname
FROM cd.members
UNION 
SELECT name
FROM cd.facilities;

###### Questions 9: Retrieve the start times of member  named 'David Farrell'.
SELECT b.starttime
FROM cd.bookings AS b
JOIN cd.members AS m
	ON b.memid = m.memid
WHERE m.firstname = 'David' AND m.surname = 'Farrell';

###### Questions 10: List of the start times for bookings for tennis courts, for the date '2012-09-21'.
SELECT b.starttime AS start, f.name
FROM cd.bookings AS b
JOIN cd.facilities AS f
	ON b.facid = f.facid
WHERE b.starttime >= '2012-09-21' AND
      b.starttime < '2012-09-22' AND 
      f.name LIKE 'Tennis Court%'
ORDER BY b.starttime;

###### Questions 11: Produce a list of all members, along with their recommender.
SELECT m.firstname AS memfname, m.surname AS memsname, 
       m2.firstname AS recfname, m2.surname AS recsname
FROM cd.members AS m
LEFT JOIN cd.members AS m2
	ON m.recommendedby = m2.memid
ORDER BY m.surname, m.firstname;

###### Questions 12: Produce a list of all members who have recommended another member.
SELECT m2.firstname, m2.surname
FROM cd.members AS m
INNER JOIN cd.members AS m2
	ON m.recommendedby = m2.memid
GROUP BY m2.surname, m2.firstname
ORDER BY m2.surname, m2.firstname;

###### Questions 13: Produce a list of all members, along with their recommender, using no joins.
SELECT DISTINCT(m.firstname || ' ' || m.surname) AS member,
       ( SELECT DISTINCT(m2.firstname || ' ' || m2.surname)
         FROM cd.members AS m2     
         WHERE m.recommendedby = m2.memid
       ) AS recommender
FROM cd.members AS m
ORDER BY member;

###### Questions 14: Count the number of recommendations each member makes.
SELECT recommendedby, COUNT(memid)
FROM cd.members
WHERE recommendedby IS NOT NULL
GROUP BY recommendedby
ORDER BY recommendedby;

###### Questions 15: List the total slots booked per facility.
SELECT facid, SUM(slots) AS "Total Slots"
FROM cd.bookings
GROUP BY facid
ORDER BY facid;

###### Questions 16: List the total slots booked per facility in a given month.
SELECT facid, SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-09-01' AND starttime < '2012-10-01'
GROUP BY facid
ORDER BY SUM(slots);

###### Questions 17: List the total slots booked per facility per month.
SELECT facid, EXTRACT(month from starttime) AS month, SUM(slots) AS "Total Slots"
FROM cd.bookings
WHERE starttime >= '2012-01-01' AND starttime < '2013-01-01'
GROUP BY facid, month
ORDER BY facid, month;

###### Questions 18: Find the count of members who have made at least one booking.
SELECT COUNT(DISTINCT(memid))
FROM cd.bookings;

###### Questions 19: List each member's first booking after September 1st 2012. 
SELECT m.surname, m.firstname, m.memid, MIN(b.starttime) as starttime
FROM cd.members AS m
JOIN cd.bookings AS b
	ON m.memid = b.memid
WHERE b.starttime > '2012-09-01'
GROUP BY m.memid
ORDER BY m.memid;

###### Questions 20: Produce a list of member names, with each row containing the total member count.
SELECT COUNT(*) over(), firstname, surname
FROM cd.members
ORDER BY joindate;

###### Questions 21: Produce a numbered list of members.
SELECT ROW_NUMBER() OVER() AS row_number, firstname, surname
FROM cd.members
ORDER BY joindate;

###### Questions 22: Output the facility id that has the highest number of slots booked.
SELECT facid, total 
FROM ( SELECT facid, SUM(slots) AS total, RANK() OVER(ORDER BY SUM(slots) DESC) AS rank
       FROM cd.bookings
	   GROUP BY facid
	  ) AS ranked
WHERE rank = 1;

###### Questions 23: Format the names of members.
SELECT CONCAT(surname, ', ', firstname) AS name
FROM cd.members;

###### Questions 24: Perform a case-insensitive search.
SELECT *
FROM cd.facilities
WHERE LOWER(name) LIKE 'tennis%';

###### Questions 25: Find telephone numbers with parentheses.
SELECT memid, telephone
FROM cd.members
WHERE telephone LIKE '(___)%';

###### Questions 26: Count the number of members whose surname starts with each letter of the alphabet.
SELECT SUBSTR(surname, 1, 1) AS letter, COUNT(*)
FROM cd.members
GROUP BY letter
ORDER BY letter;
