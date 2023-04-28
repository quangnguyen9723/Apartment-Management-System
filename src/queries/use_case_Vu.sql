
-- Insert a new rents with tenant Hieu Dang to apartment 101
INSERT INTO Rents (apartment_id, tenant_id, start_date, end_date) 
VALUES (101, 
(SELECT t.id 
FROM Tenant
WHERE t.FirstName = Hieu AND t.LastName = Dang), 2023/05/20, 2023/08/23)
UPDATE Apartment a
SET a.availability = 'occupied'
WHERE id = 101
AND availability = 'vacant';
-- Delete a tenant id 1007 as they stop renting an apartment
DELETE FROM Tenant WHERE id = 1007