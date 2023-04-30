
/*-- Insert a new rents with tenant Hieu Dang to apartment 101
INSERT INTO Rents (apartment_id, tenant_id, start_date, end_date) 
VALUES (101, 
(SELECT t.id 
FROM Tenant
WHERE t.FirstName = 'Hieu' AND t.LastName = 'Dang')
, 2023/05/20, 2023/08/23)
UPDATE Apartment
SET availability = 'occupied'
WHERE id = 101
AND availability = 'vacant';
-- Delete a tenant id 1007 as they stop renting an apartment
DELETE FROM Tenant WHERE id = 1007*/

--Query all amount of money that Tenant Hieu Dang owes Owner John Doe
/*SELECT Payment.tenant_id, concat(Tenant.FirstName, ' ', Tenant.LastName) as TenantName, concat(Owner.FirstName, ' ', Owner.LastName) as OwnerName, Payment.amount, Payment.due_date
FROM Payment
JOIN Tenant ON Payment.tenant_id = Tenant.id
JOIN Owner ON Payment.owner_id = Owner.id
WHERE Tenant.FirstName = 'Hieu'
AND Tenant.LastName = 'Dang'
AND Owner.FirstName = 'John'
AND Owner.LastName = 'Doe'*/

select * from Payment
select * from Owner
select * from Owns
select * from Apartment
select * from Rents
Select GETDATE()
