-- Trigger when insert a maintenance
   CREATE TRIGGER tr_Maintenance_Insert
   ON Maintenance
   AFTER INSERT
   AS
   BEGIN
       UPDATE Maintenance
       SET status = 'In Progress'
       WHERE id IN (SELECT id FROM INSERTED)
   END

-- Trigger when insert a rent
CREATE TRIGGER tr_Rents_Insert
ON Rents
AFTER INSERT
AS
BEGIN
  -- Update apartment availability status to occupied
  UPDATE Apartment
  SET availability = 'occupied'
  WHERE id IN (SELECT inserted.apartment_id FROM inserted);
END

-- Trigger when delete a renter
CREATE TRIGGER tr_Tenant_Delete
ON Tenant
AFTER DELETE
AS
BEGIN
  -- Remove all of the tenant's rental agreements and payments
  DELETE FROM Rents
  WHERE tenant_id IN (SELECT id FROM deleted);

  DELETE FROM Payment
  WHERE tenant_id IN (SELECT id FROM deleted);
END
