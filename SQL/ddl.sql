-- Create cd.members
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

-- Create cd.bookings
CREATE TABLE IF NOT EXISTS cd.bookings(
    facid INTEGER NOT NULL,
    memid INTEGER NOT NULL,
    starttime TIMESTAMP NOT NULL,
    slots INTEGER NOT NULL,
    CONSTRAINT facid_primary PRIMARY KEY(facid),
    CONSTRAINT memid_foreign FOREIGN KEY(memid) REFERENCES cd.members(memid)
    );

-- Create cd.facilities
CREATE TABLE IF NOT EXISTS cd.facilities(
    facid INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    membercost NUMERIC NOT NULL,
    guestcost NUMERIC NOT NULL,
    initialoutlay NUMERIC NOT NULL,
    monthlymaintenance NUMERIC NOT NULL,
    CONSTRAINT facid_primary PRIMARY KEY(facid)
    );

