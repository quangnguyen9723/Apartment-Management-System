-- Drop table Owner;
-- Drop table Building;
-- Drop table Maintenance;
-- Drop table Apartment;
-- Drop table Building;
-- Drop table Owner;
-- Drop table Owns;
-- Drop table Payment;
-- Drop table Rents;
-- Drop table Staff;
-- Drop table Tenant;
-- Drop table Work;

CREATE TABLE Owner (
  id int identity(1000, 2),
  FirstName varchar(50),
  LastName varchar(50),
  Gender varchar(10),
  DOB date,
  PRIMARY KEY (id),
  CHECK (Gender in ('Male', 'Female'))
);

CREATE TABLE Tenant (
  id int identity(1001, 2),
  FirstName varchar(50),
  LastName varchar(50),
  Gender varchar(10),
  DOB date,
  PRIMARY KEY (id),
  CHECK (Gender in ('Male', 'Female'))
);

CREATE TABLE Staff (
  id int identity(100, 1),
  FirstName varchar(50),
  LastName varchar(50),
  Salary numeric(8, 0),
  PRIMARY KEY (id),
);

CREATE TABLE Building (
  id int identity(1, 1),
  name varchar(30),
  address varchar(50),
  PRIMARY KEY (id),
);

CREATE TABLE Apartment (
  id int identity(100, 1),
  building_id int,
  price numeric(8,0),
  capacity int,
  availability varchar(20) DEFAULT 'vacant',
  PRIMARY KEY (id),
  FOREIGN KEY (building_id) references building(id)
    on update set null
    on delete cascade,
  CHECK (Availability in ('vacant', 'occupied'))
);

CREATE TABLE Maintenance (
  id int identity(1, 1),
  apartment_id int,
  category varchar(20),
  status varchar(20),
  PRIMARY KEY (id),
  CHECK (Category in ('Electricity', 'Water', 'Interior', 'Other')),
  CHECK (Status in ('In Progress', 'Done'))
);

--- Change this name because work is a keyword in sql
CREATE TABLE Work (
  staff_id int,
  building_id int,
  PRIMARY KEY (staff_id, building_id),
  FOREIGN KEY (staff_id) references staff(id)
    on delete cascade
    on update cascade,
  FOREIGN KEY (building_id) references building(id)
    on delete cascade
    on update cascade
);

CREATE TABLE Payment (
  apartment_id int,
  due_date date,
  tenant_id int,
  owner_id int,
  amount numeric(8,2),
  status varchar(20) DEFAULT 'unpaid' CHECK (status in ('paid', 'unpaid')),
  PRIMARY KEY (apartment_id, due_date),
  FOREIGN KEY (apartment_id) REFERENCES apartment(id)
    on delete cascade
    on update cascade,
  FOREIGN KEY (tenant_id) REFERENCES tenant(id)
    on delete cascade
    on update cascade,
  FOREIGN KEY (owner_id) REFERENCES owner(id)
    on delete cascade
    on update cascade
);

CREATE TABLE Owns (
  apartment_id int,
  owner_id int,
  PRIMARY KEY (apartment_id, owner_id),
  FOREIGN KEY (apartment_id) references apartment(id)
    on delete cascade
    on update cascade,
  FOREIGN KEY (owner_id) references owner(id)
    on delete cascade
    on update cascade
);

CREATE TABLE Rents (
  apartment_id int,
  tenant_id int,
  start_date date,
  end_date date,
  PRIMARY KEY (apartment_id, tenant_id),
  FOREIGN KEY (apartment_id) references apartment(id)
    on delete cascade
    on update cascade,
  FOREIGN KEY (tenant_id) references tenant(id)
    on delete cascade
    on update cascade
);


-- INSERTING VALUES

-- Inserting buildings
INSERT INTO building
VALUES ('Kuzion', '1700 West Street'),
       ('Brown', '2300 South Street'),
       ('Emera', '1200 East Street'),
       ('Blossom', '4401 North Street');

-- Insert apartments
DECLARE @kuzion_id INT
SELECT @kuzion_id = id FROM building WHERE name = 'Kuzion'

INSERT INTO Apartment (building_id, price, capacity)
VALUES (@kuzion_id, 1500, 2),
       (@kuzion_id, 1800, 3),
       (@kuzion_id, 2000, 4),
       (@kuzion_id, 1000, 1),
       (@kuzion_id, 1575, 2)

