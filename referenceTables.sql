CREATE TABLE State (
    stateID decimal(2,0),
    stateName varchar (45),
    PRIMARY KEY (stateID)
);

INSERT INTO State
VALUES
    (0, 'Not Applicable'),
    (1, 'Alabama'),
    (2, 'Alaska'),
    (3, 'American Samoa'),
    (4, 'Arizona'),
    (5, 'Arkansas'),
    (6, 'California'),
    (8, 'Colorado'),
    (9, 'Connecticut'),
    (10, 'Delaware'),
    (11, 'District of Columbia'),
    (12, 'Florida'),
    (13, 'Georgia'),
    (14, 'Guam'),
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
    (35, 'New Mexico'),
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
    (56, 'Wyoming'),
    (91, 'Not reported'),
    (92, 'No registration'),
    (93, 'Multiple state registration'),
    (94, 'U.S. government tags (includes military)'),
    (95, 'Canada'),
    (96, 'Mexico'),
    (97, 'Other Foreign country'),
    (98, 'Other registration'),
    (99, 'Unknown');

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


CREATE TABLE Make (
    makeID decimal(2,0) NOT NULL,
    makeDesc varchar(45),
    PRIMARY KEY (makeID)
);

INSERT INTO Make
VALUES 
    (1, 'American Motors'),
    (2, 'Jeep'),
    (3, 'AM General'),
    (6, 'Chrysler'),
    (7, 'Dodge'),
    (8, 'Imperial'),
    (9, 'Plymouth'),
    (10, 'Eagle'),
    (12, 'Ford'),
    (13, 'Lincoln'),
    (14, 'Mercury'),
    (18, 'Buick/Opel'),
    (19, 'Cadillac'),
    (20, 'Chevrolet'),
    (21, 'Oldsmobile'),
    (22, 'Pontiac'),
    (23, 'GMC'),
    (24, 'Saturn'),
    (25, 'Grumman'),
    (29, 'Other Domestic'),
    (30, 'Volkswagen'),
    (31, 'Alfa Romeo'),
    (32, 'Audi'),
    (33, 'Austin/Healey'),
    (34, 'BMW'),
    (35, 'Datsun/Nissan'),
    (36, 'Fiat'),
    (37, 'Honda'),
    (38, 'Isuzu'),
    (39, 'Jaguar'),
    (40, 'Lancia'),
    (41, 'Mazda'),
    (42, 'Mercedes-Benz'),
    (43, 'MG'),
    (44, 'Peugeot'),
    (45, 'Porsche'),
    (46, 'Renault'),
    (47, 'Saab'),
    (48, 'Subaru'),
    (49, 'Toyota'),
    (50, 'Triumph'),
    (51, 'Volvo'),
    (52, 'Mitsubishi'),
    (53, 'Suzuki'),
    (54, 'Acura'),
    (55, 'Hyundai'),
    (56, 'Merkur'),
    (57, 'Yugo'),
    (58, 'Infiniti'),
    (59, 'Lexus'),
    (60, 'Daihatsu'),
    (61, 'Sterling'),
    (62, 'Land Rover'),
    (63, 'Kia'),
    (64, 'Daewoo'),
    (65, 'Smart'),
    (69, 'Other Imports'),
    (70, 'BSA'),
    (71, 'Ducati'),
    (72, 'Harley-Davidson'),
    (73, 'Kawasaki'),
    (74, 'Moto-Guzzi'),
    (75, 'Norton'),
    (76, 'Yamaha'),
    (77, 'Victory'),
    (78, 'Other Make Moped'),
    (79, 'Other Make Motored Cycle'),
    (80, 'Brockway'),
    (81, 'Diamond-Reo'),
    (82, 'Freighliner'),
    (83, 'FWD'),
    (84, 'International Harvester/Navistar'),
    (85, 'Kenworth'),
    (86, 'Mack'),
    (87, 'Peterbilt'),
    (88, 'Iveco/Magirus'),
    (89, 'White/Autocar - White/GMC'),
    (90, 'Bluebird'),
    (91, 'Eagle Coach'),
    (92, 'Gilliag'),
    (93, 'MCI'),
    (94, 'Thomas Built'),
    (97, 'Not reported'),
    (98, 'Other make'),
    (99, 'Unknown make');

CREATE TABLE Weather (
    weatherID decimal(2,0) NOT NULL,
    weatherDesc varchar(45),
    PRIMARY KEY (weatherID)
);

INSERT INTO Weather
VALUES 
    (1, 'Clear'),
    (2, 'Rain'),
    (3, 'Sleet, hail, freezing rain'),
    (4, 'Snow'),
    (5, 'Fog, smog, smoke'),
    (6, 'Severe Crosswinds'),
    (7, 'Blowing sand, soil, dirt'),
    (8, 'Other'),   
    (10, 'Cloudy'),
    (19, 'Blowing Snow'),
    (88, 'Not reported'),
    (99, 'Unknown');

CREATE TABLE Light (
    lightID decimal(1,0) NOT NULL,
    lightDesc varchar(45),
    PRIMARY KEY (lightID)
);

INSERT INTO Light
VALUES 
    (1, 'Daylight'),
    (2, 'Dark, not lighted'),
    (3, 'Dark, lighted'),
    (4, 'Dawn'),
    (5, 'Dusk'),
    (6, 'Dark, unknown lighting'),
    (7, 'Other'),   
    (8, 'Not reported'),
    (9, 'Unknown');

CREATE TABLE Gender (
    genderID decimal(1,0) NOT NULL,
    genderDesc varchar(45),
    PRIMARY KEY (genderID)
);

INSERT INTO Gender
VALUES 
    (1, 'Male'),
    (2, 'Female'),
    (8, 'Not reported'),
    (9, 'Unknown');