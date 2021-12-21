CREATE TABLE State (
    stateID decimal(2,0),
    stateName varchar (25),
    PRIMARY KEY (stateID)
);

INSERT INTO State
VALUES
    (1, 'Alabama'),
    (2, 'Alaska'),
    (4, 'Arizona'),
    (5, 'Arkansas'),
    (6, 'California'),
    (8, 'Colorado'),
    (9, 'Connecticut'),
    (10, 'Delaware'),
    (11, 'District of Columbia'),
    (12, 'Florida'),
    (13, 'Georgia'),
    (15, 'Hawaii'),
    (16, 'Idaho'),
    (17, 'Illinois'),
    (18, 'Indiana'),
    (19, 'Iowa'),
    (20, 'Kansas'),
    (21, 'Kentucky'),
    (22, 'Louisiana'),
    (23, 'Maine'),
    (24, 'Maryland'),
    (25, 'Massachusetts'),
    (26, 'Michigan'),
    (27, 'Minnesota'),
    (28, 'Mississippi'),
    (29, 'Missouri'),
    (30, 'Montana'),
    (31, 'Nebraska'),
    (32, 'Nevada'),
    (33, 'New Hampshire'),
    (34, 'New Jersey'),
    (35, 'New Mexixco'),
    (36, 'New York'),
    (37, 'North Carolina'),
    (38, 'North Dakota'),
    (39, 'Ohio'),
    (40, 'Oklahoma'),
    (41, 'Oregon'),
    (42, 'Pennsylvania'),
    (43, 'Puerto Rico'),
    (44, 'Rhode Island'),
    (45, 'South Carolina'),
    (46, 'South Dakota'),
    (47, 'Tennessee'),
    (48, 'Texas'),
    (49, 'Utah'),
    (50, 'Vermont'),
    (51, 'Virginia'),
    (52, 'Virgin Islands'),
    (53, 'Washington'),
    (54, 'West Virginia'),
    (55, 'Wisconsin'),
    (56, 'Wyoming');

CREATE TABLE Route (
    routeID decimal(1,0) NOT NULL,
    routeDesc varchar(30),
    PRIMARY KEY (routeID)
);

INSERT INTO Route
VALUES 
    (1, 'Interstate'),
    (2, 'U.S. highway'),
    (3, 'State highway'),
    (4, 'County road'),
    (5, 'Township local street'),
    (6, 'Municipality local street'),
    (7, 'Frontage Road'),
    (8, 'Other'),
    (9, 'Unknown');

CREATE TABLE Owner (
    ownerID decimal(1,0) NOT NULL,
    ownerDesc varchar(255),
    PRIMARY KEY (ownerID)
);

INSERT INTO Owner
VALUES 
    (0, 'Not applicable, vehicle not registered'),
    (1, 'Driver (of this vehicle) was registered owner'),
    (2, 'Driver (of this vehicle) not registered owner (other private owner)'),
    (3, 'Vehicle registered as business/company/government vehicle'),
    (4, 'Vehicle registered as rental vehicle'),
    (5, 'Vehicle was stolen (reported by police)'),
    (6, 'Driverless / motor vehicle parked / stopped off roadway'),
    (9, 'Unknown');

CREATE TABLE CollisionManner (
    collisionMannerID decimal(2,0) NOT NULL,
    collisionMannerDesc varchar(75),
    PRIMARY KEY (collisionMannerID)
);

INSERT INTO CollisionManner
VALUES 
    (0, 'Not a collision with a motor vehicle in-transport'),
    (1, 'Front-to-rear'),
    (2, 'Front-to-front'),
    (6, 'Angle'),
    (7, 'Sideswipe - same direction'),
    (8, 'Sideswipe - opposite direction'),
    (9, 'Rear-to-side'),
    (10, 'Rear-to-rear'),
    (11, 'Other'),
    (98, 'Not reported'),
    (99, 'Unknown');

CREATE TABLE NonMotoristAction (
    nonMotoristActionID decimal(2,0) NOT NULL,
    nonMotoristActionDesc varchar(75),
    PRIMARY KEY (nonMotoristActionID)
);

INSERT INTO NonMotoristAction
VALUES 
    (1, 'Going to or from school (K-12)'),
    (2, 'Waiting to cross roadway'),
    (3, 'Crossing Roadway'),
    (4, 'Jogging/running'),
    (5, 'Movement along roadway with traffic (in or adjacent to travel lane)'),
    (6, 'Movement along roadway against traffic (in or adjacent to travel lane)'),
    (7, 'Movement on sidewalk'),
    (8, 'In roadway - other (working, playing, etc.)'),
    (9, 'Adjacent to roadway (e.g., shoulder, median)'),
    (10, 'Working in trafficway (incident response)'),
    (11, 'Entering / exiting a vehicle'),
    (12, 'Disabled vehicle related (working on, pushing, leaving / approaching)'),
    (14, 'Other'),
    (15, 'None'),
    (98, 'Not reported'),
    (99, 'Unknown');