DECLARE @brown_id INT
SELECT @brown_id = id FROM building WHERE name = 'Brown'

INSERT INTO Apartment (building_id, price, capacity)
VALUES (@brown_id, 1200, 2),
       (@brown_id, 1600, 3),
       (@brown_id, 1900, 4),
       (@brown_id, 1100, 2)

DECLARE @emera_id INT
SELECT @emera_id = id FROM building WHERE name = 'Emera'
INSERT INTO Apartment (building_id, price, capacity)
VALUES (@emera_id, 1300, 2),
       (@emera_id, 1700, 3),
       (@emera_id, 2100, 4),
       (@emera_id, 1390, 2),
       (@emera_id, 1200, 1),
       (@emera_id, 1400, 2)


DECLARE @blossom_id INT
SELECT @blossom_id = id FROM building WHERE name = 'Blossom'
INSERT INTO Apartment (building_id, price, capacity)
VALUES (@blossom_id, 1400, 2),
       (@blossom_id, 2000, 3),
       (@blossom_id, 2200, 4),
       (@blossom_id, 1000, 1),
       (@blossom_id, 1100, 2)

-- Insert Staff to building
INSERT INTO Staff (FirstName, LastName, Salary)
VALUES ('Annie', 'Jennings', 29500),
       ('Josh', 'Fleming', 31000),
       ('Kevin', 'Gates', 28800),
       ('Helly', 'Harrington', 32700);

DECLARE @jennings_id INT
SELECT @jennings_id = id FROM Staff WHERE FirstName = 'Annie' AND LastName = 'Jennings'
INSERT INTO Work (staff_id, building_id)
VALUES (@jennings_id, @kuzion_id)

DECLARE @fleming_id INT
SELECT @fleming_id = id FROM Staff WHERE FirstName = 'Josh' AND LastName = 'Fleming'
INSERT INTO Work (staff_id, building_id)
VALUES (@fleming_id, @brown_id)

DECLARE @gates_id INT
SELECT @gates_id = id FROM Staff WHERE FirstName = 'Kevin' AND LastName = 'Gates'
INSERT INTO Work (staff_id, building_id)
VALUES (@gates_id, @emera_id)

DECLARE @harrington_id INT
SELECT @harrington_id = id FROM Staff WHERE FirstName = 'Helly' AND LastName = 'Harrington'
INSERT INTO Work (staff_id, building_id)
VALUES (@harrington_id, @blossom_id)

-- INSERT MAINTENANCE REQUEST
-- Request maintenance for apartment 101 in Kuzion
DECLARE @kuzion_101_id INT
SELECT @kuzion_101_id = id FROM Apartment WHERE building_id = (SELECT id FROM Building WHERE Name = 'Kuzion') AND capacity = 2 AND price = 1500
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (@kuzion_101_id, 'Electricity', 'In Progress')



-- Request maintenance for apartment 201 in Brown
DECLARE @brown_201_id INT
SELECT @brown_201_id = id FROM Apartment WHERE building_id = (SELECT id FROM Building WHERE Name = 'Brown') AND capacity = 2 AND price = 1300
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (@brown_201_id, 'Water', 'In Progress')

-- Request maintenance for apartment 102 in Emera
DECLARE @emera_102_id INT
SELECT @emera_102_id = id FROM Apartment WHERE building_id = (SELECT id FROM Building WHERE Name = 'Emera') AND capacity = 1 AND price = 1200
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (@emera_102_id, 'Interior', 'Done')

-- Request maintenance for apartment 202 in Blossom
DECLARE @blossom_202_id INT
SELECT @blossom_202_id = id FROM Apartment WHERE building_id = (SELECT id FROM Building WHERE Name = 'Blossom') AND capacity = 2 AND price = 1100
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (@blossom_202_id, 'Electricity', 'In Progress')


-- Request maintenance for apartment 301 in Kuzion
DECLARE @kuzion_301_id INT
SELECT @kuzion_301_id = id FROM Apartment WHERE building_id = (SELECT id FROM Building WHERE Name = 'Kuzion') AND capacity = 3 AND price = 1800
INSERT INTO Maintenance (apartment_id, category, status)
VALUES (@kuzion_301_id, 'Other', 'In Progress')


