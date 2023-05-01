-- Insert a new rents with tenant Hieu Dang to apartment 101
INSERT INTO Rents (apartment_id, tenant_id, start_date, end_date) 
VALUES (100, 
(SELECT t.id 
FROM Tenant t
WHERE t.FirstName = 'Long' AND t.LastName = 'Nguyen')
, '2022/12/25', '2023/05/12')

-- Delete a tenant id 1007 as they stop renting an apartment
DELETE FROM Tenant WHERE id = 1007

--Query all amount of money that Tenant Hieu Dang owes
SELECT Payment.tenant_id, concat(Tenant.FirstName, ' ', Tenant.LastName) as TenantName, concat(Owner.FirstName, ' ', Owner.LastName) as OwnerName, Payment.amount, Payment.due_date
FROM Payment
JOIN Tenant ON Payment.tenant_id = Tenant.id
JOIN Owner ON Payment.owner_id = Owner.id
WHERE Tenant.FirstName = 'Hieu'
AND Tenant.LastName = 'Dang';

-- Given the owner's id, query all tenant that currently owe you and overdue

SELECT t.FirstName, t.LastName, p.amount
FROM Tenant t
INNER JOIN Payment p ON t.id = p.tenant_id
INNER JOIN Owns o ON p.apartment_id = o.apartment_id
WHERE p.status = 'unpaid'
  AND o.owner_id = <owner_id>
  AND p.due_date < GETDATE();


-- Query all amount of money that is overdue
SELECT Payment.tenant_id, concat(Tenant.FirstName, ' ', Tenant.LastName) as TenantName, concat(Owner.FirstName, ' ', Owner.LastName) as OwnerName, Payment.amount, Payment.due_date,  Payment.status
FROM Payment
JOIN Tenant ON Payment.tenant_id = Tenant.id
JOIN Owner ON Payment.owner_id = Owner.id
WHERE Payment.due_date < GETDATE()
AND Payment.status = 'unpaid';

select * from Payment
select * from Owner
select * from Owns
select * from Apartment
select * from Tenant
select * from Rents
