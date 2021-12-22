CREATE TABLE Accident (
    state decimal(2,0) NOT NULL,
    stateCase decimal(6,0) NOT NULL,
    veForms decimal(2,0),
    dateID int,
    locationID int,
    route decimal(2,0),
    peds decimal(2,0),
    persons decimal(2,0),
    lightEnum decimal(1,0),
    lightConditions varchar(30),
    weatherEnum decimal(2,0),
    weather varchar(30),
    drunkDrivers decimal (2,0),
    fatalities decimal (2,0),
    CONSTRAINT PK_Accident PRIMARY KEY (stateCase),
    FOREIGN KEY (state) REFERENCES State(stateID),
    FOREIGN KEY (route) REFERENCES Route(routeID)
);

LOAD DATA INFILE '/var/lib/mysql-files/Group72/accident.csv' INTO Table Accident 
FIELDS TERMINATED by ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES 
(state, stateCase, @dummy, veForms, @dummy, peds, @dummy, @dummy, persons, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
route, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, lightConditionsEnum, @dummy, @dummy, weatherEnum, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, fatalities, drunkDrivers);

Update Accident INNER JOIN Weather ON Accident.weatherEnum = Weather.weatherID SET Accident.weather = Weather.weatherDesc;
Update Accident INNER JOIN Light ON Accident.lightEnum = Light.lightID SET Accident.lightConditions = Light.lightDesc;
ALTER TABLE Accident DROP COLUMN lightEnum;
ALTER TABLE Accident DROP COLUMN weatherEnum;
DROP TABLE Weather;
DROP TABLE Light;


CREATE TABLE Date (
    dateID int NOT NULL AUTO_INCREMENT,
    stateCase decimal (6,0),
    day decimal (2,0),
    dayWeek decimal(1,0),
    month varchar (10),
    year decimal (4,0),
    hour decimal(2,0),
    minute decimal (2,0),
    PRIMARY KEY (dateID)
);

LOAD DATA INFILE '/var/lib/mysql-files/Group72/accident.csv' INTO Table Date 
FIELDS TERMINATED by ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES 
(@dummy, stateCase, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, day, month, year, dayWeek, hour, minute, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

Update Accident INNER JOIN Date ON Accident.stateCase = Date.stateCase SET Accident.dateID = Date.dateID;
ALTER TABLE Accident ADD FOREIGN KEY (dateID) REFERENCES Date(dateID);
ALTER TABLE Date DROP COLUMN stateCase;

CREATE TABLE Location (
    locationID int NOT NULL AUTO_INCREMENT,
    stateCase decimal (6,0),
    state decimal(2,0),
    city decimal(4,0),
    county decimal(3,0),
    latitude decimal(10,8),
    longitude decimal(18,15),
    PRIMARY KEY (locationID),
    FOREIGN KEY (state) REFERENCES State(stateID)
);

LOAD DATA INFILE '/var/lib/mysql-files/Group72/accident.csv' INTO Table Location 
FIELDS TERMINATED by ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES 
(state, stateCase, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, county, 
city, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy, @dummy, latitude, longitude, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy);

Update Accident INNER JOIN Location ON Accident.stateCase = Location.stateCase SET Accident.locationID = Location.locationID;
ALTER TABLE Accident ADD FOREIGN KEY (locationID) REFERENCES Location(locationID);
ALTER TABLE Location DROP COLUMN stateCase;

CREATE TABLE Vehicle (
    state decimal(2,0) NOT NULL,
    stateCase decimal(6,0) NOT NULL,
    vehicleNumber decimal(2,0) NOT NULL,
    numOccs decimal(2,0),
    collisionManner decimal(2,0),
    hitAndRun decimal (1,0),
    registeredState decimal(2,0),
    owner decimal(1,0),
    make decimal(2,0),
    model decimal(3,0),
    modelYear decimal(4,0),
    deaths decimal(2,0),
    rollover decimal(1,0),
    driverDrunk decimal(1,0),
    speedLimit decimal (3,0),
    PRIMARY KEY (stateCase, vehicleNumber),
    FOREIGN KEY (stateCase) REFERENCES Accident(stateCase),
    FOREIGN KEY (state) REFERENCES State(stateID),
    FOREIGN KEY (owner) REFERENCES Owner(ownerID),
    FOREIGN KEY (registeredState) REFERENCES State(stateID),
    FOREIGN KEY (collisionManner) REFERENCES CollisionManner(collisionMannerID)
);
-- THE IGNORE 22k is cuz of a special character at around 21500, will try to find a better workaround but there are still 26k lines after
LOAD DATA INFILE '/var/lib/mysql-files/Group72/vehicle.csv' INTO Table Vehicle
FIELDS TERMINATED by ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' IGNORE 22000 LINES 
(state, stateCase, vehicleNumber, @dummy, numOccs, @dummy, @dummy, @dummy, @dummy, @dummy, 
collisionManner, @dummy, hitAndRun, registeredState, owner, make, model, @dummy, @dummy, 
modelYear, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, rollover, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, speedLimit, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy, @dummy, deaths, driverDrunk);


--MAYBE NOT DONE? ACTION AND IMPAIREMENT ARE HARD AS FROM OTHER CSVs
CREATE TABLE NonMotorist (
    state decimal(2,0) NOT NULL,
    stateCase decimal(6,0) NOT NULL,
    personNumber decimal(2,0) NOT NULL,
    passerbyType decimal(2,0),
    age decimal(3,0),
    sex varchar(15),
    sexEnum decimal(1,0),
    PRIMARY KEY (stateCase, personNumber),
    FOREIGN KEY (stateCase) REFERENCES Accident(stateCase),
    FOREIGN KEY (passerbyType) REFERENCES PasserbyType(passerbyTypeID)
);

LOAD DATA INFILE '/var/lib/mysql-files/Group72/pbtype.csv' INTO Table NonMotorist
FIELDS TERMINATED by ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES
(state, stateCase, @dummy, personNumber, passerbyType, age, sexEnum, @dummy, @dummy, @dummy, 
@dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy,
@dummy, @dummy, @dummy);

Update NonMotorist INNER JOIN Gender ON NonMotorist.sexEnum = Gender.genderID SET NonMotorist.sex = Gender.genderDesc;
ALTER TABLE NonMotorist DROP COLUMN sexEnum;
DROP TABLE Gender;
