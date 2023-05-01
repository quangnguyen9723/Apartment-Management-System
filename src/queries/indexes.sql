-- Data population
INSERT INTO Owner (FirstName, LastName, Gender, DOB) 
VALUES 
    ('John', 'Smith', 'Male', '1980-05-10'),
    ('Emily', 'Johnson', 'Female', '1995-02-18'),
    ('Michael', 'Williams', 'Male', '1978-11-24'),
    ('Sarah', 'Brown', 'Female', '1989-07-05'),
    ('David', 'Davis', 'Male', '1985-03-22'),
    ('Rachel', 'Garcia', 'Female', '1990-09-15'),
    ('Christopher', 'Rodriguez', 'Male', '1982-06-30'),
    ('Samantha', 'Martinez', 'Female', '1986-12-12'),
    ('Kevin', 'Hernandez', 'Male', '1993-08-07'),
    ('Nicole', 'Gonzalez', 'Female', '1977-04-01');

INSERT INTO Tenant (FirstName, LastName, Gender, DOB)
VALUES
    ('Alex', 'Johnson', 'Male', '1992-04-20'),
    ('Julia', 'Kovacs', 'Female', '1986-11-05'),
    ('Robert', 'Kim', 'Male', '1991-02-10'),
    ('Maggie', 'Chen', 'Female', '1998-06-25'),
    ('Oscar', 'Nguyen', 'Male', '1984-09-08'),
    ('Sophia', 'Gupta', 'Female', '1993-12-18'),
    ('Daniel', 'Lee', 'Male', '1989-07-12'),
    ('Katherine', 'Wang', 'Female', '1996-01-30'),
    ('Anthony', 'Singh', 'Male', '1990-03-27'),
    ('Emma', 'Patel', 'Female', '1987-08-15');

INSERT INTO Owns (apartment_id, owner_id)
VALUES
    (100, 1000),
    (102, 1002),
    (106, 1012),
    (111, 1014),
    (115, 1006),
	(101, 1016),
    (105, 1006),
	(110, 1018),
    (114, 1000),
	(116, 1010);

INSERT INTO Rents (apartment_id, tenant_id, start_date, end_date)
VALUES
    (100, 1001, '2022-05-01', '2023-05-01'),
    (102, 1009, '2022-06-01', '2023-06-01'),
    (105, 1003, '2022-05-01', '2023-05-01'),
    (106, 1015, '2022-07-01', '2023-07-01'),
    (110, 1005, '2022-05-01', '2023-05-01'),
    (111, 1017, '2022-08-01', '2023-08-01'),
    (116, 1007, '2022-05-01', '2023-05-01');

INSERT INTO Payment (apartment_id, due_date, tenant_id, owner_id, amount)
SELECT
    apartment_id,
    DATEADD(month, 1, start_date) as due_date,
    tenant_id,
    (SELECT owner_id FROM Owns WHERE apartment_id = Rents.apartment_id) as owner_id,
    (SELECT price FROM Apartment WHERE id = Rents.apartment_id) as amount
FROM Rents;

INSERT INTO Payment (apartment_id, due_date, tenant_id, owner_id, amount)
SELECT
    apartment_id,
    end_date as due_date,
    tenant_id,
    (SELECT owner_id FROM Owns WHERE apartment_id = Rents.apartment_id) as owner_id,
    (SELECT price FROM Apartment WHERE id = Rents.apartment_id) as amount
FROM Rents;

-- Index creation
CREATE INDEX ind_Owner
ON Owner (LastName, id);

CREATE INDEX ind_Tenant
ON Tenant (LastName, id);

CREATE INDEX ind_Owns
ON Owns (owner_id, apartment_id);

CREATE INDEX ind_Rents
ON Rents (end_date, start_date, apartment_id);

CREATE INDEX ind_Staff
ON Staff (LastName, FirstName);

CREATE INDEX ind_Payment
ON Payment (due_date, amount);

CREATE INDEX ind_Maintenance
ON Maintenance(status)

CREATE INDEX ind_Building
ON Building(name, id)

CREATE INDEX ind_Work
ON Work (building_id, staff_id)

CREATE INDEX ind_Apartment
ON Apartment (price, capacity)

SELECT * FROM Owner
SELECT * FROM Tenant
SELECT * FROM Owns
SELECT * FROM Rents
SELECT * FROM Staff
SELECT * FROM Payment
SELECT * FROM Maintenance
SELECT * FROM Building
SELECT * FROM Apartment