CREATE TABLE NonMotoristImpairment (
    nonMotoristImpairmentID decimal(2,0) NOT NULL,
    nonMotoristImpairmentDesc varchar(75),
    PRIMARY KEY (nonMotoristImpairmentID)
);

INSERT INTO NonMotoristImpairment
VALUES 
    (0, 'None/apparently normal'),
    (1, 'Ill, blackout'),
    (2, 'Asleep or fatigued'),
    (3, 'Walking with a cane or crutches'),
    (4, 'Paraplegic or restricted to wheelchair'),
    (5, 'Impaired due to previous injury'),
    (6, 'Deaf'),
    (7, 'Blind'),
    (8, 'Emotional (depressed, angry, disturbed, etc.)'),
    (9, 'Under the influence of alcohol, drugs or medication'),
    (10, 'Physical impairment - no details'),
    (96, 'Other physical imparement'),
    (98, 'Not reported'),
    (99, 'Unknown if physically impaired ');

CREATE TABLE PasserbyType (
    passerbyTypeID decimal(2,0) NOT NULL,
    passerbyTypeDesc varchar(45),
    PRIMARY KEY (passerbyTypeID)
);

INSERT INTO PasserbyType
VALUES 
    (5, 'Pedestrian'),
    (6, 'Bicyclist'),
    (7, 'Other Cyclist'),
    (8, 'Persons on personal conveyances'),   
    (10, 'Persons in/on buildings'),
    (19, 'Unknown'),
    (88, 'Not reported'),
    (99, 'No pedestrian/bicyclist record');

CREATE TABLE Date (
    dateID int NOT NULL AUTO_INCREMENT,
    day decimal (2,0),
    dayWeek varchar(10),
    month varchar (10),
    year decimal (4,0),
    hour decimal(2,0),
    minute decimal (2,0),
    PRIMARY KEY (dateID)
);

CREATE TABLE Location (
    locationID int NOT NULL AUTO_INCREMENT,
    state decimal(2,0),
    city varchar(25),
    latitude decimal(10,0),
    longitude decimal(10,0),
    PRIMARY KEY (locationID),
    FOREIGN KEY (state) REFERENCES State(stateID)
);

CREATE TABLE Accident (
    state decimal(2,0) NOT NULL,
    caseNum decimal(4,0) NOT NULL,
    veForms decimal(2,0),
    dateID int,
    peds decimal(2,0),
    persons decimal(2,0),
    locationID int,
    route decimal(2,0),
    lightConditions varchar(75),
    weather varchar(75),
    drunkDrivers decimal (2,0),
    fatalities decimal (2,0),
    CONSTRAINT PK_Accident PRIMARY KEY (state, caseNum),
    FOREIGN KEY (dateID) REFERENCES Date(dateID),
    FOREIGN KEY (locationID) REFERENCES Location(locationID),
    FOREIGN KEY (state) REFERENCES State(stateID)
);

CREATE TABLE Vehicle (
    state decimal(2,0) NOT NULL,
    caseNum decimal(4,0) NOT NULL,
    vehicleNumber decimal(2,0) NOT NULL,
    numOccs decimal(2,0),
    collisionManner decimal(2,0),
    hitAndRun decimal (1,0),
    registeredState decimal(2,0),
    owner decimal(1,0),
    make varchar(45),
    model varchar(45),
    modelYear decimal(4,0),
    deaths decimal(2,0),
    rollover decimal(1,0),
    driverDrunk decimal(1,0),
    speedLimit decimal (3,0),
    PRIMARY KEY (state, caseNum, vehicleNumber),
    FOREIGN KEY (state, caseNum) REFERENCES Accident(state, caseNum),
    FOREIGN KEY (owner) REFERENCES Owner(ownerID),
    FOREIGN KEY (registeredState) REFERENCES State(stateID),
    FOREIGN KEY (collisionManner) REFERENCES CollisionManner(collisionMannerID)
);

CREATE TABLE NonMotorist (
    state decimal(2,0) NOT NULL,
    caseNum decimal(4,0) NOT NULL,
    personNumber decimal(2,0) NOT NULL,
    passerbyType decimal(2,0),
    age decimal(3,0),
    sex char,
    nonMotoristAction decimal(2,0),
    nonMotoristImpairment decimal(2,0),
    CONSTRAINT PK_NonMotorist PRIMARY KEY (state, caseNum, personNumber),
    FOREIGN KEY (state, caseNum) REFERENCES Accident(state, caseNum),
    FOREIGN KEY (passerbyType) REFERENCES PasserbyType(passerbyTypeID),
    FOREIGN KEY (nonMotoristAction) REFERENCES NonMotoristAction(nonMotoristActionID),
    FOREIGN KEY (nonMotoristImpairment) REFERENCES NonMotoristImpairment(nonMotoristImpairmentID)
);
