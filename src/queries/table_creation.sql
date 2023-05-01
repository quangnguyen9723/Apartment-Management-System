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
  staff_id int,
  category varchar(20),
  status varchar(20),
  PRIMARY KEY (id),
  FOREIGN KEY (staff_id) references staff(id),
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



